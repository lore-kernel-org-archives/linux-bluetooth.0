Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: linux-bluetooth@vger.kernel.org
Subject: Re: fresh bluez-4.50 install probably my fault
Date: Thu, 03 Sep 2009 12:56:45 -0400
References: <200908310102.22337.gene.heskett@verizon.net>
In-reply-to: <200908310102.22337.gene.heskett@verizon.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Message-id: <200909031256.45860.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 31 August 2009, Gene Heskett wrote:
>Greetings all;
>
>After not playing with these nearly broken adapters for a while, last time
> I had bluez-4.34 installed.  Now I have bluez-4.50 built with this
> configure script:
>
>./configure --prefix=/usr/local --enable-alsa --enable-gstreamer  \
>--enable-usb --enable-netlink --enable-tools --enable-bccmd \
>--enable-pcmcia --enable-hid2hci --enable-dfutool --enable-hidd  \
>--enable-pand  --enable-dund --enable-cups --enable-test \
>--enable-udevrules --enable-configfiles --enable-debug
>
>Followed of course by the usual make;make-install.
>
>Putzing around, I found the pre-existing bluetooth starter script in
>/etc/init.d needed  editing because bluetoothd was now in /usr/local/bin,
>where 4.34 had apparently put it in /usr/bin.  No biggie and bluetoothd now
>seems to be running.  BTW I ran a make uninstall in the /usr/src/bluez-4.34
>directory.
>
>Disconnecting and re-plugging the dongle gets me this report in the log:
>[181526.093228] usb 2-5.1: new full speed USB device using ohci_hcd and
>address 8
>[181526.196233] usb 2-5.1: New USB device found, idVendor=0e5e,
>idProduct=6622
>[181526.196236] usb 2-5.1: New USB device strings: Mfr=0, Product=0,
>SerialNumber=0
>[181526.196327] usb 2-5.1: configuration #1 chosen from 1 choice
>
>A couple of months ago, this dongle was 'paired' with another one, an eb101
>which is acting like an rs232 port on a 30 year old computer, and I could
>start a shell running on that device, and using a device in the /dev
>directory that I don't recall ATM, I could start a minicom session, log
> into the old computer, and run it in text mode from here, including using
> rzsz to move files back and forth.
>
>None of the /usr/local/bin/blue* utils can find a device to display, so
>obviously I'm still missing something.
>
>Back then I wrote a script to exercise things that looks like this:
>--------------------------------
>#!/bin/bash
>echo attempting to get bt link to the coco3
>echo "rfcomm release 0"
>rfcomm release 0
>sleep 2
>ls -l /dev/rfcomm*
>sleep 2
>rfcomm -i 11:11:11:11:11:11 show hci0
>sleep 2
>echo "resetting hci0"
>hciconfig reset hsi0
>sleep 2
>ls -l /dev/rfcomm*
>sleep 2
>rfcomm -i 11:11:11:11:11:11 show hci0
>sleep 2
>ls -l /dev/rfcomm*
>sleep 2
>echo "hciconfig -a"
>hciconfig -a
>sleep 2
>ls -l /dev/rfcomm*
>sleep 2
>echo "rfcomm bind 0 00:0c:84:00:86:F8"
>rfcomm bind 0 00:0c:84:00:86:F8
>sleep 2
>ls -l /dev/rfcomm*
>sleep 2
>#echo "rfcomm connect 0 00:0c:84:00:86:F8 1"
>#rfcomm connect 0 00:0c:84:00:86:F8 1
>echo this should show the cocos address
>rfcomm -i 11:11:11:11:11:11 show 0
>------------------------------
>And when I run it, I get this, please note the lack of rfcomm
>--------------------------------
>[root@coyote bin]# ./connect2coco3
>attempting to get bt link to the coco3
>rfcomm release 0
>Can't release device: No such device
>ls: cannot access /dev/rfcomm*: No such file or directory
>Get info failed: No such device
>resetting hci0
>hci0:   Type: USB
>        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
>        UP RUNNING PSCAN ISCAN
>        RX bytes:1035 acl:0 sco:0 events:35 errors:0
>        TX bytes:397 acl:0 sco:0 commands:35 errors:0
>
>ls: cannot access /dev/rfcomm*: No such file or directory
>Get info failed: No such device
>ls: cannot access /dev/rfcomm*: No such file or directory
>hciconfig -a
>hci0:   Type: USB
>        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
>        UP RUNNING PSCAN ISCAN
>        RX bytes:1035 acl:0 sco:0 events:35 errors:0
>        TX bytes:397 acl:0 sco:0 commands:35 errors:0
>        Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>        Link policy: RSWITCH HOLD SNIFF PARK
>        Link mode: SLAVE ACCEPT
>        Name: 'coyote.coyote.den-0'
>        Class: 0x022104
>        Service Classes: Networking
>        Device Class: Computer, Desktop workstation
>        HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver:
>0x1f4
>        Manufacturer: CONWISE Technology Corporation Ltd (66)
>
>ls: cannot access /dev/rfcomm*: No such file or directory
>rfcomm bind 0 00:0c:84:00:86:F8
>crw------- 1 root root 216, 0 2009-08-31 00:42 /dev/rfcomm0
>this should show the cocos address
>rfcomm0: 00:0C:84:00:86:F8 channel 1 clean
>[root@coyote bin]#
>-----------------------------------
>
>The last, from the rfcomm bind onward is correct.  That is indeed the
> address of the eb101 being driven from the coco3.  So I have to think that
> the devices are communicating.
>
>However, minicom refused to connect to /dev/rfcomm0, claiming an invalid
>argument.
>
>blueman-assistant runs, but finds no devices after its scan.
>
>Whats next folks?
>
>Thanks.

Ping???

I just found that the module hci_uart was not loaded, but modprobing it in 
does nothing.

Is there a tutorial on getting this started from plugging in the usb dongle, 
if so where? 

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
The NRA is offering FREE Associate memberships to anyone who wants them.
<https://www.nrahq.org/nrabonus/accept-membership.asp>

"Do not meddle in the affairs of wizards, for you are crunchy and good
with ketchup."
