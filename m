Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Audio & Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <17005.1100011637@csr.com>
References: <418FC205.7070102@tootai.net> <1099954588.6339.144.camel@loke>
	 <1099956503.29330.35.camel@pegasus>
	 <200411091411.33911.tim@birdsnest.maths.tcd.ie>  <17005.1100011637@csr.com>
Content-Type: text/plain
Message-Id: <1100048195.25879.7.camel@pegasus>
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
Date: Wed, 10 Nov 2004 01:56:35 +0100

Hi Peter,

> > A bit OT, but I tried that on my Sony Picturebook (C1VFK) and got
> > =====================================
> > tim@william ~]$ sudo hciconfig hci0 revision
> > hci0:   Type: USB
> >         BD Address: 08:00:46:21:58:29 ACL MTU: 128:8  SCO MTU: 64:8
> >         Build 66
> >         Chip version: BlueCore01b (ES)
> > =====================================
> > 
> > I guess that means the chip in the in-built Bluetooth is pre-pre-historic.
> 
> 66              beta-9.8 2001-01-17
> 
> Congratulations, this is the oldest chip I've ever heard of in the wild.
> The "ES" chip is an engineering sample, even before the full production
> run of BC01b.  I'm not 100% sure these are properly supported by the
> later BC01 firmware, so I wouldn't recommend upgrading the firmware,
> even if you find away, unless you're pretty sure you can get back.

as far as I know only the Xircom cards are the other ones with beta
firmware there were out there in the wild, but the C1VFK is really the
oldest one.

The ES is interesting, because once I flashed a BC02 ES with a newer
firmware afterwards the ES was gone ;)

However if anyone has old Bluetooth hardware and has replaced it with
newer one I would be very happy if they donate these old devices to me,
because I collect them. Something like a Bluetooth museum.

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
