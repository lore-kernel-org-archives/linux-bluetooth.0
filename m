Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3FFBFC34.3050509@york.ac.uk>
From: Alex Holland <ah160@york.ac.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] blue-fw not working for USB Belkin F8T001 in Gentoo Linux
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 07 Jan 2004 12:31:48 +0000

I'm a Gentoo user, and my kernel and bluetooth modules are all compiled 
using the latest Gentoo Sources, 2.4.22-r2.

When I was using 2.4.20-r9, hci_usb wouldn't see my USB bluetooth dongle 
until after bluefw had run. Since I upgraded to 2.4.22-r2, my dongle is 
detected as part of the standard USB bus scan during boot, although it 
brings up a lot of insmod errors. Further on during the boot, bluefw 
always fails, saying that my device has timed out. This leaves my 
bluetooth device invisible to hciconfig.

Everything works fine if I boot into Windows XP and let the Belkin 
software load the firmware, then reboot into Linux without powering 
down. I still get the insmod errors, but bluefw brings up no error 
messages and all bluetooth things work wonderfully.

I realise this may look more like a Gentoo query than a bluez query, but 
there don't seem to be many bluetooth users on the Gentoo forums, so I 
thought this might be the best place to ask.

For reference, these are the errors I get during bootup:

  * Mounting proc at /proc...   [ ok ]
hub.c: new USB device 00:07.2-2, assigned address 3
usb.c: USB device 3 (vend/prod 0xa5c/0x200a) is not claimed by any 
active driver.
hub.c: new USB device 00:07.2-1.1, assigned address 4
input: USB HID v1.10 Keyboard [045e:001d] on usb1:4.0
input: USB HID v1.10 Device [045e:001d] on usb1:4.1
BlueZ Core ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
insmod: insmod: a module named bluez already exists
insmod: insmod: insmod 
/lib/modules/2.4.22-gentoo-r2/kernel/net/bluetooth/bluez.o failed
insmod: insmod: insmod hci_usb failed
insmod: insmod: a module named bluez already exists
insmod: insmod: insmod 
/lib/modules/2.4.22-gentoo-r2/kernel/net/bluetooth/bluez.o failed
insmod: insmod: insmod hci_usb failed
BlueZ HCI USB driver ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb

Thanks.

Alex Holland



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
