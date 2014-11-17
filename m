Return-Path: <cyrus@holtmann.org>
Message-ID: <5469F727.7030403@gmail.com>
Date: Mon, 17 Nov 2014 11:24:55 -0200
From: Fabio K <healthkit@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add support for bluetooth BCM20702A1 variant
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Linux 3.18-rc5 (from git commit fc14f9c)

This variant requires the flag BTUSB_BCM_PATCHRAM to work.

Signed-off-by: Fabio K <healthkit@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index edfc17b..7c0fdd2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -106,6 +106,8 @@ static const struct usb_device_id btusb_table[] = {
     { USB_DEVICE(0x0b05, 0x17b5) },
     { USB_DEVICE(0x0b05, 0x17cb) },
     { USB_DEVICE(0x413c, 0x8197) },
+    { USB_DEVICE(0x13d3, 0x3404),
+      .driver_info = BTUSB_BCM_PATCHRAM },
 
     /* Foxconn - Hon Hai */
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },
-- 
2.1.3

