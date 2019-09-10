FROM maven:3.6.0-jdk-8 AS builder
WORKDIR /usr/src/
RUN git clone https://github.com/gt-health/VRDR_javalib.git
RUN  mvn clean install -DskipTests -f VRDR_javalib
ADD . ./IGCompass
RUN mvn clean package -DskipTests -f IGCompass

FROM tomcat:latest
#move the WAR for contesa to the webapps directory
COPY --from=builder /usr/src/IGCompass/IGCompassWebapp/target/IGCompassWebapp-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/IGCompassWebapp-0.0.1-SNAPSHOT.war
COPY --from=builder /usr/src/IGCompass/IGCompassWebapp/src/main/resources/* /usr/local/tomcat/IGCompassWebapp/src/main/resources/
