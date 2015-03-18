Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] unit/test-gatt: Add /TP/GAD/CL/BV-06-C/client-3 test
Date: Wed, 18 Mar 2015 23:04:50 +0200
Message-Id: <1426712691-5048-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426712691-5048-1-git-send-email-luiz.dentz@gmail.com>
References: <1426712691-5048-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This verify the code is able to parse services with different gaps
between handles.
---
 unit/test-gatt.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 7bc2d25..d510f51 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -178,6 +178,36 @@ struct context {
 		raw_pdu(0x04, 0x09, 0x00, 0x0a, 0x00),			\
 		raw_pdu(0x05, 0x01, 0x0a, 0x00, 0x01, 0x29)
 
+#define SERVICE_DATA_3_PDUS						\
+		MTU_EXCHANGE_CLIENT_PDUS,				\
+		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
+		raw_pdu(0x11, 0x06, 0x00, 0x01, 0x21, 0x01, 0x00, 0x18, \
+			0x00, 0x02, 0x00, 0x02, 0x01, 0x18),		\
+		raw_pdu(0x10, 0x01, 0x02, 0xff, 0xff, 0x00, 0x28),	\
+		raw_pdu(0x11, 0x06, 0x00, 0x03, 0x20, 0x03, 0x0d, 0x18),\
+		raw_pdu(0x10, 0x21, 0x03, 0xff, 0xff, 0x00, 0x28),	\
+		raw_pdu(0x01, 0x10, 0x21, 0x03, 0x0a),			\
+		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),	\
+		raw_pdu(0x01, 0x10, 0x01, 0x00, 0x0a),			\
+		raw_pdu(0x08, 0x00, 0x01, 0x21, 0x01, 0x02, 0x28),	\
+		raw_pdu(0x01, 0x08, 0x00, 0x01, 0x0a),			\
+		raw_pdu(0x08, 0x00, 0x03, 0x20, 0x03, 0x02, 0x28),	\
+		raw_pdu(0x01, 0x08, 0x00, 0x03, 0x0a),			\
+		raw_pdu(0x08, 0x00, 0x01, 0x21, 0x01, 0x03, 0x28),	\
+		raw_pdu(0x09, 0x07, 0x10, 0x01, 0x02, 0x11, 0x01, 0x00,	\
+			0x2a, 0x20, 0x01, 0x02, 0x21, 0x01, 0x01, 0x2a),\
+		raw_pdu(0x08, 0x21, 0x01, 0x21, 0x01, 0x03, 0x28),	\
+		raw_pdu(0x01, 0x08, 0x21, 0x01, 0x0a),			\
+		raw_pdu(0x04, 0x12, 0x01, 0x1f, 0x01),			\
+		raw_pdu(0x01, 0x04, 0x12, 0x01, 0x0a),			\
+		raw_pdu(0x08, 0x00, 0x03, 0x20, 0x03, 0x03, 0x28),	\
+		raw_pdu(0x09, 0x07, 0x10, 0x03, 0x0a, 0x11, 0x03, 0x29,	\
+			0x2a),						\
+		raw_pdu(0x08, 0x11, 0x03, 0x20, 0x03, 0x03, 0x28),	\
+		raw_pdu(0x01, 0x08, 0x11, 0x03, 0x0a),			\
+		raw_pdu(0x04, 0x12, 0x03, 0x20, 0x03),			\
+		raw_pdu(0x01, 0x04, 0x12, 0x03, 0x0a)			\
+
 #define PRIMARY_DISC_SMALL_DB						\
 		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
 		raw_pdu(0x11, 0x06, 0x10, 0xF0, 0x17, 0xF0, 0x00, 0x18,	\
@@ -1256,6 +1286,42 @@ static struct gatt_db *make_service_data_2_db(void)
 	return make_db(specs);
 }
 
+#define CHARACTERISTIC_AT(chr_handle, chr_uuid, permissions, properties, \
+							bytes...)	\
+	{								\
+		.valid = true,						\
+		.handle = chr_handle,					\
+		.type = CHARACTERISTIC,					\
+		.uuid = STR(chr_uuid),					\
+		.att_permissions = permissions,				\
+		.char_properties = properties,				\
+		.value = data(bytes),					\
+		.len = sizeof(data(bytes)),				\
+	}
+
+static struct gatt_db *make_service_data_3_db(void)
+{
+	const struct att_handle_spec specs[] = {
+		PRIMARY_SERVICE(0x0100, GAP_UUID, 0x0121 - 0x0100 + 1),
+		CHARACTERISTIC_STR_AT(0x0111, GATT_CHARAC_DEVICE_NAME,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ, "BlueZ"),
+		CHARACTERISTIC_AT(0x0121, GATT_CHARAC_APPEARANCE,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ, 0x00, 0x00),
+		PRIMARY_SERVICE(0x0200, GATT_UUID, 0x0200 - 0x0200 + 1),
+		PRIMARY_SERVICE(0x0300, HEART_RATE_UUID, 0x0320 - 0x0300 + 1),
+		CHARACTERISTIC_STR_AT(0x0311,
+					GATT_CHARAC_MANUFACTURER_NAME_STRING,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ |
+					BT_GATT_CHRC_PROP_WRITE, ""),
+		{ }
+	};
+
+	return make_db(specs);
+}
+
 /*
  * Defined Test database 1:
  * Tiny database fits into a single minimum sized-pdu.
@@ -2049,13 +2115,14 @@ static const struct test_step test_indication_server_1 = {
 
 int main(int argc, char *argv[])
 {
-	struct gatt_db *service_db_1, *service_db_2;
+	struct gatt_db *service_db_1, *service_db_2, *service_db_3;
 	struct gatt_db *ts_small_db, *ts_large_db_1;
 
 	tester_init(&argc, &argv);
 
 	service_db_1 = make_service_data_1_db();
 	service_db_2 = make_service_data_2_db();
+	service_db_3 = make_service_data_3_db();
 	ts_small_db = make_test_spec_small_db();
 	ts_large_db_1 = make_test_spec_large_db_1();
 
@@ -2367,6 +2434,10 @@ int main(int argc, char *argv[])
 			service_db_2, NULL,
 			SERVICE_DATA_2_PDUS);
 
+	define_test_client("/TP/GAD/CL/BV-06-C/client-3", test_client,
+			service_db_3, NULL,
+			SERVICE_DATA_3_PDUS);
+
 	define_test_server("/TP/GAD/SR/BV-06-C/small", test_server,
 			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
2.1.0

