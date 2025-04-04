# PDP11_stuff
PDP-11-related things: PiDP11, PDP2011, etc.

The PDP2011 is a VHDL implementation of the PDP-11 CPU and various peripherals for it, written by Sytse van Slooten. Learn all about it here: https://pdp2011.sytse.net

I am running it on a CYC1000 FPGA development board: https://shop.trenz-electronic.de/en/TEI0003-03-QFCR4A-CYC1000-with-Intel-Cyclone-10-LP-10CL025-C8-8-MByte-SDRAM-8-MByte-Flash
This a very reasonably-priced and easy-to-use FPGA board.

By default PDP2011 emulates a DEC RP06 disk drive, with a capacity of 176MB, on a SD card.  Sytse provides a disk image of 2.11 BSD Unix.  It runs
well, but it really could use a bigger disk drive. (You can hardly buy a SD card smaller than 8GB these days...)

PDP2011 also supports the DEC RP07 drive, which holds 516MB.  So I made a 2.11 BSD disk image for that drive, which you can download from here.
It is quite up-to-date, at patchlevel 489 for 3/31/2025.

Here is how you can use it:

1: Get PDP2011 running, on a CYC1000 board or some other suitable FPGA board.  The author provides excellent documentation at https://pdp2011.sytse.net

2: Ensure that the RP06 drive actually works on your system, using Sytse's 2.11 BSD image or one of the other opersting system images he has provided.

3: You will need to rebuild PDP2011, so download and install the (free) Quartus Lite FPGA development system from https://www.intel.com/content/www/us/en/products/details/fpga/development-tools/quartus-prime/resource.html

4: Do the one-line change to the PDP2011 VHDL code to enable the RP07 instead of the RP06 drive, and rebuild the system in Quartus.  This is not nearly as scary as it sounds.

5: Copy my new disk image to a SD card (the same way you did it in step 2 above), and boot it up!

6: I highly recommend getting Ethernet networking running on the PDP2011 - it makes 2.11 BSD Unix much easier to use.  I used this Ethernet interface board, which PDP2011 supports out-of-the-box: https://www.olimex.com/Products/Modules/Ethernet/MOD-ENC624J600/


If you ever feel like building a new Unix image from a 2.11 BSD distribution tape, you can use my file PDP2011.config as a starting point.
I based my build on the distribution tape image at https://www.tuhs.org/Archive/Distributions/UCB/2.11BSD-patch481/.
I followed Sytse's excellent instructions at https://pdp2011.sytse.net/wordpress/howto/2-11bsd-rp06/, and the entire process was much less difficult than I expected.
Of course you have to replace all usages of 'rp06' with 'rp07'.  You also have to decide what your disk partition arrangement
will be.  I did this sort of arbitrarily - you can find a description of it in the file disklabel.txt.  

