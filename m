Return-Path: <cyrus@holtmann.org>
From: Ben Collins <ben.collins@canonical.com>
Date: Sun, 20 Jul 2008 21:45:08 -0400
Subject: [PATCH 3/7] bluetooth: Add quirks for a few hci_usb devices
To: linux-kernel@vger.kernel.org
In-Reply-To: <24762.90.138.930.038.1036103001.ben.collins@canonical.com>
CC: linux-bluetooth@vger.kernel.org
Message-Id: <E1KKl4I-00068H-S6@swissweb.swissdisk.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the Dell 370 and 410 BT adapters are put into BT radio mode, they
need to be prepared like many other Broadcom adapters.

Also, add quirk Broadcom 2046 devices with HCI_RESET.

CC: linux-bluetooth@vger.kernel.org
Signed-off-by: Michael Frey <michael.frey@canonical.com>
Signed-off-by: Mario Limonciello <Mario_Limonciello@Dell.com>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: Ben Collins <ben.collins@canonical.com>
---
 drivers/bluetooth/hci_usb.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
index 192522e..0254a6b 100644
--- a/drivers/bluetooth/hci_usb.c
+++ b/drivers/bluetooth/hci_usb.c
@@ -134,6 +134,13 @@ static struct usb_device_id blacklist_ids[] = {
 
 	/* Dell laptop with Broadcom chip */
 	{ USB_DEVICE(0x413c, 0x8126), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	/* Dell Wireless 370 */
+	{ USB_DEVICE(0x413c, 0x8156), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	/* Dell Wireless 410 */
+	{ USB_DEVICE(0x413c, 0x8152), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+        
+        /* Broadcom 2046 */
+        { USB_DEVICE(0x0a5c, 0x2151), .driver_info = HCI_RESET },
 
 	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
 	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_RESET },
-- 
1.5.4.3

