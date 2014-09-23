Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 7/9] shared/gatt-client: Add bt_gatt_client_set_service_changed.
Date: Tue, 23 Sep 2014 13:47:15 -0700
Message-Id: <1411505237-10932-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1411505237-10932-1-git-send-email-armansito@chromium.org>
References: <1411505237-10932-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the bt_gatt_client_set_service_changed function which
allows upper layers to register a callback with gatt-client for
"Service Changed" events. The callback gets invoked for each indication from the
Service Changed characteristic after service discovery within the changed range
has completed and gatt-client's service cache has been updated.
---
 src/shared/gatt-client.c | 41 ++++++++++++++++++++++++++++++++++++-----
 src/shared/gatt-client.h |  7 +++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index e98a164..6dc8e95 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -80,6 +80,10 @@ struct bt_gatt_client {
 	bt_gatt_client_destroy_func_t ready_destroy;
 	void *ready_data;
 
+	bt_gatt_client_service_changed_callback_t svc_chngd_callback;
+	bt_gatt_client_destroy_func_t svc_chngd_destroy;
+	void *svc_chngd_data;
+
 	bt_gatt_client_debug_func_t debug_callback;
 	bt_gatt_client_destroy_func_t debug_destroy;
 	void *debug_data;
@@ -773,7 +777,7 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 {
 	struct bt_gatt_client *client = op->client;
 	struct service_changed_op *next_sc_op;
-	bt_gatt_service_t *head, *tail;
+	uint16_t start_handle, end_handle;
 
 	client->in_svc_chngd = false;
 
@@ -788,11 +792,19 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 	if (!op->result_head || !op->result_tail)
 		return;
 
+	start_handle = op->result_head->service.start_handle;
+	end_handle = op->result_tail->service.end_handle;
+
 	/* Insert all newly discovered services in their correct place as a
 	 * contiguous chunk */
 	service_list_insert_services(&client->svc_head, &client->svc_tail,
 					op->result_head, op->result_tail);
 
+	/* Notify the upper layer of changed services */
+	if (client->svc_chngd_callback)
+		client->svc_chngd_callback(start_handle, end_handle,
+							client->svc_chngd_data);
+
 	/* Process any queued events */
 	next_sc_op = queue_pop_head(client->svc_chngd_queue);
 	if (next_sc_op) {
@@ -803,13 +815,14 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 	}
 
 	/* Check if the GATT service is not present or has remained unchanged */
-	head = &op->result_head->service;
-	tail = &op->result_tail->service;
 	if (!client->svc_chngd_val_handle ||
-			client->svc_chngd_val_handle < head->start_handle ||
-			client->svc_chngd_val_handle > tail->end_handle)
+				client->svc_chngd_val_handle < start_handle ||
+				client->svc_chngd_val_handle > end_handle)
 		return;
 
+	/* The GATT service was modified. Re-register the handler for
+	 * indications from the "Service Changed" characteristic.
+	 */
 	if (bt_gatt_client_register_notify(client,
 						client->svc_chngd_val_handle,
 						service_changed_reregister_cb,
@@ -1320,6 +1333,24 @@ bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
 	return true;
 }
 
+bool bt_gatt_client_set_service_changed(struct bt_gatt_client *client,
+			bt_gatt_client_service_changed_callback_t callback,
+			void *user_data,
+			bt_gatt_client_destroy_func_t destroy)
+{
+	if (!client)
+		return false;
+
+	if (client->svc_chngd_destroy)
+		client->svc_chngd_destroy(client->svc_chngd_data);
+
+	client->svc_chngd_callback = callback;
+	client->svc_chngd_destroy = destroy;
+	client->svc_chngd_data = user_data;
+
+	return true;
+}
+
 bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 					bt_gatt_client_debug_func_t callback,
 					void *user_data,
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 7612a6e..1c28a82 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -57,12 +57,19 @@ typedef void (*bt_gatt_client_notify_callback_t)(uint16_t value_handle,
 typedef void (*bt_gatt_client_notify_id_callback_t)(unsigned int id,
 							uint16_t att_ecode,
 							void *user_data);
+typedef void (*bt_gatt_client_service_changed_callback_t)(uint16_t start_handle,
+							uint16_t end_handle,
+							void *user_data);
 
 bool bt_gatt_client_is_ready(struct bt_gatt_client *client);
 bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
+bool bt_gatt_client_set_service_changed(struct bt_gatt_client *client,
+			bt_gatt_client_service_changed_callback_t callback,
+			void *user_data,
+			bt_gatt_client_destroy_func_t destroy);
 bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 					bt_gatt_client_debug_func_t callback,
 					void *user_data,
-- 
2.1.0.rc2.206.gedb03e5

