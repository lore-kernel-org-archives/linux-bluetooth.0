Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Audio & Bluetooth 
In-reply-to: <200411091411.33911.tim@birdsnest.maths.tcd.ie> 
References: <418FC205.7070102@tootai.net> <1099954588.6339.144.camel@loke> <1099956503.29330.35.camel@pegasus> <200411091411.33911.tim@birdsnest.maths.tcd.ie>
Message-ID: <17005.1100011637@csr.com>
From: Peter Stephenson <pws@csr.com>
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
Date: Tue, 09 Nov 2004 14:47:17 +0000

Timothy Murphy wrote:
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

66              beta-9.8 2001-01-17

Congratulations, this is the oldest chip I've ever heard of in the wild.
The "ES" chip is an engineering sample, even before the full production
run of BC01b.  I'm not 100% sure these are properly supported by the
later BC01 firmware, so I wouldn't recommend upgrading the firmware,
even if you find away, unless you're pretty sure you can get back.

pws


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
