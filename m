Return-Path: <cyrus@holtmann.org>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: linux-bluetooth@vger.kernel.org
Cc: stable@kernel.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 1/2] bluetooth: Add support Bluetooth controller of MacbookPro 6,2
Date: Thu, 19 Aug 2010 14:54:18 +0900
Message-Id: <1282197259-16609-1-git-send-email-iwamatsu@nigauri.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth controller of MacbookPro 6,2 does not work.
Because Device Class of these controllers was set 255 (Vendor Sepecific Class).

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/bluetooth/btusb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d22ce3c..9fb8635 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -62,6 +62,9 @@ static struct usb_device_id btusb_table[] = {
 	/* Apple iMac11,1 */
 	{ USB_DEVICE(0x05ac, 0x8215) },
 
+	/* Apple MacBookPro6,2 */
+	{ USB_DEVICE(0x05ac, 0x8218) },
+
 	/* AVM BlueFRITZ! USB v2.0 */
 	{ USB_DEVICE(0x057c, 0x3800) },
 
-- 
1.7.1

