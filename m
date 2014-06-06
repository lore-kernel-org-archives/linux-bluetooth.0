Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 02/13] android/gatt: Always check for complete response queue
Date: Fri,  6 Jun 2014 15:46:15 +0200
Message-Id: <1402062386-4632-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This moves the check for pending responses to response sending function
as it should always be used with this check. Since sending only complete
response is allowed, the function name was changed to better represent
what it does.
---
 android/gatt.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a1570fd..c173b89 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3790,7 +3790,14 @@ static bool is_service(const bt_uuid_t *type)
 	return false;
 }
 
-static void send_dev_pending_response(struct gatt_device *device,
+static bool match_pending_dev_request(const void *data, const void *user_data)
+{
+	const struct pending_request *pending_request = data;
+
+	return pending_request->state == REQUEST_PENDING;
+}
+
+static void send_dev_complete_response(struct gatt_device *device,
 								uint8_t opcode)
 {
 	size_t mtu;
@@ -3799,6 +3806,12 @@ static void send_dev_pending_response(struct gatt_device *device,
 	uint16_t len = 0;
 	uint8_t error = 0;
 
+	if (queue_find(device->pending_requests, match_pending_dev_request,
+									NULL)) {
+		DBG("Still pending requests");
+		return;
+	}
+
 	switch (opcode) {
 	case ATT_OP_READ_BY_TYPE_REQ: {
 		struct att_data_list *adl;
@@ -4021,13 +4034,6 @@ struct request_processing_data {
 	struct gatt_device *device;
 };
 
-static bool match_pending_dev_request(const void *data, const void *user_data)
-{
-	const struct pending_request *pending_request = data;
-
-	return pending_request->state == REQUEST_PENDING;
-}
-
 static bool match_dev_request_by_handle(const void *data, const void *user_data)
 {
 	const struct pending_request *handle_data = data;
@@ -4176,9 +4182,7 @@ static void process_dev_pending_requests(struct gatt_device *device,
 	queue_foreach(device->pending_requests, read_requested_attributes,
 								&process_data);
 
-	if (!queue_find(device->pending_requests,
-					match_pending_dev_request, NULL))
-		send_dev_pending_response(device, att_opcode);
+	send_dev_complete_response(device, att_opcode);
 }
 
 static void send_gatt_response(uint8_t opcode, uint16_t handle,
@@ -4221,8 +4225,7 @@ static void send_gatt_response(uint8_t opcode, uint16_t handle,
 	memcpy(entry->value, data, len);
 
 done:
-	if (!queue_find(dev->pending_requests, match_pending_dev_request, NULL))
-		send_dev_pending_response(dev, opcode);
+	send_dev_complete_response(dev, opcode);
 }
 
 static struct pending_trans_data *conn_add_transact(struct app_connection *conn,
@@ -5289,8 +5292,7 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_UNLIKELY;
 	}
 
-	if (!queue_find(dev->pending_requests, match_pending_dev_request, NULL))
-		send_dev_pending_response(dev, cmd[0]);
+	send_dev_complete_response(dev, cmd[0]);
 
 	return 0;
 }
-- 
2.0.0

