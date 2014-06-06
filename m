Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 05/13] android/gatt: Improve response filling function
Date: Fri,  6 Jun 2014 15:46:18 +0200
Message-Id: <1402062386-4632-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some functionality was extracted so it can be used from functions
already having device and pending response pointers without redundant
search. Parameters order was improved and some were removed. Function
name was changed as the real sending is done elsewere.
---
 android/gatt.c | 69 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5d01d8b..fe8655a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4188,44 +4188,44 @@ static void process_dev_pending_requests(struct gatt_device *device,
 	send_dev_complete_response(device, att_opcode);
 }
 
-static void send_gatt_response(uint8_t opcode, uint16_t handle,
+static void fill_gatt_response(struct pending_request *request, uint16_t handle,
 					uint16_t offset, uint8_t status,
-					uint16_t len, const uint8_t *data,
-					bdaddr_t *bdaddr)
+					uint16_t len, const uint8_t *data)
 {
-	struct gatt_device *dev;
-	struct pending_request *entry;
+	request->handle = handle;
+	request->offset = offset;
+	request->length = len;
+	request->state = REQUEST_DONE;
+	request->error = status;
 
-	dev = find_device_by_addr(bdaddr);
-	if (!dev) {
-		error("gatt: send_gatt_response, could not find dev");
+	if (!len)
 		return;
-	}
 
-	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
-							UINT_TO_PTR(handle));
-	if (!entry) {
-		DBG("No pending response found! Bogus android response?");
+	request->value = malloc0(len);
+	if (!request->value) {
+		request->error = ATT_ECODE_INSUFF_RESOURCES;
+
 		return;
 	}
 
-	entry->handle = handle;
-	entry->offset = offset;
-	entry->length = len;
-	entry->state = REQUEST_DONE;
-	entry->error = status;
-
-	if (!len)
-		return;
+	memcpy(request->value, data, len);
+}
 
-	entry->value = malloc0(len);
-	if (!entry->value) {
-		entry->error = ATT_ECODE_INSUFF_RESOURCES;
+static void fill_gatt_response_by_handle(uint16_t handle, uint16_t offset,
+						uint8_t status, uint16_t len,
+						const uint8_t *data,
+						struct gatt_device *dev)
+{
+	struct pending_request *entry;
 
+	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
+							UINT_TO_PTR(handle));
+	if (entry) {
+		DBG("No pending response found! Bogus android response?");
 		return;
 	}
 
-	memcpy(entry->value, data, len);
+	fill_gatt_response(entry, handle, offset, status, len, data);
 }
 
 static struct pending_trans_data *conn_add_transact(struct app_connection *conn,
@@ -4257,6 +4257,7 @@ static void read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
 	struct gatt_app *app;
 	struct app_connection *conn;
 	int32_t id = PTR_TO_INT(user_data);
+	struct gatt_device *dev;
 
 	app = find_app_by_id(id);
 	if (!app) {
@@ -4291,8 +4292,10 @@ static void read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
 	return;
 
 failed:
-	send_gatt_response(att_opcode, handle, 0, ATT_ECODE_UNLIKELY, 0,
-							NULL, bdaddr);
+	dev = find_device_by_addr(bdaddr);
+	if (dev)
+		fill_gatt_response_by_handle(handle, 0, ATT_ECODE_UNLIKELY, 0,
+							NULL, dev);
 }
 
 static void write_cb(uint16_t handle, uint16_t offset,
@@ -4306,6 +4309,7 @@ static void write_cb(uint16_t handle, uint16_t offset,
 	struct gatt_app *app;
 	int32_t id = PTR_TO_INT(user_data);
 	struct app_connection *conn;
+	struct gatt_device *dev;
 
 	app = find_app_by_id(id);
 	if (!app) {
@@ -4352,8 +4356,10 @@ static void write_cb(uint16_t handle, uint16_t offset,
 	return;
 
 failed:
-	send_gatt_response(att_opcode, handle, 0, ATT_ECODE_UNLIKELY, 0, NULL,
-								bdaddr);
+	dev = find_device_by_addr(bdaddr);
+	if (dev)
+		fill_gatt_response_by_handle(handle, 0, ATT_ECODE_UNLIKELY, 0,
+								NULL, dev);
 }
 
 static uint32_t android_to_gatt_permissions(int32_t hal_permissions)
@@ -4714,9 +4720,8 @@ static void handle_server_send_response(const void *buf, uint16_t len)
 		 */
 	}
 
-	send_gatt_response(transaction->opcode, handle, cmd->offset,
-					cmd->status, cmd->len, cmd->data,
-					&conn->device->bdaddr);
+	fill_gatt_response_by_handle(handle, cmd->offset, cmd->status, cmd->len,
+						cmd->data, conn->device);
 	send_dev_complete_response(conn->device, transaction->opcode);
 
 done:
-- 
2.0.0

