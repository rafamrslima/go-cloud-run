# Go Cloud Run

A minimal Go HTTP server ready for deployment on [Google Cloud Run](https://cloud.google.com/run).

## Overview

This service listens on the port provided by the `$PORT` environment variable (injected automatically by Cloud Run) and responds to all HTTP requests.

## Requirements

- [Go 1.24+](https://golang.org/dl/)
- [Docker](https://www.docker.com/)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) (`gcloud`)

## Running Locally

```bash
go run main.go
```

The server will start on port `8080` by default. Visit http://localhost:8080.

## Running with Docker

```bash
# Build the image
docker build -t go-cloud-run .

# Run the container
docker run -p 8080:8080 go-cloud-run
```

## Deploying to Cloud Run

### 1. Authenticate with GCP

```bash
gcloud auth login
gcloud config set project YOUR_PROJECT_ID
```

### 2. Build and push the image

```bash
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/go-cloud-run
```

### 3. Deploy to Cloud Run

```bash
gcloud run deploy go-cloud-run \
  --image gcr.io/YOUR_PROJECT_ID/go-cloud-run \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

After deployment, `gcloud` will output the public URL of your service.

## Project Structure

```
.
├── Dockerfile   # Multi-stage build for a minimal production image
├── go.mod       # Go module definition
└── main.go      # HTTP server entry point
```

## How It Works

Cloud Run injects a `$PORT` environment variable at runtime. The server reads this value and binds to that port, which is the required behavior for all Cloud Run services.
