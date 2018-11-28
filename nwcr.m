%Northwest corner rule
format short e
a = input(' Enter the number of souces: ');
s = [];% Initialize array/vector
d = [];% Initialize array/vector
for i=1:a
  s(i) =  input('Enter availability at souces: ');
end
b = input(' Enter the number of destinations: ');
for i=1:b
  d(i) =  input('Enter demands at destinations: ');
end
c=zeros(a,b);
for i=1:a
    for j=1:b
        c(i,j)= input(sprintf('Enter cost of sending product from source %d to destination %d:\t',i,j));
    end
end
[x,z]=nwcf(a,s,b,d,c);
disp(x);
fprintf("Optimal cost per North west corner rule: %d\n",z);
[x,z]=vsam(a,s,b,d,c);
disp(x);
fprintf("Optimal cost per Vogel's approximation method: %d\n",z);
