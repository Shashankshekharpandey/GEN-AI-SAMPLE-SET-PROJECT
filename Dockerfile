FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Set environment variables for Streamlit
ENV PYTHONUNBUFFERED=1
ENV STREAMLIT_SERVER_PORT=8501
ENV STREAMLIT_SERVER_HEADLESS=true

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install pip and dependencies
RUN pip install --upgrade pip

# Install Python dependencies
RUN pip install --no-cache-dir \
    streamlit \
    python-dotenv \
    langchain \
    unstructured \
    faiss-cpu \
    sentence-transformers \
    torch \
    transformers

# Expose the port the app runs on
EXPOSE 8501

# Run Streamlit when the container launches
CMD ["streamlit", "run", "app.py"]
