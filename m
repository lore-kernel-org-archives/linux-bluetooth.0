Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/gatt: If attribute was not found in database, return proper error
Date: Wed, 28 May 2014 08:54:00 +0200
Message-Id: <1401260041-693-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401260041-693-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401260041-693-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If get_attribute_permissions return negative value, we should reply with
ATT_ECODE_ATTR_NOT_FOUND.
---
 android/gatt.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 99e91f4..b95047d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3857,7 +3857,7 @@ static bool match_dev_request_by_handle(const void *data, const void *user_data)
 }
 
 static uint8_t check_device_permissions(struct gatt_device *device,
-					uint8_t opcode, uint32_t permissions)
+					uint8_t opcode, int64_t permissions)
 {
 	GIOChannel *io;
 	int sec_level;
@@ -3868,7 +3868,7 @@ static uint8_t check_device_permissions(struct gatt_device *device,
 							BT_IO_OPT_INVALID))
 		return ATT_ECODE_UNLIKELY;
 
-	DBG("opcode %u permissions %u sec_level %u", opcode, permissions,
+	DBG("opcode %u permissions %ld sec_level %u", opcode, permissions,
 								sec_level);
 
 	switch (opcode) {
@@ -3928,19 +3928,18 @@ static void read_requested_attributes(void *data, void *user_data)
 {
 	struct pending_request *resp_data = data;
 	struct request_processing_data *process_data = user_data;
-	uint32_t permissions;
+	int64_t permissions;
 	uint8_t *value;
 	int value_len;
 
 	permissions = gatt_db_get_attribute_permissions(gatt_db,
 							resp_data->handle);
 
-	/*
-	 * Check if it is attribute we didn't declare permissions, like service
-	 * declaration or included service. Set permissions to read only
-	 */
-	if (permissions == 0)
-		permissions = GATT_PERM_READ;
+	if (permissions < 0) {
+		resp_data->error = ATT_ECODE_ATTR_NOT_FOUND;
+		resp_data->state = REQUEST_DONE;
+		return;
+	}
 
 	resp_data->error = check_device_permissions(process_data->device,
 							process_data->opcode,
@@ -4152,7 +4151,7 @@ failed:
 
 static uint32_t android_to_gatt_permissions(int32_t hal_permissions)
 {
-	uint32_t permissions = 0;
+	int64_t permissions = 0;
 
 	if (hal_permissions & HAL_GATT_PERMISSION_READ)
 		permissions |= GATT_PERM_READ;
@@ -4191,7 +4190,7 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
 	struct gatt_app *server;
 	bt_uuid_t uuid;
 	uint8_t status;
-	uint32_t permissions;
+	int64_t permissions;
 	int32_t app_id = cmd->server_if;
 
 	DBG("");
@@ -4239,7 +4238,7 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
 	struct gatt_app *server;
 	bt_uuid_t uuid;
 	uint8_t status;
-	uint32_t permissions;
+	int64_t permissions;
 	int32_t app_id = cmd->server_if;
 
 	DBG("");
@@ -4894,7 +4893,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
 	uint8_t value[cmd_len];
-	uint32_t permissions;
+	int64_t permissions;
 	uint16_t handle;
 	uint16_t len;
 	size_t vlen;
@@ -4904,6 +4903,9 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 		return;
 
 	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
+	if (permissions < 0)
+		return;
+
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
 
@@ -4915,7 +4917,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 {
 	uint8_t value[ATT_DEFAULT_LE_MTU];
 	uint8_t s[ATT_SIGNATURE_LEN];
-	uint32_t permissions;
+	int64_t permissions;
 	uint16_t handle;
 	uint16_t len;
 	size_t vlen;
@@ -4930,6 +4932,9 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	len = dec_signed_write_cmd(cmd, cmd_len, &handle, value, &vlen, s);
 
 	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
+	if (permissions < 0)
+		return;
+
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
 
@@ -4959,7 +4964,7 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 {
 	uint8_t value[cmd_len];
 	struct pending_request *data;
-	uint32_t permissions;
+	int64_t permissions;
 	uint16_t handle;
 	uint16_t len;
 	uint8_t error;
@@ -4970,6 +4975,8 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_INVALID_PDU;
 
 	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
+	if (permissions < 0)
+		return ATT_ECODE_ATTR_NOT_FOUND;
 
 	error = check_device_permissions(dev, cmd[0], permissions);
 	if (error)
@@ -5004,7 +5011,7 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 {
 	uint8_t value[cmd_len];
 	struct pending_request *data;
-	uint32_t permissions;
+	int64_t permissions;
 	uint16_t handle;
 	uint16_t offset;
 	uint8_t error;
@@ -5017,6 +5024,8 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_INVALID_PDU;
 
 	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
+	if (permissions < 0)
+		return ATT_ECODE_ATTR_NOT_FOUND;
 
 	error = check_device_permissions(dev, cmd[0], permissions);
 	if (error)
-- 
1.9.0

