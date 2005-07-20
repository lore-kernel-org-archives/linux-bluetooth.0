Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Philipp H. Mohr" <phm4@kent.ac.uk>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0507201807410.9879@myrtle.ukc.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-devel] setserial /dev/bluetooth/rfcomm/1 ????
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
Date: Wed, 20 Jul 2005 18:09:18 +0100 (BST)

Hello,

I like to use rxtx - a java/linux serial port library. But it doesn't
recognise my bluetooth serial ports on my ipaq. In order to activate them
I would like to use the tool setserial - if that's the right tool to use
!?. I would like to activate my bluetooth serial port, but I am not sure
which parameters to pass to it.

setserial /dev/bluetooth/rfcomm/1 ??????

My port is working, as I can get data from it by doing cat, but for the
library to recognise it I need to make it active or some thing...


Thank you,
Phil


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
