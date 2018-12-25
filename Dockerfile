FROM ubuntu:18.04

MAINTAINER ZhouKe <hhhybb@gmail.com>

WORKDIR /opt

# install hadoop 2.9.2 use local file
ADD ./hadoop-2.9.2.tar.gz /opt/

# install openssh-server, openjdk and wget
RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk && \
    mv ./hadoop-2.9.2 ./hadoop && \
    apt-get clean

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/opt/hadoop 
ENV PATH=$PATH:/opt/hadoop/bin:/opt/hadoop/sbin 

RUN mkdir -p /opt/hdfs/namenode && \ 
    mkdir -p /opt/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs &&\
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh &&\
    chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh &&\
    /opt/hadoop/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]

