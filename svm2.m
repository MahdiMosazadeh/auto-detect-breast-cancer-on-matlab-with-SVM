clear;clc;
load('brCan_data-1.mat');
brCan_data = brCan_data';       % Transport(change row and column)

brCan_data(1,:)=[];             % Delete first row becaus ID number is a cheap data

class(1,:) = brCan_data(10,:);  %cut class on brCan_data and Delete class row  
brCan_data(10,:)=[];

[class index]= sort(class);     % sort class and brCan_data
brCan_data=brCan_data(:,[index]);

clear index;

for j = 1:458                   % replace zero numbers ?? ???? average
    for i = 1:9
        if brCan_data(i,j)==0
            brCan_data(i,j)=mean(brCan_data(i,1:458));
        end
    end
end

for j = 459:699                   % replace zero numbers ?? ???? average
    for i = 1:9
        if brCan_data(i,j)==0
            brCan_data(i,j)=mean(brCan_data(i,459:699));
        end
    end
end

class(class==2)=1;              % reaplace 2 -> 1 && 4 ->4
class(class==4)=-1;

brCan_data(5:9,:)=[];

%% svm code
x = brCan_data;
t = class;

xTrainAtt = [brCan_data(:,1:200) brCan_data(:,459:658)];
xTrainClass = [ones(1,200) -1*ones(1,200)];

xTestAtt = [brCan_data(:,201:458) brCan_data(:,659:699)];
xTestClass = [ones(1,258) -1*ones(1,41)];

net = fitcsvm (xTrainAtt',xTrainClass);
yy=predict(net,xTestAtt');
k = 0;
for i = 1:299
    if xTestClass(i) == yy(i);
        k = k + 1;
    end
end

CCR = (k/299)*100