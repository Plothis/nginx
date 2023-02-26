if [[ -n $(docker ps -a | grep static-site) ]];then
    docker exec -i  static-site /bin/bash -c "rm -rf /var/log/nginx/*.log"
	docker container rm static-site -f
else
	echo "no container static-site"
fi

docker container run --name static-site \
-p 80:80 \
-p 443:443 \
-v /var/lib/jenkins/workspace:/var/lib/jenkins/workspace \
-v $(pwd)/site:/etc/nginx/html \
-v $(pwd)/log:/var/log/nginx \
-v $(pwd)/nginx:/etc/nginx/conf.d \
-v $(pwd)/certs:/etc/nginx/certs \
-d nginx

if [[ -n $(docker network ls | grep localNet) ]];then
	echo "localNet already exists"
else
	docker network create -d bridge --subnet 192.168.0.0/24 --gateway 192.168.0.1 localNet
fi


