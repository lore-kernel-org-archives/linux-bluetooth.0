Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/gatt-client: Forward events from parent to clones
Date: Mon, 21 Mar 2016 17:45:41 +0200
Message-Id: <1458575141-3808-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1458575141-3808-1-git-send-email-luiz.dentz@gmail.com>
References: <1458575141-3808-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some events such as ready and service changed shall be forward to clones
since the clones may have set callbacks as well.
---
 src/shared/gatt-client.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 8fa66ae..0c7bd97 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -55,6 +55,9 @@ struct bt_gatt_client {
 	struct bt_att *att;
 	int ref_count;
 
+	struct bt_gatt_client *parent;
+	struct queue *clones;
+
 	bt_gatt_client_callback_t ready_callback;
 	bt_gatt_client_destroy_func_t ready_destroy;
 	void *ready_data;
@@ -1013,12 +1016,23 @@ done:
 static void notify_client_ready(struct bt_gatt_client *client, bool success,
 							uint8_t att_ecode)
 {
+	const struct queue_entry *entry;
+
 	if (!client->ready_callback || client->ready)
 		return;
 
 	bt_gatt_client_ref(client);
 	client->ready = success;
 	client->ready_callback(success, att_ecode, client->ready_data);
+
+	/* Notify clones */
+	for (entry = queue_get_entries(client->clones); entry;
+							entry = entry->next) {
+		struct bt_gatt_client *clone = entry->data;
+
+		notify_client_ready(clone, success, att_ecode);
+	}
+
 	bt_gatt_client_unref(client);
 }
 
@@ -1332,6 +1346,7 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 	struct service_changed_op *next_sc_op;
 	uint16_t start_handle = op->start;
 	uint16_t end_handle = op->end;
+	const struct queue_entry *entry;
 
 	client->in_svc_chngd = false;
 
@@ -1348,6 +1363,16 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 		client->svc_chngd_callback(start_handle, end_handle,
 							client->svc_chngd_data);
 
+	/* Notify clones */
+	for (entry = queue_get_entries(client->clones); entry;
+							entry = entry->next) {
+		struct bt_gatt_client *clone = entry->data;
+
+		if (clone->svc_chngd_callback)
+			clone->svc_chngd_callback(start_handle, end_handle,
+							clone->svc_chngd_data);
+	}
+
 	/* Process any queued events */
 	next_sc_op = queue_pop_head(client->svc_chngd_queue);
 	if (next_sc_op) {
@@ -1634,11 +1659,17 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 
 	gatt_db_unref(client->db);
 
+	queue_destroy(client->clones, NULL);
 	queue_destroy(client->svc_chngd_queue, free);
 	queue_destroy(client->long_write_queue, request_unref);
 	queue_destroy(client->notify_chrcs, notify_chrc_free);
 	queue_destroy(client->pending_requests, request_unref);
 
+	if (client->parent) {
+		queue_remove(client->parent->clones, client);
+		bt_gatt_client_unref(client->parent);
+	}
+
 	free(client);
 }
 
@@ -1670,6 +1701,7 @@ static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
 	if (!client->disc_id)
 		goto fail;
 
+	client->clones = queue_new();
 	client->long_write_queue = queue_new();
 	client->svc_chngd_queue = queue_new();
 	client->notify_list = queue_new();
@@ -1729,6 +1761,12 @@ struct bt_gatt_client *bt_gatt_client_clone(struct bt_gatt_client *client)
 	if (!clone)
 		return NULL;
 
+	queue_push_tail(client->clones, clone);
+
+	/* Reference the parent since the clones depend on it to propagate
+	 * service changed and ready callbacks.
+	 */
+	clone->parent = bt_gatt_client_ref(client);
 	clone->ready = client->ready;
 
 	return bt_gatt_client_ref(clone);
-- 
2.5.0

