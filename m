Return-Path: <cyrus@holtmann.org>
Subject: btusb reset quirk for MacBook Pro
From: David Woodhouse <dwmw2@infradead.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Thu, 18 Sep 2008 13:30:58 -0700
Message-Id: <1221769858.3573.69.camel@macbook.infradead.org>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without this, my new shinybook tends to boot up either giving I/O errors
on 'hciconfig -a', or complaining about packets from non-existent ACL
connections.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6a01068..c46c299 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -157,6 +157,8 @@ static struct usb_device_id blacklist_table[] = {
 	/* Frontline ComProbe Bluetooth Sniffer */
 	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = BTUSB_SNIFFER },
 
+	/* MacBook Pro 4,1 */
+	{ USB_DEVICE(0x05ac, 0x820f), .driver_info = BTUSB_RESET },
 	{ }	/* Terminating entry */
 };
 
-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

