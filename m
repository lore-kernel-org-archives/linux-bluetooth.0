Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH] shared/gatt: Allow register_notify without CCC
Date: Tue,  3 Feb 2015 19:58:22 -0800
Message-Id: <1423022302-27124-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Certain peripherals can expose a GATT characteristic with the
notify/indicate property but with no Client Characteristic Configuration
descriptor. Since bt_gatt_client_register_notify enforces a CCC as a
requirement, it returns an error for such characteristics.

This patch fixes this behavior so that bt_gatt_client_register_notify
immediately registers the callback and returns success for
characteristics with no CCC.
---
 src/shared/gatt-client.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 5edb991..d0fc054 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -88,6 +88,7 @@ struct bt_gatt_client {
 	 * the remote peripheral.
 	 */
 	unsigned int svc_chngd_ind_id;
+	bool svc_chngd_registered;
 	struct queue *svc_chngd_queue;  /* Queued service changed events */
 	bool in_svc_chngd;
 
@@ -234,12 +235,6 @@ static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
 							&properties, NULL))
 			return NULL;
 
-	/* Find the CCC characteristic */
-	ccc = NULL;
-	gatt_db_service_foreach_desc(attr, find_ccc, &ccc);
-	if (!ccc)
-		return NULL;
-
 	chrc = new0(struct notify_chrc, 1);
 	if (!chrc)
 		return NULL;
@@ -250,8 +245,17 @@ static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
 		return NULL;
 	}
 
+	/*
+	 * Find the CCC characteristic. Some characteristics that allow
+	 * notifications may not have a CCC descriptor. We treat these as
+	 * automatically successful.
+	 */
+	ccc = NULL;
+	gatt_db_service_foreach_desc(attr, find_ccc, &ccc);
+	if (ccc)
+		chrc->ccc_handle = gatt_db_attribute_get_handle(ccc);
+
 	chrc->value_handle = value_handle;
-	chrc->ccc_handle = gatt_db_attribute_get_handle(ccc);
 	chrc->properties = properties;
 
 	queue_push_tail(client->notify_chrcs, chrc);
@@ -1020,6 +1024,7 @@ static void service_changed_reregister_cb(uint16_t att_ecode, void *user_data)
 		util_debug(client->debug_callback, client->debug_data,
 			"Re-registered handler for \"Service Changed\" after "
 			"change in GATT service");
+		client->svc_chngd_registered = true;
 		return;
 	}
 
@@ -1089,6 +1094,7 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 	/* The GATT service was modified. Re-register the handler for
 	 * indications from the "Service Changed" characteristic.
 	 */
+	client->svc_chngd_registered = false;
 	client->svc_chngd_ind_id = bt_gatt_client_register_notify(client,
 					gatt_db_attribute_get_handle(attr),
 					service_changed_reregister_cb,
@@ -1197,6 +1203,7 @@ static void service_changed_register_cb(uint16_t att_ecode, void *user_data)
 		goto done;
 	}
 
+	client->svc_chngd_registered = true;
 	client->ready = true;
 	success = true;
 	util_debug(client->debug_callback, client->debug_data,
@@ -1239,13 +1246,16 @@ static void init_complete(struct discovery_op *op, bool success,
 					service_changed_register_cb,
 					service_changed_cb,
 					client, NULL);
-	client->ready = false;
+
+	if (!client->svc_chngd_registered)
+		client->ready = false;
 
 	if (client->svc_chngd_ind_id)
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
 			"Failed to register handler for \"Service Changed\"");
+	success = false;
 
 fail:
 	util_debug(client->debug_callback, client->debug_data,
@@ -1423,18 +1433,17 @@ static void complete_unregister_notify(void *data)
 	 */
 	if (notify_data->att_id) {
 		bt_att_cancel(notify_data->client->att, notify_data->att_id);
-		notify_data_unref(notify_data);
-		return;
+		goto done;
 	}
 
-	if (__sync_sub_and_fetch(&notify_data->chrc->notify_count, 1)) {
-		notify_data_unref(notify_data);
-		return;
-	}
+	if (__sync_sub_and_fetch(&notify_data->chrc->notify_count, 1) ||
+						!notify_data->chrc->ccc_handle)
+		goto done;
 
 	if (notify_data_write_ccc(notify_data, false, disable_ccc_callback))
 		return;
 
+done:
 	notify_data_unref(notify_data);
 }
 
@@ -2571,9 +2580,7 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 	/* Add the handler to the bt_gatt_client's general list */
 	queue_push_tail(client->notify_list, notify_data);
 
-	/* Assign an ID to the handler and notify the caller that it was
-	 * successfully registered.
-	 */
+	/* Assign an ID to the handler. */
 	if (client->next_reg_id < 1)
 		client->next_reg_id = 1;
 
@@ -2591,7 +2598,7 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 	/*
 	 * If the ref count is not zero, then notifications are already enabled.
 	 */
-	if (chrc->notify_count > 0) {
+	if (chrc->notify_count > 0 || !chrc->ccc_handle) {
 		complete_notify_request(notify_data);
 		return notify_data->id;
 	}
-- 
2.2.0.rc0.207.ga3a616c

