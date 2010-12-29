Return-Path: <cyrus@holtmann.org>
From: gene heskett <gheskett@wdtv.com>
To: linux-bluetooth@vger.kernel.org
Subject: Bluez DOA after reboot(s)
Date: Wed, 29 Dec 2010 10:23:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201012291023.50971.gheskett@wdtv.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings;

I had a Broadcom button linked to an a7 brand eb-101 that worked great,
for about a week, then rebooted to a newer 2.6.37-rc8 kernel where it 
fails.  Rebooting to the old kernel, 2.6.36.1, now fails also.

Starting blueman-manager from a root terminal gets this return.
[root@coyote ~]# blueman-manager
Loading configuration plugins
Using gconf config backend
_________
on_bluez_name_owner_changed (/usr/bin/blueman-manager:104)
org.bluez owner changed to


at which point a small window opens and advises me

Connection to Bluez failed

and only has one option, close.

I have looked at line 104, and its apparent that 'owner' is not set, hence
the apparent null after 'to' above.  But I don't know enough about python
to even be dangerous.

Running kde-4.5.latest here, on 32 bit pclos-2010 uptodate except for the
newer, badly broken for amanda's usage, tar.

Fixes anyone, please?

Where is this bluez started in the boot sequence?

I have looked at the logs (dmesg etc) and the device is discovered just 
fine.  Everything for bluetooth is enabled in the kernel's .config.

>From /var/log/messages

Dec 29 06:30:05 coyote klogd: [    6.234467] usb 1-10.4.4: new full speed USB device using ehci_hcd and 
address 14
Dec 29 06:30:05 coyote klogd: [    6.327964] usb 1-10.4.4: New USB device found, idVendor=0a5c, idProduct=4500
Dec 29 06:30:05 coyote klogd: [    6.334330] usb 1-10.4.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
Dec 29 06:30:05 coyote klogd: [    6.340660] usb 1-10.4.4: Product: BCM2046B1
Dec 29 06:30:05 coyote klogd: [    6.346950] usb 1-10.4.4: Manufacturer: Broadcom
Dec 29 06:30:05 coyote klogd: [    6.647365] usb 1-10.4.4.1: new full speed USB device using ehci_hcd and 
address 16
Dec 29 06:30:05 coyote klogd: [    6.748240] usb 1-10.4.4.1: New USB device found, idVendor=0a5c, 
idProduct=4502
Dec 29 06:30:05 coyote klogd: [    6.748244] usb 1-10.4.4.1: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
Dec 29 06:30:05 coyote klogd: [    6.837371] usb 1-10.4.4.2: new full speed USB device using ehci_hcd and 
address 17
Dec 29 06:30:05 coyote klogd: [    6.924252] usb 1-10.4.4.2: New USB device found, idVendor=0a5c, 
idProduct=4503
Dec 29 06:30:05 coyote klogd: [    6.924257] usb 1-10.4.4.2: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
Dec 29 06:30:05 coyote klogd: [    6.997390] usb 1-10.4.4.3: new full speed USB device using ehci_hcd and 
address 18
Dec 29 06:30:05 coyote klogd: [    7.089511] usb 1-10.4.4.3: New USB device found, idVendor=0a5c, 
idProduct=2148
Dec 29 06:30:05 coyote klogd: [    7.089515] usb 1-10.4.4.3: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
Dec 29 06:30:05 coyote klogd: [    7.089518] usb 1-10.4.4.3: Product: BCM92046DG-CL1ROM
Dec 29 06:30:05 coyote klogd: [    7.089520] usb 1-10.4.4.3: Manufacturer: Broadcom Corp
Dec 29 06:30:05 coyote klogd: [    7.089531] usb 1-10.4.4.3: SerialNumber: 000272A176A4

But now bluez isn't running, and of course /dev/rfcomm0 is not being 
created.  Even on the 2.6.36.1 kernel it was running well with yesterday.

Thank you.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
He looked at me as if I were a side dish he hadn't ordered.
		-- Ring Lardner
