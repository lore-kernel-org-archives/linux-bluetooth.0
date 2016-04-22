Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 22 Apr 2016 13:02:55 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [patch] Bluetooth: ath3k: Silence uninitialized variable warning
Message-ID: <20160422100255.GE11398@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

We could print an uninitialized value in the error message.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 47ca4b3..641c2d1 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -206,7 +206,8 @@ static int ath3k_load_firmware(struct usb_device *udev,
 				const struct firmware *firmware)
 {
 	u8 *send_buf;
-	int err, pipe, len, size, sent = 0;
+	int len = 0;
+	int err, pipe, size, sent = 0;
 	int count = firmware->size;
 
 	BT_DBG("udev %p", udev);
@@ -302,7 +303,8 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 		const struct firmware *firmware)
 {
 	u8 *send_buf;
-	int err, pipe, len, size, count, sent = 0;
+	int len = 0;
+	int err, pipe, size, count, sent = 0;
 	int ret;
 
 	count = firmware->size;
