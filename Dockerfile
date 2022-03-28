#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
ENV PORT=8080
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/praksa2022-0.0.1-SNAPSHOT.jar /usr/local/lib/praksa2022.jar
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/praksa2022.jar"]