Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] apple wireless mouse on apple ibook (g4, builtin
	usb)
From: Marcel Holtmann <marcel@holtmann.org>
To: Sunnan <sunnan@handgranat.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <402D07B8.8030504@handgranat.org>
References: <402D07B8.8030504@handgranat.org>
Content-Type: text/plain
Message-Id: <1076694675.2671.191.camel@pegasus>
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
Date: Fri, 13 Feb 2004 18:51:15 +0100

Hi Sunnan,

> I'm trying to get an apple wireless mouse working on the apple ibook 
> (g4, builtin usb).
> 
> I've got the debian bluez packages installed, actually
> 
> sudo apt-get install `apt-cache search bluez |cut -f1 -d' '`
> 
> (yeah, lazy maybe..)
> 
> and I've also got libs2 and utils2 installed from cvs.
> 
> Until I ran hid2hci I didn't see anything with hcitool, but hid2hci 
> seemed to work fine.
> 
> Now running hcitool dev gives me
> Devices:
>          hci0    00:0D:93:04:19:15

what is the output of "hciconfig -a" and the content of
/proc/bus/usb/devices (before and after the run of hid2hci)?

> I'm experimenting with running bthid (from bluez cvs utils2).
> /var/log/daemon.log has
> Feb 13 17:42:20 slowstorm bthid[980]: Bluetooth HID service started
> 
> but little else.
> Once it got
> Feb 13 17:25:20 slowstorm bthid[890]: Bluetooth HID service started
> Feb 13 17:26:49 slowstorm bthid[890]: Connected: HID device (ffff:0000)
> Feb 13 17:26:49 slowstorm bthid[890]: Connection failed: Connection 
> timed out (110)
> 
> ..but that's all.
> 
> I'm also repeatedly grepping ps aux for bthid and it only appears for a 
> couple of minutes after starting it, then it's not there (so I usually 
> restart it).
> 
> I don't see any cursor movement or anything. I don't know so much about 
> bluetooth or about computers in general.

The Apple Bluetooth mouse expects a PIN or a link key even if you only
connect to the SDP service (security mode 3). This is stupid for a HID
mouse, but they did it this way. A working PIN is "0000". So I say you
replace your PIN helper program (from hcid.conf) with the following
executable script

	#!/bin/sh
	echo "PIN:0000"

and put also "0000" into /etc/bluetooth/pin. Restart the hcid and see
how it goes. If this don't work, run "hcidump -w <file>" and send us the
dump file.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
