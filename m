Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 2/3] shared/gatt: Cancel discovery requests in client
Date: Fri, 27 Feb 2015 16:44:46 -0800
Message-Id: <1425084287-9974-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1425084287-9974-1-git-send-email-armansito@chromium.org>
References: <1425084287-9974-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes potential cases of invalid access if discovery and
MTU exchange procedure callbacks are invoked after cleaning up a
bt_gatt_client, by cancelling all pending discovery requests in
bt_gatt_cancel_all.
---
 src/shared/gatt-client.c | 113 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 28 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 008bd3e..88863bc 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -100,6 +100,9 @@ struct bt_gatt_client {
 	 */
 	struct queue *pending_requests;
 	unsigned int next_request_id;
+
+	struct bt_gatt_async_req *discovery_req;
+	unsigned int mtu_req_id;
 };
 
 struct request {
@@ -415,6 +418,15 @@ static void discovery_op_unref(void *data)
 	discovery_op_free(op);
 }
 
+static void discovery_req_clear(struct bt_gatt_client *client)
+{
+	if (!client->discovery_req)
+		return;
+
+	bt_gatt_async_req_unref(client->discovery_req);
+	client->discovery_req = NULL;
+}
+
 static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data);
@@ -432,6 +444,8 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 	char uuid_str[MAX_LEN_UUID_STR];
 	unsigned int includes_count, i;
 
+	discovery_req_clear(client);
+
 	if (!success) {
 		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND)
 			goto next;
@@ -508,11 +522,14 @@ next:
 			goto failed;
 
 		op->cur_svc = attr;
-		if (bt_gatt_discover_characteristics(client->att,
+
+		client->discovery_req = bt_gatt_discover_characteristics(
+							client->att,
 							start, end,
 							discover_chrcs_cb,
 							discovery_op_ref(op),
-							discovery_op_unref))
+							discovery_op_unref);
+		if (client->discovery_req)
 			return;
 
 		util_debug(client->debug_callback, client->debug_data,
@@ -529,10 +546,12 @@ next:
 	if (start == end)
 		goto next;
 
-	if (bt_gatt_discover_included_services(client->att, start, end,
+	client->discovery_req = bt_gatt_discover_included_services(client->att,
+							start, end,
 							discover_incl_cb,
 							discovery_op_ref(op),
-							discovery_op_unref))
+							discovery_op_unref);
+	if (client->discovery_req)
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
@@ -585,11 +604,13 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 			continue;
 		}
 
