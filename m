Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] shared/gatt-client: Don't clear db in case of errors
Date: Thu,  1 Dec 2016 22:40:30 +0200
Message-Id: <20161201204030.27626-3-luiz.dentz@gmail.com>
In-Reply-To: <20161201204030.27626-1-luiz.dentz@gmail.com>
References: <20161201204030.27626-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the db was not empty when initializing the instance set the
discovery last handle to avoid clearing the database in case of
cache validation error.
---
 src/shared/gatt-client.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index c4102dd..e133bbc 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -340,12 +340,8 @@ static void discovery_op_complete(struct discovery_op *op, bool success,
 								uint8_t err)
 {
 	/* Reset remaining range */
-	if (success) {
-		if (op->last != UINT16_MAX)
-			gatt_db_clear_range(op->client->db, op->last + 1,
-								UINT16_MAX);
-	} else
-		gatt_db_clear(op->client->db);
+	if (op->last != UINT16_MAX)
+		gatt_db_clear_range(op->client->db, op->last + 1, UINT16_MAX);
 
 	op->success = success;
 	op->complete_func(op, success, err);
@@ -368,6 +364,7 @@ static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 	op->failure_func = failure_func;
 	op->start = start;
 	op->end = end;
+	op->last = gatt_db_isempty(client->db) ? 0 : UINT16_MAX;
 
 	return op;
 }
@@ -386,7 +383,7 @@ static void discovery_op_unref(void *data)
 	if (__sync_sub_and_fetch(&op->ref_count, 1))
 		return;
 
-	if (!op->success)
+	if (!op->success && op->failure_func)
 		op->failure_func(op);
 
 	discovery_op_free(op);
@@ -1605,13 +1602,6 @@ done:
 	notify_client_ready(client, success, att_ecode);
 }
 
-static void init_fail(struct discovery_op *op)
-{
-	struct bt_gatt_client *client = op->client;
-
-	gatt_db_clear(client->db);
-}
-
 static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 {
 	struct discovery_op *op;
@@ -1619,8 +1609,7 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 	if (client->in_init || client->ready)
 		return false;
 
-	op = discovery_op_create(client, 0x0001, 0xffff, init_complete,
-								init_fail);
+	op = discovery_op_create(client, 0x0001, 0xffff, init_complete, NULL);
 	if (!op)
 		return false;
 
-- 
2.9.3

