Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2] Bluetooth: btusb: Mark CW6622 devices to have broken link key commands
Date: Thu,  1 Sep 2016 17:22:37 +0200
Message-Id: <1472743357-11144-1-git-send-email-szymon.janc@codecoup.pl>
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
 drivers/bluetooth/btusb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 80ae854..4ef5ec8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -62,6 +62,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_REALTEK		0x20000
 #define BTUSB_BCM2045		0x40000
 #define BTUSB_IFNUM_2		0x80000
+#define BTUSB_CW6622		0x100000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -291,7 +292,8 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0400, 0x080a), .driver_info = BTUSB_BROKEN_ISOC },
 
 	/* CONWISE Technology based adapters with buggy SCO support */
-	{ USB_DEVICE(0x0e5e, 0x6622), .driver_info = BTUSB_BROKEN_ISOC },
+	{ USB_DEVICE(0x0e5e, 0x6622),
+	  .driver_info = BTUSB_BROKEN_ISOC | BTUSB_CW6622},
 
 	/* Roper Class 1 Bluetooth Dongle (Silicon Wave based) */
 	{ USB_DEVICE(0x1310, 0x0001), .driver_info = BTUSB_SWAVE },
@@ -2845,7 +2847,8 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
 
-	if (id->driver_info & BTUSB_BCM2045)
+	if ((id->driver_info & BTUSB_BCM2045) ||
+	    (id->driver_info & BTUSB_CW6622))
 		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
 
 	if (id->driver_info & BTUSB_BCM92035)
-- 
2.7.4

