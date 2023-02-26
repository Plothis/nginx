FROM nginx
LABEL version="1.0" description="nginx" by="hubo"
ENV MYPATH /var/lib/jenkins/workspace/static-site
WORKDIR $MYPATH

#设置容器时间与宿主机时间同步
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
VOLUME ["$MYPATH", "$MYPATH"]
VOLUME ["$MYPATH/site", "/usr/share/nginx/html"]
VOLUME ["$MYPATH/log", "/var/log/nginx"]
VOLUME ["$MYPATH/nginx", "/etc/nginx/conf.d"]
VOLUME ["$MYPATH/certs", "/etc/nginx/certs"]
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["rm -rf /var/log/nginx/*.log"]

CMD echo "------success------OK------"