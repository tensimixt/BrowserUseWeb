FROM ubuntu:latest

# Install required dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    xvfb \
    x11vnc \
    firefox \
    bubblewrap \
    # Add other necessary dependencies

# Copy application files
COPY . /app
WORKDIR /app

# Install Python requirements
RUN pip3 install -r requirements.txt

# Expose necessary ports
EXPOSE 5000  # For web interface
EXPOSE 5900  # For VNC

# Start script
CMD ["python3", "app.py"]
