Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] D-Link DWB-120M and BlueZ 2.14
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200501282151.ALQ50969@ms12.netsolmail.com>
References: <200501282151.ALQ50969@ms12.netsolmail.com>
Content-Type: text/plain
Message-Id: <1106961215.10580.5.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 29 Jan 2005 02:13:35 +0100

Hi Chris,

> I installed bluez-libs-2.14 and bluez-utils-2.14 on a linux 2.4.26 system. I 
> also installed the BCM2033-FW.bin  and BCM2033-MD.hex files in both /
> lib/firmware and /usr/lib/hotplug/firmware. The bluez kernel module 
> loads, and I can see stuff like this in the messages log when I unplug and 
> plug in the device and start the hcid daemon:
> 
> Jan 28 12:23:59 krank kernel: usb.c: deregistering driver hci_usb
> Jan 28 12:24:14 krank kernel: BlueZ Core ver 2.3 Copyright (C) 2000,2001 
> Qualcomm Inc
> Jan 28 12:24:14 krank kernel: Written 2000,2001 by Maxim Krasnyansky 
> <maxk@qualcomm.com>
> Jan 28 12:24:31 krank kernel: BlueZ HCI USB driver ver 2.5 Copyright 
> (C) 2000,2001 Qualcomm Inc
> Jan 28 12:24:31 krank kernel: Written 2000,2001 by Maxim Krasnyansky 
> <maxk@qualcomm.com>
> Jan 28 12:24:31 krank kernel: usb.c: registered new driver hci_usb
> Jan 28 12:25:13 krank kernel: usb.c: USB disconnect on device 00:04.2-2 
> address 2
> Jan 28 12:25:17 krank kernel: hub.c: new USB device 00:04.2-2, assigned 
> address 3
> Jan 28 12:36:49 krank -- MARK --
> Jan 28 12:39:06 krank hcid[1025]: Bluetooth HCI daemon
> 
> However, when I do a 'hcitool dev' it doesn't see anything- it just says 
> "Devices:" and then nothing. If I run lsusb it says:
> 
> Bus 001 Device 001: ID 0000:0000  
> Bus 001 Device 003: ID 0a5c:2033 Broadcom Corp. BCM2033 Bluetooth
> 
> What'd I do wrong?

on a system with a 2.4 kernel you need the bcm203x utility. You must
enable when compiling bluez-utils.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
