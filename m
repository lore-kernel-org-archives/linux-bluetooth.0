Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Unresolved Symbols
From: Marcel Holtmann <marcel@holtmann.org>
To: the-flash@web.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040520114752.GA3125@mcmabrruq.sirius.net>
References: <20040520090502.GA4352@mcmabrruq.sirius.net>
	 <1085044940.4327.135.camel@pegasus>
	 <20040520114752.GA3125@mcmabrruq.sirius.net>
Content-Type: text/plain
Message-Id: <1085056072.4327.166.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 20 May 2004 14:27:52 +0200

Hi Florian,

> The problem is the following. I want to use my Sitecom CN-500 USB- 
> Bluetooth adapter. On Sitecom's webpage they say that I have to use the  
> bluez-kernel-2.3-package but they actually use kernel 2.4.18.

and who cares what Sitecom says ;)

> Because im want to use a newer kernel and - as you said - the bluez- 
> kernel-2.3-package is deprecated, I tried it now with 2.4.26-mh1. After  
> compiling and rebooting and having plugged in the bluetooth adapter, I  
> get the following output from from dmesg
> 
> usb.c: USB device 2 (vend/prod 0xa12/0x1) is not claimed by any active  
> driver.
> usb-uhci.c: ENXIO 80000280, flags 0, urb dedad280, burb dedad400
> usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 193 ret -6
> usb-uhci.c: ENXIO 80000280, flags 0, urb dedad200, burb dedad400
> usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
> BlueZ Core ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
> Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> usb-uhci.c: ENXIO 80000280, flags 0, urb dedad400, burb df388f00
> usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 193 ret -6
> usb-uhci.c: ENXIO 80000280, flags 0, urb dedad400, burb df388f00
> usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
> usb-uhci.c: ENXIO 80000280, flags 0, urb df388f00, burb dedad400
> usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -6

This stuff above is all USB related and not a BlueZ problem.

> BlueZ HCI USB driver ver 2.5 Copyright (C) 2000,2001 Qualcomm Inc
> Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> usb.c: registered new driver hci_usb
> BlueZ L2CAP ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
> Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> 
> Furthermore I get
> 
> /usr/sbin/hciconfig
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0

And so what? Run "hciconfig hci0 up" or start "hcid".

> Is there no working driver available at the moment? Should I try to go  
> back to kernel-2.4.18 as the Sitecom-people suggest?

Of course you can go back, but then ask Sitecom for help if you get
problems.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
