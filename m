Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/gatt-client: Validate cached services
Date: Tue,  2 May 2017 10:28:31 +0200
Message-Id: <1493713711-26061-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1493713711-26061-1-git-send-email-marcin.kraglak@tieto.com>
References: <1493713711-26061-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove services that were not found in current discovery.
---
 src/shared/gatt-client.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 0134721..ce19e38 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -920,6 +920,72 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
+struct validate_svc_data {
+	struct bt_gatt_result *result;
+	uint16_t start, end;
+	bool primary;
+};
+
+static bool validate_svc_cb(struct gatt_db_attribute *attrib,
+							void *user_data)
+{
+	struct validate_svc_data *data = user_data;
+	uint16_t service_start_h, service_end_h;
+	struct bt_gatt_iter iter;
+	bt_uuid_t service_uuid;
+	uint128_t u128;
+	bool primary;
+
+	gatt_db_attribute_get_service_data(attrib, &service_start_h,
+						&service_end_h, &primary,
+						&service_uuid);
+
+	if (primary != data->primary)
+		return false;
+
+	if (data->start > service_start_h || data->end < service_start_h)
+		return false;
+
+	if (data->result) {
+		uint16_t start_h, end_h;
+
+		bt_gatt_iter_init(&iter, data->result);
+
+		while (bt_gatt_iter_next_service(&iter, &start_h, &end_h,
+								u128.data)) {
+			bt_uuid_t uuid;
+
+			if (start_h != service_start_h)
+				continue;
+
+			if (end_h != service_end_h)
+				continue;
+
+			bt_uuid128_create(&uuid, u128);
+			if (bt_uuid_cmp(&uuid, &service_uuid))
+				continue;
+
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static void validate_services(struct gatt_db *db, uint16_t start,
+					uint16_t end, bool primary,
+					struct bt_gatt_result *result)
+{
+	struct validate_svc_data data = {
+		.start = start,
+		.end = end,
+		.primary = primary,
+		.result = result,
+	};
+
+	gatt_db_remove_services(db, validate_svc_cb, &data);
+}
+
 static void discover_secondary_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -939,6 +1005,9 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 		util_debug(client->debug_callback, client->debug_data,
 					"Secondary service discovery failed."
 					" ATT ECODE: 0x%02x", att_ecode);
+
+		validate_services(client->db, op->start, op->end, false, NULL);
+
 		switch (att_ecode) {
 		case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
 		case BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE:
@@ -957,6 +1026,8 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 					"Secondary services found: %u",
 					bt_gatt_result_service_count(result));
 
+	validate_services(client->db, op->start, op->end, false, result);
+
 	while (bt_gatt_iter_next_service(&iter, &start, &end, u128.data)) {
 		bt_uuid128_create(&uuid, u128);
 
@@ -1051,6 +1122,9 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 		util_debug(client->debug_callback, client->debug_data,
 					"Primary service discovery failed."
 					" ATT ECODE: 0x%02x", att_ecode);
+
+		validate_services(client->db, op->start, op->end, true, NULL);
+
 		/* Reset error in case of not found */
 		switch (att_ecode) {
 		case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
@@ -1071,6 +1145,8 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 					"Primary services found: %u",
 					bt_gatt_result_service_count(result));
 
+	validate_services(client->db, op->start, op->end, true, result);
+
 	while (bt_gatt_iter_next_service(&iter, &start, &end, u128.data)) {
 		bt_uuid128_create(&uuid, u128);
 
-- 
2.4.3

