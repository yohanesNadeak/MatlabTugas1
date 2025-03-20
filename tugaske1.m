clear
close all
clc
format long

% Definisikan fungsi
F = @(x) (3*x - 2).*log(x) - (x + 1);

% Plot fungsi
gambar
fplot(F, [0 4]); % Mulai dari 0.01 untuk menghindari log(0)
grid on;
xlabel('x');
ylabel('f(x)');
title('Plot dari f(x) = (3x - 2)*ln(x) - (x + 1)');
set(gca, 'fontsize', 16);

% Inisialisasi tebakan dan parameter untuk metode biseksi
a = 1; % Tebakan pertama
b = 3; % Tebakan kedua
maksIterasi = 20; % Maksimum iterasi
toleransi = 0.001; % Toleransi kesalahan

% Cek tanda fungsi di ujung interval
Fa = F(a);
Fb = F(b);

if Fa * Fb > 0
    error('Fungsi memiliki tanda sama di a dan b. Bisection tidak bisa digunakan.')
else
    disp('Iterasi   a          b          xNS       f(xNS)    Toleransi')
    
    for i = 1:maksIterasi
        xNS = (a + b) / 2; % Titik tengah
        toli = (b - a) / 2; % Perhitungan toleransi
        FxNS = F(xNS); % Nilai fungsi di titik tengah
        
        hold on;
        scatter(xNS, FxNS, 25, 'r', 'filled'); % Tandai titik tengah pada plot
        
        fprintf('%3i %11.6f %11.6f %11.6f %11.6f %11.6f\n',...
                i, a, b, xNS, FxNS, toli);
        
        if FxNS == 0 % Solusi eksak ditemukan
            fprintf('\nSolusi eksak ditemukan: x = %11.6f\n', xNS);
            break;
        end
        
        if toli < toleransi % Cek konvergensi
            fprintf('\nKonvergensi tercapai pada iterasi ke-%i\n', i);
            break;
        end
        
        if F(a) * FxNS < 0
            b = xNS; % Akar ada di [a, xNS]
        else
            a = xNS; % Akar ada di [xNS, b]
        end
    end
    
    xlim([min(a,b), max(a,b)]); % Set batas sumbu x berdasarkan interval
end

hold off; % Lepaskan pegangan pada figur saat ini

% Pesan akhir untuk akar yang ditemukan atau tidak ditemukan setelah maksimum iterasi
if i == maksIterasi && abs(FxNS) > toleransi 
    fprintf('\nMaksimum iterasi tercapai tanpa menemukan akar.\n');
end
xlim ([2 2.8]) %batas X
ylim ([-1 2])  %batas Y
