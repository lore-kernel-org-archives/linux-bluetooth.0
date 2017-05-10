Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/10] shared/gatt-client: Simplify included discovery
Date: Wed, 10 May 2017 15:48:30 +0300
Message-Id: <20170510124835.17462-6-luiz.dentz@gmail.com>
In-Reply-To: <20170510124835.17462-1-luiz.dentz@gmail.com>
References: <20170510124835.17462-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead of doing include per service in a depth-first fashion do it
in breadth-first like its done for primary and secondary since it is
now possible to insert the include handle, not just append at the end,
it is not longer necessary to fetch the attribute in order to have
included handle.

As a bonus this can also speed up the discovery procedure since it will
result in less traffic over the air.
---
 src/shared/gatt-client.c | 130 +++++++++++++++--------------------------------
 1 file changed, 42 insertions(+), 88 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 3caed5f..a5f3c18 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -315,13 +315,14 @@ struct discovery_op {
 	struct bt_gatt_client *client;
 	struct queue *pending_svcs;
 	struct queue *pending_chrcs;
-	struct queue *svcs;
 	struct queue *ext_prop_desc;
 	struct gatt_db_attribute *cur_svc;
 	bool success;
 	uint16_t start;
 	uint16_t end;
 	uint16_t last;
+	uint16_t svc_first;
+	uint16_t svc_last;
 	int ref_count;
 	discovery_op_complete_func_t complete_func;
 	discovery_op_fail_func_t failure_func;
@@ -331,7 +332,6 @@ static void discovery_op_free(struct discovery_op *op)
 {
 	queue_destroy(op->pending_svcs, NULL);
 	queue_destroy(op->pending_chrcs, free);
-	queue_destroy(op->svcs, NULL);
 	queue_destroy(op->ext_prop_desc, NULL);
 	free(op);
 }
@@ -357,7 +357,6 @@ static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 	op = new0(struct discovery_op, 1);
 	op->pending_svcs = queue_new();
 	op->pending_chrcs = queue_new();
-	op->svcs = queue_new();
 	op->ext_prop_desc = queue_new();
 	op->client = client;
 	op->complete_func = complete_func;
@@ -408,7 +407,7 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 	struct discovery_op *op = user_data;
 	struct bt_gatt_client *client = op->client;
 	struct bt_gatt_iter iter;
-	struct gatt_db_attribute *attr, *tmp;
+	struct gatt_db_attribute *attr;
 	uint16_t handle, start, end;
 	uint128_t u128;
 	bt_uuid_t uuid;
@@ -424,11 +423,6 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 		goto failed;
 	}
 
-	/* Get the currently processed service */
-	attr = op->cur_svc;
-	if (!attr)
-		goto failed;
-
 	if (!result || !bt_gatt_iter_init(&iter, result))
 		goto failed;
 
@@ -453,12 +447,12 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 				"handle: 0x%04x, start: 0x%04x, end: 0x%04x,"
 				"uuid: %s", handle, start, end, uuid_str);
 
-		tmp = gatt_db_get_attribute(client->db, start);
-		if (!tmp)
+		attr = gatt_db_get_attribute(client->db, start);
+		if (!attr)
 			goto failed;
 
-		tmp = gatt_db_service_insert_included(attr, handle, tmp);
-		if (!tmp)
+		attr = gatt_db_insert_included(client->db, handle, attr);
+		if (!attr)
 			goto failed;
 
 		/*
@@ -467,62 +461,32 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 		 * these entries, the correct handle must be assigned to the new
 		 * attribute.
 		 */
-		if (gatt_db_attribute_get_handle(tmp) != handle)
+		if (gatt_db_attribute_get_handle(attr) != handle)
 			goto failed;
 	}
 
 next:
 	/* Move on to the next service */
 	attr = queue_pop_head(op->pending_svcs);
