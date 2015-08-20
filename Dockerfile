#
# ES Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV ES_VERSION elasticsearch-1.6.0

# Update & install packages for graylog
RUN apt-get update && \
    apt-get install -y wget dpkg-dev openjdk-7-jre

#Configure ES
RUN wget https://download.elastic.co/elasticsearch/elasticsearch/$ES_VERSION.deb && \
    dpkg -i $ES_VERSION.deb
ADD elasticsearch.yml /etc/elasticsearch/
ADD logging.yml /etc/elasticsearch/

#install paramedic plugin
RUN /usr/share/elasticsearch/bin/plugin -install karmi/elasticsearch-paramedic

EXPOSE 9200 9300

CMD ["/usr/share/elasticsearch/bin/elasticsearch", "-Des.default.config=/etc/elasticsearch/elasticsearch.yml"]
