#!/bin/bash

# Update system
 sudo apt-get update -y

# Install required packages
 sudo apt-get install gnupg2 -y
 sudo apt-get install wget -y
 sudo apt-get install vim -y

# Add postgresql repository
 sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Import the GPG key for the added repository
 wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update apt package index
 sudo apt-get update -y

# Install postgresql 14
 sudo apt-get install postgresql-14 -y

# Configure postgreSQL 14 for remote access
 sudo sed -i '/^local/s/peer/trust/' /etc/postgresql/14/main/pg_hba.conf
 sudo sed -i '/^host/s/ident/md5/' /etc/postgresql/14/main/pg_hba.conf

 sudo echo "# IPv4 local connections:" >> /etc/postgresql/14/main/pg_hba.conf
 sudo echo 'host    all             all             0.0.0.0/24              md5' >> /etc/postgresql/14/main/pg_hba.conf
 sudo echo "# IPv6 local connections:" >> /etc/postgresql/14/main/pg_hba.conf
 sudo echo 'host    all             all             0.0.0.0/0               md5' >> /etc/postgresql/14/main/pg_hba.conf

 sudo echo "# CONNECTIONS AND AUTHENTICATION" >> /etc/postgresql/14/main/postgresql.conf
 sudo echo "listen_addresses='*'" >> /etc/postgresql/14/main/postgresql.conf


# Restart and enable postgresql
 sudo systemctl restart postgresql
 sudo systemctl enable postgresql