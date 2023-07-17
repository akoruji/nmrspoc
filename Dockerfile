# Use the official Java 8 image as the base image
FROM openjdk:8-jdk-alpine

# Set environment variables for Tomcat and MySQL
ENV TOMCAT_VERSION 9.0.76
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV MYSQL_VERSION 5.7

# Install required dependencies
RUN apk add --no-cache curl tar

# Download and install Apache Tomcat
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.76/bin/apache-tomcat-9.0.76.tar.gz \
    && tar -xzf apache-tomcat-$TOMCAT_VERSION.tar.gz \
    && rm apache-tomcat-$TOMCAT_VERSION.tar.gz \
    && mv apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME

# Copy the war file to the Tomcat webapps directory
COPY /openmrs.war $CATALINA_HOME/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
