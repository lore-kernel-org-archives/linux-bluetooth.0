Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] Don't allow notifications/indications without CCC
Date: Wed, 21 Sep 2016 16:17:36 +0200
Message-Id: <20160921141736.10770-1-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-client.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 4386692..cfc3602 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -98,7 +98,6 @@ struct bt_gatt_client {
 	 * the remote peripheral.
 	 */
 	unsigned int svc_chngd_ind_id;
-	bool svc_chngd_registered;
 	struct queue *svc_chngd_queue;  /* Queued service changed events */
 	bool in_svc_chngd;
 
@@ -247,6 +246,12 @@ static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
 								NULL, NULL))
 		return NULL;
 
+	/* Find the CCC characteristic */
+	ccc = NULL;
+	gatt_db_service_foreach_desc(attr, find_ccc, &ccc);
+	if (!ccc)
+		return NULL;
+
 	chrc = new0(struct notify_chrc, 1);
 
 	chrc->reg_notify_queue = queue_new();
@@ -255,17 +260,8 @@ static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
 		return NULL;
 	}
 
-	/*
-	 * Find the CCC characteristic. Some characteristics that allow
-	 * notifications may not have a CCC descriptor. We treat these as
-	 * automatically successful.
-	 */
-	ccc = NULL;
-	gatt_db_service_foreach_desc(attr, find_ccc, &ccc);
-	if (ccc)
-		chrc->ccc_handle = gatt_db_attribute_get_handle(ccc);
-
 	chrc->value_handle = value_handle;
+	chrc->ccc_handle = gatt_db_attribute_get_handle(ccc);
 	chrc->properties = properties;
 
 	queue_push_tail(client->notify_chrcs, chrc);
@@ -1356,7 +1352,9 @@ static unsigned int register_notify(struct bt_gatt_client *client,
 	/* Add the handler to the bt_gatt_client's general list */
 	queue_push_tail(client->notify_list, notify_data);
 
-	/* Assign an ID to the handler. */
+	/* Assign an ID to the handler and notify the caller that it was
+	 * successfully registered.
+	 */
 	if (client->next_reg_id < 1)
 		client->next_reg_id = 1;
 
@@ -1377,7 +1375,7 @@ static unsigned int register_notify(struct bt_gatt_client *client,
 	/*
 	 * If the ref count > 1, then notifications are already enabled.
 	 */
-	if (chrc->notify_count > 1 || !chrc->ccc_handle) {
+	if (chrc->notify_count > 1) {
 		complete_notify_request(notify_data);
 		return notify_data->id;
 	}
@@ -1416,7 +1414,6 @@ static void service_changed_register_cb(uint16_t att_ecode, void *user_data)
 		goto done;
 	}
 
-	client->svc_chngd_registered = true;
 	success = true;
 	util_debug(client->debug_callback, client->debug_data,
 			"Registered handler for \"Service Changed\": %u",
@@ -1593,7 +1590,10 @@ static void init_complete(struct discovery_op *op, bool success,
 
 	util_debug(client->debug_callback, client->debug_data,
 			"Failed to register handler for \"Service Changed\"");
-	success = false;
+
+	/* Discovery continues even without service changed being registered */
+	success = true;
+	goto done;
 
 fail:
 	util_debug(client->debug_callback, client->debug_data,
@@ -1710,8 +1710,7 @@ static void complete_unregister_notify(void *data)
 		goto done;
 	}
 
-	if (__sync_sub_and_fetch(&notify_data->chrc->notify_count, 1) ||
-						!notify_data->chrc->ccc_handle)
+	if (__sync_sub_and_fetch(&notify_data->chrc->notify_count, 1))
 		goto done;
 
 	notify_data_write_ccc(notify_data, false, disable_ccc_callback);
-- 
2.10.0

