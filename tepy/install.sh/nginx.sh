#!/bin/sh
yum -y update
yum -y install \
 gcc.x86_64 cpp.x86_64 pcre-devel.x86_64 zlib-devel.x86_64 \
 curl.x86_64 curl-devel.x86_64 libmcrypt-devel.x86_64 \
 mysql.x86_64 mysql-devel.x86_64 libxml2-devel.x86_64 \
 gd.x86_64 gd-devel.x86_64 mhash-devel.x86_64 ntp \
 libmcrypt-devel.x86_64 bzip2-devel.x86_64  autoconf.noarch \
 libevent-devel.x86_64 subversion.x86_64  gcc-c++ \
 libtermcap-devel.x86_64 ncurses-devel.x86_64  nc nmap-ncat \
 GeoIP.x86_64 GeoIP-devel.x86_64  lua.x86_64 lua-devel.x86_64 \
 libcurl.x86_64 libcurl-devel.x86_64  libpcap-devel.x86_64 \
 libpcap.x86_64 openssl-libs.x86_64 openssl-devel.x86_64  git
 
 yum install -y  openssl openssl-devel libmcrypt epel-release make libmcrypt-devel.x86_64 m4 autoconf bzip2 bzip2-devel gcc bzip2 libxml2-devel  curl-devel  libjpeg-devel  libpng-devel  freetype-devel  gmp-devel  pcre-devel  glib2-devel  opensssl  libxml2 yum install libxml2-devel  gcc-c++  wget gdb php-mcrypt cloud-init libmcrypt  libmcrypt-devel  psmisc gcc.x86_64 cpp.x86_64 pcre-devel.x86_64 zlib-devel.x86_64  curl.x86_64 curl-devel.x86_64 libmcrypt-devel.x86_64  mysql.x86_64 mysql-devel.x86_64 libxml2-devel.x86_64  gd.x86_64 gd-devel.x86_64 mhash-devel.x86_64  libmcrypt-devel.x86_64 bzip2-devel.x86_64  autoconf.noarch  libevent-devel.x86_64 subversion.x86_64 ntp gcc-c++ libtermcap-devel.x86_64 ncurses-devel.x86_64  GeoIP.x86_64 GeoIP-devel.x86_64  lua.x86_64 lua-devel.x86_64 libcurl.x86_64 libcurl-devel.x86_64  libpcap-devel.x86_64 libpcap.x86_64 openssl-libs.x86_64 openssl-devel.x86_64


 
cd ~
git clone https://github.com/lukas2511/dehydrated.git
wget https://www.openssl.org/source/openssl-1.0.2j.tar.gz
wget https://openresty.org/download/openresty-1.11.2.1.tar.gz



tar -zxvf openresty-1.11.2.1.tar.gz 
tar -zxvf openssl-1.0.2j.tar.gz 


cd openssl-1.0.2j
./config
make depend
make -j4 &&make install
mv /usr/bin/openssl /usr/bin/openssl_old
ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl # 可以测试一下openssl的版本 openssl version 查看输出

cd ~
# 编译 nginx
cd openresty-1.11.2.1
./configure --prefix=/usr/local/ \
      --with-poll_module \
      --with-file-aio \
      --with-http_realip_module \
      --without-http_scgi_module \
      --without-http_uwsgi_module \
      --without-http_autoindex_module \
      --with-http_stub_status_module \
      --with-http_ssl_module \
      --with-http_v2_module \
      --with-http_gzip_static_module \
      --with-http_geoip_module \
      --with-http_sub_module \
      --with-poll_module \
      --with-openssl=/root/openssl-1.0.2j \
      --with-stream \
	   --user=nobody --group=nobody
      
gmake -j4 && gmake install

/opt/server/nginx/sbin/nginx
ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
