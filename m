Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <009401c57b06$7afe3ef0$0132a8c0@AL>
From: "Al Chane" <al_chane@issc.com.tw>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="big5";
	reply-type=original
Subject: [Bluez-users] ISSC USB dongle patch
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
Date: Mon, 27 Jun 2005 18:53:40 +0800

Hi,

     I have an ISSC USB dongle and search the last year's archive to find 
the patch to
make it work with BlueZ.

     I just wonder how it works. What's black_ids[] for and the purpose of
adding .driver_info = HCI_RESET?

struct usb_device_id bluetooth_ids[]
struct usb_device_id ignore_ids[] or black_ids[]

thanks a lot,

Al



=================================================================
it looks like that this device needs the HCI_Reset before it can run an
inquiry. Funny is that every other HCI command work without it. Try the
attached patch.

Regards

Marcel


===== drivers/bluetooth/hci_usb.c 1.53 vs edited =====
--- 1.53/drivers/bluetooth/hci_usb.c	2004-07-16 12:55:02 +02:00
+++ edited/drivers/bluetooth/hci_usb.c	2004-07-31 12:13:10 +02:00
 <at>  <at>  -98,6 +98,9  <at>  <at>
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET },

+	/* ISSC Bluetooth Adapter v3.1 */
+	{ USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
