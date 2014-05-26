Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/gatt: Check permissions before write execution
Date: Mon, 26 May 2014 16:06:23 +0200
Message-Id: <1401113183-6617-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401113183-6617-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401113183-6617-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check attribute's permissions and return error if device is not allowed
to read.
---
 android/gatt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 721785a..18e1e03 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4894,6 +4894,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
 	uint8_t value[cmd_len];
+	uint32_t permissions;
 	uint16_t handle;
 	uint16_t len;
 	size_t vlen;
@@ -4902,6 +4903,10 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return;
 
+	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
+	if (check_device_permissions(dev, cmd[0], permissions))
+		return;
+
 	gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0], &dev->bdaddr);
 }
 
@@ -4910,6 +4915,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 {
 	uint8_t value[ATT_DEFAULT_LE_MTU];
 	uint8_t s[ATT_SIGNATURE_LEN];
+	uint32_t permissions;
 	uint16_t handle;
 	uint16_t len;
 	size_t vlen;
@@ -4922,6 +4928,11 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	len = dec_signed_write_cmd(cmd, cmd_len, &handle, value, &vlen, s);
+
+	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
+	if (check_device_permissions(dev, cmd[0], permissions))
+		return;
+
 	if (len) {
 		uint8_t t[ATT_SIGNATURE_LEN];
 
@@ -4948,14 +4959,22 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 {
 	uint8_t value[cmd_len];
 	struct pending_request *data;
+	uint32_t permissions;
 	uint16_t handle;
 	uint16_t len;
+	uint8_t error;
 	size_t vlen;
 
 	len = dec_write_req(cmd, cmd_len, &handle, value, &vlen);
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
+
+	error = check_device_permissions(dev, cmd[0], permissions);
+	if (error)
+		return error;
+
 	data = new0(struct pending_request, 1);
 	if (!data)
 		return ATT_ECODE_INSUFF_RESOURCES;
@@ -4983,8 +5002,10 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 {
 	uint8_t value[cmd_len];
 	struct pending_request *data;
+	uint32_t permissions;
 	uint16_t handle;
 	uint16_t offset;
+	uint8_t error;
 	uint16_t len;
 	size_t vlen;
 
@@ -4993,6 +5014,12 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
+
+	error = check_device_permissions(dev, cmd[0], permissions);
+	if (error)
+		return error;
+
 	data = new0(struct pending_request, 1);
 	if (!data)
 		return ATT_ECODE_INSUFF_RESOURCES;
-- 
1.9.0

