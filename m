Return-Path: <the-flash@web.de>
Date: Thu, 20 May 2004 13:47:52 +0200
From: the-flash@web.de
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Unresolved Symbols
Message-ID: <20040520114752.GA3125@mcmabrruq.sirius.net>
References: <20040520090502.GA4352@mcmabrruq.sirius.net> <1085044940.4327.135.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
List-ID: <bluez-users.lists.sourceforge.net>

Thanks for your answer.

> > What can I do?
> 
> don't use bluez-kernel-2.3 !!! This package is deprecated and no
> longer
> needed. The only way to update the kernel drivers is via my -mh  
> patch.

The problem is the following. I want to use my Sitecom CN-500 USB- 
Bluetooth adapter. On Sitecom's webpage they say that I have to use the  
bluez-kernel-2.3-package but they actually use kernel 2.4.18.

Because im want to use a newer kernel and - as you said - the bluez- 
kernel-2.3-package is deprecated, I tried it now with 2.4.26-mh1. After  
compiling and rebooting and having plugged in the bluetooth adapter, I  
get the following output from from dmesg

usb.c: USB device 2 (vend/prod 0xa12/0x1) is not claimed by any active  
driver.
usb-uhci.c: ENXIO 80000280, flags 0, urb dedad280, burb dedad400
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 193 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb dedad200, burb dedad400
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
BlueZ Core ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb-uhci.c: ENXIO 80000280, flags 0, urb dedad400, burb df388f00
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 193 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb dedad400, burb df388f00
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb df388f00, burb dedad400
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -6
BlueZ HCI USB driver ver 2.5 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
BlueZ L2CAP ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>



Furthermore I get

/usr/sbin/hciconfig
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0


and

hcitool dev
Devices:


which does NOT look good, right?

Is there no working driver available at the moment? Should I try to go  
back to kernel-2.4.18 as the Sitecom-people suggest?

Thanks and goodbye,
Florian
