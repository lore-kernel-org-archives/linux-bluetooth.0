Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] shared/gatt-client: Simplify descriptor discovery
Date: Wed, 10 May 2017 16:03:42 +0300
Message-Id: <20170510130342.18650-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead of discovering descriptor per characteristic in a depth-first
fashion do it in breadth-first like its done for everything else.

This doesn't trade as efficiently as other changes since Find Info does
not take full advantage of the MTU if UUIDs are of different sizes,
also since we cannot specify intervals the services and characteristics
UUIDs are also read, though depending o the db layout and MTU size it
can still improve the speed because there are less round trips.
---
 src/shared/gatt-client.c | 186 +++++++++++++----------------------------------
 1 file changed, 50 insertions(+), 136 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 7557600..c5c62d4 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -482,106 +482,10 @@ failed:
 	discovery_op_complete(op, false, att_ecode);
 }
 
-struct chrc {
-	uint16_t start_handle;
-	uint16_t end_handle;
-	uint16_t value_handle;
-	uint8_t properties;
-	bt_uuid_t uuid;
-};
-
 static void discover_descs_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data);
 
-static bool discover_descs(struct discovery_op *op, bool *discovering)
-{
-	struct bt_gatt_client *client = op->client;
-	struct gatt_db_attribute *attr;
-	struct chrc *chrc_data;
-	uint16_t desc_start;
-
-	*discovering = false;
-
-	while ((chrc_data = queue_pop_head(op->pending_chrcs))) {
-		struct gatt_db_attribute *svc;
-		uint16_t start, end;
-
-		attr = gatt_db_insert_characteristic(client->db,
-							chrc_data->value_handle,
-							&chrc_data->uuid, 0,
-							chrc_data->properties,
-							NULL, NULL, NULL);
-
-		if (!attr) {
-			util_debug(client->debug_callback, client->debug_data,
-				"Failed to insert characteristic at 0x%04x",
-				chrc_data->value_handle);
-			goto failed;
-		}
-
-		if (gatt_db_attribute_get_handle(attr) !=
-							chrc_data->value_handle)
-			goto failed;
-
-		/* Adjust current service */
-		svc = gatt_db_get_service(client->db, chrc_data->value_handle);
-		if (op->cur_svc != svc) {
-			queue_remove(op->pending_svcs, svc);
-
-			/* Done with the current service */
-			gatt_db_service_set_active(op->cur_svc, true);
-			op->cur_svc = svc;
-		}
-
-		gatt_db_attribute_get_service_handles(svc, &start, &end);
-
-		/*
-		 * Ajust end_handle in case the next chrc is not within the
-		 * same service.
-		 */
-		if (chrc_data->end_handle > end)
-			chrc_data->end_handle = end;
-
-		/*
-		 * check for descriptors presence, before initializing the
-		 * desc_handle and avoid integer overflow during desc_handle
-		 * intialization.
-		 */
-		if (chrc_data->value_handle >= chrc_data->end_handle) {
-			free(chrc_data);
-			continue;
-		}
-
-		desc_start = chrc_data->value_handle + 1;
-
-		client->discovery_req = bt_gatt_discover_descriptors(
-							client->att, desc_start,
-							chrc_data->end_handle,
-							discover_descs_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
-		if (client->discovery_req) {
-			*discovering = true;
-			goto done;
-		}
-
-		util_debug(client->debug_callback, client->debug_data,
-					"Failed to start descriptor discovery");
-		discovery_op_unref(op);
-
-		goto failed;
-	}
-
-done:
-	free(chrc_data);
-	return true;
-
-failed:
-	free(chrc_data);
-	return false;
-}
-
 static void ext_prop_write_cb(struct gatt_db_attribute *attrib,
 						int err, void *user_data)
 {
@@ -621,7 +525,6 @@ static void ext_prop_read_cb(bool success, uint8_t att_ecode,
 {
 	struct discovery_op *op = user_data;
 	struct bt_gatt_client *client = op->client;
-	bool discovering;
 	struct gatt_db_attribute *desc_attr = NULL;
 
 	util_debug(client->debug_callback, client->debug_data,
@@ -639,12 +542,6 @@ static void ext_prop_read_cb(bool success, uint8_t att_ecode,
 	if (read_ext_prop_desc(op))
 		return;
 
-	if (!discover_descs(op, &discovering))
-			goto failed;
-
-	if (discovering)
-		return;
-
 	/* Done with the current service */
 	gatt_db_service_set_active(op->cur_svc, true);
 
@@ -670,7 +567,6 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 	bt_uuid_t uuid;
 	char uuid_str[MAX_LEN_UUID_STR];
 	unsigned int desc_count;
-	bool discovering;
 	bt_uuid_t ext_prop_uuid;
 
 	discovery_req_clear(client);
@@ -698,9 +594,24 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 
 	while (bt_gatt_iter_next_descriptor(&iter, &handle, u128.data)) {
 		bt_uuid128_create(&uuid, u128);
+		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+
+		attr = gatt_db_get_attribute(client->db, handle);
+		/* Check if attribute already exists*/
+		if (attr) {
+			/* UUID shall match otherwise the db is inconsistent */
+			if (bt_uuid_cmp(gatt_db_attribute_get_type(attr),
+								&uuid)) {
+				util_debug(client->debug_callback,
+					client->debug_data,
+					"Invalid descriptor at 0x%04x uuid %s",
+					handle, uuid_str);
+				goto failed;
+			}
+			goto skip;
+		}
 
 		/* Log debug message */
-		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
 		util_debug(client->debug_callback, client->debug_data,
 						"handle: 0x%04x, uuid: %s",
 						handle, uuid_str);
@@ -720,6 +631,17 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 
 		if (!bt_uuid_cmp(&ext_prop_uuid, &uuid))
 			queue_push_tail(op->ext_prop_desc, attr);
+
+skip:
+		/* Adjust current service */
+		attr = gatt_db_get_service(client->db, handle);
+		if (op->cur_svc != attr) {
+			queue_remove(op->pending_svcs, attr);
+
+			/* Done with the current service */
+			gatt_db_service_set_active(op->cur_svc, true);
+			op->cur_svc = attr;
+		}
 	}
 
 	/* If we got extended prop descriptor, lets read it right away */
@@ -727,12 +649,6 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 		return;
 
 next:
-	if (!discover_descs(op, &discovering))
-		goto failed;
-
-	if (discovering)
-		return;
-
 	/* Done with the current service */
 	gatt_db_service_set_active(op->cur_svc, true);
 
@@ -752,21 +668,19 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 	struct discovery_op *op = user_data;
 	struct bt_gatt_client *client = op->client;
 	struct bt_gatt_iter iter;
-	struct chrc *chrc_data;
+	struct gatt_db_attribute *attr;
 	uint16_t start, end, value;
 	uint8_t properties;
 	uint128_t u128;
 	bt_uuid_t uuid;
 	char uuid_str[MAX_LEN_UUID_STR];
 	unsigned int chrc_count;
-	bool discovering;
 
 	discovery_req_clear(client);
 
 	if (!success) {
 		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
 			success = true;
-			goto next;
 		}
 
 		goto done;
@@ -793,37 +707,37 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 				"props: 0x%02x, uuid: %s",
 				start, end, value, properties, uuid_str);
 
-		chrc_data = new0(struct chrc, 1);
-
-		chrc_data->start_handle = start;
-		chrc_data->end_handle = end;
-		chrc_data->value_handle = value;
-		chrc_data->properties = properties;
-		chrc_data->uuid = uuid;
-
-		queue_push_tail(op->pending_chrcs, chrc_data);
+		attr = gatt_db_insert_characteristic(client->db, value, &uuid,
+							0, properties,
+							NULL, NULL, NULL);
+		if (!attr) {
+			util_debug(client->debug_callback, client->debug_data,
+				"Failed to insert characteristic at 0x%04x",
+				value);
+			goto failed;
+		}
 	}
 
-	/*
-	 * Sequentially discover descriptors for each characteristic and insert
-	 * the characteristics into the database as we proceed.
-	 */
-	if (!discover_descs(op, &discovering))
-		goto failed;
-
-	if (discovering)
+	client->discovery_req = bt_gatt_discover_descriptors(client->att,
+							op->svc_first,
+							op->svc_last,
+							discover_descs_cb,
+							discovery_op_ref(op),
+							discovery_op_unref);
+	if (client->discovery_req)
 		return;
 
-next:
-	/* Done with the current service */
-	gatt_db_service_set_active(op->cur_svc, true);
-
-	goto done;
+	util_debug(client->debug_callback, client->debug_data,
+					"Failed to start descriptor discovery");
+	discovery_op_unref(op);
 
 failed:
 	success = false;
 
 done:
+	/* Done with the current service */
+	gatt_db_service_set_active(op->cur_svc, true);
+
 	discovery_op_complete(op, success, att_ecode);
 }
 
-- 
2.9.3

