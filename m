Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Connection Timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Quattlebaum <stephen@covidimus.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1099090255.12760.26.camel@athene.covidimus.net>
References: <1099090255.12760.26.camel@athene.covidimus.net>
Content-Type: multipart/mixed; boundary="=-mv7LGX89J34ig8crKM47"
Message-Id: <1099091721.6912.35.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 30 Oct 2004 01:15:21 +0200


--=-mv7LGX89J34ig8crKM47
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Stephen,

> I'm a BT newbie having trouble with device timeouts using bluez.  I've
> seen this issue posted a few other places but no answers yet.  Some
> background:
> 
> I just bought a Microsoft BT mouse for a Win XP laptop and decided this
> afternoon to take it for a spin on my Linux box.
> 
> I've got kernel 2.6.8 (what gentoo calls 2.6.8.1-ck9; don't know where
> the .1 comes from but the ck9 refers to a set of desktop performance
> tuning patches they apply).
> 
> I applied patch-2.6.9-mh2 from http://www.bluez.org/patches.html and
> rebuilt my kernel and modules.

be carful with this, because these patches are only tested with the
kernel they are made for.

> The mouse came with a little USB dongle that has the following info on
> the backside:
> 
> "Wireless Transceiver for Bluetooth 2.0"
> Model: 1003
> IC: 3048A-1003
> 
> usbview shows the dongle with the name "Wireless Radio for Bluetooth",
> and its name is in red, which I've been led to believe means that no
> drivers have attached themselves to the device.  I don't know if that's
> important here or not.  I'd paste in the usbview output but usbview
> appears to not support whatever flavor of cut-and-paste gnome uses.
> I'll pull out any info someone asks me for (it's a big listing).  Here's
> the first several lines:
> 
> Manufacturer: Microsoft
> Serial Number: 0050F2E8E590
> Speed: 12Mb/s (full)
> USB Version: 1.10
> Device Class: e0(unk.)
> Device Subclass: 01
> Device Protocol: 01
> Maximum Default Endpoint Size: 64
> Number of Configurations: 1
> Vendor Id: 045e
> Product Id: 009c
> Revision Number: 1.00

This is the new dongle from Microsoft and it is now Broadcom based and
so you maybe need an additional patch to make it working. When it works,
send back the output from "hciconfig -a".

Btw I need this new desktop package from Microsoft for testing. Is there
anyone willing to donate one?

Regards

Marcel


--=-mv7LGX89J34ig8crKM47
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/bluetooth/hci_usb.c 1.58 vs edited =====
--- 1.58/drivers/bluetooth/hci_usb.c	2004-10-27 23:42:21 +02:00
+++ edited/drivers/bluetooth/hci_usb.c	2004-10-30 01:09:54 +02:00
@@ -103,6 +103,9 @@
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
 
+	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
+	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
+
 	/* ISSC Bluetooth Adapter v3.1 */
 	{ USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },
 

--=-mv7LGX89J34ig8crKM47--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
