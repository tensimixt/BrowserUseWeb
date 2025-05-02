FROM ubuntu:latest

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    xvfb \
    x11vnc \
    firefox \
    bubblewrap \
    wget \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /app

# Copy application files
COPY . /app

# Install Python requirements
RUN pip3 install --no-cache-dir -r requirements.txt

# Install latest geckodriver for Firefox
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux64.tar.gz \
    && tar -xvzf geckodriver-v0.33.0-linux64.tar.gz \
    && chmod +x geckodriver \
    && mv geckodriver /usr/local/bin/ \
    && rm geckodriver-v0.33.0-linux64.tar.gz

# Create directory for virtual display
RUN mkdir -p /tmp/.X11-unix

# Expose ports
EXPOSE 5000
EXPOSE 5900

# Set environment variables
ENV DISPLAY=:99
ENV OPENAI_API_KEY=${OPENAI_API_KEY}
ENV GOOGLE_API_KEY=${GOOGLE_API_KEY}

# Start script (you might need to adjust this based on your actual entry point)
CMD ["python3", "app.py"]
