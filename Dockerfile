# Dockerfile for squareup/certstrap
#
# To build this image:
#     docker build -t squareup/certstrap .
#
# To run certstrap from the image (for example):
#     docker run --rm squareup/certstrap --version

FROM golang:1.11.2-alpine as build

MAINTAINER Cedric Staub "cs@squareup.com"

# Add git, gcc for module dependencies
RUN apk add --no-cache git gcc musl-dev

# Copy source
WORKDIR /certstrap
COPY . .

# Build
RUN go build -o /usr/bin/certstrap .

# Create a multi-stage build with the binary
FROM alpine

COPY --from=build /usr/bin/certstrap /usr/bin/certstrap

ENTRYPOINT ["/usr/bin/certstrap"]
