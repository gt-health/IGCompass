FROM maven:3.6.0-jdk-8 AS builder
WORKDIR /usr/src/IGCompass_src
ADD . .
RUN mvn clean package

FROM tomcat:latest
#move the WAR for contesa to the webapps directory
COPY --from=builder /usr/src/IGCompass_src/IGCompassWebapp/target/IGCompassWebapp-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/IGCompassWebapp-0.0.1-SNAPSHOT.war
COPY --from=builder /usr/src/IGCompass_src/IGCompassWebapp/src/main/resources/* /usr/local/tomcat/IGCompassWebapp/src/main/resources/