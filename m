Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 3/8] unit/gatt: Use source db for server_tests
Date: Tue,  9 Dec 2014 15:08:35 -0800
Message-Id: <1418166520-32993-4-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
References: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the passed-in gatt_db for server tests instead of populating
with the same db every time.
---
 unit/test-gatt.c | 70 +++++++++++++-------------------------------------------
 1 file changed, 16 insertions(+), 54 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index c23b4c4..336bd6e 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -450,42 +450,6 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 	context_quit(context);
 }
 
-static void populate_db(struct context *context)
-{
-	struct gatt_db *db = context->server_db;
-	struct gatt_db_attribute *attr;
-	bt_uuid_t uuid;
-	uint128_t u128 = {
-		.data = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-				0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f }
-	};
-
-	/* Service 1 */
-	bt_uuid16_create(&uuid, 0x1800);
-	attr = gatt_db_add_service(db, &uuid, true, 5);
-	gatt_db_service_set_active(attr, true);
-
-	/* Service 2 */
-	bt_uuid16_create(&uuid, 0x1801);
-	attr = gatt_db_add_service(db, &uuid, true, 3);
-	gatt_db_service_set_active(attr, true);
-
-	/* Service 3 */
-	bt_uuid16_create(&uuid, 0x180f);
-	attr = gatt_db_add_service(db, &uuid, false, 5);
-	gatt_db_service_set_active(attr, true);
-
-	/* Service 4 */
-	bt_uuid16_create(&uuid, 0x180d);
-	attr = gatt_db_add_service(db, &uuid, true, 8);
-	gatt_db_service_set_active(attr, true);
-
-	/* Service 5 */
-	bt_uuid128_create(&uuid, u128);
-	attr = gatt_db_add_service(db, &uuid, true, 1);
-	gatt_db_service_set_active(attr, true);
-}
-
 static struct context *create_context(uint16_t mtu, gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
@@ -514,15 +478,13 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 		bt_gatt_exchange_mtu(context->att, mtu, NULL, NULL, NULL);
 		break;
 	case SERVER:
-		context->server_db = gatt_db_new();
+		context->server_db = gatt_db_ref(test_data->source_db);
 		g_assert(context->server_db);
 
 		context->server = bt_gatt_server_new(context->server_db, att,
 									mtu);
 		g_assert(context->server);
 
-		populate_db(context);
-
 		if (g_test_verbose())
 			bt_gatt_server_set_debug(context->server, print_debug,
 						"bt_gatt_server:", NULL);
@@ -718,7 +680,7 @@ static struct gatt_db *make_service_data_1_db(void)
 	struct gatt_db_attribute *serv_att, *chrc_att;
 	bt_uuid_t uuid;
 
-	bt_string_to_uuid(&uuid, GATT_UUID);
+	bt_uuid16_create(&uuid, 0x1801);
 	serv_att = gatt_db_insert_service(db, 0x0001, &uuid, true, 4);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
@@ -727,7 +689,9 @@ static struct gatt_db *make_service_data_1_db(void)
 
 	add_user_description(chrc_att, "Device Name", false);
 
-	bt_string_to_uuid(&uuid, HEART_RATE_UUID);
+	gatt_db_service_set_active(serv_att, true);
+
+	bt_uuid16_create(&uuid, 0x180d);
 	serv_att = gatt_db_insert_service(db, 0x0005, &uuid, true, 4);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
@@ -738,6 +702,8 @@ static struct gatt_db *make_service_data_1_db(void)
 
 	add_user_description(chrc_att, "Manufacturer Name", false);
 
+	gatt_db_service_set_active(serv_att, true);
+
 	return db;
 }
 
@@ -978,8 +944,9 @@ int main(int argc, char *argv[])
 	define_test_client("/TP/GAC/CL/BV-01-C", test_client, NULL, NULL,
 						raw_pdu(0x02, 0x00, 0x02));
 
-	define_test_server("/TP/GAC/SR/BV-01-C", test_server, NULL, NULL,
-						raw_pdu(0x03, 0x00, 0x02));
+	define_test_server("/TP/GAC/SR/BV-01-C", test_server, service_db_1,
+					NULL,
+					raw_pdu(0x03, 0x00, 0x02));
 
 	/*
 	 * Discovery
@@ -1002,19 +969,14 @@ int main(int argc, char *argv[])
 			raw_pdu(0x10, 0x97, 0x00, 0xff, 0xff, 0x00, 0x28),
 			raw_pdu(0x01, 0x10, 0x97, 0x00, 0x0a));
 
-	define_test_server("/TP/GAD/SR/BV-01-C", test_server, NULL, NULL,
+	define_test_server("/TP/GAD/SR/BV-01-C", test_server, service_db_1,
+			NULL,
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
-			raw_pdu(0x11, 0x06, 0x01, 0x00, 0x05, 0x00, 0x00, 0x18,
-					0x06, 0x00, 0x08, 0x00, 0x01, 0x18,
-					0x0e, 0x00, 0x15, 0x00, 0x0d, 0x18),
-			raw_pdu(0x10, 0x16, 0x00, 0xff, 0xff, 0x00, 0x28),
-			raw_pdu(0x11, 0x14, 0x16, 0x00, 0x16, 0x00, 0x0f,
-					0x0e, 0x0d, 0x0c, 0x0b, 0x0a, 0x09,
-					0x08, 0x07, 0x06, 0x05, 0x04, 0x03,
-					0x02, 0x01, 0x00),
-			raw_pdu(0x10, 0x17, 0x00, 0xff, 0xff, 0x00, 0x28),
-			raw_pdu(0x01, 0x10, 0x17, 0x00, 0x0a));
+			raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x01, 0x18,
+					0x05, 0x00, 0x08, 0x00, 0x0d, 0x18),
+			raw_pdu(0x10, 0x06, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x01, 0x10, 0x06, 0x00, 0x0a));
 
 	define_test_att("/TP/GAD/CL/BV-02-C-1", test_search_primary, &uuid_16,
 			NULL,
-- 
2.2.0.rc0.207.ga3a616c

