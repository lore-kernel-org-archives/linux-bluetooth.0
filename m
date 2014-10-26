Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/7] shared/gatt-client: Fix bug in service changed handling.
Date: Sun, 26 Oct 2014 14:12:42 -0700
Message-Id: <1414357967-9371-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1414357967-9371-1-git-send-email-armansito@chromium.org>
References: <1414357967-9371-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a bug where the upper layer never got notified of a
service changed event if no new services are added within a changed
service range. This also fixes a bug where an empty changed service list
or ATT error caused pending service changed events to not get processed.
---
 src/shared/gatt-client.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index faae71c..a3bb86d 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -965,16 +965,16 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 
 	client->in_svc_chngd = false;
 
-	if (!success) {
+	if (!success && att_ecode != BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
 		util_debug(client->debug_callback, client->debug_data,
 			"Failed to discover services within changed range - "
 			"error: 0x%02x", att_ecode);
-		return;
+		goto next;
 	}
 
 	/* No new services in the modified range */
 	if (!op->result_head || !op->result_tail)
-		return;
+		goto next;
 
 	start_handle = op->result_head->service.start_handle;
 	end_handle = op->result_tail->service.end_handle;
@@ -984,6 +984,7 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 	service_list_insert_services(&client->svc_head, &client->svc_tail,
 					op->result_head, op->result_tail);
 
+next:
 	/* Notify the upper layer of changed services */
 	if (client->svc_chngd_callback)
 		client->svc_chngd_callback(start_handle, end_handle,
-- 
2.1.0.rc2.206.gedb03e5

