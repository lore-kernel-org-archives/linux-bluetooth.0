Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH Bluez v1 2/2] unit/test-gatt: Add /TP/GAD/SR/BV-01-C test case.
Date: Fri, 21 Nov 2014 15:31:40 -0800
Message-Id: <1416612700-10283-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1416612700-10283-1-git-send-email-armansito@chromium.org>
References: <1416612700-10283-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added discovery test case /TP/GAD/SR/BV-01-C for bt_gatt_server.
---
 unit/test-gatt.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index d3fb4a0..ab73ccb 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -431,6 +431,42 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 	context_quit(context);
 }
 
+static void populate_db(struct context *context)
+{
+	struct gatt_db *db = context->db;
+	struct gatt_db_attribute *attr;
+	bt_uuid_t uuid;
+	uint128_t u128 = {
+		.data = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+				0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f }
+	};
+
+	/* Service 1 */
+	bt_uuid16_create(&uuid, 0x1800);
+	attr = gatt_db_add_service(db, &uuid, true, 5);
+	gatt_db_service_set_active(attr, true);
+
+	/* Service 2 */
+	bt_uuid16_create(&uuid, 0x1801);
+	attr = gatt_db_add_service(db, &uuid, true, 3);
+	gatt_db_service_set_active(attr, true);
+
+	/* Service 3 */
+	bt_uuid16_create(&uuid, 0x180f);
+	attr = gatt_db_add_service(db, &uuid, false, 5);
+	gatt_db_service_set_active(attr, true);
+
+	/* Service 4 */
+	bt_uuid16_create(&uuid, 0x180d);
+	attr = gatt_db_add_service(db, &uuid, true, 8);
+	gatt_db_service_set_active(attr, true);
+
+	/* Service 5 */
+	bt_uuid128_create(&uuid, u128);
+	attr = gatt_db_add_service(db, &uuid, true, 1);
+	gatt_db_service_set_active(attr, true);
+}
+
 static struct context *create_context(uint16_t mtu, gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
@@ -465,6 +501,8 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 		context->server = bt_gatt_server_new(context->db, att, mtu);
 		g_assert(context->server);
 
+		populate_db(context);
+
 		if (g_test_verbose())
 			bt_gatt_server_set_debug(context->server, print_debug,
 						"bt_gatt_server:", NULL);
@@ -852,6 +890,20 @@ int main(int argc, char *argv[])
 			raw_pdu(0x10, 0x97, 0x00, 0xff, 0xff, 0x00, 0x28),
 			raw_pdu(0x01, 0x10, 0x97, 0x00, 0x0a));
 
+	define_test_server("/TP/GAD/SR/BV-01-C", test_server, NULL, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x06, 0x01, 0x00, 0x05, 0x00, 0x00, 0x18,
+					0x06, 0x00, 0x08, 0x00, 0x01, 0x18,
+					0x0e, 0x00, 0x15, 0x00, 0x0d, 0x18),
+			raw_pdu(0x10, 0x16, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x14, 0x16, 0x00, 0x16, 0x00, 0x0f,
+					0x0e, 0x0d, 0x0c, 0x0b, 0x0a, 0x09,
+					0x08, 0x07, 0x06, 0x05, 0x04, 0x03,
+					0x02, 0x01, 0x00),
+			raw_pdu(0x10, 0x17, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x01, 0x10, 0x17, 0x00, 0x0a));
+
 	define_test_att("/TP/GAD/CL/BV-02-C-1", test_search_primary, &uuid_16,
 			NULL,
 			raw_pdu(0x02, 0x00, 0x02),
-- 
2.1.0.rc2.206.gedb03e5

