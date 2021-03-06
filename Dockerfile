FROM centos:centos7.7.1908
MAINTAINER bugbeta <bugbeta@foxmail.com>

USER 0

RUN yum install -y wget telnet net-tools epel-release \
&& rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm \
&& yum install -y php72w php72w-gd httpd && yum clean all && rm -rf /tmp/* \
&& sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 50M/' /etc/php.ini \ 
&& sed -i 's/post_max_size = 8M/post_max_size = 50M/' /etc/php.ini \
&& mkdir -p /var/www/html/dokuwiki && chown -R apache:apache /var/www/html/dokuwiki

COPY dokuwiki.conf /etc/httpd/conf.d
COPY httpd-foreground /usr/local/bin/

EXPOSE 80
CMD ["httpd-foreground"]
