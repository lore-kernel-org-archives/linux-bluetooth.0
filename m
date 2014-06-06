Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 04/13] android/gatt: Fix double processing of pending responses list
Date: Fri,  6 Jun 2014 15:46:17 +0200
Message-Id: <1402062386-4632-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

send_gat_response should have been used to only fill the response
data since when pending reponses queue was introduced and response
sending was moved to queue processing function.
---
 android/gatt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index c3dc41c..5d01d8b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4199,7 +4199,7 @@ static void send_gatt_response(uint8_t opcode, uint16_t handle,
 	dev = find_device_by_addr(bdaddr);
 	if (!dev) {
 		error("gatt: send_gatt_response, could not find dev");
-		goto done;
+		return;
 	}
 
 	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
@@ -4216,19 +4216,16 @@ static void send_gatt_response(uint8_t opcode, uint16_t handle,
 	entry->error = status;
 
 	if (!len)
-		goto done;
+		return;
 
 	entry->value = malloc0(len);
 	if (!entry->value) {
 		entry->error = ATT_ECODE_INSUFF_RESOURCES;
 
-		goto done;
+		return;
 	}
 
 	memcpy(entry->value, data, len);
-
-done:
-	send_dev_complete_response(dev, opcode);
 }
 
 static struct pending_trans_data *conn_add_transact(struct app_connection *conn,
@@ -4720,6 +4717,7 @@ static void handle_server_send_response(const void *buf, uint16_t len)
 	send_gatt_response(transaction->opcode, handle, cmd->offset,
 					cmd->status, cmd->len, cmd->data,
 					&conn->device->bdaddr);
+	send_dev_complete_response(conn->device, transaction->opcode);
 
 done:
 	/* Clean request data */
-- 
2.0.0

