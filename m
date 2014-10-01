Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/gatt-client: Take fd in bt_gatt_client_new
Date: Wed,  1 Oct 2014 14:38:12 +0300
Message-Id: <1412163494-20283-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412163494-20283-1-git-send-email-luiz.dentz@gmail.com>
References: <1412163494-20283-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This simplify the instance creation and also drop automatically the
reference in case of disconnection.
---
 src/shared/gatt-client.c | 52 +++++++++++++++++++++++++++++++++++++-----------
 src/shared/gatt-client.h |  3 ++-
 tools/btgatt-client.c    | 29 ++++++---------------------
 3 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 782e6b3..d884185 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -104,7 +104,7 @@ struct bt_gatt_client {
 	/* List of registered notification/indication callbacks */
 	struct queue *notify_list;
 	int next_reg_id;
-	unsigned int notify_id, ind_id;
+	unsigned int disc_id, notify_id, ind_id;
 	bool in_notify;
 	bool need_notify_cleanup;
 
@@ -1221,8 +1221,12 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
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
 
 	queue_destroy(client->svc_chngd_queue, free);
 	queue_destroy(client->long_write_queue, long_write_op_unref);
@@ -1230,21 +1234,38 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 
 	gatt_client_clear_services(client);
 
-	bt_att_unref(client->att);
 	free(client);
 }
 
-struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
+static void att_disconnect_cb(void *user_data)
 {
-	struct bt_gatt_client *client;
+	struct bt_gatt_client *client = user_data;
 
-	if (!att)
-		return NULL;
+	bt_att_unref(client->att);
+	client->att = NULL;
+}
+
+struct bt_gatt_client *bt_gatt_client_new(int fd, uint16_t mtu)
+{
+	struct bt_gatt_client *client;
 
 	client = new0(struct bt_gatt_client, 1);
 	if (!client)
 		return NULL;
 
+	client->att = bt_att_new(fd);
+	if (!client->att)
+		goto fail;
+
+	if (!bt_att_set_close_on_unref(client->att, true))
+		goto fail;
+
+	client->disc_id = bt_att_register_disconnect(client->att,
+							att_disconnect_cb,
+							client, NULL);
+	if (!client->disc_id)
+		goto fail;
+
 	client->long_write_queue = queue_new();
 	if (!client->long_write_queue)
 		goto fail;
@@ -1257,18 +1278,17 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 	if (!client->notify_list)
 		goto fail;
 
-	client->notify_id = bt_att_register(att, BT_ATT_OP_HANDLE_VAL_NOT,
+	client->notify_id = bt_att_register(client->att,
+						BT_ATT_OP_HANDLE_VAL_NOT,
 						notify_cb, client, NULL);
 	if (!client->notify_id)
 		goto fail;
 
-	client->ind_id = bt_att_register(att, BT_ATT_OP_HANDLE_VAL_IND,
+	client->ind_id = bt_att_register(client->att, BT_ATT_OP_HANDLE_VAL_IND,
 						notify_cb, client, NULL);
 	if (!client->ind_id)
 		goto fail;
 
-	client->att = bt_att_ref(att);
-
 	gatt_client_init(client, mtu);
 
 	return bt_gatt_client_ref(client);
@@ -1278,6 +1298,14 @@ fail:
 	return NULL;
 }
 
+struct bt_att *bt_gatt_client_get_att(struct bt_gatt_client *client)
+{
+	if (!client)
+		return NULL;
+
+	return client->att;
+}
+
 struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client)
 {
 	if (!client)
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 6807f6b..4e8da29 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -38,7 +38,8 @@
 
 struct bt_gatt_client;
 
-struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu);
+struct bt_gatt_client *bt_gatt_client_new(int fd, uint16_t mtu);
+struct bt_att *bt_gatt_client_get_att(struct bt_gatt_client *client);
 
 struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client);
 void bt_gatt_client_unref(struct bt_gatt_client *client);
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index d900e08..95d395d 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -107,33 +107,19 @@ static struct client *client_create(int fd, uint16_t mtu)
 		return NULL;
 	}
 
-	att = bt_att_new(fd);
-	if (!att) {
-		fprintf(stderr, "Failed to initialze ATT transport layer\n");
-		bt_att_unref(att);
+	cli->fd = fd;
+	cli->gatt = bt_gatt_client_new(fd, mtu);
+	if (!cli->gatt) {
+		fprintf(stderr, "Failed to create GATT client\n");
 		free(cli);
 		return NULL;
 	}
 
-	if (!bt_att_set_close_on_unref(att, true)) {
-		fprintf(stderr, "Failed to set up ATT transport layer\n");
-		bt_att_unref(att);
-		free(cli);
-		return NULL;
-	}
+	att = bt_gatt_client_get_att(cli->gatt);
 
 	if (!bt_att_register_disconnect(att, att_disconnect_cb, NULL, NULL)) {
 		fprintf(stderr, "Failed to set ATT disconnect handler\n");
-		bt_att_unref(att);
-		free(cli);
-		return NULL;
-	}
-
-	cli->fd = fd;
-	cli->gatt = bt_gatt_client_new(att, mtu);
-	if (!cli->gatt) {
-		fprintf(stderr, "Failed to create GATT client\n");
-		bt_att_unref(att);
+		bt_gatt_client_unref(cli->gatt);
 		free(cli);
 		return NULL;
 	}
@@ -148,9 +134,6 @@ static struct client *client_create(int fd, uint16_t mtu)
 	bt_gatt_client_set_service_changed(cli->gatt, service_changed_cb, cli,
 									NULL);
 
-	/* bt_gatt_client already holds a reference */
-	bt_att_unref(att);
-
 	return cli;
 }
 
-- 
1.9.3

