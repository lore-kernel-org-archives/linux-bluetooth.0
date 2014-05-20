Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/gatt: Fix handling write cmd.
Date: Tue, 20 May 2014 12:42:49 +0200
Message-Id: <1400582569-30934-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should not response on write cmd. This patch fixed that.
---
 android/gatt.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8e0d72a..36a1a7a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4648,7 +4648,7 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
-static uint8_t write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
+static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
 	uint8_t value[ATT_DEFAULT_LE_MTU];
@@ -4658,13 +4658,9 @@ static uint8_t write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	len = dec_write_cmd(cmd, cmd_len, &handle, value, &vlen);
 	if (!len)
-		return ATT_ECODE_INVALID_PDU;
-
-	if (!gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
-								&dev->bdaddr))
-		return ATT_ECODE_UNLIKELY;
+		return;
 
-	return 0;
+	gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0], &dev->bdaddr);
 }
 
 static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
@@ -4750,10 +4746,9 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 			return;
 		break;
 	case ATT_OP_WRITE_CMD:
-		status = write_cmd_request(ipdu, len, dev);
-		if (!status)
-			return;
-		break;
+		write_cmd_request(ipdu, len, dev);
+		/* No response on write cmd */
+		return;
 	case ATT_OP_PREP_WRITE_REQ:
 		status = write_prep_request(ipdu, len, dev);
 		if (!status)
-- 
1.8.4

