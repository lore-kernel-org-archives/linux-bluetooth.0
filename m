Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] want duplicate inquiry results during a single
	device inquiry
From: Marcel Holtmann <marcel@holtmann.org>
To: Albert Huang <ashuang@gmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ef9938ec04081309406c2abae3@mail.gmail.com>
References: <ef9938ec04081309406c2abae3@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1092416317.28711.258.camel@pegasus>
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
Date: Fri, 13 Aug 2004 18:58:37 +0200

Hi Albert,

> While experimenting with a hp ipaq running a 2.4.19 kernel, I noticed
> that during a since device inquiry, multiple EVT_INQUIRY_RESULT events
> could be generated from the same remote device.  The inquiry was done
> using a raw hci socket.  On x86 PCs running the same userland code but
> with more recent versions of bluez and the linux kernel, the duplicate
> events are no longer generated.  Instead, during a single inquiry, a
> response will be received from a remote device at most once.
> 
> I'm assuming that sometime in the recent past, kernel level caching
> was implemented to prevent these duplicate inquiry results from
> propagating up to user land.  Is there a way to turn this off, so that
> all inquiry results are passed through?

this is device specific and can be controlled by a HCI command. Show us
the outputs of "hciconfig -a" for both devices.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
