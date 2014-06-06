Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 07/13] android/gatt: Use fill_gatt_response in response processing
Date: Fri,  6 Jun 2014 15:46:20 +0200
Message-Id: <1402062386-4632-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes use of fill_gatt_response in function doing reads on queue
with pending responses.
---
 android/gatt.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 35a163d..76844f7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4157,8 +4157,8 @@ static void read_requested_attributes(void *data, void *user_data)
 	struct pending_request *resp_data = data;
 	struct request_processing_data *process_data = user_data;
 	uint32_t permissions;
-	uint8_t *value;
-	int value_len;
+	uint8_t *value, error;
+	int value_len = 0;
 
 	if (!gatt_db_get_attribute_permissions(gatt_db, resp_data->handle,
 								&permissions)) {
@@ -4174,40 +4174,27 @@ static void read_requested_attributes(void *data, void *user_data)
 	if (permissions == 0)
 		permissions = GATT_PERM_READ;
 
-	resp_data->error = check_device_permissions(process_data->device,
+	error = check_device_permissions(process_data->device,
 							process_data->opcode,
 							permissions);
-	if (resp_data->error) {
-		resp_data->state = REQUEST_DONE;
-		return;
-	}
+	if (error)
+		goto done;
 
 	if (!gatt_db_read(gatt_db, resp_data->handle,
 						resp_data->offset,
 						process_data->opcode,
 						&process_data->device->bdaddr,
 						&value, &value_len)) {
-		resp_data->state = REQUEST_DONE;
-		resp_data->error = ATT_ECODE_UNLIKELY;
-		return;
+		error = ATT_ECODE_UNLIKELY;
+		goto done;
 	}
 
+done:
 	/* We have value here already if no callback will be called */
-	if (value_len >= 0) {
-		resp_data->state = REQUEST_DONE;
-
-		resp_data->value = malloc0(value_len);
-		if (!resp_data->value) {
-			/* If data cannot be copied, act like when read fails */
-			resp_data->error = ATT_ECODE_INSUFF_RESOURCES;
-			return;
-		}
-
-		memcpy(resp_data->value, value, value_len);
-		resp_data->length = value_len;
-	} else if (resp_data->state == REQUEST_INIT) {
-		resp_data->state = REQUEST_PENDING;
-	}
+	if (value_len >= 0)
+		fill_gatt_response(resp_data, resp_data->handle,
+					resp_data->offset, error, value_len,
+					value);
 }
 
 static void process_dev_pending_requests(struct gatt_device *device,
-- 
2.0.0

