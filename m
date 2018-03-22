Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH BlueZ v2 3/3] shared/gatt-client: Fix tracking current service during discovery
Date: Thu, 22 Mar 2018 16:21:01 +0100
Message-Id: <20180322152101.9871-4-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <20180322152101.9871-1-andrzej.kaczmarek@codecoup.pl>
References: <20180322152101.9871-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should mark service as completed before trying to insert another
characteristic - in case inserting characteristic for new service
fails, previous one won't be discarded.
---
 src/shared/gatt-client.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index b7cf91820..5721f3e5c 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -588,6 +588,19 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 		struct gatt_db_attribute *svc;
 		uint16_t start, end;
 
+		/* Adjust current service */
+		svc = gatt_db_get_service(client->db, chrc_data->value_handle);
+		if (op->cur_svc != svc) {
+			if (op->cur_svc) {
+				queue_remove(op->pending_svcs, op->cur_svc);
+
+				/* Done with the current service */
+				gatt_db_service_set_active(op->cur_svc, true);
+			}
+
+			op->cur_svc = svc;
+		}
+
 		attr = gatt_db_insert_characteristic(client->db,
 							chrc_data->value_handle,
 							&chrc_data->uuid, 0,
@@ -605,19 +618,6 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 							chrc_data->value_handle)
 			goto failed;
 
-		/* Adjust current service */
-		svc = gatt_db_get_service(client->db, chrc_data->value_handle);
-		if (op->cur_svc != svc) {
-			if (op->cur_svc) {
-				queue_remove(op->pending_svcs, op->cur_svc);
-
-				/* Done with the current service */
-				gatt_db_service_set_active(op->cur_svc, true);
-			}
-
-			op->cur_svc = svc;
-		}
-
 		gatt_db_attribute_get_service_handles(svc, &start, &end);
 
 		/*
-- 
2.16.2

