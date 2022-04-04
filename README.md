# Introduction
This is a program written in **Haskell** that will load an image and convert the image into **ASCII art** using a special formula to make it look extremely similar to the original image.

-Need to make sure the program works still, last updated in march 2020

## Requirements:
you will need to install the package "bmp-1.2.6.3".

## Instructions:

First, load the image by calling the ```loadBitmap``` function on the image. For example, if the image is called "flower" you would do ```loadBitmap "flower.bmp"```
This would result in a two-dimensional list of pixels as a return value. This allows you to call the ```displayImage``` function to see the end result.

```displayImage ".-+*#" True (loadBitmap "sample_image_to_search.bmp")``` This command would load the image and convert it so that `.` would be used for **white** pixels, and `#` is used for **black** pixels. The characters in between the first and last character would be used for different shades of **grey** accordingly. In this case, `-+*` would be used for 3 shades of grey... 75%, 50%, & 25%. The algorithm I made will automatically split the shades of grey into a balanced amount. For example, if we had `.$%^&#` then `.` & `#` would be used for white and black pixels respectively and then `$%^&` would be split into 4 quadrants equally instead of 3. The **true/false** paramteres in the function switches white and blacks meaning the first pixel would be black instead of white and the last white instead of black

The **showAsASCIIArt** function will allow you to view the result of your function. it should be called on the previous function ran to view the results. 

For instance: ```showAsASCIIArt (displayImage ".-+*#" True (loadBitmap "sample_image_to_search.bmp"))```


## Note: 
this program only works with bitmap files (.bmp)

This is outdated and needs to be updated I believe
-- also need a haskell refresher.
