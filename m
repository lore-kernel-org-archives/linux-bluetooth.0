Return-Path: <cyrus@holtmann.org>
To: marcel@holtmann.org
Subject: Dell Wireless 365 requires reset quirk
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20081104162448.A338EF8A65@sepang.rtg.net>
Date: Tue,  4 Nov 2008 09:24:48 -0700 (MST)
From: timg@tpi.com (Tim Gardner)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 931ccb629d739aa563347a4e866bc26107e6b545 Mon Sep 17 00:00:00 2001
From: Tim Gardner <tim.gardner@canonical.com>
Date: Tue, 4 Nov 2008 09:18:06 -0700
Subject: [PATCH] Dell Wireless 365 needs BTUSB_RESET quirk.
 OriginalAuthor: Mario Limonciello <mario_limonciello@dell.com>

Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Cc: stable@kernel.org
---
 drivers/bluetooth/btusb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index af472e0..051b758 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -125,6 +125,9 @@ static struct usb_device_id blacklist_table[] = {
 	/* Dell laptop with Broadcom chip */
 	{ USB_DEVICE(0x413c, 0x8126), .driver_info = BTUSB_RESET | BTUSB_WRONG_SCO_MTU },
 
+	/* Dell Wireless 365 */
+	{ USB_DEVICE(0x413c, 0x8160), .driver_info = BTUSB_RESET },
+
 	/* Dell Wireless 370 */
 	{ USB_DEVICE(0x413c, 0x8156), .driver_info = BTUSB_RESET | BTUSB_WRONG_SCO_MTU },
 
-- 
1.5.6.3

