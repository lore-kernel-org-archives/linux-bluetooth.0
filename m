Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1137164677.7780.10.camel@pc-05.ycom.ch>
Mime-Version: 1.0
Subject: [Bluez-users] UDEV data missing after hid2hci
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 13 Jan 2006 16:04:37 +0100

Hi, 

I've a bug with my DiNovo keyb and mice.

I cannot force the device name in udev to link against xorg
configuration.

Fixed device name is required for the Xorg configuration, since kernel
and udev change device numbers at reconnect, after a Bluetooth stop to
save batteries.

Example :

/dev/input/event0	-> mouse at startup (in usb mode)
/dev/input/event1	-> keyboard (in usb mode) 
/dev/input/event3	-> mouse in BT mode, if I touch mice first
/dev/input/event4	-> keyboard in BT mode

After a while without using mouse, hidd will stop session with device.
Touching the mouse re-enable the link, but device number could be
event5 !


So, I want to fix the device name with a udev script. Testing : 
KERNEL=="event[0-9]*"  SYSFS{idVendor}=="046d",
SYSFS{idProduct}=="b001", NAME=="input/ev-mx900", MODE=="0664"

Not working !!


/proc/bus/input/devices gives : 
I: Bus=0005 Vendor=046d Product=b001 Version=2200
N: Name="Bluetooth HID Boot Protocol Device"
P: Phys=
S: Sysfs=/class/input/input3
H: Handlers=mouse1 event3
B: EV=7
B: KEY=1f0000 0 0 0 0 0 0 0 0
B: REL=103



So both vendor and device ID are correct.

I check by udev : 
udevinfo -a -p /sys/class/input/event3

device '/sys/class/input/input3/event3' has major:minor 13:67
  looking at class device '/sys/class/input/input3/event3':
    KERNEL=="event3"
    SUBSYSTEM=="input"
    SYSFS{dev}=="13:67"





This mean that the udev struct is not filled with all needed infos to
match udev rules.

Any help to make it working ?

Oh, BTW, tested with linux-2.6.15

Thanks


-- 
        Alexandre



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
