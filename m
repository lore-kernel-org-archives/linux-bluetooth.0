Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix not clearing database after discovery
Date: Fri, 26 Feb 2016 15:21:39 +0200
Message-Id: <1456492899-23174-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The database cache needs to be in sync with discovery so once a discovery
complete handles after that last attribute found shall be cleared.
---
 src/shared/gatt-client.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 292e6ec..b255175 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -362,6 +362,7 @@ struct discovery_op {
 	bool success;
 	uint16_t start;
 	uint16_t end;
+	uint16_t last;
 	int ref_count;
 	discovery_op_complete_func_t complete_func;
 	discovery_op_fail_func_t failure_func;
@@ -375,6 +376,21 @@ static void discovery_op_free(struct discovery_op *op)
 	free(op);
 }
 
+static void discovery_op_complete(struct discovery_op *op, bool success,
+								uint8_t err)
+{
+	/* Reset remaining range */
+	if (success) {
+		if (op->last != UINT16_MAX)
+			gatt_db_clear_range(op->client->db, op->last + 1,
+								UINT16_MAX);
+	} else
+		gatt_db_clear(op->client->db);
+
+	op->success = success;
+	op->complete_func(op, success, err);
+}
+
 static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 				uint16_t start, uint16_t end,
 				discovery_op_complete_func_t complete_func,
@@ -550,8 +566,7 @@ next:
 	discovery_op_unref(op);
 
 failed:
-	op->success = false;
-	op->complete_func(op, false, att_ecode);
+	discovery_op_complete(op, false, att_ecode);
 }
 
 struct chrc {
@@ -725,8 +740,7 @@ failed:
 	success = false;
 
 done:
-	op->success = success;
-	op->complete_func(op, success, att_ecode);
+	discovery_op_complete(op, success, att_ecode);
 }
 
 static void discover_chrcs_cb(bool success, uint8_t att_ecode,
@@ -832,8 +846,7 @@ failed:
 	success = false;
 
 done:
-	op->success = success;
-	op->complete_func(op, success, att_ecode);
+	discovery_op_complete(op, success, att_ecode);
 }
 
 static void discover_secondary_cb(bool success, uint8_t att_ecode,
@@ -901,6 +914,10 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 		/* Skip if service already active */
 		if (!gatt_db_service_get_active(attr))
 			queue_push_tail(op->pending_svcs, attr);
+
+		/* Update last handle */
+		if (end > op->last)
+			op->last = end;
 	}
 
 next:
@@ -938,8 +955,7 @@ next:
 	discovery_op_unref(op);
 
 done:
-	op->success = success;
-	op->complete_func(op, success, att_ecode);
+	discovery_op_complete(op, success, att_ecode);
 }
 
 static void discover_primary_cb(bool success, uint8_t att_ecode,
@@ -1005,6 +1021,10 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 		/* Skip if service already active */
 		if (!gatt_db_service_get_active(attr))
 			queue_push_tail(op->pending_svcs, attr);
+
+		/* Update last handle */
+		if (end > op->last)
+			op->last = end;
 	}
 
 secondary:
@@ -1032,8 +1052,7 @@ secondary:
 	success = false;
 
 done:
-	op->success = success;
-	op->complete_func(op, success, att_ecode);
+	discovery_op_complete(op, success, att_ecode);
 }
 
 static void notify_client_ready(struct bt_gatt_client *client, bool success,
-- 
2.5.0

