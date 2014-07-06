Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove module parameters for ignoring USB devices
Date: Sun,  6 Jul 2014 14:27:39 +0200
Message-Id: <1404649659-47741-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The module parameters to ignore devices based on USB VID/PID are not
needed at all. So just remove them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 21f10cac4fac..14314a12babe 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -30,9 +30,6 @@
 
 #define VERSION "0.6"
 
-static bool ignore_dga;
-static bool ignore_csr;
-static bool ignore_sniffer;
 static bool disable_scofix;
 static bool force_scofix;
 
@@ -1683,15 +1680,6 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info == BTUSB_IGNORE)
 		return -ENODEV;
 
-	if (ignore_dga && id->driver_info & BTUSB_DIGIANSWER)
-		return -ENODEV;
-
-	if (ignore_csr && id->driver_info & BTUSB_CSR)
-		return -ENODEV;
-
-	if (ignore_sniffer && id->driver_info & BTUSB_SNIFFER)
-		return -ENODEV;
-
 	if (id->driver_info & BTUSB_ATH3012) {
 		struct usb_device *udev = interface_to_usbdev(intf);
 
@@ -1981,15 +1969,6 @@ static struct usb_driver btusb_driver = {
 
 module_usb_driver(btusb_driver);
 
-module_param(ignore_dga, bool, 0644);
-MODULE_PARM_DESC(ignore_dga, "Ignore devices with id 08fd:0001");
-
-module_param(ignore_csr, bool, 0644);
-MODULE_PARM_DESC(ignore_csr, "Ignore devices with id 0a12:0001");
-
-module_param(ignore_sniffer, bool, 0644);
-MODULE_PARM_DESC(ignore_sniffer, "Ignore devices with id 0a12:0002");
-
 module_param(disable_scofix, bool, 0644);
 MODULE_PARM_DESC(disable_scofix, "Disable fixup of wrong SCO buffer size");
 
-- 
1.9.3

