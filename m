Return-Path: <cyrus@holtmann.org>
From: gene heskett <gheskett@wdtv.com>
To: linux-hotplug@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: At wits end with a Broadcom Corp BCM92046DG-CL1ROM
Date: Sun, 2 Jan 2011 13:27:41 -0500
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201101021327.41699.gheskett@wdtv.com>
Sender: linux-hotplug-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings all;

This device, a bluetooth button/dongle, or the a7 eb101 it pairs with to 
create a virtual rs232 cable, have to be the most obstinate inanimate 
devices ever.

AIUI the BT specs, 2 devices once paired, are to remain so, even after 
powerdowns, until such time as a new pairing is performed.  Right?  Or does 
linux impose its own rules for low traffic, slow (9600 baud) bluetooth 
links?

It takes about a days messing around to finally get it to work, usually 
accomplished by unplugging it long enough for linux to detect and do the 
cleanup.  Then when plugging it back in, if one is quick enough to catch it 
before bluetoothd times out and goes away and gets blueman-manager running 
within this timeout, which appears to be in the 5 second range after its 
rediscovery, then, 1 time only per reboot of this machine, I can get it to 
work, and it works error free, with good signal strength showing in 
blueman-manager.  For possibly 12 hours or so.  At some point, blueman-
manager goes away silently, and the link is dropped and cannot be re-
established by the same procedure until I have rebooted this box again.

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

And as of this instant /dev/rfcomm0 has not been removed.  And the link is 
dead.

It seems to me there should be a foolproof method that will accomplish this 
from reboot to reboot, but I haven't found the method yet despite warming 
up googles servers searching for instructional material that does NOT 
appear to exist.

What can I do, or better yet, where can I find the info that makes this 
Just Work(TM)?

Thanks all.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
New Microsoft PnP documents released: http://www.microsoft.eu.org/PnP.html
