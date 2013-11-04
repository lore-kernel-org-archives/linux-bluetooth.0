Return-Path: <cyrus@holtmann.org>
Message-ID: <52774AB7.1010609@canonical.com>
Date: Mon, 04 Nov 2013 15:20:23 +0800
From: "Bruce.Ma" <bruce.ma@canonical.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btusb: add realtek 8723 in the blacklist
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruce Ma <bruce.ma@canonical.com>
Date: Tue, 04 Nov 2013 11:21:20 +0800
Subject: [PATCH] btusb: add Realtek 8723 in the blacklist

The btusb doesn't work with Realtek 8723 bluetooth device,
so we want to add it to the blacklist.

Signed-off-by: Bruce Ma <bruce.ma@canonical.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index eae58a1..3097ac8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -138,6 +138,9 @@ static struct usb_device_id blacklist_table[] = {
	{ USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
	{ USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
+	/* Realtek 8723 Bluetooth */
+	{ USB_DEVICE(0x0bda, 0xb728), .driver_info = BTUSB_IGNORE },
+
	/* Atheros AR9285 Malbec with sflash firmware */
	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
 -- 1.8.1.2

