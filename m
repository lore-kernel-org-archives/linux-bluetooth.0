Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44B3F51E.1070009@free.fr>
Date: Tue, 11 Jul 2006 20:59:42 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Broadcom 2035 SCO question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hi all,

I recently purchased a class 1 "sweex" bluetooth USB dongle.  It has a 
broadcom bcm2035
usb chip( idVendor = 0x0a5c, idProduct = 0x200a). It advertises SCO 
mtu=16, sco packets = 0.
I tryed to use it with SCO, no luck.(I wasn't surprised by that, given 
sco packets = 0) Then i looked at hci usb driver and found it was in the 
blacklist, with HCI_BROKEN_ISOC.

I then removed it from this list, forced SCO mtu to 48 and packets 
number to 8 by hacking hci_event.c... and guess what, it works !!

So my question is: shouldn't this product marked as HCI_WRONG_SCO_MTU 
mtu instead of HCI_BROKEN_ISOC?

Cheers,

Fabien


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
