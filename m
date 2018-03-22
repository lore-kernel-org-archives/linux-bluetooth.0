Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH BlueZ v2 1/3] shared/gatt-client: Fix removing services from pending list
Date: Thu, 22 Mar 2018 16:20:59 +0100
Message-Id: <20180322152101.9871-2-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <20180322152101.9871-1-andrzej.kaczmarek@codecoup.pl>
References: <20180322152101.9871-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should remove from pending list service which was just processed,
not the one that has just started being processed.
---
 src/shared/gatt-client.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index e1d489d32..f0850e0fe 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -591,10 +591,13 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 		/* Adjust current service */
 		svc = gatt_db_get_service(client->db, chrc_data->value_handle);
 		if (op->cur_svc != svc) {
-			queue_remove(op->pending_svcs, svc);
+			if (op->cur_svc) {
+				queue_remove(op->pending_svcs, op->cur_svc);
+
+				/* Done with the current service */
+				gatt_db_service_set_active(op->cur_svc, true);
+			}
 
-			/* Done with the current service */
-			gatt_db_service_set_active(op->cur_svc, true);
 			op->cur_svc = svc;
 		}
 
-- 
2.16.2

