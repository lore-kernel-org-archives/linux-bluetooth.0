Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/gatt: Fix searching primary services by uuids
Date: Tue, 15 Jul 2014 12:54:52 +0200
Message-Id: <1405421694-13466-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Return all instances of services. It is needed to by PTS test case
TC_GAD_CL_BV_01_C. Upper tester should receive all instances of service.
---
 android/gatt.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 986f435..0aa71ad 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1136,28 +1136,28 @@ static void discover_srvc_by_uuid_cb(uint8_t status, GSList *ranges,
 	}
 
 	bt_uuid_to_string(&cb_data->uuid, prim.uuid, sizeof(prim.uuid));
-	/*
-	 * If multiple instances of the same service (as identified by UUID)
-	 * exist, the first instance of the service is returned.
-	 */
-	memcpy(&prim.range, ranges->data, sizeof(prim.range));
 
-	s = create_service(instance_id++, true, prim.uuid, &prim);
-	if (!s) {
-		gatt_status = GATT_FAILURE;
-		goto reply;
-	}
+	for (; ranges; ranges = ranges->next) {
+		memcpy(&prim.range, ranges->data, sizeof(prim.range));
 
-	if (!queue_push_tail(dev->services, s)) {
-		error("gatt: Cannot push primary service to the list");
-		gatt_status = GATT_FAILURE;
-		goto reply;
-	}
+		s = create_service(instance_id++, true, prim.uuid, &prim);
+		if (!s) {
+			gatt_status = GATT_FAILURE;
+			goto reply;
+		}
+
+		if (!queue_push_tail(dev->services, s)) {
+			error("gatt: Cannot push primary service to the list");
+			destroy_service(s);
+			gatt_status = GATT_FAILURE;
+			goto reply;
+		}
 
-	send_client_primary_notify(s, INT_TO_PTR(cb_data->conn->id));
+		send_client_primary_notify(s, INT_TO_PTR(cb_data->conn->id));
 
-	DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
-		prim.range.start, prim.range.end, prim.uuid);
+		DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
+				prim.range.start, prim.range.end, prim.uuid);
+	}
 
 	/* Partial search service scanning was performed */
 	dev->partial_srvc_search = true;
-- 
1.9.0