-		if (bt_gatt_discover_descriptors(client->att, desc_start,
+		client->discovery_req = bt_gatt_discover_descriptors(
+							client->att, desc_start,
 							chrc_data->end_handle,
 							discover_descs_cb,
 							discovery_op_ref(op),
-							discovery_op_unref)) {
+							discovery_op_unref);
+		if (client->discovery_req) {
 			*discovering = true;
 			goto done;
 		}
@@ -625,6 +646,8 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 	unsigned int desc_count;
 	bool discovering;
 
+	discovery_req_clear(client);
+
 	if (!success) {
 		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
 			success = true;
@@ -684,10 +707,13 @@ next:
 
 	/* Move on to the next service */
 	op->cur_svc = attr;
-	if (bt_gatt_discover_characteristics(client->att, start, end,
+
+	client->discovery_req = bt_gatt_discover_characteristics(client->att,
+							start, end,
 							discover_chrcs_cb,
 							discovery_op_ref(op),
-							discovery_op_unref))
+							discovery_op_unref);
+	if (client->discovery_req)
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
@@ -719,6 +745,8 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 	unsigned int chrc_count;
 	bool discovering;
 
+	discovery_req_clear(client);
+
 	if (!success) {
 		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
 			success = true;
@@ -788,10 +816,13 @@ next:
 
 	/* Move on to the next service */
 	op->cur_svc = attr;
-	if (bt_gatt_discover_characteristics(client->att, start, end,
+
+	client->discovery_req = bt_gatt_discover_characteristics(client->att,
+							start, end,
 							discover_chrcs_cb,
 							discovery_op_ref(op),
-							discovery_op_unref))
+							discovery_op_unref);
+	if (client->discovery_req)
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
@@ -819,6 +850,8 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 	bt_uuid_t uuid;
 	char uuid_str[MAX_LEN_UUID_STR];
 
+	discovery_req_clear(client);
+
 	if (!success) {
 		util_debug(client->debug_callback, client->debug_data,
 					"Secondary service discovery failed."
@@ -883,10 +916,12 @@ next:
 		goto done;
 	}
 
-	if (bt_gatt_discover_included_services(client->att, start, end,
+	client->discovery_req = bt_gatt_discover_included_services(client->att,
+							start, end,
 							discover_incl_cb,
 							discovery_op_ref(op),
-							discovery_op_unref))
+							discovery_op_unref);
+	if (client->discovery_req)
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
@@ -911,6 +946,8 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 	bt_uuid_t uuid;
 	char uuid_str[MAX_LEN_UUID_STR];
 
+	discovery_req_clear(client);
+
 	if (!success) {
 		util_debug(client->debug_callback, client->debug_data,
 					"Primary service discovery failed."
@@ -950,11 +987,12 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 
 secondary:
 	/* Discover secondary services */
-	if (bt_gatt_discover_secondary_services(client->att, NULL,
-							op->start, op->end,
-							discover_secondary_cb,
-							discovery_op_ref(op),
-							discovery_op_unref))
+	client->discovery_req = bt_gatt_discover_secondary_services(client->att,
+						NULL, op->start, op->end,
+						discover_secondary_cb,
+						discovery_op_ref(op),
+						discovery_op_unref);
+	if (client->discovery_req)
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
@@ -984,6 +1022,7 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 	struct bt_gatt_client *client = op->client;
 
 	op->success = success;
+	client->mtu_req_id = 0;
 
 	if (!success) {
 		util_debug(client->debug_callback, client->debug_data,
@@ -1006,10 +1045,12 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 		return;
 	}
 
-	if (bt_gatt_discover_all_primary_services(client->att, NULL,
+	client->discovery_req = bt_gatt_discover_all_primary_services(
+							client->att, NULL,
 							discover_primary_cb,
 							discovery_op_ref(op),
-							discovery_op_unref))
+							discovery_op_unref);
+	if (client->discovery_req)
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
@@ -1120,7 +1161,9 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 
 static void service_changed_failure(struct discovery_op *op)
 {
-	gatt_db_clear_range(op->client->db, op->start, op->end);
+	struct bt_gatt_client *client = op->client;
+
+	gatt_db_clear_range(client->db, op->start, op->end);
 }
 
 static void process_service_changed(struct bt_gatt_client *client,
@@ -1146,11 +1189,12 @@ static void process_service_changed(struct bt_gatt_client *client,
 	if (!op)
 		goto fail;
 
-	if (bt_gatt_discover_primary_services(client->att, NULL,
-						start_handle, end_handle,
+	client->discovery_req = bt_gatt_discover_primary_services(client->att,
+						NULL, start_handle, end_handle,
 						discover_primary_cb,
 						discovery_op_ref(op),
-						discovery_op_unref)) {
+						discovery_op_unref);
+	if (client->discovery_req) {
 		client->in_svc_chngd = true;
 		return;
 	}
@@ -1280,7 +1324,9 @@ done:
 
 static void init_fail(struct discovery_op *op)
 {
-	gatt_db_clear(op->client->db);
+	struct bt_gatt_client *client = op->client;
+
+	gatt_db_clear(client->db);
 }
 
 static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
@@ -1296,10 +1342,12 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 		return false;
 
 	/* Configure the MTU */
-	if (!bt_gatt_exchange_mtu(client->att, MAX(BT_ATT_DEFAULT_LE_MTU, mtu),
-							exchange_mtu_cb,
-							discovery_op_ref(op),
-							discovery_op_unref)) {
+	client->mtu_req_id = bt_gatt_exchange_mtu(client->att,
+						MAX(BT_ATT_DEFAULT_LE_MTU, mtu),
+						exchange_mtu_cb,
+						discovery_op_ref(op),
+						discovery_op_unref);
+	if (!client->mtu_req_id) {
 		discovery_op_free(op);
 		return false;
 	}
@@ -1790,6 +1838,15 @@ bool bt_gatt_client_cancel_all(struct bt_gatt_client *client)
 
 	queue_remove_all(client->pending_requests, NULL, NULL, cancel_request);
 
+	if (client->discovery_req) {
+		bt_gatt_async_req_cancel(client->discovery_req);
+		bt_gatt_async_req_unref(client->discovery_req);
+		client->discovery_req = NULL;
+	}
+
+	if (client->mtu_req_id)
+		bt_att_cancel(client->att, client->mtu_req_id);
+
 	return true;
 }
 
-- 
2.2.0.rc0.207.ga3a616c