-	if (!attr) {
-		/*
-		 * We have processed all include definitions. Move on to
-		 * characteristics.
-		 */
-		attr = queue_pop_head(op->svcs);
-		if (!attr)
-			goto failed;
-
-		if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
-			goto failed;
-
-		op->cur_svc = attr;
-
-		client->discovery_req = bt_gatt_discover_characteristics(
-							client->att,
-							start, end,
-							discover_chrcs_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
-		if (client->discovery_req)
-			return;
-
-		util_debug(client->debug_callback, client->debug_data,
-				"Failed to start characteristic discovery");
-		discovery_op_unref(op);
+	if (!attr)
 		goto failed;
-	}
 
-	queue_push_tail(op->svcs, attr);
-	op->cur_svc = attr;
 	if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
 		goto failed;
 
-	if (start == end)
-		goto next;
+	op->cur_svc = attr;
 
-	client->discovery_req = bt_gatt_discover_included_services(client->att,
+	client->discovery_req = bt_gatt_discover_characteristics(client->att,
 							start, end,
-							discover_incl_cb,
+							discover_chrcs_cb,
 							discovery_op_ref(op),
 							discovery_op_unref);
 	if (client->discovery_req)
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
-					"Failed to start included discovery");
+				"Failed to start characteristic discovery");
 	discovery_op_unref(op);
-
 failed:
 	discovery_op_complete(op, false, att_ecode);
 }
@@ -674,7 +638,7 @@ static void ext_prop_read_cb(bool success, uint8_t att_ecode,
 		/* Done with the current service */
 		gatt_db_service_set_active(op->cur_svc, true);
 
-		next_srv = queue_pop_head(op->svcs);
+		next_srv = queue_pop_head(op->pending_svcs);
 		if (!next_srv)
 			goto done;
 
@@ -782,7 +746,7 @@ next:
 	/* Done with the current service */
 	gatt_db_service_set_active(op->cur_svc, true);
 
-	attr = queue_pop_head(op->svcs);
+	attr = queue_pop_head(op->pending_svcs);
 	if (!attr)
 		goto done;
 
@@ -888,7 +852,7 @@ next:
 	/* Done with the current service */
 	gatt_db_service_set_active(op->cur_svc, true);
 
-	attr = queue_pop_head(op->svcs);
+	attr = queue_pop_head(op->pending_svcs);
 	if (!attr)
 		goto done;
 
@@ -920,6 +884,26 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
+static void discovery_found_service(struct discovery_op *op,
+					struct gatt_db_attribute *attr,
+					uint16_t start, uint16_t end)
+{
+	/* Skip if service already active */
+	if (!gatt_db_service_get_active(attr)) {
+		queue_push_tail(op->pending_svcs, attr);
+
+		/* Update discovery range */
+		if (!op->svc_first || op->svc_first > start)
+			op->svc_first = start;
+		if (op->svc_last < end)
+			op->svc_last = end;
+	}
+
+	/* Update last handle */
+	if (end > op->last)
+		op->last = end;
+}
+
 static void discover_secondary_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -984,39 +968,14 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 			op->last = end;
 		}
 
-		/* Skip if service already active */
-		if (!gatt_db_service_get_active(attr))
-			queue_push_tail(op->pending_svcs, attr);
-
-		/* Update last handle */
-		if (end > op->last)
-			op->last = end;
+		/* Update pending list */
+		discovery_found_service(op, attr, start, end);
 	}
 
 next:
-	/* Sequentially discover included services */
-	attr = queue_pop_head(op->pending_svcs);
-
-	/* Complete with success if queue is empty */
-	if (!attr) {
-		success = true;
-		goto done;
-	}
-
-	/*
-	 * Store the service in the svcs queue to be reused during
-	 * characteristics discovery later.
-	 */
-	queue_push_tail(op->svcs, attr);
-	op->cur_svc = attr;
-
-	if (!gatt_db_attribute_get_service_handles(attr, &start, &end)) {
-		success = false;
-		goto done;
-	}
-
 	client->discovery_req = bt_gatt_discover_included_services(client->att,
-							start, end,
+							op->svc_first,
+							op->svc_last,
 							discover_incl_cb,
 							discovery_op_ref(op),
 							discovery_op_unref);
@@ -1097,13 +1056,8 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 			op->last = end;
 		}
 
-		/* Skip if service already active */
-		if (!gatt_db_service_get_active(attr))
-			queue_push_tail(op->pending_svcs, attr);
-
-		/* Update last handle */
-		if (end > op->last)
-			op->last = end;
+		/* Update pending list */
+		discovery_found_service(op, attr, start, end);
 	}
 
 secondary:
-- 
2.9.3

