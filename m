Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Audio & Bluetooth
References: <418FC205.7070102@tootai.net> <1099954588.6339.144.camel@loke> <1099956503.29330.35.camel@pegasus>
In-Reply-To: <1099956503.29330.35.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200411091411.33911.tim@birdsnest.maths.tcd.ie>
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
Date: Tue, 9 Nov 2004 14:11:33 +0000

On Monday 08 November 2004 23:28, Marcel Holtmann wrote:

> you are kidding me? Use "hciconfig hci0 revision" or look at my webpage
> where most of the build ids are decoded.

A bit OT, but I tried that on my Sony Picturebook (C1VFK) and got
=====================================
tim@william ~]$ sudo hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 08:00:46:21:58:29 ACL MTU: 128:8  SCO MTU: 64:8
        Build 66
        Chip version: BlueCore01b (ES)
=====================================

I guess that means the chip in the in-built Bluetooth is pre-pre-historic.

Is there any hope of upgrading in such a case?
Eg could upgrading the BIOS upgrade the BT chip too?

It's really only an academic question, 
as Bluez/gnokii are perfectly able for what I want.


-- 
Timothy Murphy  
e-mail (<80k only): tim /at/ birdsnest.maths.tcd.ie
tel: +353-86-2336090, +353-1-2842366
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
