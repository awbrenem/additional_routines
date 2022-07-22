;Create cyclotron frequency or other lines and (if requested) combine them with spectral tplot variables. 
;

;Variables:
; tbmag = tplot variable of magnetic field magnitude (nT)
; flines = array of factors to multiply fce by (e.g. 1*fce or 0.1*fce)
; tspectra --> optional array of spectral tplot names to add fce lines over top of
; tmlat --> optional tplot name of magnetic latitude (deg) for calculating the equatorial values of fce 
; fnames --> optional array (same size as flines) containing the desired tplot names of each fce variable
;
;
;
;Examples:
;----------
;(1) only Bmag and flines (no mlat to map fce values to magnetic equator)
;tbmag = 'Bmag'
;flines = [1.,0.5,0.1,1/1836.]
;fce_lines_create,tbmag,flines
;Returns tplot variables
  ;fce*1.00000, fce*0.500000, fce*0.100000, fce*0.000544662
;----------
;(2) Bmag, flines, and mlat (maps fce values to equator)
;tbmag = 'Bmag'
;tmlat = 'rbspa_mlat'
;flines = [1.,0.5,0.1,1/1836.]
;fce_lines_create,tbmag,flines
;Returns tplot variables
  ;fce_eq*1.00000, fce_eq*0.500000, fce_eq*0.100000, fce_eq*0.000544662
;----------
;(3) Bmag, flines, fnames, and mlat (Returns fce_eq variables with custom names)
;tbmag = 'Bmag'
;flines = [1.,0.5,0.1,1/1836.]
;fnames = ['fce_eq','fce_eq_2','fce_eq_10','fci_eq']
;tmlat = rb+'_mlat'
;fce_lines_create,tbmag,flines,fnames=fnames,tmlat=tmlat
;Returns tplot variables
  ;fce_eq, fce_eq_2, fce_eq_10, fci_eq
;----------
;(4) add in spectral data 
;tbmag = 'Bmag'
;flines = [1.,0.5,0.1,1/1836.]
;fnames = ['fce_eq','fce_eq_2','fce_eq_10','fci_eq']
;tspectra = ['spec64_e12ac','spec64_scmw']
;tmlat = rb+'_mlat'
;fce_lines_create,tbmag,flines,fnames=fnames,tmlat=tmlat,tspectra=tspectra
;Returns tplot variables
  ;fce_eq, fce_eq_2, fce_eq_10, fci_eq
  ;spec64_e12ac_fces, spec64_scmw_fces

;-------------------------------------------------------------------------------


pro fce_tplot_lines_create,tbmag,flines,$
  tspectra=tspectra,tmlat=tmlat,fnames=fnames


  ;fce variables will be at cadence of magnetic field data
  get_data,tbmag,ttt,magnit
  fce = 28.*magnit


  ;---------------------------------------------------
  ;if magnetic lat variable is set, then map fce to equator
  ;---------------------------------------------------

  if keyword_set(tmlat) then begin
    tinterpol_mxn,tmlat,'Magnitude'
    get_data,tmlat + '_interp',data=mlat
    fce_eq = fce*cos(2*mlat.y*!dtor)^3/sqrt(1+3*sin(mlat.y*!dtor)^2)
  endif else fce_eq = fce

  ;---------------------------------------------------
  ;determine names of output fce tplot variables and create them
  ;---------------------------------------------------

  if ~keyword_set(fnames) then begin
    if keyword_set(tmlat) then fnames = 'fce_eq*'+strtrim(flines,2) else fnames = 'fce*'+strtrim(flines,2)
  endif


  for i=0,n_elements(flines)-1 do store_data,fnames[i],ttt,fce_eq*flines[i]
  


  ;---------------------------------------------------
  ;combine spectral data and fce variables, if desired
  ;---------------------------------------------------
  
  if keyword_set(tspectra) then begin 
    for i=0,n_elements(tspectra)-1 do begin
      store_data,tspectra[i]+'_fces',data=[tspectra[i],fnames]
      ylim,[tspectra[i],tspectra[i]+'_fces'],1,6000,1
    endfor
  endif


  
  
end
