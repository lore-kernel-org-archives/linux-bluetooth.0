Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtman.org, "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Move bit-field var to data->flags
Date: Fri, 16 Jul 2010 17:20:33 -0300
Message-Id: <1279311633-12131-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

did_iso_resume keeps only a bit-field value, so moving that to a proper
flags place.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 drivers/bluetooth/btusb.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6fcb971..d22ce3c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -149,6 +149,7 @@ static struct usb_device_id blacklist_table[] = {
 #define BTUSB_BULK_RUNNING	1
 #define BTUSB_ISOC_RUNNING	2
 #define BTUSB_SUSPENDING	3
+#define BTUSB_DID_ISO_RESUME	4
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -182,7 +183,6 @@ struct btusb_data {
 	unsigned int sco_num;
 	int isoc_altsetting;
 	int suspend_count;
-	int did_iso_resume:1;
 };
 
 static int inc_tx(struct btusb_data *data)
@@ -810,7 +810,7 @@ static void btusb_work(struct work_struct *work)
 	int err;
 
 	if (hdev->conn_hash.sco_num > 0) {
-		if (!data->did_iso_resume) {
+		if (!test_bit(BTUSB_DID_ISO_RESUME, &data->flags)) {
 			err = usb_autopm_get_interface(data->isoc);
 			if (err < 0) {
 				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
@@ -818,7 +818,7 @@ static void btusb_work(struct work_struct *work)
 				return;
 			}
 
-			data->did_iso_resume = 1;
+			set_bit(BTUSB_DID_ISO_RESUME, &data->flags);
 		}
 		if (data->isoc_altsetting != 2) {
 			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
@@ -839,10 +839,8 @@ static void btusb_work(struct work_struct *work)
 		usb_kill_anchored_urbs(&data->isoc_anchor);
 
 		__set_isoc_interface(hdev, 0);
-		if (data->did_iso_resume) {
-			data->did_iso_resume = 0;
+		if (test_and_clear_bit(BTUSB_DID_ISO_RESUME, &data->flags))
 			usb_autopm_put_interface(data->isoc);
-		}
 	}
 }
 
-- 
1.7.1.1

