#!/bin/bash

# update the system
apt-get update && apt-get upgrade -y

# install firewalls
apt-get install firewalld -y

# enable the firewall
systemctl start firewalld
systemctl enable firewalld

# add rules to the firewall
firewall-cmd --permanent --add-service=ssh
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https

# enable the firewall rules
firewall-cmd --reload

# install fail2ban
apt-get install fail2ban -y

# enable fail2ban
systemctl start fail2ban
systemctl enable fail2ban

# install and configure SSH
apt-get install openssh-server -y

# set the SSH port to a custom value
sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config

# disable root login over SSH
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

# disable password authentication
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# restart SSH
systemctl restart ssh

# install and configure the rootkit hunter
apt-get install rkhunter -y

# update the rootkit hunter
rkhunter --update

# run the rootkit hunter
rkhunter --check

# Install and configure Fail2Ban
apt-get install fail2ban

# Copy the default Fail2Ban configuration file
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# Restart Fail2Ban to apply the changes
service fail2ban restart
