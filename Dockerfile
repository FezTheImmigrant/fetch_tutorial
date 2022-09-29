FROM tensorflow/tensorflow:devel-gpu

#RUN rm /etc/apt/sources.list.d/cuda.list
#RUN rm /etc/apt/sources.list.d/nvidia-ml.list

# needed for openCV
RUN apt-get update 
RUN apt-get install ffmpeg libsm6 libxext6  -y 

RUN python3 -m pip uninstall -y enum34


WORKDIR /app/
COPY . .

RUN python3 -m pip install pycocotools lvis pyparsing==2.4.7 opencv-python-headless==4.5.*
RUN python3 -m pip install --upgrade bosdyn-client bosdyn-mission bosdyn-choreography-client
#RUN python3 -m pip install tensorflow-gpu==2.3.1 tensorflow==2.3.1 tensorboard==2.3.0 tf-models-official==2.3.0 pycocotools lvis pyparsing==2.4.7 opencv-python-headless==4.5.*

RUN python3 -m pip install models-with-protos/research


CMD ["python3", "model_main_tf2.py"," --model_dir=dogtoy/models/my_ssd_resnet50_v1_fpn --pipeline_config_path=dogtoy/models/my_ssd_resnet50_v1_fpn/pipeline.config --num_train_steps=20000"]
