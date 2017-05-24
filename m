Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix not removing services that had disappeared
Date: Wed, 24 May 2017 13:54:24 +0300
Message-Id: <20170524105424.6708-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a service cannot be found in the middle of the database the current
logic don't clear its range leaving it still active which cause upper
layer to its attributes are still available.

In order to fix the code now loads existing services into the pending
list and remove the services left at the end of the discovery:

src/device.c:gatt_debug() Primary services found: 2
src/device.c:gatt_debug() start: 0x0001, end: 0x0005, uuid: 00001800-0000-1000-8000-00805f9b34fb
src/device.c:gatt_debug() start: 0x0100, end: 0x0104, uuid: 0000180a-0000-1000-8000-00805f9b34fb
src/device.c:gatt_debug() Secondary service discovery failed. ATT ECODE: 0x0a
src/device.c:gatt_debug() Characteristics found: 2
src/device.c:gatt_debug() start: 0x0101, end: 0x0102, value: 0x0102, props: 0x02, uuid: 00002a24-0000-1
src/device.c:gatt_debug() start: 0x0103, end: 0x0104, value: 0x0104, props: 0x02, uuid: 00002a29-0000-1
src/device.c:gatt_debug() service disappeared: start 0x0006 end 0x000a
src/device.c:gatt_service_removed() start: 0x0006, end: 0x000a
---
 src/shared/gatt-client.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 7557600..b8f70c8 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -323,6 +323,7 @@ struct discovery_op {
 	uint16_t last;
 	uint16_t svc_first;
 	uint16_t svc_last;
+	unsigned int db_id;
 	int ref_count;
 	discovery_op_complete_func_t complete_func;
 	discovery_op_fail_func_t failure_func;
@@ -330,6 +331,9 @@ struct discovery_op {
 
 static void discovery_op_free(struct discovery_op *op)
 {
+	if (op->db_id > 0)
+		gatt_db_unregister(op->client->db, op->db_id);
+
 	queue_destroy(op->pending_svcs, NULL);
 	queue_destroy(op->pending_chrcs, free);
 	queue_destroy(op->ext_prop_desc, NULL);
@@ -339,6 +343,30 @@ static void discovery_op_free(struct discovery_op *op)
 static void discovery_op_complete(struct discovery_op *op, bool success,
 								uint8_t err)
 {
+	const struct queue_entry *svc;
+
+	/*
+	 * Unregister remove callback so it is not called when clearing unused
+	 * range.
+	 */
+	gatt_db_unregister(op->client->db, op->db_id);
+	op->db_id = 0;
+
+	/* Remove services pending */
+	for (svc = queue_get_entries(op->pending_svcs); svc; svc = svc->next) {
+		struct gatt_db_attribute *attr = svc->data;
+		uint16_t start, end;
+
+		gatt_db_attribute_get_service_data(attr, &start, &end,
+							NULL, NULL);
+
+		util_debug(op->client->debug_callback, op->client->debug_data,
+				"service disappeared: start 0x%04x end 0x%04x",
+				start, end);
+
+		gatt_db_remove_service(op->client->db, attr);
+	}
+
 	/* Reset remaining range */
 	if (op->last != UINT16_MAX)
 		gatt_db_clear_range(op->client->db, op->last + 1, UINT16_MAX);
@@ -347,6 +375,22 @@ static void discovery_op_complete(struct discovery_op *op, bool success,
 	op->complete_func(op, success, err);
 }
 
+static void discovery_load_services(struct gatt_db_attribute *attr,
+							void *user_data)
+{
+	struct discovery_op *op = user_data;
+
+	queue_push_tail(op->pending_svcs, attr);
+}
+
+static void discovery_service_changed(struct gatt_db_attribute *attr,
+							void *user_data)
+{
+	struct discovery_op *op = user_data;
+
+	queue_remove(op->pending_svcs, attr);
+}
+
 static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 				uint16_t start, uint16_t end,
 				discovery_op_complete_func_t complete_func,
@@ -365,6 +409,19 @@ static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 	op->end = end;
 	op->last = gatt_db_isempty(client->db) ? 0 : UINT16_MAX;
 
+	/* Load existing services as pending */
+	gatt_db_foreach_service_in_range(client->db, NULL,
+					 discovery_load_services, op,
+					 start, end);
+
+	/*
+	 * Services are only added when set active in which case they are no
+	 * longer pending so it is safe to remove either way.
+	 */
+	op->db_id = gatt_db_register(client->db, discovery_service_changed,
+						discovery_service_changed,
+						op, NULL);
+
 	return op;
 }
 
@@ -840,7 +897,9 @@ static void discovery_found_service(struct discovery_op *op,
 			op->svc_first = start;
 		if (op->svc_last < end)
 			op->svc_last = end;
-	}
+	} else
+		/* Remove from pending if active */
+		queue_remove(op->pending_svcs, attr);
 
 	/* Update last handle */
 	if (end > op->last)
@@ -916,6 +975,9 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 	}
 
 next:
+	if (queue_isempty(op->pending_svcs))
+		goto done;
+
 	client->discovery_req = bt_gatt_discover_included_services(client->att,
 							op->svc_first,
 							op->svc_last,
-- 
2.9.4

