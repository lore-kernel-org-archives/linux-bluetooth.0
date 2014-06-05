Return-Path: <cyrus@holtmann.org>
From: Adam Lee <adam8157@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: ath3k: reduce pipe setting times in ath3k_load_fwfile()
Date: Thu,  5 Jun 2014 21:47:44 +0800
Message-Id: <1401976064-6736-1-git-send-email-adam8157@gmail.com>
In-Reply-To: <20140527131548.GB2034@joana>
References: <20140527131548.GB2034@joana>
List-ID: <linux-bluetooth.vger.kernel.org>

Invoking usb_sndbulkpipe() on same pipe for same purpose only once is
enough.

Signed-off-by: Adam Lee <adam8157@gmail.com>
---
 drivers/bluetooth/ath3k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 4aef96b..f938263 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -288,10 +288,10 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 	sent += size;
 	count -= size;
 
+	pipe = usb_sndbulkpipe(udev, 0x02);
+
 	while (count) {
 		size = min_t(uint, count, BULK_SIZE);
-		pipe = usb_sndbulkpipe(udev, 0x02);
-
 		memcpy(send_buf, firmware->data + sent, size);
 
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
-- 
2.0.0
