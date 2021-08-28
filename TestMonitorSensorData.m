function [recvData] = TestMonitorSensorData(nSamples,selectedSensors)


MAX_NUMBER_OF_SENSORS = 16; % sensors' number are between 1 and 16

if length(selectedSensors) ~= length(unique(selectedSensors))
     error("There are sensors which are selected more than once.");
end
if max(selectedSensors) > MAX_NUMBER_OF_SENSORS
    error("There are sensors which their number is out of range.");
end
load("sensorsData.mat");
input = 65 ; %Number of Recieving Bytes

recvData = zeros(nSamples,input);
time = zeros(nSamples,input);
nPlot = length(selectedSensors);

global plots ;
plots = gobjects(3,nPlot);
global plane;
plane = gobjects(1,nPlot);

nRow = 0;
terminator = 32767;
% Calculate Number of Rows in order to put 2 figs in Each of Them
if (mod(nPlot,2) == 0 )
    nRow = nPlot/2;
else
    nRow = (nPlot+1) /2 ;
end
arePlotsInitialized = false;
sample= 1;
figure('units','normalized','outerposition',[0 0 1 1])
tic ;
while true
    recvData(sample,1:input) = sensorsData(sample,1:input);
    if recvData(sample,input)==terminator
        if(recvData(sample,[1,5,9,13,17,21,25,29,33,37,41,45,49,53,57,61])==[1:16])
        % based on your input data, you may need the upper condition    
            time(sample,1) = toc;
            % Initializing Plot Plane and their properties
            if arePlotsInitialized == false
                if nPlot == 1
                    plane(1,1) = subplot(nRow,1,1);
                    plots(1:3,1) = plot(time(1,1),recvData(1,selectedSensors(1,1)*4-2:selectedSensors(1,1)*4));
                    SetFiguresProperty(sprintf('Sensor %d',selectedSensors(1,1)));
                    legend("X","Y","Z");
                elseif nPlot>1
                    for i=1:1:nPlot
                        plane(1,i) = subplot(nRow,2,i);
                        plots(1:3,i)=plot(time(1,1),recvData(1,selectedSensors(1,i)*4-2:selectedSensors(1,i)*4));
                        SetFiguresProperty(sprintf('Sensor %d',selectedSensors(1,i)));
                    end
                    legend("X","Y","Z");
                    if((mod(nPlot,2) ~= 0))% If you have odd number of plots
                        pos = get(plane,'Position');
                        new = mean(cellfun(@(v)v(1),pos(1:2)));
                        set(plane(i),'Position',[new,pos{end}(2:end)]);
                    end
                end
                pause(1);% remove this line in your real-time plotting
                sample = sample+1
                arePlotsInitialized = true;
            elseif  arePlotsInitialized == true
                time(sample,1) = toc ;
                % Real-Time Plotting, Updates your plot
                for j =1:1:nPlot
                    set(plots(1,j),'XData',time(1:sample,1),'YData', recvData(1:sample,selectedSensors(1,j)*4-2));
                    set(plots(2,j),'XData',time(1:sample,1),'YData', recvData(1:sample,selectedSensors(1,j)*4-1));
                    set(plots(3,j),'XData',time(1:sample,1),'YData', recvData(1:sample,selectedSensors(1,j)*4));
                end
                pause(0.5); % remove this line in your real-time plotting
                sample = sample+1
            end
        end
    end
end
end

function SetFiguresProperty(titleName)
set(gca,'FontSize',10,'FontWeight','bold');
xlabel('Time(Sec)','fontsize',10,'FontWeight','normal');
ylabel('Magnitude ','fontsize',10,'FontWeight','normal');
title(titleName,'FontSize',12);
grid on ;
end




