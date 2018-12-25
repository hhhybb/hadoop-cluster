# Hadoop-cluster
An simple Hadoop-cluster based on docker  

### Version:
* OS: Ubuntu:18.04
* java: openjdk-8
* hadoop: 2.9.2 

### How to use

##### 1.clone github repository

```
git clone https://github.com/hhhybb/hadoop-cluster.git
```

##### 2. Download hadoop-2.9.2 via mirror sites, then put it in the current directory

```
http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz
```
![alt tag](https://github.com/hhhybb/hadoop-cluster/blob/master/config.jpg)

##### 3. Execute docker-compose under this directory

```
docker-compose up -d
```
  
##### 4. access the master container

```
docker exec -it hadoop-master /bin/bash
```
  
##### 5. run wordcount

```
./run-wordcount.sh
```

**output**

```
input file1.txt:
Hello Hadoop

input file2.txt:
Hello Docker

wordcount output:
Docker    1
Hadoop    1
Hello    2
```

