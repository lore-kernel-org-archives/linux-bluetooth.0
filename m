Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 06 Aug 2006 13:14:38 -0500
From: digitalfredy <digitalfredy@debiancolombia.org>
In-reply-to: <20060803043158.GA13259@refinery.twat.com.ar>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <1154888079.7923.13.camel@YODA>
MIME-version: 1.0
References: <20060803043158.GA13259@refinery.twat.com.ar>
Subject: Re: [Bluez-users] Cannot transfer files via OBEX
Reply-To: digitalfredy@debiancolombia.org,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

El jue, 03-08-2006 a las 01:31 -0300, redondos escribi=F3:
> Hello, list. This is my first post.
> =

> I just got myself a Bluetooth 1.2 USB dongle, listed by `lsusb' as:
> Bus 004 Device 005: ID 1131:1001 Integrated System Solution Corp.
> KY-BT100 Bluetooth Adapter
> =

> I have a Sony Ericsson Z520a phone, which incorporates a bluetooth and
> infrared adapter.
> =

> I am using BlueZ (libs, utils) version 2.25 on a Gentoo system.
> =

> uname -a:
> Linux refinery.twat.com.ar 2.6.16-suspend2-r8 #1 PREEMPT Mon Jul
> 31 19:05:52 ART 2006 i686 AMD Athlon(TM) XP 2400+ GNU/Linux
> =

> I have 3 main goals:
> 1) Transfer files between my computer and the phone.
ok in this i think to i can help you.
sdptool browse 00:16:20:F1:47:68 and review the chanel for and search
the channel for OBEX File Transfer for use this in the -B option,
reading your log i see chanel 6
$ obexftp -b 00:16:20:F1:47:68 -B 6 -l
If this run write again and i send you my shell script for auto download
pictures, images ...
> 2) Synchronize my PIM with the phone.
you can use evolution and multisync
more info in
http://es.wikibooks.org/wiki/Hacks_para_sistemas_operativos_Unix-like/Redes=
/Bluetooth/Linux (spanish but easy to understand reading the comands)
> 3) Use the phone as a modem to connect my laptop computer to the net
> using GPRS.
> =

> I think you guys can help me with points 1) and 3), am I correct?
> One step at a time, of course. =

> =

> [obexftp]
> I have tried to transfer simple text files between my computer and the
> phone, but I have been unsuccessful. I am attaching a session log and
> its corresponding dump for a simple file push from the PC to the phone.
> =

> [konqueror]
> I have also installed kbluetoothd, which lets me browse the phone's
> "filesystem" using the OBEX KIOSlave. Whenever I try to copy a file from
> or to the phone using Konqueror, the file transfer dialog shows that
> some bytes have been transferred, it even shows different data rates. It
> is usually in the 10-20 KiB/s range. It apparently transfers some bytes
> and then it stops with the message: =

> =

> Connection error: Transport is broken
> =

> I have also tried with the FUSE OBEX module, but that didn't work. Of
> course, it relies on obexftp.
> =

> Any thoughts will be greatly appreciated. Please let me know if I missed
> something in the problem description.
> =

> Thanks.
> =

> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________ Bluez-users mailing list =
Bluez-users@lists.sourceforge.net https://lists.sourceforge.net/lists/listi=
nfo/bluez-users

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
