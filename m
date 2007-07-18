Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <469E5D82.5070800@gmail.com>
Date: Wed, 18 Jul 2007 11:35:46 -0700
From: Xamindar <junkxamindar@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Bluetooth compact flash card troubles.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I hope I can get some help from you guys.  I have a Zaurus with bluez
installed.  Probably an old version of bluez.  It works great with a
bluetooth usb dongle that I have but I recently bought an ambicom
bt2000-cf compact flash bluetooth card and am having trouble getting it
to work.

Apparently it uses the serial_cs driver and I am pretty sure at this
point that it is built into the zaurus kernel that I am using.
When I plug it in dmesg reports:

[code]

ttyS03 at port 0xf60002f8 (irq = 135) is a 16C950/954
BlueZ Core ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ L2CAP ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ RFCOMM ver 1.1
Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
bash-2.05#                                                 

[/code]

It is very interesting that I get [b]"ttyS03 at port 0xf60002f8 (irq =
135) is a 16C950/954"[/b] .  But I do not get any new bluetooth device
reported by "hcitool dev", just no device.  Why would it get a serial
device but no bluetooth device?  Is there any way to pair it or in other
words use it as if it is a bluetooth device?

I bought this dang card off ebay and the auction specificly stated that
it was zaurus compatible.  I guess they lied.


Thanks for any help or suggestions.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
