Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Audio & Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411091411.33911.tim@birdsnest.maths.tcd.ie>
References: <418FC205.7070102@tootai.net> <1099954588.6339.144.camel@loke>
	 <1099956503.29330.35.camel@pegasus>
	 <200411091411.33911.tim@birdsnest.maths.tcd.ie>
Content-Type: text/plain
Message-Id: <1100010494.6866.7.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 09 Nov 2004 15:28:14 +0100

Hi Timothy,

> > you are kidding me? Use "hciconfig hci0 revision" or look at my webpage
> > where most of the build ids are decoded.
> 
> A bit OT, but I tried that on my Sony Picturebook (C1VFK) and got
> =====================================
> tim@william ~]$ sudo hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 08:00:46:21:58:29 ACL MTU: 128:8  SCO MTU: 64:8
>         Build 66
>         Chip version: BlueCore01b (ES)
> =====================================
> 
> I guess that means the chip in the in-built Bluetooth is pre-pre-historic.

this is a pre HCI 11.2 firmware and my oldest card is a Xircom CBT one
with build id 101.

> Is there any hope of upgrading in such a case?
> Eg could upgrading the BIOS upgrade the BT chip too?

No. This is always done separately. However this boot loader shouldn't
check the signature of the DFU file and so in general you can try to
load a HCI 16.4 on it. Of course at your own risk. Does Sony provide an
update for this notebook?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
