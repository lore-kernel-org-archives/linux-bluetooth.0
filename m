Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Zero length L2CAP packets
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Moritz Gmelin <moritz.gmelin@avetana.de>
In-Reply-To: <200502101112.09602.harbaum@beecon.de>
References: <200502101112.09602.harbaum@beecon.de>
Content-Type: text/plain
Message-Id: <1108044288.15974.45.camel@pegasus>
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
Date: Thu, 10 Feb 2005 15:04:48 +0100

Hi Till,

> while working on the avetana jsr82 implementation we discovered, that the bt 
> spec as well as jsr82 allow to transmit zero length l2cap packets. IMHO the 
> linux socket interface does not support zero length packets and a read 
> returning zero indicates an end of file (in this case meaning that the 
> connection has been closed).
> 
> What happens if the other side actually sends a zero length packet? Is this 
> dropped inside the kernel? Or will read return zero which i'll misinterpret 
> as the eof marker? How can i distinguish between eof and a zero length 
> packet?

actually I see no problem with zero length L2CAP packets. I modified the
l2test program to actually be able to send and receive them, but there
is no problem at all. This is a socket and not a file and so you might
use poll() or select() to detect the hangup of the connection and not
some weird zero length magic.

The kernel btw is dropping no packets. I see all of these zero packets
flying from one end to the other.

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
