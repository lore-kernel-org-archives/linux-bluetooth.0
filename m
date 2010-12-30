Return-Path: <cyrus@holtmann.org>
From: gene heskett <gheskett@wdtv.com>
To: linux-bluetooth@vger.kernel.org
Subject: reliable bluetooth rfcomm0?
Date: Wed, 29 Dec 2010 21:51:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201012292151.21118.gheskett@wdtv.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings again;

by blindly modprobing just about everything in /lib/modules/`uname -
r`/kernel/drivers/bluetooth and retrying blueman-manager, I finally hit the 
magic twanger in the right place and its working.

Now, it seems to me I should be able to add a stanza in 
/etc/udev/rules.d/bluetooth-serial.rules to make this completely automatic 
on boot.

Here is what I have modprobed now that makes it work:
[root@coyote bluetooth]# lsmod |grep rfcomm
rfcomm                 23697  23 
l2cap                  32434  18 rfcomm,bnep
bluetooth              39235  11 btsdio,hci_uart,rfcomm,sco,bnep,l2cap,btusb

What would a new stanza for udev/rules.d/bluetooth-serial.rules that will 
make this work for every boot look like for this bt button/dongle?

[    6.997390] usb 1-10.4.4.3: new full speed USB device using ehci_hcd and address 18
[    7.089511] usb 1-10.4.4.3: New USB device found, idVendor=0a5c, idProduct=2148
[    7.089515] usb 1-10.4.4.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.089518] usb 1-10.4.4.3: Product: BCM92046DG-CL1ROM
[    7.089520] usb 1-10.4.4.3: Manufacturer: Broadcom Corp
[    7.089531] usb 1-10.4.4.3: SerialNumber: 000272A176A4

Thanks all;

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
If you give a man enough rope, he'll claim he's tied up at the office.
