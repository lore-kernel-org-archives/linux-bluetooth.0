Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] position of multiple bluetooth dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <421042D2.2040905@gmx.ch>
References: <420B9635.6020701@gmx.ch>  <200502101825.15870.cijoml@volny.cz>
	 <1108057316.15974.93.camel@pegasus>  <421042D2.2040905@gmx.ch>
Content-Type: text/plain
Message-Id: <1108409043.7780.12.camel@notepaq>
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
Date: Mon, 14 Feb 2005 20:24:03 +0100

Hi Marco,

> so it's no problem? no mather of the bluetooth version of the dongle? no 
> interference, respectively maybe a couple if thousands in a second?

ask an expert on the baseband level.

> corrected by rfcomm?

The error correction is done at the chip level. The ACL link is
reliable.

> the distance of two dongles doesn't matter?

If the distance is bigger, the chip must request more retransmission.
You won't see that in any of the BlueZ layers.

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
