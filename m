Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/5] shared/gatt-client: Handle ATT disconnection
Date: Thu,  2 Oct 2014 12:51:41 +0300
Message-Id: <1412243501-1755-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412243501-1755-1-git-send-email-luiz.dentz@gmail.com>
References: <1412243501-1755-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If ATT disconnects reset ready flag and propagate to the callback, also
since there is no use for bt_att after that unref it.
---
 src/shared/gatt-client.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 5833e7a..03d722f 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -101,10 +101,10 @@ struct bt_gatt_client {
 	struct queue *long_write_queue;
 	bool in_long_write;
 
-	/* List of registered notification/indication callbacks */
+	/* List of registered disconnect/notification/indication callbacks */
 	struct queue *notify_list;
 	int next_reg_id;
-	unsigned int notify_id, ind_id;
+	unsigned int disc_id, notify_id, ind_id;
 	bool in_notify;
 	bool need_notify_cleanup;
 
@@ -1219,8 +1219,12 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 	if (client->debug_destroy)
 		client->debug_destroy(client->debug_data);
 
-	bt_att_unregister(client->att, client->notify_id);
-	bt_att_unregister(client->att, client->ind_id);
+	if (client->att) {
+		bt_att_unregister_disconnect(client->att, client->disc_id);
+		bt_att_unregister(client->att, client->notify_id);
+		bt_att_unregister(client->att, client->ind_id);
+		bt_att_unref(client->att);
+	}
 
 	gatt_client_clear_services(client);
 
@@ -1228,10 +1232,25 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 	queue_destroy(client->long_write_queue, long_write_op_unref);
 	queue_destroy(client->notify_list, notify_data_unref);
 
-	bt_att_unref(client->att);
 	free(client);
 }
 
+static void att_disconnect_cb(void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+
+	client->disc_id = 0;
+
+	bt_att_unref(client->att);
+	client->att = NULL;
+
+	client->in_init = false;
+	client->ready = false;
+
+	if (client->ready_callback)
+		client->ready_callback(false, 0, client->ready_data);
+}
+
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 {
 	struct bt_gatt_client *client;
@@ -1243,6 +1262,11 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 	if (!client)
 		return NULL;
 
+	client->disc_id = bt_att_register_disconnect(att, att_disconnect_cb,
+								client, NULL);
+	if (!client->disc_id)
+		goto fail;
+
 	client->long_write_queue = queue_new();
 	if (!client->long_write_queue)
 		goto fail;
-- 
1.9.3

