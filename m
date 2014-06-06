Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 06/13] android/gatt: Move response filling functions up
Date: Fri,  6 Jun 2014 15:46:19 +0200
Message-Id: <1402062386-4632-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Its needed to be called from read_requested_attributes.
---
 android/gatt.c | 80 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index fe8655a..35a163d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4112,6 +4112,46 @@ static uint8_t check_device_permissions(struct gatt_device *device,
 	return 0;
 }
 
+static void fill_gatt_response(struct pending_request *request, uint16_t handle,
+					uint16_t offset, uint8_t status,
+					uint16_t len, const uint8_t *data)
+{
+	request->handle = handle;
+	request->offset = offset;
+	request->length = len;
+	request->state = REQUEST_DONE;
+	request->error = status;
+
+	if (!len)
+		return;
+
+	request->value = malloc0(len);
+	if (!request->value) {
+		request->error = ATT_ECODE_INSUFF_RESOURCES;
+
+		return;
+	}
+
+	memcpy(request->value, data, len);
+}
+
+static void fill_gatt_response_by_handle(uint16_t handle, uint16_t offset,
+						uint8_t status, uint16_t len,
+						const uint8_t *data,
+						struct gatt_device *dev)
+{
+	struct pending_request *entry;
+
+	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
+							UINT_TO_PTR(handle));
+	if (entry) {
+		DBG("No pending response found! Bogus android response?");
+		return;
+	}
+
+	fill_gatt_response(entry, handle, offset, status, len, data);
+}
+
 static void read_requested_attributes(void *data, void *user_data)
 {
 	struct pending_request *resp_data = data;
@@ -4188,46 +4228,6 @@ static void process_dev_pending_requests(struct gatt_device *device,
 	send_dev_complete_response(device, att_opcode);
 }
 
-static void fill_gatt_response(struct pending_request *request, uint16_t handle,
-					uint16_t offset, uint8_t status,
-					uint16_t len, const uint8_t *data)
-{
-	request->handle = handle;
-	request->offset = offset;
-	request->length = len;
-	request->state = REQUEST_DONE;
-	request->error = status;
-
-	if (!len)
-		return;
-
-	request->value = malloc0(len);
-	if (!request->value) {
-		request->error = ATT_ECODE_INSUFF_RESOURCES;
-
-		return;
-	}
-
-	memcpy(request->value, data, len);
-}
-
-static void fill_gatt_response_by_handle(uint16_t handle, uint16_t offset,
-						uint8_t status, uint16_t len,
-						const uint8_t *data,
-						struct gatt_device *dev)
-{
-	struct pending_request *entry;
-
-	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
-							UINT_TO_PTR(handle));
-	if (entry) {
-		DBG("No pending response found! Bogus android response?");
-		return;
-	}
-
-	fill_gatt_response(entry, handle, offset, status, len, data);
-}
-
 static struct pending_trans_data *conn_add_transact(struct app_connection *conn,
 								uint8_t opcode)
 {
-- 
2.0.0

