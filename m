Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec04081309406c2abae3@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
Reply-To: Albert Huang <ashuang@gmail.com>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] want duplicate inquiry results during a single device inquiry
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
Date: Fri, 13 Aug 2004 12:40:52 -0400

Hello,

While experimenting with a hp ipaq running a 2.4.19 kernel, I noticed
that during a since device inquiry, multiple EVT_INQUIRY_RESULT events
could be generated from the same remote device.  The inquiry was done
using a raw hci socket.  On x86 PCs running the same userland code but
with more recent versions of bluez and the linux kernel, the duplicate
events are no longer generated.  Instead, during a single inquiry, a
response will be received from a remote device at most once.

I'm assuming that sometime in the recent past, kernel level caching
was implemented to prevent these duplicate inquiry results from
propagating up to user land.  Is there a way to turn this off, so that
all inquiry results are passed through?

Thanks!
-albert


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
