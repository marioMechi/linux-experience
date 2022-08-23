#!/bin/bash

echo "Criando banco de dados"

apt install mysql-server-8.0 -y
mysql -u root -p
create databse dados;
use database dados;
create table Dados (AlunoID int, Nome varchar(50), Sobrenome varchar(50), Endereco varchar(150), Cidade varchar(50), Host varchar(50));

echo "Atualizando e criando container"

apt-get update
apt-get upgrade -y
cd /var/lib/docker/volumes/app/_data
docker run -- name web-server -dt -p 80:80 --mount type =volume,src=app,dst=/app/ webdev/php-apache:alpine-php

echo "Criando Swarm e serviço"

docker rm --force web-server
docker swarm init
docker service --name web server --replicas 3 -dt -p 80:80 mount typr = volume,src=app,dst/app/ webdevops/php-apache:alpine-php7

echo "Instalando NFS"

apt-get install nfs-server -y

echo "Utilizando NGINX"

cd proxy
docker build -t proxy -app .
docker container run -- name my-proxy -dti -p 4500:4500 proxy -app
