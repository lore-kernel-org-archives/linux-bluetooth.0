Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <418E4E9C.8070100@xmission.com>
References: <418DB442.2050801@uen.org> <1099830449.6896.14.camel@pegasus>
	 <418E4E9C.8070100@xmission.com>
Content-Type: text/plain
Message-Id: <1099846462.6896.26.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 07 Nov 2004 17:54:22 +0100

Hi Brad,

> What I wanted to do was start by using the reference SBC codec or just 
> one of the reference streams (cleverly hidden in the *zipfile* 
> A2DP_TS.pdf at bluetooth.org) and then experiment with sending it to the 
> headset.

I looked a little bit into ALSA and actually what we really need is the
support in the ALSA library for understanding SBC. So the kernel don't
has to worry about it.

> I'm looking at the diagram on p. 17 of the A2DP spec... it looks like 
> the AVDTP layer takes the encoded stream, breaks it up and puts the 
> media packet headers on it. Is that right?

In general yes, but the AVDTP is crap. It needs at least two L2CAP
channels on PSM 25.

> I am a little confused about this though... does this show the A2DP sink 
> as using the rfcomm protocol?
> 
> $ sdptool search --bdaddr 00:08:F4:30:05:BB 0x1101
> Class 0x1101
> Searching for 0x1101 on 00:08:F4:30:05:BB ...
> Service Name: Audio Sink
> Service RecHandle: 0x10005
> Service Class ID List:
>    "Serial Port" (0x1101)
> Protocol Descriptor List:
>    "L2CAP" (0x0100)
>    "RFCOMM" (0x0003)
>      Channel: 1

I saw that too and actually I don't know what is it good for. Maybe you
wanna try to connect it to a TTY and then copy the SBC files into it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
