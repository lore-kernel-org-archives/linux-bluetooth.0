Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 7/8] shared/gatt-client: Fix bug in service changed handler.
Date: Tue, 11 Nov 2014 13:39:46 -0800
Message-Id: <1415741987-22272-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1415741987-22272-1-git-send-email-armansito@chromium.org>
References: <1415741987-22272-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a bug in which "0" was passed as the start and end
handles of the service changed callback if no new service was found
within the range.
---
 src/shared/gatt-client.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 401f551..6016b06 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -963,7 +963,9 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 {
 	struct bt_gatt_client *client = op->client;
 	struct service_changed_op *next_sc_op;
-	uint16_t start_handle = 0, end_handle = 0;
+	uint16_t start_handle = op->start;
+	uint16_t end_handle = op->end;
+	bool services_found = false;
 
 	client->in_svc_chngd = false;
 
@@ -978,8 +980,7 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 	if (!op->result_head || !op->result_tail)
 		goto next;
 
-	start_handle = op->result_head->service.start_handle;
-	end_handle = op->result_tail->service.end_handle;
+	services_found = true;
 
 	/* Insert all newly discovered services in their correct place as a
 	 * contiguous chunk */
@@ -1002,7 +1003,7 @@ next:
 	}
 
 	/* Check if the GATT service is not present or has remained unchanged */
-	if (!start_handle || !client->svc_chngd_val_handle ||
+	if (!services_found || !client->svc_chngd_val_handle ||
 				client->svc_chngd_val_handle < start_handle ||
 				client->svc_chngd_val_handle > end_handle)
 		return;
@@ -1085,6 +1086,12 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 	start = get_le16(value);
 	end = get_le16(value + 2);
 
+	if (start > end) {
+		util_debug(client->debug_callback, client->debug_data,
+			"Service Changed received with invalid handles");
+		return;
+	}
+
 	util_debug(client->debug_callback, client->debug_data,
 			"Service Changed received - start: 0x%04x end: 0x%04x",
 			start, end);
-- 
2.1.0.rc2.206.gedb03e5

