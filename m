Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40436251.4000802@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Thor Egil Skaug <paxtonrd@hotmail.com>
CC: "'BlueZ Mailing List'" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] AUX1 packets
References: <000401c3ffa7$5b52f310$46a57e40@thores>
In-Reply-To: <000401c3ffa7$5b52f310$46a57e40@thores>
Content-Type: text/plain; charset="us-ascii"
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
Date: Mon, 01 Mar 2004 16:18:25 +0000

Thor Egil Skaug wrote:
> But the LM can only use packet types that I specified in
> create_connection or change_connection_packet_type,
> in addition to the mandatory DM1 type. Am I correct in assuming this?

This is true, but, if you specify DM and DH packets, then the Link
Manager will switch automatically. If you try to specify just DH packets
but the Link Manager thinks the link is too poor to use them then, since
DM1 packets are always allowed, it will drop to DM1 giving poor bandwidth
(whereas if you'd left it alone it would have used DM5).

The only thing that works is specifying DM packets only.

Note also that you can alter the packet types only for the packets
sent by the controller. The information is not communicated over the
air, so the other side will be using whatever packet types its host
has suggested.

> Will the link manager notify me through events that CQDDR scheme has
> changed packet type?

No, and seeing as the LM can adapt very quickly, this could lead to
the host being flooded by messages.

> How do I know whether CQDDR is supported, and is there any way of
> disabling this?

CQDDR is supported if the appropriate features bit is set. BlueZ
reports it as Channel Quality (IIRC).

There's no standard way of disabling it. I've yet to be convinved
it would be a good thing.

In what way is automatic CQDDR inappropriate for your application.

	- Steven
-- 



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
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
