#!/bin/bash

#Assign Variables
ACTION=${1}
version=1.0.0

function  start_webserver() {

#Install all system packages
sudo yum update -y

#Install the Nginx software package
sudo amazon-linux-extras install nginx1.12 -y

#Configure Nginx to automatically start at system boot up
sudo chkconfig nginx on

#Copy the website documents from s3 to the web document root directory
sudo aws s3 cp s3://boek1307-assignment-webserver/index.html /usr/share/nginx/html/index.html

#Start the Nginx service
sudo service nginx start

}

function stop_webserver() {

#Stop the nginx service
sudo service nginx stop

#Delete files in website document root directory /usr/share/nginx/html
sudo rm -rf /usr/share/nginx/html/

#Uninstall the nginx software package
sudo yum remove nginx -y

}

function show_version() {
echo $version

}

function display_help() {

cat << EOF
Usage: ${0} {-h|--help|-r|--remove|-v|--version} <filename>
OPTIONS:
	-h | --help	Display the command help
	-r | --remove	Remove the webserver components
	-v | --version	Show the version of this script
EOF
}

case "$ACTION" in
	-h|--help)
		display_help
		;;
	-r|--remove)
		stop_webserver
		;;
	-v|--version)
		show_version
		;;
	*)
	start_webserver
	exit 1
esac
