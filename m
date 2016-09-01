Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] Bluetooth: btusb: Mark CW6622 devices to have broken link key commands
Date: Thu,  1 Sep 2016 16:52:39 +0200
Message-Id: <1472741559-32358-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Conwise CW6622 seems to have a problem with the stored link key
commands so just mark it as broken.

< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Supported Features (0x04|0x0003) ncmd 1
    status 0x00
    Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 2.0 (0x3) HCI Revision: 0x1f4
    LMP Version: 2.0 (0x3) LMP Subversion: 0x1f4
    Manufacturer: CONWISE Technology Corporation Ltd (66)
...
< HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
> HCI Event: Command Complete (0x0e) plen 68
    Read Local Supported Commands (0x04|0x0002) ncmd 1
    status 0x00
    Commands: 7fffef03cedfffffffffff1ff20ff8ff3f
...
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
    bdaddr 00:00:00:00:00:00 all 1
> HCI Event: Command Complete (0x0e) plen 8
    Read Stored Link Key (0x03|0x000d) ncmd 1
    status 0x11 max 0 num 0
    Error: Unsupported Feature or Parameter Value

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 drivers/bluetooth/btusb.c | 54 +++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 80ae854..396f91d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -42,26 +42,26 @@ static bool reset = true;
 
 static struct usb_driver btusb_driver;
 
-#define BTUSB_IGNORE		0x01
-#define BTUSB_DIGIANSWER	0x02
-#define BTUSB_CSR		0x04
-#define BTUSB_SNIFFER		0x08
-#define BTUSB_BCM92035		0x10
-#define BTUSB_BROKEN_ISOC	0x20
-#define BTUSB_WRONG_SCO_MTU	0x40
-#define BTUSB_ATH3012		0x80
-#define BTUSB_INTEL		0x100
-#define BTUSB_INTEL_BOOT	0x200
-#define BTUSB_BCM_PATCHRAM	0x400
-#define BTUSB_MARVELL		0x800
-#define BTUSB_SWAVE		0x1000
-#define BTUSB_INTEL_NEW		0x2000
-#define BTUSB_AMP		0x4000
-#define BTUSB_QCA_ROME		0x8000
-#define BTUSB_BCM_APPLE		0x10000
-#define BTUSB_REALTEK		0x20000
-#define BTUSB_BCM2045		0x40000
-#define BTUSB_IFNUM_2		0x80000
+#define BTUSB_IGNORE			0x01
+#define BTUSB_DIGIANSWER		0x02
+#define BTUSB_CSR			0x04
+#define BTUSB_SNIFFER			0x08
+#define BTUSB_BCM92035			0x10
+#define BTUSB_BROKEN_ISOC		0x20
+#define BTUSB_WRONG_SCO_MTU		0x40
+#define BTUSB_ATH3012			0x80
+#define BTUSB_INTEL			0x100
+#define BTUSB_INTEL_BOOT		0x200
+#define BTUSB_BCM_PATCHRAM		0x400
+#define BTUSB_MARVELL			0x800
+#define BTUSB_SWAVE			0x1000
+#define BTUSB_INTEL_NEW			0x2000
+#define BTUSB_AMP			0x4000
+#define BTUSB_QCA_ROME			0x8000
+#define BTUSB_BCM_APPLE			0x10000
+#define BTUSB_REALTEK			0x20000
+#define BTUSB_BROKEN_STORED_LINK_KEY	0x40000
+#define BTUSB_IFNUM_2			0x80000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -173,8 +173,9 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Broadcom BCM2033 without firmware */
 	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = BTUSB_IGNORE },
 
-	/* Broadcom BCM2045 devices */
-	{ USB_DEVICE(0x0a5c, 0x2045), .driver_info = BTUSB_BCM2045 },
+	/* Broadcom BCM2045 devices, broken Read Stored Link Key command */
+	{ USB_DEVICE(0x0a5c, 0x2045),
+	  .driver_info = BTUSB_BROKEN_STORED_LINK_KEY },
 
 	/* Atheros 3011 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
@@ -290,8 +291,11 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0400, 0x0807), .driver_info = BTUSB_BROKEN_ISOC },
 	{ USB_DEVICE(0x0400, 0x080a), .driver_info = BTUSB_BROKEN_ISOC },
 
-	/* CONWISE Technology based adapters with buggy SCO support */
-	{ USB_DEVICE(0x0e5e, 0x6622), .driver_info = BTUSB_BROKEN_ISOC },
+	/* CONWISE Technology based adapters with buggy SCO support and broken
+	 * Read Stored Link Key command
+	 */
+	{ USB_DEVICE(0x0e5e, 0x6622),
+	  .driver_info = BTUSB_BROKEN_ISOC | BTUSB_BROKEN_STORED_LINK_KEY},
 
 	/* Roper Class 1 Bluetooth Dongle (Silicon Wave based) */
 	{ USB_DEVICE(0x1310, 0x0001), .driver_info = BTUSB_SWAVE },
@@ -2845,7 +2849,7 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
 
-	if (id->driver_info & BTUSB_BCM2045)
+	if (id->driver_info & BTUSB_BROKEN_STORED_LINK_KEY)
 		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
 
 	if (id->driver_info & BTUSB_BCM92035)
-- 
2.7.4

