Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Prakash <aprakash@tataelxsi.co.in>
To: bluez-users@lists.sourceforge.net
Message-id: <200508021312.38055.aprakash@tataelxsi.co.in>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] SCO Query on tty based Stack
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
Date: Tue, 02 Aug 2005 13:12:38 +0530

Hi,

         I am trying to run OPEN-BT with USB device. i have compiled
 userstack application and initialized my USB dongle too.  I am aware of
 openbt that it doesn't support SCO and interacts through tty device. I have
 gonethrough bluetty.c (class driver). I didn't find any codes for SCO
 packet.

         Suppose if we would like to add SCO support on OPENBT, we should
 have add SCO packet handling code in bluetty class driver.... otherwise Can
 we use hci_usb module. (COZ SCO support already available in BLUEZ).  This
 hci_usb module depends on bluetooth module. Bluetooth module initialize
 socket layer for interaction...

         what i m thinking , there should be a separate kernel module, which
will interact with hci_usb module and Openbt stack.  Is it feasible to
achieve it ?...  or  Can i add SCO support on bluetty class driver itself ?.
Have any one tried this ?..

Expecting your valuable suggestions !!!..

Thanks
PRAKASH



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
