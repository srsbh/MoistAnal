path="/home/subhar/data/2017_07_26/min/";
list=getFileList(path);

Dialog.create("File type");
Dialog.addString("File suffix: ", ".JPG", 5);
Dialog.show();
suffix = Dialog.getString();
threshVal=parseInt(suffix); 
for(i=0;i<list.length;i++){
	open(path+list[i]);
	run("ROI Manager...");
	roiManager("Open", path+"RoiSet.zip");
	roiManager("Show All");
	run("Set Measurements...", "area mean min area_fraction redirect=None decimal=3");
	run("8-bit");
	setAutoThreshold("Default");
	//run("Threshold...");
	//setThreshold(0, threshVal);
	setOption("BlackBackground", false);
	run("Convert to Mask");

	pr="proc";
	ext=".jpg";
	saveAs("Jpeg", path+pr+list[i]+ext);
	roiManager("multi-measure measure_all one append");

	
	
	 // close all windows
		while (nImages>0) { 
		  selectImage(nImages); 
		  close(); 
		} 	
		
	roiManager("reset") 


} 
selectWindow("Results");
saveAs("Results", path+"Results.csv");
