Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't establish a connection
From: Marcel Holtmann <marcel@holtmann.org>
To: ben4fun <ben_4_fun@freenet.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1092779397.3475.31.camel@localhost>
References: <1091742606.6143.17.camel@localhost>
	 <1092727197.12606.1.camel@localhost> <1092728177.31651.6.camel@pegasus>
	 <200408170949.50588.cijoml@volny.cz>  <1092776029.3475.27.camel@localhost>
	 <1092778940.31651.39.camel@pegasus>  <1092779397.3475.31.camel@localhost>
Content-Type: text/plain
Message-Id: <1092814652.31651.43.camel@pegasus>
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
Date: Wed, 18 Aug 2004 09:37:32 +0200

Hi Ben,

> > so adding the broken ISOC quirk would be enough to make this dongle work
> > again. Maybe the last time I tested it, I had the SCO support disabled.
> Is this something to add in the kernel settings?

===== drivers/bluetooth/hci_usb.c 1.54 vs edited =====
--- 1.54/drivers/bluetooth/hci_usb.c    2004-07-31 12:57:14 +02:00
+++ edited/drivers/bluetooth/hci_usb.c  2004-08-17 23:32:42 +02:00
@@ -96,7 +96,7 @@
        { USB_DEVICE(0x0a5c, 0x2033), .driver_info = HCI_IGNORE },
 
        /* Broadcom BCM2035 */
-       { USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET },
+       { USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
 
        /* ISSC Bluetooth Adapter v3.1 */
        { USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },

> > What does "hciconfig hci0 revision" say? These versions look a little
> > bit wrong.
> hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:02:72:B3:43:18 ACL MTU: 377:10  SCO MTU: 16:0
>         Unsupported manufacturer

Update your libs and utils. The current version is 2.10.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
