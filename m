Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Leif Liddy <leif.linux@gmail.com>
To: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, kai.heng.feng@canonical.com,
        stable@vger.kernel.org, mka@chromium.org, briannorris@chromium.org,
        drake@endlessm.com
Cc: Leif Liddy <leif.linux@gmail.com>
Subject: [PATCH] usb: quirks: Add reset-resume quirk for QCA6174 Rome Bluetooth
Date: Sun, 31 Dec 2017 18:13:35 +0100
Message-Id: <20171231171335.12020-1-leif.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a rework of reverted commit fd865802c66bc451dc515ed89360f84376ce1a56
The issue is that some QCA Rome bluetooth controllers stop functioning upon resume from suspend.
These devices seem to be losing power during suspend. This patch will enable
reset_resume in usb core (instead of btusb) and will target the specific device 0x0cf3:0xe300

Signed-off-by: Leif Liddy <leif.linux@gmail.com>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index a10b346b9777..d94e6658d054 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -248,6 +248,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* INTEL VALUE SSD */
 	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* QCA Rome Bluetooth in QCA6174 wireless module */
+	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	{ }  /* terminating entry must be last */
 };
 
-- 
2.14.3
