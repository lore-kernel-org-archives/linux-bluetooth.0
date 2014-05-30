Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/gatt: Chack if given handle exists in database
Date: Fri, 30 May 2014 07:51:13 +0200
Message-Id: <1401429074-31535-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401429074-31535-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401429074-31535-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If attribute doesn't exist, we should return ATT_ECODE_ATTR_NOT_FOUND
error.
---
 android/gatt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 80d9f30..48a32ec 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4070,6 +4070,9 @@ static void read_requested_attributes(void *data, void *user_data)
 	uint8_t *value;
 	int value_len;
 
+	if (!gatt_db_has_attribute(gatt_db, resp_data->handle))
+		return;
+
 	permissions = gatt_db_get_attribute_permissions(gatt_db,
 							resp_data->handle);
 
@@ -5067,6 +5070,9 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return;
 
+	if (!gatt_db_has_attribute(gatt_db, handle))
+		return;
+
 	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
@@ -5093,6 +5099,9 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	len = dec_signed_write_cmd(cmd, cmd_len, &handle, value, &vlen, s);
 
+	if (!gatt_db_has_attribute(gatt_db, handle))
+		return;
+
 	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
@@ -5133,6 +5142,9 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	if (!gatt_db_has_attribute(gatt_db, handle))
+		return ATT_ECODE_ATTR_NOT_FOUND;
+
 	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
 
 	error = check_device_permissions(dev, cmd[0], permissions);
@@ -5181,6 +5193,9 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	if (!gatt_db_has_attribute(gatt_db, handle))
+		return ATT_ECODE_ATTR_NOT_FOUND;
+
 	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
 
 	error = check_device_permissions(dev, cmd[0], permissions);
-- 
1.9.0

