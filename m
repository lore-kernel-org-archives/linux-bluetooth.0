Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 6/9] shared/gatt-client: Add handler for "Service Changed" if GATT service changes.
Date: Tue, 23 Sep 2014 13:47:14 -0700
Message-Id: <1411505237-10932-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1411505237-10932-1-git-send-email-armansito@chromium.org>
References: <1411505237-10932-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the GATT service on a peripheral changes gatt-client unregisters its handler
for "Service Changed" indications. This patch adds code that re-registers the
handler at the end of re-discovery if there was a change in the Service Changed
characteristic.
---
 src/shared/gatt-client.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 3f092ac..e98a164 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -744,15 +744,36 @@ struct service_changed_op {
 	uint16_t end_handle;
 };
 
+static void service_changed_reregister_cb(unsigned int id, uint16_t att_ecode,
+								void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+
+	if (!id || att_ecode) {
+		util_debug(client->debug_callback, client->debug_data,
+			"Failed to register handler for \"Service Changed\"");
+		return;
+	}
+
+	client->svc_chngd_ind_id = id;
+
+	util_debug(client->debug_callback, client->debug_data,
+		"Re-registered handler for \"Service Changed\" after change in "
+		"GATT service");
+}
+
 static void process_service_changed(struct bt_gatt_client *client,
 							uint16_t start_handle,
 							uint16_t end_handle);
+static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data);
 
 static void service_changed_complete(struct discovery_op *op, bool success,
 							uint8_t att_ecode)
 {
 	struct bt_gatt_client *client = op->client;
 	struct service_changed_op *next_sc_op;
+	bt_gatt_service_t *head, *tail;
 
 	client->in_svc_chngd = false;
 
@@ -781,9 +802,23 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 		return;
 	}
 
-	/* TODO: if the GATT service has changed then register a handler
-	 * for "Service Changed".
-	 */
+	/* Check if the GATT service is not present or has remained unchanged */
+	head = &op->result_head->service;
+	tail = &op->result_tail->service;
+	if (!client->svc_chngd_val_handle ||
+			client->svc_chngd_val_handle < head->start_handle ||
+			client->svc_chngd_val_handle > tail->end_handle)
+		return;
+
+	if (bt_gatt_client_register_notify(client,
+						client->svc_chngd_val_handle,
+						service_changed_reregister_cb,
+						service_changed_cb,
+						client, NULL))
+		return;
+
+	util_debug(client->debug_callback, client->debug_data,
+		"Failed to re-register handler for \"Service Changed\"");
 }
 
 static void process_service_changed(struct bt_gatt_client *client,
@@ -810,6 +845,13 @@ static void process_service_changed(struct bt_gatt_client *client,
 		return;
 	}
 
+	if (client->gatt_svc_handle >= start_handle &&
+					client->gatt_svc_handle <= end_handle) {
+		client->gatt_svc_handle = 0;
+		client->svc_chngd_val_handle = 0;
+		client->svc_chngd_ind_id = 0;
+	}
+
 	op->client = client;
 	op->complete_func = service_changed_complete;
 
-- 
2.1.0.rc2.206.gedb03e5

