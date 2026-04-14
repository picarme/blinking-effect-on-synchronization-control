%Network
N=20;
A= zeros(N,N);
links =[1 3; 3 4; 3 16; 16 10; 10 9; 10 18; 18 12; 16 2; 2 1; 2 20; 
        1 20; 2 8; 8 7; 7 11; 11 17; 1 14; 14 19; 14 4; 14 13; 1 13; 13 5; 5 15; 15 6];
for l=1: length(links)
    A(links(l,1),links(l,2))=1;
    A(links(l,2),links(l,1))=1;
end

%Laplacian matrix
G=diag(sum(A))-A;

%Probability
p = logspace(-2,0,21);                
Emean = zeros(1,length(p));

%integration parameters
dt =0.0001;                            
steps =1000/dt;

%parameters
ac= -1.27;
bc= -0.68;
gamma =0.0385;
alpha =10;
beta =15;
sigma =2;

for k=1:length(p)
    %Creation of L' matrix
    La = zeros(N,N);
    links2 = [4 18; 12 14; 12 3];
    for l=1:length(links2) 
        La(links2(l,1),links2(l,2)) = -1/p(k);
        La(links2(l,2),links2(l,1)) = -1/p(k);
    end

    %L' matrix
    L = La - diag(sum(La));      

    %initialization
    x=zeros(steps ,N);
    y=zeros(steps ,N);
    z=zeros(steps ,N);

    %initial conditions for Chua ’s oscillators
    xold =0.5* rand(N,1);
    yold =0.5* rand(N,1);
    zold =0.5* rand(N,1);
    
    for t=1: steps
        %coupling
        couplingx1 = G*xold;
        couplingy1 = G*yold;

        couplingx2 = (G+L)*xold;
        couplingy2 = (G+L)*yold;
        
        %Probability of having the links
        if(mod(t,10) == 1) 
            if rand < p(k)                     
                couplingx = couplingx2;
                couplingy = couplingy2;
            else                            
                couplingx = couplingx1;
                couplingy = couplingy1;
            end
        end 
        
        %dynamics
        fc=-bc*xold+(-ac+bc)/2*( abs(xold +1)-abs(xold -1));
        dxdt=alpha *(yold -xold+fc)-sigma*couplingx;
        dydt=xold -yold+zold -sigma*couplingy;
        dzdt=-beta*yold -gamma*zold;

        xnew=xold+dt*dxdt;
        ynew=yold+dt*dydt;
        znew=zold+dt*dzdt;

        xold=xnew;
        yold=ynew;
        zold=znew;

        x(t,:)=xnew;
        y(t,:)=ynew;
        z(t,:)=znew;     
    end

    %Global Error
    E=0;
    for i=1:N
        for j=1:N
            Ee =(((x(:,(i))-x(:,(j))).^2+(y(:,(i))-y(:,(j))).^2+(z(:,(i))-z(:,(j))).^2));
            E=E+Ee;
        end
    end
    E=sqrt(E/N/(N-1));

    %Error between 4 and 12 
    Ee4 = (((x(:,(4)) - x(:,(12))).^2 +(y(:,(4))-y(:,(12))).^2+(z(:,(4))-z(:,(12))).^2));
    E4 = sqrt(Ee4);
    %Average of the error (between 4 and 12) from half to end of the signal
    Emean1 = mean(E4(end/2:end));        
    Emean(1,k) = Emean1;
end

%plot of the synchronization Error
figure, plot((1:steps)*dt,E,'k '), xlabel('t'), ylabel('e(t)');
figure, plot((1:steps)*dt,E4,'k '), xlabel('t'), ylabel('e4,12(t)');
figure, plot(p, Emean, 'k'), xlabel('p'), ylabel('Average Error'); 