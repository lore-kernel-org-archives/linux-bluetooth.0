Return-Path: <lramos.prof@yahoo.com.br>
Date: Fri, 7 Sep 2018 20:36:03 -0300
From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] ath3k: add more information to error message
Message-ID: <20180907233603.GF3379@giustizia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

When there is an error in either ath3k_load_firmware() or
ath3k_load_fwfile(), the inlined function ath3k_log_failed_loading() is
called receiving the error returned and both the block size requested to
load and the size actually loaded. These values are printed in an error
message using the macro BT_ERR.

This patch creates a new function which does the same but also receives
the "count" variable, in order to show more information when a failing
firmware loading happens. The calls to the older function were changed
to the new one.

This event is being monitored in a laptop with an adapter which
identifies itself as 0cf3:0036, where sometimes there are errors in the
firmware loading process.

Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
---
 drivers/bluetooth/ath3k.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 3a8c47efea55..ebc312cb4412 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -209,6 +209,14 @@ static inline void ath3k_log_failed_loading(int err, int len, int size)
 			err, len, size);
 }
 
+static inline void ath3k_log_failed_loading_2(int err, int len, int size,
+						int count)
+{
+	BT_ERR("%s err = %d, len = %d, size = %d, count = %d",
+			"Error in firmware loading",
+			err, len, size, count);
+}
+
 #define USB_REQ_DFU_DNLOAD	1
 #define BULK_SIZE		4096
 #define FW_HDR_SIZE		20
@@ -257,7 +265,7 @@ static int ath3k_load_firmware(struct usb_device *udev,
 					&len, 3000);
 
 		if (err || (len != size)) {
-			ath3k_log_failed_loading(err, len, size);
+			ath3k_log_failed_loading_2(err, len, size, count);
 			goto error;
 		}
 
@@ -356,7 +364,7 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
 					&len, 3000);
 		if (err || (len != size)) {
-			ath3k_log_failed_loading(err, len, size);
+			ath3k_log_failed_loading_2(err, len, size, count);
 			kfree(send_buf);
 			return err;
 		}
-- 
2.14.4
