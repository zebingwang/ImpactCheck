#!/bin/bash

## install combine environment
export SCRAM_ARCH=slc7_amd64_gcc700
cmsrel CMSSW_10_2_13
cd CMSSW_10_2_13/src
cmsenv
git cms-init
git clone git@github.com:jonathon-langford/HiggsAnalysis.git
git clone git@github.com:cms-analysis/HiggsAnalysis-CombinedLimit.git HiggsAnalysis/CombinedLimit
git clone https://github.com/cms-analysis/CombineHarvester.git CombineHarvester
cmsenv
scram b -j

pwd
cd ../../


# run the impact
rm higgsCombine*
text2workspace.py datacard_ALPmass11.txt -m 125 -o datacard_ALPmass11.root
combineTool.py -M Impacts -d datacard_ALPmass11.root -m 125 --rMin -0.1 --rMax 1 --robustFit 1 --doInitialFit --cminDefaultMinimizerType Minuit2 --cminDefaultMinimizerStrategy 0 --cminDefaultMinimizerTolerance 0.1 --cminFallbackAlgo Minuit2,0:0.2 --cminFallbackAlgo Minuit2,0:0.4 --X-rtd REMOVE_CONSTANT_ZERO_POINT=1 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2 --setParameters MH=125,r=0.01 --freezeParameters MH #-v 3
combineTool.py -M Impacts -d datacard_ALPmass11.root -m 125 --rMin -0.1 --rMax 1 --robustFit 1 --doFits --cminDefaultMinimizerType Minuit2 --cminDefaultMinimizerStrategy 0 --cminDefaultMinimizerTolerance 0.1 --cminFallbackAlgo Minuit2,0:0.2 --cminFallbackAlgo Minuit2,0:0.4 --X-rtd REMOVE_CONSTANT_ZERO_POINT=1 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2 --setParameters MH=125,r=0.01 --freezeParameters MH
combineTool.py -M Impacts -d datacard_ALPmass11.root -m 125 -o M11_Observed.json
plotImpacts.py -i M11_Observed.json -o M11_Observed_Impact