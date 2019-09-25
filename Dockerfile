############################################################
# Dockerfile to build memcached container images
# Based on Centos 7.5
############################################################
FROM centos:7.5.1804

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && rpm --import /etc/pki/rpm-gpg/RPM* && export TERM=linux

ENV MEMCACHED_VERSION=1.5.0

RUN yum update -y && yum -y install gcc automake autoconf libtool make libevent-devel && yum clean all

ADD memcached-1.5.0.tar.gz /home
WORKDIR /home/memcached-1.5.0
RUN ./configure && make && make install && rm -rf /home/memcached-1.5.0

EXPOSE 11211/tcp

CMD ["memcached","--user=root"]

