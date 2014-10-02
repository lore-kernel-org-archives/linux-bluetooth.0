Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/5] shared/gatt-client: Simplify bt_gatt_client_new
Date: Thu,  2 Oct 2014 12:51:37 +0300
Message-Id: <1412243501-1755-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This split bt_gatt_client_unref into bt_gatt_client_free so it can be
used within bt_gatt_client_new when freeing the data.
---
v3: Add changes to handle ATT disconnection

 src/shared/gatt-client.c | 87 +++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 49 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 6dc8e95..782e6b3 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1211,6 +1211,29 @@ static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	bt_gatt_client_unref(client);
 }
 
+static void long_write_op_unref(void *data);
+
+static void bt_gatt_client_free(struct bt_gatt_client *client)
+{
+	if (client->ready_destroy)
+		client->ready_destroy(client->ready_data);
+
+	if (client->debug_destroy)
+		client->debug_destroy(client->debug_data);
+
+	bt_att_unregister(client->att, client->notify_id);
+	bt_att_unregister(client->att, client->ind_id);
+
+	queue_destroy(client->svc_chngd_queue, free);
+	queue_destroy(client->long_write_queue, long_write_op_unref);
+	queue_destroy(client->notify_list, notify_data_unref);
+
+	gatt_client_clear_services(client);
+
+	bt_att_unref(client->att);
+	free(client);
+}
+
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 {
 	struct bt_gatt_client *client;
@@ -1223,52 +1246,36 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 		return NULL;
 
 	client->long_write_queue = queue_new();
-	if (!client->long_write_queue) {
-		free(client);
-		return NULL;
-	}
+	if (!client->long_write_queue)
+		goto fail;
 
 	client->svc_chngd_queue = queue_new();
-	if (!client->svc_chngd_queue) {
-		queue_destroy(client->long_write_queue, NULL);
-		free(client);
-		return NULL;
-	}
+	if (!client->svc_chngd_queue)
+		goto fail;
 
 	client->notify_list = queue_new();
-	if (!client->notify_list) {
-		queue_destroy(client->svc_chngd_queue, NULL);
-		queue_destroy(client->long_write_queue, NULL);
-		free(client);
-		return NULL;
-	}
+	if (!client->notify_list)
+		goto fail;
 
 	client->notify_id = bt_att_register(att, BT_ATT_OP_HANDLE_VAL_NOT,
 						notify_cb, client, NULL);
-	if (!client->notify_id) {
-		queue_destroy(client->notify_list, NULL);
-		queue_destroy(client->svc_chngd_queue, NULL);
-		queue_destroy(client->long_write_queue, NULL);
-		free(client);
-		return NULL;
-	}
+	if (!client->notify_id)
+		goto fail;
 
 	client->ind_id = bt_att_register(att, BT_ATT_OP_HANDLE_VAL_IND,
 						notify_cb, client, NULL);
-	if (!client->ind_id) {
-		bt_att_unregister(att, client->notify_id);
-		queue_destroy(client->notify_list, NULL);
-		queue_destroy(client->svc_chngd_queue, NULL);
-		queue_destroy(client->long_write_queue, NULL);
-		free(client);
-		return NULL;
-	}
+	if (!client->ind_id)
+		goto fail;
 
 	client->att = bt_att_ref(att);
 
 	gatt_client_init(client, mtu);
 
 	return bt_gatt_client_ref(client);
+
+fail:
+	bt_gatt_client_free(client);
+	return NULL;
 }
 
 struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client)
@@ -1281,8 +1288,6 @@ struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client)
 	return client;
 }
 
-static void long_write_op_unref(void *data);
-
 void bt_gatt_client_unref(struct bt_gatt_client *client)
 {
 	if (!client)
@@ -1291,23 +1296,7 @@ void bt_gatt_client_unref(struct bt_gatt_client *client)
 	if (__sync_sub_and_fetch(&client->ref_count, 1))
 		return;
 
-	if (client->ready_destroy)
-		client->ready_destroy(client->ready_data);
-
-	if (client->debug_destroy)
-		client->debug_destroy(client->debug_data);
-
-	bt_att_unregister(client->att, client->notify_id);
-	bt_att_unregister(client->att, client->ind_id);
-
-	queue_destroy(client->svc_chngd_queue, free);
-	queue_destroy(client->long_write_queue, long_write_op_unref);
-	queue_destroy(client->notify_list, notify_data_unref);
-
-	gatt_client_clear_services(client);
-
-	bt_att_unref(client->att);
-	free(client);
+	bt_gatt_client_free(client);
 }
 
 bool bt_gatt_client_is_ready(struct bt_gatt_client *client)
-- 
1.9.3

