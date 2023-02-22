clc;
clear all;

base_url = 'dd.weather.gc.ca/hydrometric/csv/';
province = 'ON';
frequency = 'daily';
file_type = 'csv';
station_id = '04FB001'; % found on excel

my_url = strcat('https://',base_url, province, '/', frequency, '/', ...
    province, '_', station_id, ...
    '_', frequency, '_hydrometric.', file_type);

gauge_data = webread(my_url); 
depth_data = gauge_data.WaterLevel_NiveauD_eau_m_;
depth_data((isnan(depth_data))) = [];
x = 1:1:length(depth_data);
avg_y_scalar = mean(depth_data);
avg_y_vector = avg_y_scalar * ones(1,length(depth_data));
std_y = std(depth_data);
y_plus = depth_data + std_y;
y_minus = depth_data - std_y;
j=1;
for i = length(depth_data):-1:1
 y_minus_reverse(j) = y_minus(i);
 j=j+1; % increment j positive
end
plot(x,depth_data,'b->',x,avg_y_vector, 'g');
d=transpose(y_minus);
dd=transpose(y_plus);
x=[1:1:length(depth_data) length(depth_data):-1:1];
dco=[d dd];
patch(x,dco,'b','facealpha','0.05','edgecolor','r','edgealpha','0.05');
title('Daily Water Level at ATTAWAPISKATRIVER (04FB001)'); 
ylabel('Water Levels [m]'); xlabel('Historical Daily Water Level [Day]');
