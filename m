Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] RFCOMM Connect problem, need help to understand
	HCIDUMP output
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200504140608.19450.magnus.larsson@callista.se>
References: <200504100032.15053.magnus.larsson@callista.se>
	 <200504140608.19450.magnus.larsson@callista.se>
Content-Type: text/plain
Message-Id: <1113467389.16014.19.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 14 Apr 2005 10:29:49 +0200

Hi Magnus,

> Can someone help me to describe what the HCIDUMP in the end of this message 
> says is wrong?
> 
> Does anyone have a URL to some doc that explain the HCIDUMP output?

install the latest hcidump and use the options "-X -V" which give you a
better hex/ASCII dump and the verbose decoding.

> I think the following part is of interest (see below for the full hcidump - 
> output):
> 
> > ACL data: handle 0x002e flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> < ACL data: handle 0x002e flags 0x02 dlen 8
>     L2CAP(d): cid 0x0048 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd


The more important one is the data packet before it. It tells you for
what command the DM is send:

< ACL data: handle 0x002e flags 0x02 dlen 8
    L2CAP(d): cid 0x004a len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59

This means that you tried to open RFCOMM channel 1 and with the DM the
phone tells you that it won't create it. So you better check your phone
why it is not accepting a connection on this channel.

The DISC is not for channel 1 (DLCI 2). It is for DLCI 0 which is the
signal channel.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
