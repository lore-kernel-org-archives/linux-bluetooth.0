Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 2/5] android/gatt: Fix write confirm callback being not set
Date: Tue,  9 Dec 2014 09:51:47 +0100
Message-Id: <1418115110-25335-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1418115110-25335-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418115110-25335-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently this callback is required or previously registered write
callback function wont be called.
---
 android/gatt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 720a205..841f08c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6179,6 +6179,15 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
+static void write_confirm(struct gatt_db_attribute *attrib,
+						int err, void *user_data)
+{
+	if (!err)
+		return;
+
+	error("Error writting attribute %p", attrib);
+}
+
 static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
@@ -6207,7 +6216,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 		return;
 
 	gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0], &dev->bdaddr,
-								NULL, NULL);
+							write_confirm, NULL);
 }
 
 static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
@@ -6279,7 +6288,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 		/* Signature OK, proceed with write */
 		bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK, r_sign_cnt);
 		gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
-						&dev->bdaddr, NULL, NULL);
+					&dev->bdaddr, write_confirm, NULL);
 	}
 }
 
@@ -6641,15 +6650,6 @@ static void device_name_read_cb(struct gatt_db_attribute *attrib,
 								strlen(name));
 }
 
-static void write_confirm(struct gatt_db_attribute *attrib,
-						int err, void *user_data)
-{
-	if (!err)
-		return;
-
-	error("Error writting attribute %p", attrib);
-}
-
 static void register_gap_service(void)
 {
 	uint16_t start, end;
-- 
1.9.1

