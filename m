Return-Path: <cyrus@holtmann.org>
From: Adam Lee <adam8157@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH] Bluetooth: ath3k: no need to set same pipe multiple times
Date: Tue, 27 May 2014 13:49:07 +0800
Message-Id: <1401169747-11033-1-git-send-email-adam8157@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Invoking usb_sndbulkpipe() on same pipe for same purpose only once is
enough.

Signed-off-by: Adam Lee <adam8157@gmail.com>
---
 drivers/bluetooth/ath3k.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index a83b57e..f983806 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -193,9 +193,10 @@ static int ath3k_load_firmware(struct usb_device *udev,
 	sent += 20;
 	count -= 20;
 
+	pipe = usb_sndbulkpipe(udev, 0x02);
+
 	while (count) {
 		size = min_t(uint, count, BULK_SIZE);
-		pipe = usb_sndbulkpipe(udev, 0x02);
 		memcpy(send_buf, firmware->data + sent, size);
 
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
-- 
2.0.0.rc4

