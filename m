Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/gatt-client: Use of bt_gatt_client_clone
Date: Mon, 14 Mar 2016 17:02:29 +0200
Message-Id: <1457967749-24963-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1457967749-24963-1-git-send-email-luiz.dentz@gmail.com>
References: <1457967749-24963-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses bt_gatt_client_clone to track pending requests and cancel
them if bt_gatt_client_unref is called.
---
 src/gatt-client.c | 44 +-------------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index dd76a36..a03df1f 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1792,7 +1792,7 @@ void btd_gatt_client_connected(struct btd_gatt_client *client)
 	DBG("Device connected.");
 
 	bt_gatt_client_unref(client->gatt);
-	client->gatt = bt_gatt_client_ref(gatt);
+	client->gatt = bt_gatt_client_clone(gatt);
 
 	/*
 	 * Services have already been created before. Re-enable notifications
@@ -1843,47 +1843,6 @@ static void clear_notify_id(void *data, void *user_data)
 	client->notify_id = 0;
 }
 
-static void cancel_desc_ops(void *data, void *user_data)
-{
-	struct descriptor *desc = data;
-	struct bt_gatt_client *gatt = user_data;
-
-	if (desc->read_id) {
-		bt_gatt_client_cancel(gatt, desc->read_id);
-		desc->read_id = 0;
-	}
-
-	if (desc->write_id) {
-		bt_gatt_client_cancel(gatt, desc->write_id);
-		desc->write_id = 0;
-	}
-}
-
-static void cancel_chrc_ops(void *data, void *user_data)
-{
-	struct characteristic *chrc = data;
-	struct bt_gatt_client *gatt = user_data;
-
-	if (chrc->read_id) {
-		bt_gatt_client_cancel(gatt, chrc->read_id);
-		chrc->read_id = 0;
-	}
-
-	if (chrc->write_id) {
-		bt_gatt_client_cancel(gatt, chrc->write_id);
-		chrc->write_id = 0;
-	}
-
-	queue_foreach(chrc->descs, cancel_desc_ops, user_data);
-}
-
-static void cancel_ops(void *data, void *user_data)
-{
-	struct service *service = data;
-
-	queue_foreach(service->chrcs, cancel_chrc_ops, user_data);
-}
-
 void btd_gatt_client_disconnected(struct btd_gatt_client *client)
 {
 	if (!client || !client->gatt)
@@ -1897,7 +1856,6 @@ void btd_gatt_client_disconnected(struct btd_gatt_client *client)
 	 * done.
 	 */
 	queue_foreach(client->all_notify_clients, clear_notify_id, NULL);
-	queue_foreach(client->services, cancel_ops, client->gatt);
 
 	bt_gatt_client_unref(client->gatt);
 	client->gatt = NULL;
-- 
2.5.0

