Return-Path: <cyrus@holtmann.org>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: linux-bluetooth@vger.kernel.org
Cc: stable@kernel.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 2/2] bluetooth: Add support Bluetooth controller of MacbookPro 7,1
Date: Thu, 19 Aug 2010 14:54:19 +0900
Message-Id: <1282197259-16609-2-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1282197259-16609-1-git-send-email-iwamatsu@nigauri.org>
References: <1282197259-16609-1-git-send-email-iwamatsu@nigauri.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth controller of MacbookPro 7,1 does not work.
Because Device Class of these controllers was set 255 (Vendor Sepecific Class).

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/bluetooth/btusb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9fb8635..3da2ba2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -59,6 +59,9 @@ static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
 
+	/* Apple MacBookPro 7,1 */
+	{ USB_DEVICE(0x05ac, 0x8213) },
+
 	/* Apple iMac11,1 */
 	{ USB_DEVICE(0x05ac, 0x8215) },
 
-- 
1.7.1

