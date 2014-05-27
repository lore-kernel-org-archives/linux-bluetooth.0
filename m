Return-Path: <cyrus@holtmann.org>
From: Adam Lee <adam8157@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: ath3k: no need to set same pipe multiple times
Date: Wed, 28 May 2014 01:16:32 +0800
Message-Id: <1401210992-11878-1-git-send-email-adam8157@gmail.com>
In-Reply-To: <20140527131548.GB2034@joana>
References: <20140527131548.GB2034@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Invoking usb_sndbulkpipe() on same pipe for same purpose only once is
enough.

v2: patch the missing place too, sorry.

Signed-off-by: Adam Lee <adam8157@gmail.com>
---
 drivers/bluetooth/ath3k.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index a83b57e..9559f74 100644
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
@@ -289,10 +290,10 @@ static int ath3k_load_fwfile(struct usb_device *udev,
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
2.0.0.rc4

