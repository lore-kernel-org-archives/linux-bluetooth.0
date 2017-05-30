Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix removing services with no attributes
Date: Tue, 30 May 2017 14:45:39 +0300
Message-Id: <20170530114539.4441-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a service has no attributes, like IPSS, just mark it as active and
skip doing any attribute discover.
---
 src/shared/gatt-client.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index b8f70c8..58ab0b8 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -890,7 +890,11 @@ static void discovery_found_service(struct discovery_op *op,
 {
 	/* Skip if service already active */
 	if (!gatt_db_service_get_active(attr)) {
-		queue_push_tail(op->pending_svcs, attr);
+		/* Skip if there are no attributes */
+		if (end == start)
+			gatt_db_service_set_active(attr, true);
+		else
+			queue_push_tail(op->pending_svcs, attr);
 
 		/* Update discovery range */
 		if (!op->svc_first || op->svc_first > start)
-- 
2.9.4

