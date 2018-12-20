FROM httpd:2.4.37

RUN apt-get update ; apt-get install -yq subversion && apt-get clean && \
    svn co --trust-server-cert https://github.com/crkn-rcdr/Digital-Preservation.git/trunk/xml/published/ /usr/local/apache2/htdocs/xml-published/

COPY cihm-error /usr/local/apache2/htdocs/cihm-error/
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf

# This should be changed when running container to the correct host and post for the relevant instance.  This is only Dev.
ENV CAPHOSTPORT danablu.office.c7a.ca:3011
ENV CDNHOSTPORT beemster.office.c7a.ca:5984

# SSL related variables (set to blank if specific file isn't needed)
ENV SSLCertificateFile      /etc/ssl/certs/secure.canadiana.ca.crt
ENV SSLCertificateKeyFile   /etc/ssl/certs/secure.canadiana.ca.key
ENV SSLCertificateChainFile /etc/ssl/certs/secure.canadiana.ca-Inter.cert
ENV SSLCACertificateFile    /etc/ssl/certs/GlobalSign_Root_CA.pem

# Location of logfiles
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80 443
