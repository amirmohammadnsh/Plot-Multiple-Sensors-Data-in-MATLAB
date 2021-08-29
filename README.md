# Plot-Multiple-Sensors-Data-in-MATLAB
Monitoring multiple sensors data in Real-Time based on MATLAB. By this method you do need to use draw() or any other function which makes delay in your real-time monitoring. 

# How To Implement

1. Implement the proper type connection based on your project, Serial, TCP/IP, ...
2. Initialize global Plots and Plane objects.
3. Plot the firt input on your plane, then the next input just needed to be set on the plane. No need to Re-Plotting.
4. For more information visit "TestMonitorSensorData.m" script.

# Notes

I tested this method on Lis3mdl magnetometers, 40 Hz sampling rate, TCP/IP connection and monitoring 12 sensors simultaneously without any delay.

![alt text](https://github.com/amirmohammadnsh/Plot-Multiple-Sensors-Data-in-MATLAB/blob/96cf8f6155ba9befbb59c5c6e8ee6f6652bc4d19/Monitoring-8-Sensors.jpg)
