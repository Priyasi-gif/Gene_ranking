% Load CSV with preserved headers
T = readtable('G:\MATLAB2025\Data\finalproject.csv', 'VariableNamingRule', 'preserve');
headers = T.Properties.VariableNames;
X = table2array(T);    % [1217 x 22000]

% Labels: normal=0, cancer=1 → make 1 and 2
y = [zeros(36,1); ones(1181,1)];
y_feast = double(y + 1);  % must be double

% Discretize features to 5 bins
numBins = 5;
X_disc = zeros(size(X));
for i = 1:size(X, 2)
    X_disc(:, i) = discretize(X(:, i), numBins); % returns integers
end

X_disc = double(X_disc);  % must be double

% Number of features to select
k = 1000;

% Run FEAST
[selected, scores] = feast('mrmr', k, X_disc, y_feast);

% Map selected indices to gene names
selected_genes = headers(selected);
disp(selected_genes');
