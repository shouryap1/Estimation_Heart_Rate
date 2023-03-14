% Load CSV file
data = readmatrix('Capture_heart_beat.csv');

% Extract signal and sampling rate
signal = data;
Fs = 15;

% Perform FFT
L = length(signal);
Y = fft(signal);
P2 = abs(Y);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
P1(1)=0.04;

% Plot original magnitude spectrum
figure;
plot(f,P1)
title('Single-Sided Amplitude Spectrum of Signal')
xlabel('f (Hz)')
ylabel('|P1(f)|')

bandpass(Y,[1,2],Fs)
% Apply bandpass filter
Wp = [1 2]/(Fs/2);
[b,a] = butter(10,Wp,'bandpass');
signal_filtered = filter(b,a,signal);

% Perform FFT on filtered signal
L_filt = length(signal_filtered);
Y_filt = fft(signal_filtered);
P2_filt = abs(Y_filt/L_filt);
P1_filt = P2_filt(1:L_filt/2+1);
P1_filt(2:end-1) = 2*P1_filt(2:end-1);
f_filt = Fs*(0:(L_filt/2))/L_filt;

% Plot filtered magnitude spectrum
figure;
plot(f_filt,P1_filt)
title('Amplitude Spectrum of Filtered Signal')
xlabel('f (Hz)')
ylabel('|P1(f)|')
