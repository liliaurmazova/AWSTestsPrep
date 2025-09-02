# Multi-stage Docker build for testing and deployment
FROM python:3.13-slim as base

# Set working directory
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Testing stage
FROM base as testing

# Install additional testing dependencies
RUN pip install --no-cache-dir \
    pytest-html \
    pytest-cov \
    pytest-xdist \
    bandit \
    safety \
    flake8 \
    black \
    isort \
    mypy

# Copy source code
COPY . .

# Create reports directory
RUN mkdir -p /app/reports

# Run tests as default command
CMD ["pytest"]

