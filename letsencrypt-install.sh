#!/bin/bash

# Let's Encrypt Install

#-------------------------------------
echo "パスの通っている場所を入力してください (ex. /usr/bin)"
read INSTALL_PATH
#-------------------------------------

#-------------------------------------
echo "RootDirectoryを入力してください (ex. /var/www/hoge)"
read WEBROOT
#-------------------------------------

#-------------------------------------
echo "対象ドメインを入力してください (ex. hoge.com)"
read DOMAIN
#-------------------------------------

#-------------------------------------
echo "管理用メールアドレスを入力してください (ex. hoge@hoge.com)"
read EMAIL
#-------------------------------------

# certbotが未インストール時のみインストール
if ! type certbot-auto > /dev/null 2>&1; then
  sudo curl https://dl.eff.org/certbot-auto -o $INSTALL_PATH/certbot-auto
fi

# 権限付与
sudo chmod 700 $INSTALL_PATH/certbot-auto

# 証明書発行
sudo certbot-auto certonly --webroot -w $WEBROOT -d $DOMAIN --email $EMAIL