# Base image with CUDA, cuDNN, PyTorch pre-installed
FROM pytorch/pytorch:2.7.1-cuda11.8-cudnn9-runtime

LABEL maintainer="Merve Unlu"

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8
    
RUN apt-get update && apt-get install -y build-essential

# Upgrade pip and install Python libraries
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
        transformers \
        pandas \
        datasets \
        evaluate \
        protobuf \
        tiktoken \ 
        sentencepiece \
        accelerate>=0.26.0 
        
RUN pip install --upgrade transformers 

# Optional: install additional dependencies from requirements.txt if you have one
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt || true

# Optional entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
