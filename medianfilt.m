function [outimg] = medianfilt(img,sz)
    sim_coef = 0;
    temp_image = img;
    [rows,cols] = size(img);    
    pad = sz-1; 
    nimg = zeros(rows+pad,cols+pad); 
    nimg(pad/2+1:rows+pad/2, pad/2+1:cols+pad/2) = img;
    outimg = zeros(rows,cols);
    for x = pad/2 + 1 : cols + pad/2
        for y = pad/2 + 1 : rows + pad/2
            
            win = nimg(y-pad/2:y+pad/2, x-pad/2:x+pad/2);
            
            white_noise_count = 0;
            black_noise_count = 0;
            
            for win_row=1: size(win, 1)
                for win_col=1: size(win, 2)
                    
                    if win(win_row, win_col) == 1
                        white_noise_count = white_noise_count + 1;
                    end
                    
                    if win(win_row, win_col) == 0
                        black_noise_count = black_noise_count + 1;
                    end
                    
                end
            end
            
            %%inja check kon noise haro
            temp = win(win(:) ~= 1 & win(:) ~= 0);
            temp = median(sort(temp(:)));
            med = median(sort(win(:)));
            if black_noise_count/numel(win) > 0.5
                
                outimg(y-pad/2,x-pad/2) = median(temp(:));
            
            elseif white_noise_count/numel(win) > 0.5
                
                outimg(y-pad/2,x-pad/2) = temp;
            
            else
                outimg(y-pad/2,x-pad/2) = med;
            end
            
            if temp == med
                sim_coef = sim_coef + 1;
            end
            %outimg(y-pad/2,x-pad/2) = median(temp(:));
            %outimg(y-pad/2,x-pad/2) = median(win(:));
            
            
        end
    end
end