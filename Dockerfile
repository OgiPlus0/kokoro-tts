# Start with Python 3.12
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install git and wget for downloading resources
RUN apt-get update && \
    apt-get install -y git wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone the repository
RUN git clone https://github.com/nazdridoy/kokoro-tts.git /app && \
    rm -rf .git

# Download required model files
RUN wget https://github.com/nazdridoy/kokoro-tts/releases/download/v1.0.0/voices-v1.0.bin && \
    wget https://github.com/nazdridoy/kokoro-tts/releases/download/v1.0.0/kokoro-v1.0.onnx

# Install dependencies using pip
RUN pip install --no-cache-dir -r requirements.txt

# Set the default command
CMD ["python", "kokoro-tts.py"]

# Expose port if the application has a web interface
# EXPOSE 8000