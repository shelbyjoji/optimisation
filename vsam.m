function[x,z]=vsam(a,s,b,d,c1)
x=zeros(a,b);
c=c1;
for k=1:a+b-1

    %row difference
    %define array to hold the least two minimum numbers in the row and array to hold the position of minimum 
    mr1=zeros(a,1);
    mr2=mr1;
    mc1=zeros(1,a);
    for i=1:a
      minr=inf;
      for j=1:b % finding minimum in the ith row and its position
        if c(i,j)<minr
            minr=c(i,j);
            mc1(i)=j; % we get the position of lowest element
        end
      end
      mr1(i)=minr;
    end
    clear i;
    clear j;
    %Since we get the position of lowest element, we can find the next lowest 
    for i=1:a
      minr=inf;
      for j=1:b % finding minimum in the ith row and its position
          if j~=mc1(i) %if position of next lowest element is not the lowest
            if c(i,j)<minr
                minr=c(i,j);
            end
          end
      end
      mr2(i)=minr;
    end
      
    %column difference
    %define array for the least two minimum numbers in the column and another array to hold the position of minimum in each column 
    mc1=zeros(1,b);
    mc2=mc1;
    posr=zeros(1,b);
    for i=1:b
      minc=inf;
      for j=1:a % loop to find minimum in the ith column and its position
        if c(j,i)<minc
            minc=c(j,i);
            posr(i)=j; % we get the position of lowest element
        end
      end
      mc1(i)=minc;
    end
    
    %Since we get the position of lowest element, we can find the next
    %lowest in the column
    for i=1:b
      minc=inf;
      for j=1:a % finding minimum in the ith column and its position
          if j~=posr(i) %if position of next lowest element is not the lowest
            if c(j,i)<minc
                minc=c(j,i);
            end
          end
      end
      mc2(i)=minc;
    end
    
    %penalty
    rp=zeros(1,a);
    cp=zeros(b,1);
    rp=abs(mr2-mr1);%row penalty
    cp=abs(mc2-mc1);%coulmn penalty
    
    %find the maximum value of row penalty and its index
    
    
    Mrp=0;
    for i=1:a
        if rp(i)>=Mrp
            Mrp=rp(i);
            Irp=i; 
        end
    end
    
    %largest row penalty R and index iminrow
    Mcp=0;
    for j=1:b
        if cp(j)>=Mcp
            Mcp=cp(j);
            Icp=j;
        end
    end
       
    I=0;
    M=0;
    signal=0;
    oc=c(:,Icp);
    or=c(Irp,:);
    % if column has larger or equal penality
    if Mcp>=Mrp
        [M,I]=min(oc);
        if s(I)>d(Icp)
             x(I,Icp)=d(Icp);
             s(I)=s(I)-d(Icp);
             d(Icp)=0;
             Signal=0;% column needs to be eliminated
        elseif s(I)<d(Icp)
             x(I,Icp)=s(I);
             d(Icp)=d(Icp)-s(I);
             s(I)=0;
             signal=1;% row needs to be eliminated
        else
             x(I,Icp)=d(Icp);
             s(I)=0;
             d(Icp)=0;
             signal=2;% row and column needs to be eliminated
        end
        %next elimination is performed
        if signal==0
            c(:,Icp)=inf;
        elseif signal==1
            c(I,:)=inf;
        elseif signal==2
            c(:,Icp)=inf;
            c(I,:)=inf;
        end
        
    else%hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
        
        [M,I]=min(or);
        if s(Irp)>d(I)
             x(Irp,I)=d(I);
             s(Irp)=s(Irp)-d(I);
             d(I)=0;
             Signal=0;% column needs to be eliminated
        elseif s(Irp)<d(I)
             x(Irp,I)=s(Irp);
             d(I)=d(I)-s(Irp);
             s(Irp)=0;
             signal=1;% row needs to be eliminated
        else
             x(Irp,I)=d(I);
             s(Irp)=0;
             d(I)=0;
             signal=2;% row and column needs to be eliminated
        end
        %next elimination is performed
        if signal==0
            c(:,I)=inf;
        elseif signal==1
            c(Irp,:)=inf;
        elseif signal==2
            c(:,I)=inf;
            c(Irp,:)=inf;
        end
    end
end
z=sum(sum(c1.*x));
end
