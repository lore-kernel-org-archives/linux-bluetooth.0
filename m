Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Missing data in ACL packets from CSR chip
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000301c3f191$14e80dd0$1a01010a@baked>
References: <000301c3f191$14e80dd0$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1076688033.2671.113.camel@pegasus>
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
Date: Fri, 13 Feb 2004 17:00:33 +0100

Hi Daryl,

> Here's my decode:
> 
> Starting at index 536645:
> 
> 0536645: 04 13 05 01 2d 00 03 00
> HCI event: Number of completed packets
> 
> 0536655: 02 2d 20 09 00 05 00 40 00 21 ff 01 03 9c
> Valid ACL data packet.
> 
> 0536673 - 0537012
> More Number of completed packets events
> 
> 0537013: 02 2d 20 09 00 05 00 40 00 21 ff 01 01 9c
> Valid ACL data packet
> 
> 0537031: 02 2d 20 09 00 05 00 40 00 21 ff 01 9c 02
> Corrupt packet.

this looks like an UART problem to me, but I don't know if it is on the
chip, on the module or one your side.

Is it possible for you to use BCSP? Do you have a firmware update to the
latest HCI 16.x or HCI 17.x?

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
