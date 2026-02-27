# Use the official Go image to build the binary
FROM golang:1.25-alpine AS builder
WORKDIR /app
COPY go.mod go.sum* ./
RUN go mod download
COPY . .
RUN go build -o server main.go

# Use a tiny base image for the final container
FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=builder /app/server /server

# Cloud Run injects PORT at runtime
ENV PORT=8080
EXPOSE 8080

CMD ["/server"]