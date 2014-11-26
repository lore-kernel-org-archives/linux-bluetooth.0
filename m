Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/4] android/gatt: Improve prepare write request response
Date: Wed, 26 Nov 2014 09:47:38 +0100
Message-Id: <1416991660-21828-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416991660-21828-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416991660-21828-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to spec we should response with value provided in the request.
Helper function was not very helpfull in prepare write request. It was forcing
another buffer copy and was overwriting reponse values with their own values,
thus was removed.
---
 android/gatt.c | 59 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 6d79e61..84fdbe7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4682,30 +4682,6 @@ static uint8_t check_device_permissions(struct gatt_device *device,
 	return 0;
 }
 
-static void fill_gatt_response(struct pending_request *request,
-					struct gatt_db_attribute *attrib,
-					uint16_t offset, uint8_t status,
-					uint16_t len, const uint8_t *data)
-{
-	request->attrib = attrib;
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
 static uint8_t err_to_att(int err)
 {
 	if (!err || (err > 0 && err < UINT8_MAX))
@@ -4728,8 +4704,23 @@ static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
 	struct pending_request *resp_data = user_data;
 	uint8_t error = err_to_att(err);
 
-	fill_gatt_response(resp_data, attrib, resp_data->offset, error, length,
-									value);
+	resp_data->attrib = attrib;
+	resp_data->length = length;
+	resp_data->error = error;
+
+	resp_data->state = REQUEST_DONE;
+
+	if (!length)
+		return;
+
+	resp_data->value = malloc0(length);
+	if (!resp_data->value) {
+		resp_data->error = ATT_ECODE_INSUFF_RESOURCES;
+
+		return;
+	}
+
+	memcpy(resp_data->value, value, length);
 }
 
 static void read_requested_attributes(void *data, void *user_data)
@@ -6299,7 +6290,10 @@ static void attribute_write_cb(struct gatt_db_attribute *attrib, int err,
 
 	DBG("");
 
-	fill_gatt_response(data, attrib, data->offset, error, 0, NULL);
+	data->attrib = attrib;
+	data->error = error;
+
+	data->state = REQUEST_DONE;
 }
 
 static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
@@ -6400,9 +6394,18 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_INSUFF_RESOURCES;
 	}
 
+	data->value = g_memdup(value, vlen);
+	data->length = vlen;
+
 	if (!gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
-					&dev->bdaddr, attribute_write_cb, data))
+					&dev->bdaddr, attribute_write_cb,
+					data)) {
+		queue_remove(dev->pending_requests, data);
+		g_free(data->value);
+		free(data);
+
 		return ATT_ECODE_UNLIKELY;
+	}
 
 	return 0;
 }
-- 
1.9.1

