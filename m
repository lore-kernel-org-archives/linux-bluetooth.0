Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] shared/gatt-client: Rename tmp_queue to svcs
Date: Mon, 15 Feb 2016 14:30:39 +0200
Message-Id: <1455539442-31843-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1455539442-31843-1-git-send-email-luiz.dentz@gmail.com>
References: <1455539442-31843-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The tmp_queue in fact store the processed services so just rename it to
svcs and stop creating extra variables for that.
---
 src/shared/gatt-client.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 8486b09..4c563c2 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -357,7 +357,7 @@ struct discovery_op {
 	struct bt_gatt_client *client;
 	struct queue *pending_svcs;
 	struct queue *pending_chrcs;
-	struct queue *tmp_queue;
+	struct queue *svcs;
 	struct gatt_db_attribute *cur_svc;
 	bool success;
 	uint16_t start;
@@ -371,7 +371,7 @@ static void discovery_op_free(struct discovery_op *op)
 {
 	queue_destroy(op->pending_svcs, NULL);
 	queue_destroy(op->pending_chrcs, free);
-	queue_destroy(op->tmp_queue, NULL);
+	queue_destroy(op->svcs, NULL);
 	free(op);
 }
 
@@ -385,7 +385,7 @@ static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 	op = new0(struct discovery_op, 1);
 	op->pending_svcs = queue_new();
 	op->pending_chrcs = queue_new();
-	op->tmp_queue = queue_new();
+	op->svcs = queue_new();
 	op->client = client;
 	op->complete_func = complete_func;
 	op->failure_func = failure_func;
@@ -501,17 +501,11 @@ next:
 	/* Move on to the next service */
 	attr = queue_pop_head(op->pending_svcs);
 	if (!attr) {
-		struct queue *tmp_queue;
-
-		tmp_queue = op->pending_svcs;
-		op->pending_svcs = op->tmp_queue;
-		op->tmp_queue = tmp_queue;
-
 		/*
 		 * We have processed all include definitions. Move on to
 		 * characteristics.
 		 */
-		attr = queue_pop_head(op->pending_svcs);
+		attr = queue_pop_head(op->svcs);
 		if (!attr)
 			goto failed;
 
@@ -535,7 +529,7 @@ next:
 		goto failed;
 	}
 
-	queue_push_tail(op->tmp_queue, attr);
+	queue_push_tail(op->svcs, attr);
 	op->cur_svc = attr;
 	if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
 		goto failed;
@@ -920,10 +914,10 @@ next:
 	}
 
 	/*
-	 * Store the service in the tmp queue to be reused during
+	 * Store the service in the svcs queue to be reused during
 	 * characteristics discovery later.
 	 */
-	queue_push_tail(op->tmp_queue, attr);
+	queue_push_tail(op->svcs, attr);
 	op->cur_svc = attr;
 
 	if (!gatt_db_attribute_get_service_handles(attr, &start, &end)) {
-- 
2.5.0

