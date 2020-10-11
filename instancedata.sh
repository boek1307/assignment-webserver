#!/bin/bash

#Create metadata file
touch metadata.txt

#Add instance hostname
curl http://169.254.169.254/latest/meta-data/hostname > metadata.txt


#Append iam info
curl -w "\n" http://169.254.169.254/latest/meta-data/iam/ >> metadata.txt


#Append security groups
curl -w "\n"  http://169.254.169.254/latest/meta-data/security-groups >> metadata.txt
