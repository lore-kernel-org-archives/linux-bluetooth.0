Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Feb 2010 08:43:17 +0300
From: Dan Carpenter <error27@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alicke Xu <sxu@atheros.com>,
	"Luis R. Rodriguez" <lrodriguez@atheros.com>,
	Vikram Kandukuri <vikram.kandukuri@atheros.com>,
	linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] bluetooth: ath3k: add kfree() on error path
Message-ID: <20100208054317.GA10576@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Add a couple kfree() calls on an error path.

Signed-off-by: Dan Carpenter <error27@gmail.com>

---
I only compile tested this one and it's obvoiusly low priority.  Could it go into linux-next?

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index add9485..128cae4 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -143,6 +143,8 @@ static int ath3k_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, data);
 	if (ath3k_load_firmware(data, data->fw_data, data->fw_size)) {
 		usb_set_intfdata(intf, NULL);
+		kfree(data->fw_data);
+		kfree(data);
 		return -EIO;
 	}
 
