FROM localregistry:5000/debian

ENV http_proxy="http://193.56.47.20:8080"
ENV https_proxy="http://193.56.47.20:8080"

HEALTHCHECK CMD curl -s http://localhost >/dev/null || exit 1

EXPOSE 8080
EXPOSE 8443

COPY entrypoint.sh /

RUN apt-get update && \
apt-get -y upgrade && \
apt-get -y install apt-utils gcc make unzip procps libpng-dev libjpeg-dev libgd-dev apache2 php snmp libnet-snmp-perl libssl-dev wget bc gawk dc gettext libdbi-dev libldap2-dev libmariadbclient-dev \
libmariadbclient-dev-compat dnsutils fping libpqxx-dev ssh libradsec-dev sudo curl php-gd php-mysql php-soap php-xml php-ldap php-mbstring graphviz php-zip \
lsb-release && \
mkdir /builditop

WORKDIR /builditop

COPY iTop-2.7.1-5896.zip .

RUN unzip iTop-2.7.1-5896.zip && rm -f /var/www/html/index.html && mv web/* /var/www/html/ && chown -Rv www-data:www-data /var/www/html


CMD ["/bin/bash"]

ENTRYPOINT ["/entrypoint.sh"]

