Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/gatt-client: Don't remove notification handlers
Date: Wed, 16 Mar 2016 15:17:24 +0200
Message-Id: <1458134245-23277-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The notification handlers shall not be removed automatically when service
changed is received and the handle is in range. The user should be able to
decide whether to keep the registration or not since it will get events of
the service changed via gatt_db.
---
 src/shared/gatt-client.c | 51 ------------------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 7fa0b1d..37c219b 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -291,25 +291,6 @@ struct handle_range {
 	uint16_t end;
 };
 
-static bool match_notify_data_handle_range(const void *a, const void *b)
-{
-	const struct notify_data *notify_data = a;
-	struct notify_chrc *chrc = notify_data->chrc;
-	const struct handle_range *range = b;
-
-	return chrc->value_handle >= range->start &&
-					chrc->value_handle <= range->end;
-}
-
-static bool match_notify_chrc_handle_range(const void *a, const void *b)
-{
-	const struct notify_chrc *chrc = a;
-	const struct handle_range *range = b;
-
-	return chrc->value_handle >= range->start &&
-					chrc->value_handle <= range->end;
-}
-
 static void notify_data_cleanup(void *data)
 {
 	struct notify_data *notify_data = data;
@@ -320,32 +301,6 @@ static void notify_data_cleanup(void *data)
 	notify_data_unref(notify_data);
 }
 
-static void gatt_client_remove_all_notify_in_range(
-				struct bt_gatt_client *client,
-				uint16_t start_handle, uint16_t end_handle)
-{
-	struct handle_range range;
-
-	range.start = start_handle;
-	range.end = end_handle;
-
-	queue_remove_all(client->notify_list, match_notify_data_handle_range,
-						&range, notify_data_cleanup);
-}
-
-static void gatt_client_remove_notify_chrcs_in_range(
-				struct bt_gatt_client *client,
-				uint16_t start_handle, uint16_t end_handle)
-{
-	struct handle_range range;
-
-	range.start = start_handle;
-	range.end = end_handle;
-
-	queue_remove_all(client->notify_chrcs, match_notify_chrc_handle_range,
-						&range, notify_chrc_free);
-}
-
 struct discovery_op;
 
 typedef void (*discovery_op_complete_func_t)(struct discovery_op *op,
@@ -1426,12 +1381,6 @@ static void process_service_changed(struct bt_gatt_client *client,
 	if (start_handle == 0x0001 && end_handle == 0xffff)
 		goto discover;
 
-	/* Invalidate and remove all effected notify callbacks */
-	gatt_client_remove_all_notify_in_range(client, start_handle,
-								end_handle);
-	gatt_client_remove_notify_chrcs_in_range(client, start_handle,
-								end_handle);
-
 	/* Remove all services that overlap the modified range since we'll
 	 * rediscover them
 	 */
-- 
2.5.0

