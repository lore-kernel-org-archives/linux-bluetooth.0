Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pand Connection refused(111) when connecting to
	a Belkin NAP
From: Marcel Holtmann <marcel@holtmann.org>
To: lta@creativemonsters.com
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <27345483$110790477642094908d86d51.65090625@config17.schlund.de>
References: <27345483$110790477642094908d86d51.65090625@config17.schlund.de>
Content-Type: text/plain
Message-Id: <1107908002.14624.3.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 09 Feb 2005 01:13:22 +0100

Hi Leon,

> I have exactly the same problem as Dave Henriksen !!!  :-(
> 
> 
> RFCOMM works ( connects ) fine, but PAND simply fails with "Connection
> refused(111)".
> 
> 
> My log tells me...
> 
> Feb  8 23:12:32 slave kernel: hciconfig[3728]: segfault at
> 00000000000000a9 rip 0000002a957d2c0c rsp 0000007fbfffef50 error 4

first I would check why this segfault happens.

> Feb  8 23:29:24 slave kernel: Bluetooth: BNEP (Ethernet Emulation) ver
> 1.2
> Feb  8 23:29:24 slave kernel: Bluetooth: BNEP filters: protocol
> multicast
> Feb  8 23:29:24 slave pand[3760]: Bluetooth PAN daemon
> Feb  8 23:29:24 slave pand[3760]: Connecting to 00:02:72:00:EB:4D
> Feb  8 23:29:28 slave pand[3760]: Connect to 00:02:72:00:EB:4D failed.
> Connection refused(111)

Second the PSM is not supported. Is you device really supporting the PAN
profile. Check with sdptool for a PAN service.

What is the version of your utils?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
