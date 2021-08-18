function z = mahdi (a)
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
class(class==4)=2;

%% FDR eslah shode ostad rajeby ba genetic algorimt
a = [a(1);a(2);a(3);a(4);a(5);a(6);a(7);a(8);a(9)];

xx = brCan_data;
mu1 = mean (xx(:,1:458),2);
mu2 = mean (xx(:,459:699),2);

s1 = 0;
for i = 1:458
    s1 = s1 + (xx(:,i)-mu1) * (xx(:,i)-mu2)';
end
s1 = s1/458;

s2 = 0;
for i = 459:699
    s2 = s2 + (xx(:,i)-mu1) * (xx(:,i)-mu2)';
end
s2 = s2/241;

z = (a' * s1 * a + a' * s2 * a) / (a' * (mu1 - mu2) * (mu1 - mu2)' * a);
end