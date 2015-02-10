Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 1/8] gatt-client: skip discovery with no handles
Date: Tue, 10 Feb 2015 12:16:17 -0800
Message-Id: <1423599385-36295-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
References: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there are no handles in a defined service, it is not useful to try to
discover anything in it, just go to the next service.
---
 src/shared/gatt-client.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index d0fc054..bfb9427 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -525,6 +525,9 @@ next:
 	if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
 		goto failed;
 
+	if (start == end)
+		goto next;
+
 	if (bt_gatt_discover_included_services(client->att, start, end,
 							discover_incl_cb,
 							discovery_op_ref(op),
@@ -675,6 +678,9 @@ next:
 	if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
 		goto failed;
 
+	if (start == end)
+		goto next;
+
 	/* Move on to the next service */
 	op->cur_svc = attr;
 	if (bt_gatt_discover_characteristics(client->att, start, end,
@@ -776,6 +782,9 @@ next:
 	if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
 		goto failed;
 
+	if (start == end)
+		goto next;
+
 	/* Move on to the next service */
 	op->cur_svc = attr;
 	if (bt_gatt_discover_characteristics(client->att, start, end,
-- 
2.2.0.rc0.207.ga3a616c

