#! /bin/bash

cd ~
sudo rm -f /var/run/yum.pid
sudo yum clean all

# PHP7.4 Install
sudo amazon-linux-extras enable php7.4
sleep 3
sudo yum clean metadata
sleep 3
sudo yum install -y php

# node.js npm Install
sleep 3
echo "Node.js and Npm Install"
wget -O - https://rpm.nodesource.com/setup_12.x | sudo bash -
sleep 3
sudo yum install -y nodejs

# PHP Extentions Install
sleep 3
echo "PHP Extentions Install"
sudo yum install -y \
        php-bcmath \
        php-mcrypt \
        php-pdo \
        php-xml \
        php-tokenizer \
        php-mysqlnd \
        php-pecl-xdebug \
        php-gd \
        php-intl \
        php-zip \
        php-opcache \
        php-mbstring \
        php-fpm

# Composer Installer Download
sleep 3
echo "Composer Installer Download"
wget https://getcomposer.org/installer -O composer-installer.php

# Composer Install
sleep 3
echo "Composer Install"
sudo php composer-installer.php --filename=composer --install-dir=/usr/local/bin

# Composer Update
sleep 3
echo "Composer Update"
composer self-update

# Composer Version
sleep 3
echo "Composer Version"
composer -v

# Laravel Install
sleep 3
echo "Laravel Install"
composer global require laravel/installer

# Set Path
sleep 3
echo "Set Laravel Command Path"
export PATH="~/.config/composer/vendor/bin:$PATH"

echo "#############################"
echo " Laravel Install Complite!!"
echo "#############################"

# Create Laravel Project
echo "Input new Laravel Project Name :"
read project
laravel new $project

# Laravel Project Setting
sleep 3
echo "Laravel Project Setting"
cd ~/$project
chmod 777 -R bootstrap/cache
chmod 777 -R storage
cp .env .env.development
php artisan key:generate

# PHPMyAdmin Install
cd ~/$project/public
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip
unzip phpMyAdmin-latest-all-languages.zip
rm -f phpMyAdmin-latest-all-languages.zip
ln -s phpMyAdmin-5.0.4-all-languages phpMyAdmin
cp phpMyAdmin/config.sample.inc.php phpMyAdmin/config.inc.php

cd ~/$project
php artisan cache:clear
php artisan config:clear
php artisan config:cache

# Laravel UI Setting
composer require laravel/ui
php artisan ui bootstrap --auth
npm install && npm run dev
#php artisan ui vue --auth

# Laravel Debugar Install
# 本番環境にデプロイする場合はインストールしない
composer require barryvdh/laravel-debugbar --dev

echo "##############################"
echo " Create New Laravel Project!!"
echo "##############################"
php artisan --version

cd ~
rm -f composer-installer.php

# chmod 755 /home/ec2-user

# /etc/php.ini PHPの環境設定を行い、
# systemctl restart php-fpm

# /etc/httpd/conf.d/vhost.conf VirtualHostの設定を行い,
# systemctl restart httpd

# LaravelProject/.env Laravelの環境設定を行う
# LaravelProject/public/phpMyAdmin/config.inc.php phpMyAdminの環境設定を行う

# php artisan cache:clear
# php artisan config:clear
# php artisan config:cache
# php artisan migrate