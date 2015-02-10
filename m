Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 6/8] unit/gatt: Add TP/GAI/SR/BV-01-C test
Date: Tue, 10 Feb 2015 12:16:22 -0800
Message-Id: <1423599385-36295-7-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
References: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile server can send a Characteristic
Value Indication.
---
 unit/test-gatt.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 520b546..c45ff3d 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -206,7 +206,7 @@ struct context {
 		raw_pdu(0x08, 0x17, 0xf0, 0x17, 0xf0, 0x03, 0x28),	\
 		raw_pdu(0x01, 0x08, 0x17, 0xf0, 0x0a),			\
 		raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x03, 0x28),	\
-		raw_pdu(0x09, 0x07, 0x02, 0x00, 0x12, 0x03, 0x00, 0x29,	\
+		raw_pdu(0x09, 0x07, 0x02, 0x00, 0x32, 0x03, 0x00, 0x29,	\
 			0x2a),						\
 		raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x03, 0x28),	\
 		raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a)
@@ -966,7 +966,8 @@ static struct gatt_db *make_test_spec_small_db(void)
 		CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
 						BT_ATT_PERM_READ,
 						BT_GATT_CHRC_PROP_READ |
-						BT_GATT_CHRC_PROP_NOTIFY,
+						BT_GATT_CHRC_PROP_NOTIFY |
+						BT_GATT_CHRC_PROP_INDICATE,
 						"BlueZ"),
 		DESCRIPTOR(GATT_CLIENT_CHARAC_CFG_UUID, BT_ATT_PERM_READ |
 						BT_ATT_PERM_WRITE, 0x00, 0x00),
@@ -1630,6 +1631,40 @@ static const struct test_step test_notification_server_1 = {
 	.length = 0x03,
 };
 
+static uint8_t indication_received;
+
+static void test_indication_cb(void *user_data)
+{
+	struct context *context = user_data;
+
+	indication_received = 1;
+
+	context_quit(context);
+}
+
+static void test_server_indication_confirm(struct context *context)
+{
+	g_assert(indication_received == 1);
+}
+
+static void test_server_indication(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+
+	bt_gatt_server_send_indication(context->server, step->handle,
+						step->value, step->length,
+						test_indication_cb,
+						context, NULL);
+}
+
+static const struct test_step test_indication_server_1 = {
+	.handle = 0x0003,
+	.func = test_server_indication,
+	.post_func = test_server_indication_confirm,
+	.value = read_data_1,
+	.length = 0x03,
+};
+
 int main(int argc, char *argv[])
 {
 	struct gatt_db *service_db_1, *ts_small_db, *ts_large_db_1;
@@ -1860,7 +1895,7 @@ int main(int argc, char *argv[])
 			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x08, 0x01, 0x00, 0x0f, 0x00, 0x03, 0x28),
-			raw_pdu(0x09, 0x07, 0x02, 0x00, 0x12, 0x03, 0x00, 0x29,
+			raw_pdu(0x09, 0x07, 0x02, 0x00, 0x32, 0x03, 0x00, 0x29,
 					0x2a),
 			raw_pdu(0x08, 0x03, 0x00, 0x0f, 0x00, 0x03, 0x28),
 			raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a));
@@ -1913,7 +1948,7 @@ int main(int argc, char *argv[])
 			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x08, 0x01, 0x00, 0x0f, 0x00, 0x03, 0x28),
-			raw_pdu(0x09, 0x07, 0x02, 0x00, 0x12, 0x03, 0x00, 0x29,
+			raw_pdu(0x09, 0x07, 0x02, 0x00, 0x32, 0x03, 0x00, 0x29,
 					0x2a),
 			raw_pdu(0x08, 0x03, 0x00, 0x0f, 0x00, 0x03, 0x28),
 			raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a));
@@ -2493,7 +2528,7 @@ int main(int argc, char *argv[])
 			&test_notification_1,
 			MTU_EXCHANGE_CLIENT_PDUS,
 			SMALL_DB_DISCOVERY_PDUS,
-			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x00),
+			raw_pdu(0x12, 0x04, 0x00, 0x03, 0x00),
 			raw_pdu(0x13),
 			raw_pdu(),
 			raw_pdu(0x1B, 0x03, 0x00, 0x01, 0x02, 0x03));
@@ -2506,5 +2541,14 @@ int main(int argc, char *argv[])
 			raw_pdu(),
 			raw_pdu(0x1B, 0x03, 0x00, 0x01, 0x02, 0x03));
 
+	define_test_server("/TP/GAI/SR/BV-01-C", test_server, ts_small_db,
+			&test_indication_server_1,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x04, 0x00, 0x02, 0x00),
+			raw_pdu(0x13),
+			raw_pdu(),
+			raw_pdu(0x1D, 0x03, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x1E));
+
 	return g_test_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

