Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 06/10] android/gatt: Improve send_dev_complete_response
Date: Wed, 11 Feb 2015 15:34:04 +0100
Message-Id: <1423665248-5121-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For simple reads or writes there is no need to take the request out
of the queue as it is destroyed at the end anyway. We can peek and
check for errors even before switch statement.
---
 android/gatt.c | 47 +++++++++++------------------------------------
 1 file changed, 11 insertions(+), 36 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 81b0283..19232f7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4455,6 +4455,17 @@ static void send_dev_complete_response(struct gatt_device *device,
 		return;
 	}
 
+	val = queue_peek_head(device->pending_requests);
+	if (!val) {
+		error = ATT_ECODE_ATTR_NOT_FOUND;
+		goto done;
+	}
+
+	if (val->error) {
+		error = val->error;
+		goto done;
+	}
+
 	switch (opcode) {
 	case ATT_OP_READ_BY_TYPE_REQ: {
 		struct att_data_list *adl;
@@ -4514,25 +4525,11 @@ static void send_dev_complete_response(struct gatt_device *device,
 		break;
 	}
 	case ATT_OP_READ_BLOB_REQ:
-		val = queue_pop_head(device->pending_requests);
-		if (val->error) {
-			error = val->error;
-			goto done;
-		}
-
 		len = enc_read_blob_resp(val->value, val->length, val->offset,
 								rsp, mtu);
-		destroy_pending_request(val);
 		break;
 	case ATT_OP_READ_REQ:
-		val = queue_pop_head(device->pending_requests);
-		if (val->error) {
-			error = val->error;
-			goto done;
-		}
-
 		len = enc_read_resp(val->value, val->length, rsp, mtu);
-		destroy_pending_request(val);
 		break;
 	case ATT_OP_READ_BY_GROUP_REQ: {
 		struct att_data_list *adl;
@@ -4638,39 +4635,17 @@ static void send_dev_complete_response(struct gatt_device *device,
 		break;
 	}
 	case ATT_OP_EXEC_WRITE_REQ:
-		val = queue_pop_head(device->pending_requests);
-		if (val->error) {
-			error = val->error;
-			goto done;
-		}
-
 		len = enc_exec_write_resp(rsp);
-		destroy_pending_request(val);
 		break;
 	case ATT_OP_WRITE_REQ:
-		val = queue_pop_head(device->pending_requests);
-		if (val->error) {
-			error = val->error;
-			goto done;
-		}
-
 		len = enc_write_resp(rsp);
-		destroy_pending_request(val);
 		break;
 	case ATT_OP_PREP_WRITE_REQ: {
 		uint16_t handle;
 
-		val = queue_pop_head(device->pending_requests);
-		if (val->error) {
-			error = val->error;
-			goto done;
-		}
-
 		handle = gatt_db_attribute_get_handle(val->attrib);
-
 		len = enc_prep_write_resp(handle, val->offset, val->value,
 							val->length, rsp, mtu);
-		destroy_pending_request(val);
 		break;
 	}
 	default:
-- 
1.9.1

