Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 3/3] shared/gatt-client: Fix searching secondary services
Date: Wed, 10 May 2017 21:41:37 +0200
Message-Id: <1494445297-11552-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1494445297-11552-1-git-send-email-marcin.kraglak@tieto.com>
References: <1494445297-11552-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Search secondary services if there is any cached primary service.
---
 src/shared/gatt-client.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index a919d32..fe9aaeb 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1054,6 +1054,18 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
+static void count_primary_services_cb(struct gatt_db_attribute *attrib,
+							void *user_data)
+{
+	uint16_t *service_count = (uint16_t *) user_data;
+	bool primary = false;
+
+	gatt_db_attribute_get_service_data(attrib, NULL, NULL, &primary, NULL);
+
+	if (primary)
+		(*service_count)++;
+}
+
 static void discover_primary_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -1063,6 +1075,7 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 	struct bt_gatt_iter iter;
 	struct gatt_db_attribute *attr;
 	uint16_t start, end;
+	uint16_t primary_service_count = 0;
 	uint128_t u128;
 	bt_uuid_t uuid;
 	char uuid_str[MAX_LEN_UUID_STR];
@@ -1137,7 +1150,10 @@ secondary:
 	 * functionality of a device and is referenced from at least one
 	 * primary service on the device.
 	 */
-	if (queue_isempty(op->pending_svcs))
+	gatt_db_foreach_service(client->db, NULL, count_primary_services_cb,
+						&primary_service_count);
+
+	if (primary_service_count == 0)
 		goto done;
 
 	/* Discover secondary services */
-- 
2.4.3

