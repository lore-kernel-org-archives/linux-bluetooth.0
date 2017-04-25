Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/gatt-client: Remove services after Service Changed indication
Date: Tue, 25 Apr 2017 13:56:10 +0200
Message-Id: <1493121371-29377-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Clear services in range of Service Changed indication.
>From specification, Version 4.2 [Vol 3, Part G] 2.5.2 Attribute Caching:
"The client, upon receiving a Handle Value Indication containing the range of
affected Attribute Handles, shall consider the attribute cache invalid over
the affected Attribute Handle range".
---
 src/shared/gatt-client.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 0134721..7d23702 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1475,8 +1475,6 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 		util_debug(client->debug_callback, client->debug_data,
 			"Failed to discover services within changed range - "
 			"error: 0x%02x", att_ecode);
-
-		gatt_db_clear_range(client->db, start_handle, end_handle);
 	}
 
 	/* Notify the upper layer of changed services */
@@ -1514,7 +1512,8 @@ static void service_changed_failure(struct discovery_op *op)
 {
 	struct bt_gatt_client *client = op->client;
 
-	gatt_db_clear_range(client->db, op->start, op->end);
+	util_debug(client->debug_callback, client->debug_data,
+					"Failed to process Service Changed");
 }
 
 static void process_service_changed(struct bt_gatt_client *client,
@@ -1523,6 +1522,8 @@ static void process_service_changed(struct bt_gatt_client *client,
 {
 	struct discovery_op *op;
 
+	gatt_db_clear_range(client->db, start_handle, end_handle);
+
 	op = discovery_op_create(client, start_handle, end_handle,
 						service_changed_complete,
 						service_changed_failure);
-- 
2.4.3

