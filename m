Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Thoughts about AVDTP support
From: Marcel Holtmann <marcel@holtmann.org>
To: Aarti Kumar <akmr2000@yahoo.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040604215717.30223.qmail@web52309.mail.yahoo.com>
References: <20040604215717.30223.qmail@web52309.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1086393485.16316.26.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 05 Jun 2004 01:58:06 +0200

Hi Aarti,

> The bluetooth avdtp specification is complex but the
> if we are dealing with the basic functionality part
> itself and it reduces a lot of complexities. 

you can leave reporting and recovery out, but it will be still complex
and at some point you must include these features. So we must think
about them from the start.

> What makes you think that avdtp is using Multiple
> l2cap channels between same devices with same PSM - is
> it beacuse of the siganlling link and data transfer
> link ?

As I read the specification, between two devices there is always one
signal channel (and only one). This is the first L2CAP channel opened on
the PSM 25. It also assigns the roles of initiator and acceptor. For the
streaming between two endpoints it has to open at least another L2CAP
channel for the media transport. This channel uses the same PSM and so
the order of the L2CAP channel creation tells us what they are for.

> Using AVDTP as kernel module is good idea (much better
> than using it at user space).

No. Doing something in userspace is almost better and easier, but with
the definition of the streaming endpoints a kernel based socket design
makes sense.

> I think the connection oriented socket is required for
> avdtp. Its also mentioned in the specification.

For the L2CAP connection, yes, but I was asking for the socket type of
our AVDTP socket. I think it should be SOCK_DGRAM or SOCK_SEQPACKET.

> I would like to help with coding and testing if it
> fine with you. I had started with the AVDTP
> implementation, but it was at the user level only and
> I have not much experience coding at kernel level.

How far did you came? Any code that you can share with us?

Do anyone started implementing the SBC audio codec? The specification of
this codec is in the A2DP document and the test document contains sample
*.sbc files and a DOS decoder and encoder (works fine with wine). I like
to see an open source implementation of SBC for FFMPEG or a separate
library.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
