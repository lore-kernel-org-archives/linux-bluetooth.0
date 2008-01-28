Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201344161.7769.28.camel@localhost>
References: <1200991632.7006.20.camel@localhost>
	<1201002028.7978.159.camel@aeonflux>
	<1201344161.7769.28.camel@localhost>
Content-Type: multipart/mixed; boundary="=-aDPC7s4nabva3CPn04Zg"
Date: Mon, 28 Jan 2008 09:38:43 +0100
Message-Id: <1201509523.7254.1.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Asus WL-BTD202 needs force_scofix
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-aDPC7s4nabva3CPn04Zg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

Hopefully, this time a working patch :-)

Regards,

Guillaume B.


--=-aDPC7s4nabva3CPn04Zg
Content-Disposition: attachment;
	filename=hci_usb.c-automatically-set-scofix-for-wl-btd202-v2.patch
Content-Type: text/x-patch;
	name=hci_usb.c-automatically-set-scofix-for-wl-btd202-v2.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

--- drivers/bluetooth/hci_usb.c.orig	2008-01-28 02:43:22.000000000 +0100
+++ drivers/bluetooth/hci_usb.c	2008-01-28 00:34:12.000000000 +0100
@@ -104,6 +104,9 @@
 MODULE_DEVICE_TABLE (usb, bluetooth_ids);
 
 static struct usb_device_id blacklist_ids[] = {
+	/* ASUS WL-BTD202 */
+	{ USB_DEVICE(0x0b05, 0x1715), .driver_info = HCI_WRONG_SCO_MTU },
+
 	/* CSR BlueCore devices */
 	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = HCI_CSR },
 

--=-aDPC7s4nabva3CPn04Zg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-aDPC7s4nabva3CPn04Zg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-aDPC7s4nabva3CPn04Zg--
