Return-Path: <cyrus@holtmann.org>
To: linux-hotplug@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: At wits end with a Broadcom Corp BCM92046DG-CL1ROM
From: gene heskett <gheskett@wdtv.com>
Date: Mon, 3 Jan 2011 15:52:14 -0500
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201101031552.15059.gheskett@wdtv.com>
Sender: linux-hotplug-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings all;

Ping?  Repeat post with a few additions.

This device, a bluetooth button/dongle, or the a7 eb101 it pairs with to 
create a virtual rs232 cable, have to be the most obstinate inanimate 
devices ever.

AIUI the BT specs, 2 devices once paired, are to remain so, even after 
powerdowns, until such time as a new pairing is performed.  Right/wrong?  

It takes about a days messing around to finally get it to work, usually 
accomplished by unplugging it long enough for linux to detect and do the 
cleanup.  Then when plugging it back in, if one is quick enough to catch it 
before bluetoothd times out and goes away and gets blueman-manager running 
within this timeout, which appears to be in the 5 second range after its 
rediscovery, then, 1 time only per reboot of this machine, I can get it to 
work, and it works error free, with good signal strength showing in 
blueman-manager.  For possibly 12 hours or so.  At some point, blueman-
manager goes away silently, and the link is dropped and cannot be re-
established by the same procedure until I have rebooted both boxes again.

Pertinent (maybe) info:
current kernel: 2.6.37-rc8
current distro:	PClos, 32 bit, 100% uptodate
current hdwe:   AMD quad core phenom, 4Gb dram, 4 Tb of drives
current gui:    KDE-4.5.4

I have edited /etc/bluetooth/rfcomm.conf to:
#
# RFCOMM configuration file.
#
# this was ALL commented out
rfcomm0 {
#	# Automatically bind the device at startup
	bind yes;
#
#	# Bluetooth address of the device
	device 00:0C:84:00:86:F8;
#
#	# RFCOMM channel for the connection
	channel	1;
#
#	# Description of the connection
#	comment "Example Bluetooth device";
	comment "connection to coco3's eb-301 device";
}

Added question: Pin seems to be a problem as I have to answer several 
requests for it, and it seems to work only if I press the enter key in the 
requester box, which seemingly has no effect, and then click the ok button, 
which puts 5 bytes in the buffer.  And FWIW, I have noted that the 4 digit 
pin is stored as 5 bytes long no matter how I generate it, including 
deleting the file and building a new one.  So my added question is, why is 
the return key not being accepted as the "go do it" key?

And as of this instant /dev/rfcomm0 has not been removed.  And the link is 
dead.  And is again working after a reboot of both machines.  No clue how 
long though.

It seems to me there should be a foolproof method that will accomplish this 
from reboot to reboot, but I haven't found the method yet despite warming 
up googles servers searching for instructional material that does NOT 
appear to exist or is so dated that the 2nd or third example in any of 
those tuts is no longer valid.

What can I do, or better yet, URL's where can I find the info that makes 
this Just Work(TM) for a more modern 2010-2011 distribution using todays 
kernels?

Thanks all.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)

