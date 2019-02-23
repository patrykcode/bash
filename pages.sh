#!/bin/bash
if [ -z "$1" ]; then
	echo "$(date +%F_%H-%M-%S) - podaj nazwę strony";
else
   if [ -d /home/patryk/projects/"$1" ]; then
  	echo "Plik $1 już istnieje."
   else
	echo "$(date +%F_%H-%M-%S) - nazwa strony to $1";
	echo "$1" && mkdir -m 777 $1;
	echo "tworzenie nginx $1 config";
	cp /etc/nginx/sites-available/example.test /etc/nginx/sites-available/$1 && sed -i "s/example.test/$1/gI" /etc/nginx/sites-available/$1;

	echo "tworzenie symlinkow $1";
	ln -s /etc/nginx/sites-available/$1 /etc/nginx/sites-enabled/$1;
	ln -s /home/patryk/projects/$1 /var/www/$1;

	echo "dodanie $1 do /etc/hosts";
	echo "127.0.0.1	$1" >> /etc/hosts;
    fi
fi
