T = readtable('G:\MATLAB2025\Data\finalproject.csv');
T.Properties.VariableNames

% Extract expression matrix and headers
X = T{:,:};                              % Get data as numeric matrix [1217 x 22000]
headers = T.Properties.VariableNames;   % Get gene names (e.g., ENSG00000...)

% Create label vector (normal = 0, cancer = 1 → then add 1)
y = [zeros(36,1); ones(1181,1)];
y_feast = uint16(y + 1);  

% Transpose X for FEAST
X_feast = X';   % Now [22000 x 1217]

% Run CMIM using FEAST
[selected, scores] = FSToolboxMex(X_feast, y_feast, 'CMIM', 200);

% Get selected gene names
selected_genes = headers(selected);

% Display
disp(selected_genes')