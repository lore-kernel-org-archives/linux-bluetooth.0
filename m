Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 2/2] shared/gatt-client: Validate cached services
Date: Wed, 10 May 2017 20:29:17 +0200
Message-Id: <1494440957-6844-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1494440957-6844-1-git-send-email-marcin.kraglak@tieto.com>
References: <1494440957-6844-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove services that were not found in current discovery.
---
 src/shared/gatt-client.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 0134721..a919d32 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -316,6 +316,7 @@ struct discovery_op {
 	struct queue *pending_svcs;
 	struct queue *pending_chrcs;
 	struct queue *svcs;
+	struct queue *found_svcs;
 	struct queue *ext_prop_desc;
 	struct gatt_db_attribute *cur_svc;
 	bool success;
@@ -332,13 +333,31 @@ static void discovery_op_free(struct discovery_op *op)
 	queue_destroy(op->pending_svcs, NULL);
 	queue_destroy(op->pending_chrcs, free);
 	queue_destroy(op->svcs, NULL);
+	queue_destroy(op->found_svcs, NULL);
 	queue_destroy(op->ext_prop_desc, NULL);
 	free(op);
 }
 
+static bool validate_svc_cb(struct gatt_db_attribute *attrib, void *user_data)
+{
+	struct discovery_op *op = user_data;
+	uint16_t start_h;
+
+	gatt_db_attribute_get_service_data(attrib, &start_h, NULL, NULL, NULL);
+
+	if (op->start > start_h || op->end < start_h)
+		return false;
+
+	return (queue_find(op->found_svcs, NULL, attrib) == NULL);
+}
+
 static void discovery_op_complete(struct discovery_op *op, bool success,
 								uint8_t err)
 {
+	struct bt_gatt_client *client = op->client;
+
+	gatt_db_remove_services(client->db, validate_svc_cb, op);
+
 	/* Reset remaining range */
 	if (op->last != UINT16_MAX)
 		gatt_db_clear_range(op->client->db, op->last + 1, UINT16_MAX);
@@ -358,6 +377,7 @@ static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 	op->pending_svcs = queue_new();
 	op->pending_chrcs = queue_new();
 	op->svcs = queue_new();
+	op->found_svcs = queue_new();
 	op->ext_prop_desc = queue_new();
 	op->client = client;
 	op->complete_func = complete_func;
@@ -988,6 +1008,8 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 		if (!gatt_db_service_get_active(attr))
 			queue_push_tail(op->pending_svcs, attr);
 
+		queue_push_tail(op->found_svcs, attr);
+
 		/* Update last handle */
 		if (end > op->last)
 			op->last = end;
@@ -1101,6 +1123,8 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 		if (!gatt_db_service_get_active(attr))
 			queue_push_tail(op->pending_svcs, attr);
 
+		queue_push_tail(op->found_svcs, attr);
+
 		/* Update last handle */
 		if (end > op->last)
 			op->last = end;
-- 
2.4.3

