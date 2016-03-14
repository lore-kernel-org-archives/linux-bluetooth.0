Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/gatt-client: Add bt_gatt_client_clone
Date: Mon, 14 Mar 2016 17:02:28 +0200
Message-Id: <1457967749-24963-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_gatt_client_clone which can clone existing client skipping
the discovery phase and creating separate queues so that all requests
done using the clone can be cancelled separately.
---
 src/shared/gatt-client.c | 51 ++++++++++++++++++++++++++++++++++++++----------
 src/shared/gatt-client.h |  1 +
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 45acf7b..7fa0b1d 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1720,15 +1720,11 @@ static void att_disconnect_cb(int err, void *user_data)
 		notify_client_ready(client, false, 0);
 }
 
-struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
-							struct bt_att *att,
-							uint16_t mtu)
+static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
+							struct bt_att *att)
 {
 	struct bt_gatt_client *client;
 
-	if (!att || !db)
-		return NULL;
-
 	client = new0(struct bt_gatt_client, 1);
 	client->disc_id = bt_att_register_disconnect(att, att_disconnect_cb,
 								client, NULL);
@@ -1754,14 +1750,49 @@ struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
 	client->att = bt_att_ref(att);
 	client->db = gatt_db_ref(db);
 
-	if (!gatt_client_init(client, mtu))
-		goto fail;
-
-	return bt_gatt_client_ref(client);
+	return client;
 
 fail:
 	bt_gatt_client_free(client);
 	return NULL;
+
+}
+
+struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
+							struct bt_att *att,
+							uint16_t mtu)
+{
+	struct bt_gatt_client *client;
+
+	if (!att || !db)
+		return NULL;
+
+	client = gatt_client_new(db, att);
+	if (!client)
+		return NULL;
+
+	if (!gatt_client_init(client, mtu)) {
+		bt_gatt_client_free(client);
+		return NULL;
+	}
+
+	return bt_gatt_client_ref(client);
+}
+
+struct bt_gatt_client *bt_gatt_client_clone(struct bt_gatt_client *client)
+{
+	struct bt_gatt_client *clone;
+
+	if (!client || !client->ready)
+		return NULL;
+
+	clone = gatt_client_new(client->db, client->att);
+	if (!clone)
+		return NULL;
+
+	clone->ready = client->ready;
+
+	return bt_gatt_client_ref(clone);
 }
 
 struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client)
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index befa43f..aceb570 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -32,6 +32,7 @@ struct bt_gatt_client;
 struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
 							struct bt_att *att,
 							uint16_t mtu);
+struct bt_gatt_client *bt_gatt_client_clone(struct bt_gatt_client *client);
 
 struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client);
 void bt_gatt_client_unref(struct bt_gatt_client *client);
-- 
2.5.0

