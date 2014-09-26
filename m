Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 1/2] shared/gatt-client: Add callback for reporting att state
Date: Fri, 26 Sep 2014 11:46:46 +0200
Message-Id: <1411724807-4842-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1411724807-4842-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411724807-4842-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used to notify upper layers about the link disconnection
or ATT procedure timeout.
---
 src/shared/gatt-client.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/gatt-client.h |  5 ++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 6dc8e95..5c72466 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -88,6 +88,10 @@ struct bt_gatt_client {
 	bt_gatt_client_destroy_func_t debug_destroy;
 	void *debug_data;
 
+	bt_gatt_client_stale_callback_t att_stale_callback;
+	bt_gatt_client_destroy_func_t att_stale_destroy;
+	void *att_stale_data;
+
 	struct service_list *svc_head, *svc_tail;
 	bool in_init;
 	bool ready;
@@ -104,7 +108,7 @@ struct bt_gatt_client {
 	/* List of registered notification/indication callbacks */
 	struct queue *notify_list;
 	int next_reg_id;
-	unsigned int notify_id, ind_id;
+	unsigned int notify_id, ind_id, disc_id;
 	bool in_notify;
 	bool need_notify_cleanup;
 
@@ -1211,6 +1215,29 @@ static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	bt_gatt_client_unref(client);
 }
 
+static void disconnect_cb(void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+
+	util_debug(client->debug_callback, client->debug_data, "Disconnect_cb");
+
+	if (client->att_stale_callback)
+		client->att_stale_callback(client->att_stale_data);
+}
+
+static void att_timeout_cb(unsigned int id, uint8_t opcode,
+							void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+
+	util_debug(client->debug_callback, client->debug_data,
+			"ID: %d transaction timeout, opcode: 0x%02x", id,
+			opcode);
+
+	if (client->att_stale_callback)
+		client->att_stale_callback(client->att_stale_data);
+}
+
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 {
 	struct bt_gatt_client *client;
@@ -1264,6 +1291,20 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 		return NULL;
 	}
 
+	client->disc_id = bt_att_register_disconnect(att, disconnect_cb,
+								client,	NULL);
+	if (!client->disc_id) {
+		bt_att_unregister(att, client->ind_id);
+		bt_att_unregister(att, client->notify_id);
+		queue_destroy(client->notify_list, NULL);
+		queue_destroy(client->svc_chngd_queue, NULL);
+		queue_destroy(client->long_write_queue, NULL);
+		free(client);
+		return NULL;
+	}
+
+	bt_att_set_timeout_cb(att, att_timeout_cb, client, NULL);
+
 	client->att = bt_att_ref(att);
 
 	gatt_client_init(client, mtu);
@@ -1299,6 +1340,7 @@ void bt_gatt_client_unref(struct bt_gatt_client *client)
 
 	bt_att_unregister(client->att, client->notify_id);
 	bt_att_unregister(client->att, client->ind_id);
+	bt_att_unregister_disconnect(client->att, client->disc_id);
 
 	queue_destroy(client->svc_chngd_queue, free);
 	queue_destroy(client->long_write_queue, long_write_op_unref);
@@ -1368,6 +1410,24 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 	return true;
 }
 
+bool bt_gatt_client_set_stale_handler(struct bt_gatt_client *client,
+				bt_gatt_client_stale_callback_t callback,
+				void *user_data,
+				bt_gatt_client_destroy_func_t destroy)
+{
+	if (!client)
+		return false;
+
+	if (client->att_stale_destroy)
+		client->att_stale_destroy(client->att_stale_data);
+
+	client->att_stale_callback = callback;
+	client->att_stale_destroy = destroy;
+	client->att_stale_data = user_data;
+
+	return true;
+}
+
 bool bt_gatt_service_iter_init(struct bt_gatt_service_iter *iter,
 						struct bt_gatt_client *client)
 {
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 6807f6b..73a1002 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -59,6 +59,7 @@ typedef void (*bt_gatt_client_notify_id_callback_t)(unsigned int id,
 typedef void (*bt_gatt_client_service_changed_callback_t)(uint16_t start_handle,
 							uint16_t end_handle,
 							void *user_data);
+typedef void (*bt_gatt_client_stale_callback_t)(void *user_data);
 
 bool bt_gatt_client_is_ready(struct bt_gatt_client *client);
 bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
@@ -73,6 +74,10 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 					bt_gatt_client_debug_func_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
+bool bt_gatt_client_set_stale_handler(struct bt_gatt_client *client,
+				bt_gatt_client_stale_callback_t callback,
+				void *user_data,
+				bt_gatt_client_destroy_func_t destroy);
 
 typedef struct {
 	uint16_t start_handle;
-- 
1.9.1

