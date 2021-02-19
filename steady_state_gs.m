function [ T ] = steady_state_gs(error,tol,nx,ny,Told)
  
%creating mesh
x = linspace(0,1,nx);
y = x;
dx = x(2) - x(1);
dy = dx;
T_gs = Told ;

%gauss seidel method
  
  k = 2*(dx^2+dy^2)/(dx^2 * dy^2);

  gs_iter = 1;
  
  %convergence loop
  while(error > tol)
    
      %space loop
      for i = 2:nx-1
       
          for j = 2:ny-1
             
                 term3 = (Told(i+1,j) + T_gs(i-1,j))/(dx^2);
                 term4 = (Told(i,j+1) + T_gs(i,j-1))/(dy^2);
                 
                 
                 T_gs(i,j) = term3/k + term4/k ; 
                  
          end
        
      end
    
    %calculating error 
    error = max(max(abs(Told - T_gs)));
    %updating the value
    Told = T_gs;
    gs_iter = gs_iter + 1;
   
    %plotting of results
    figure(2);
    contourf(T_gs,10);
    set(gca,'yDIR','reverse');
    colorbar;
    title_text = sprintf('GS iteratons = %d',gs_iter);
    title(title_text)
    xlabel('x');
    ylabel('y');
    pause(0.03)
    
  end 
  
end