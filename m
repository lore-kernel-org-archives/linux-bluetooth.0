Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/10] shared/gatt-client: Simplify characteristics discovery
Date: Tue,  9 May 2017 23:48:39 +0300
Message-Id: <20170509204840.3270-10-luiz.dentz@gmail.com>
In-Reply-To: <20170509204840.3270-1-luiz.dentz@gmail.com>
References: <20170509204840.3270-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead of discovering characteristics per service in a depth-first
fashion do it in breadth-first like its done for primary, secondary and
included.

As a bonus this can also speed up the discovery procedure since it will
result in less traffic over the air.
---
 src/shared/gatt-client.c | 138 ++++++++++++++---------------------------------
 1 file changed, 40 insertions(+), 98 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 9109bda..9a701ad 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -464,18 +464,8 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 	}
 
 next:
-	/* Move on to the next service */
-	attr = queue_pop_head(op->pending_svcs);
-	if (!attr)
-		goto failed;
-
-	if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
-		goto failed;
-
-	op->cur_svc = attr;
-
 	client->discovery_req = bt_gatt_discover_characteristics(client->att,
-							start, end,
+							op->start, op->end,
 							discover_chrcs_cb,
 							discovery_op_ref(op),
 							discovery_op_unref);
@@ -511,7 +501,10 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 	*discovering = false;
 
 	while ((chrc_data = queue_pop_head(op->pending_chrcs))) {
-		attr = gatt_db_service_insert_characteristic(op->cur_svc,
+		struct gatt_db_attribute *svc;
+		uint16_t start, end;
+
+		attr = gatt_db_insert_characteristic(client->db,
 							chrc_data->value_handle,
 							&chrc_data->uuid, 0,
 							chrc_data->properties,
@@ -528,6 +521,25 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 							chrc_data->value_handle)
 			goto failed;
 
+		/* Adjust current service */
+		svc = gatt_db_get_service(client->db, chrc_data->value_handle);
+		if (op->cur_svc != svc) {
+			queue_remove(op->pending_svcs, svc);
+
+			/* Done with the current service */
+			gatt_db_service_set_active(op->cur_svc, true);
+			op->cur_svc = svc;
+		}
+
+		gatt_db_attribute_get_service_handles(svc, &start, &end);
+
+		/*
+		 * Ajust end_handle in case the next chrc is not within the
+		 * same service.
+		 */
+		if (chrc_data->end_handle > end)
+			chrc_data->end_handle = end;
+
 		/*
 		 * check for descriptors presence, before initializing the
 		 * desc_handle and avoid integer overflow during desc_handle
@@ -537,6 +549,7 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 			free(chrc_data);
 			continue;
 		}
+
 		desc_start = chrc_data->value_handle + 1;
 
 		client->discovery_req = bt_gatt_discover_descriptors(
@@ -607,8 +620,6 @@ static void ext_prop_read_cb(bool success, uint8_t att_ecode,
 	struct bt_gatt_client *client = op->client;
 	bool discovering;
 	struct gatt_db_attribute *desc_attr = NULL;
-	struct gatt_db_attribute *next_srv;
-	uint16_t start, end;
 
 	util_debug(client->debug_callback, client->debug_data,
 				"Ext. prop value: 0x%04x", (uint16_t)value[0]);
@@ -625,42 +636,16 @@ static void ext_prop_read_cb(bool success, uint8_t att_ecode,
 	if (read_ext_prop_desc(op))
 		return;
 
-	/* Continue with discovery */
-	do {
-		if (!discover_descs(op, &discovering))
-			goto failed;
-
-		if (discovering)
-			return;
-
-		/* Done with the current service */
-		gatt_db_service_set_active(op->cur_svc, true);
-
-		next_srv = queue_pop_head(op->pending_svcs);
-		if (!next_srv)
-			goto done;
-
-		if (!gatt_db_attribute_get_service_handles(next_srv, &start,
-									&end))
+	if (!discover_descs(op, &discovering))
 			goto failed;
 
-	} while (start == end);
-
-	/* Move on to the next service */
-	op->cur_svc = next_srv;
-
-	client->discovery_req = bt_gatt_discover_characteristics(client->att,
-							start, end,
-							discover_chrcs_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
-	if (client->discovery_req)
+	if (discovering)
 		return;
 
-	util_debug(client->debug_callback, client->debug_data,
-				"Failed to start characteristic discovery");
+	/* Done with the current service */
+	gatt_db_service_set_active(op->cur_svc, true);
 
-	discovery_op_unref(op);
+	goto done;
 
 failed:
 	success = false;
@@ -677,7 +662,7 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 	struct bt_gatt_client *client = op->client;
 	struct bt_gatt_iter iter;
 	struct gatt_db_attribute *attr;
-	uint16_t handle, start, end;
+	uint16_t handle;
 	uint128_t u128;
 	bt_uuid_t uuid;
 	char uuid_str[MAX_LEN_UUID_STR];
@@ -717,11 +702,15 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 						"handle: 0x%04x, uuid: %s",
 						handle, uuid_str);
 
-		attr = gatt_db_service_insert_descriptor(op->cur_svc, handle,
+		attr = gatt_db_insert_descriptor(client->db, handle,
 							&uuid, 0, NULL, NULL,
 							NULL);
-		if (!attr)
+		if (!attr) {
+			util_debug(client->debug_callback, client->debug_data,
+				"Failed to insert descriptor at 0x%04x",
+				handle);
 			goto failed;
+		}
 
 		if (gatt_db_attribute_get_handle(attr) != handle)
 			goto failed;
@@ -744,30 +733,7 @@ next:
 	/* Done with the current service */
 	gatt_db_service_set_active(op->cur_svc, true);
 
-	attr = queue_pop_head(op->pending_svcs);
-	if (!attr)
-		goto done;
-
-	if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
-		goto failed;
-
-	if (start == end)
-		goto next;
-
-	/* Move on to the next service */
-	op->cur_svc = attr;
-
-	client->discovery_req = bt_gatt_discover_characteristics(client->att,
-							start, end,
-							discover_chrcs_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
-	if (client->discovery_req)
-		return;
-
-	util_debug(client->debug_callback, client->debug_data,
-				"Failed to start characteristic discovery");
-	discovery_op_unref(op);
+	goto done;
 
 failed:
 	success = false;
@@ -783,7 +749,6 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 	struct discovery_op *op = user_data;
 	struct bt_gatt_client *client = op->client;
 	struct bt_gatt_iter iter;
-	struct gatt_db_attribute *attr;
 	struct chrc *chrc_data;
 	uint16_t start, end, value;
 	uint8_t properties;
@@ -804,7 +769,7 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 		goto done;
 	}
 
-	if (!op->cur_svc || !result || !bt_gatt_iter_init(&iter, result))
+	if (!result || !bt_gatt_iter_init(&iter, result))
 		goto failed;
 
 	chrc_count = bt_gatt_result_characteristic_count(result);
@@ -850,30 +815,7 @@ next:
 	/* Done with the current service */
 	gatt_db_service_set_active(op->cur_svc, true);
 
-	attr = queue_pop_head(op->pending_svcs);
-	if (!attr)
-		goto done;
-
-	if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
-		goto failed;
-
-	if (start == end)
-		goto next;
-
-	/* Move on to the next service */
-	op->cur_svc = attr;
-
-	client->discovery_req = bt_gatt_discover_characteristics(client->att,
-							start, end,
-							discover_chrcs_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
-	if (client->discovery_req)
-		return;
-
-	util_debug(client->debug_callback, client->debug_data,
-				"Failed to start characteristic discovery");
-	discovery_op_unref(op);
+	goto done;
 
 failed:
 	success = false;
-- 
2.9.3

