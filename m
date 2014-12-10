Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/3] android/gatt: Fix execute write request still pending
Date: Wed, 10 Dec 2014 10:57:07 +0100
Message-Id: <1418205428-6122-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1418205428-6122-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418205428-6122-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For execute write no write callback is called thus we have to change its
state directly in app's response handler.

This fixes not sending execute write responses in TC_GAW_SR_BI_07_C.
---
 android/gatt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index ac45ffc..f39a66b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5530,6 +5530,8 @@ static void handle_server_send_response(const void *buf, uint16_t len)
 	}
 
 	if (transaction->opcode == ATT_OP_EXEC_WRITE_REQ) {
+		struct pending_request *req;
+
 		conn->wait_execute_write = false;
 
 		/* Check for execute response from all server applications */
@@ -5537,6 +5539,14 @@ static void handle_server_send_response(const void *buf, uint16_t len)
 			goto done;
 
 		/*
+		 * This is usually done through db write callback but for
+		 * execute write we dont have the attribute or handle to call
+		 * gatt_db_attribute_write().
+		 */
+		req = queue_peek_head(conn->device->pending_requests);
+		req->state = REQUEST_DONE;
+
+		/*
 		 * FIXME: Handle situation when not all server applications
 		 * respond with a success.
 		 */
-- 
1.9.1

