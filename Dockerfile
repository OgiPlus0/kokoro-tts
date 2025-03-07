FROM nvidia/cuda:12.2.0-runtime-ubuntu22.04
RUN apt-get update && apt-get install -y python3.12 python3-pip git wget libsndfile1 && \
    ln -s /usr/bin/python3.12 /usr/bin/python
WORKDIR /app
RUN git clone -b oguzhan-deneme https://github.com/OgiPlus0/kokoro-tts.git /app && rm -rf .git
RUN wget -O voices-v1.0.bin https://github.com/nazdridoy/kokoro-tts/releases/download/v1.0.0/voices-v1.0.bin && \
    wget -O kokoro-v1.0.onnx https://github.com/nazdridoy/kokoro-tts/releases/download/v1.0.0/kokoro-v1.0.onnx
RUN pip install --no-cache-dir numpy ebooklib beautifulsoup4 soundfile sounddevice kokoro-onnx pymupdf4llm PyMuPDF runpod
COPY kokoro-tts.py /app/kokoro-tts.py
CMD ["python", "kokoro-tts.py", "--serverless"]