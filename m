Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: vkandukuri@atheros.com, sbalashanmugam@atheros.com,
	padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Bluetooth: ath3k: Use GFP_KERNEL instead of GFP_ATOMIC
Date: Tue, 25 Oct 2011 11:49:54 +0200
Message-Id: <1319536194-4720-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are allowed to sleep here so no need to use GFP_ATOMIC. The caller
(ath3k_probe) calls request_firmware() which definitely sleeps. Hence, we should
avoid using GFP_ATOMIC.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/ath3k.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index db7cb81..bcf9727 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -105,7 +105,7 @@ static int ath3k_load_firmware(struct usb_device *udev,
 
 	pipe = usb_sndctrlpipe(udev, 0);
 
-	send_buf = kmalloc(BULK_SIZE, GFP_ATOMIC);
+	send_buf = kmalloc(BULK_SIZE, GFP_KERNEL);
 	if (!send_buf) {
 		BT_ERR("Can't allocate memory chunk for firmware");
 		return -ENOMEM;
-- 
1.7.7.1

