#! /usr/bin/env python


#Instructions on how to use.
#1) Change unix directory to the one that contains this file
#2) Set "path" variable. This is where the files to be converted are located
#3) Set "filestem" variable. This is a substring contained in all the files
#that you desire to be converted. For ex, you could set it to "rbsp_" to convert
#all files with this substring
#4) Set init_suffix and final_suffix
#5) At the Unix prompt type ./convert_image_type.py
#6) Wait.....large files can take some time to convert.


#Grab a bunch of files of similar type (e.g. .eps) and convert to another type




import subprocess
import os
from os import listdir
from PIL import Image

#--------------------------------------------------
#INPUT VARIABLES


# path = '/Users/aaronbreneman/Desktop/code/Aaron/RBSP/efw_barrel_coherence_analysis/barrel_missionwide_plots/'
#path = '/Users/aaronbreneman/Desktop/Research/RBSP_hiss_precip2_coherence_survey/plots/'
#path = '/Users/aaronbreneman/Desktop/Research/RBSP_hiss_precip2_coherence_survey/paper2/figures/'
#path = '/Users/aaronbreneman/Desktop/Research/RBSP_hiss_precip2_coherence_survey/plots/'
#path = '/Users/aaronbreneman/Desktop/Research/RBSP_hiss_precip2_coherence_survey/plots/'
#path = '/Users/aaronbreneman/Desktop/Research/OTHER/Stuff_for_other_people/Wygant_John/V1_saturation_issue/Archive/'

#path = '/Users/aaronbreneman/Desktop/Research/OTHER/Stuff_for_other_people/Cattell_Cindy/goldstein_field_models/20151214/'
#path = '/Users/aaronbreneman/Desktop/Research/RBSP_hiss_precip2_coherence_survey/data/tplot_vars_2014_run2_coh_plots/'
#path = '/Users/aaronbreneman/Desktop/'
#path = '/Users/aaronbreneman/Desktop/Research/RBSP_hiss_precip2_coherence_survey/plots/barrel_movie_10-60min_ratiomax=1.05_NEW/'
#filestem = 'fbk_interpol_20130114_sf=0.6'
#filestem = 'psphere_plot_jan8'
#filestem = 'jan8_pressure_event_chorus_hiss_fft_comparison'
#filestem = 'plot_'
path = "/Users/abrenema/Desktop/Research/RBSP_Firebird_microburst_conjunctions_all/conjunction_extended_plots/e12dc/"
#path = '/Users/aaronbreneman/Desktop/Research/OTHER/proposals/2020_CubeSat_Colpitts_IMPAX/raytracing_dispersion_analysis/'
filestem = '20'
init_suffix = '.ps'
final_suffix = '.png'




#--------------------------------------------------



files = os.listdir(path)

goodfiles = []
for x in range(0,len(files)):
    loc = files[x].find(filestem)
    if loc != -1:
        loc = files[x].find(init_suffix)
        if loc != -1:
            goodfiles.append(files[x])
            tmp = files[x]
            print(tmp[0:loc]+final_suffix)
            #exit_code = subprocess.call(['convert',path+tmp,path+tmp[0:loc]+final_suffix])
            #os.system('convert ' + path+tmp + ' ' + path+tmp[0:loc]+final_suffix)
            #psimage=Image.open(path+tmp)
            #psimage.save(path+tmp[0:loc]+final_suffix)
            Image.open(path+tmp).save(path+tmp[0:loc]+final_suffix)

print("END OF PROGRAM convert_image_type.py")



