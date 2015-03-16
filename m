Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] unit/test-gatt: Add /TP/GAD/CL/BV-06-C/client-2 test
Date: Mon, 16 Mar 2015 12:32:32 +0200
Message-Id: <1426501952-26670-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426501952-26670-1-git-send-email-luiz.dentz@gmail.com>
References: <1426501952-26670-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This veryfy we the code is able to parse services with gaps between
handles.
---
 unit/test-gatt.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 109 insertions(+), 15 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 33d4b9f..7bc2d25 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -149,6 +149,35 @@ struct context {
 		raw_pdu(0x04, 0x08, 0x00, 0x08, 0x00),			\
 		raw_pdu(0x05, 0x01, 0x08, 0x00, 0x01, 0x29)
 
+#define SERVICE_DATA_2_PDUS						\
+		MTU_EXCHANGE_CLIENT_PDUS,				\
+		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
+		raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x01, 0x18),\
+		raw_pdu(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28),	\
+		raw_pdu(0x11, 0x06, 0x05, 0x00, 0x0a, 0x00, 0x0d, 0x18),\
+		raw_pdu(0x10, 0x0b, 0x00, 0xff, 0xff, 0x00, 0x28),	\
+		raw_pdu(0x01, 0x10, 0x0b, 0x00, 0x0a),			\
+		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),	\
+		raw_pdu(0x01, 0x10, 0x01, 0x00, 0x0a),			\
+		raw_pdu(0x08, 0x01, 0x00, 0x04, 0x00, 0x02, 0x28),	\
+		raw_pdu(0x01, 0x08, 0x01, 0x00, 0x0a),			\
+		raw_pdu(0x08, 0x05, 0x00, 0x0a, 0x00, 0x02, 0x28),	\
+		raw_pdu(0x01, 0x08, 0x05, 0x00, 0x0a),			\
+		raw_pdu(0x08, 0x01, 0x00, 0x04, 0x00, 0x03, 0x28),	\
+		raw_pdu(0x09, 0x07, 0x02, 0x00, 0x02, 0x03, 0x00, 0x00,	\
+				0x2a),					\
+		raw_pdu(0x08, 0x03, 0x00, 0x04, 0x00, 0x03, 0x28),	\
+		raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),			\
+		raw_pdu(0x04, 0x04, 0x00, 0x04, 0x00),			\
+		raw_pdu(0x05, 0x01, 0x04, 0x00, 0x01, 0x29),		\
+		raw_pdu(0x08, 0x05, 0x00, 0x0a, 0x00, 0x03, 0x28),	\
+		raw_pdu(0x09, 0x07, 0x07, 0x00, 0x0a, 0x08, 0x00, 0x29,	\
+				0x2a),					\
+		raw_pdu(0x08, 0x08, 0x00, 0x0a, 0x00, 0x03, 0x28),	\
+		raw_pdu(0x01, 0x08, 0x08, 0x00, 0x0a),			\
+		raw_pdu(0x04, 0x09, 0x00, 0x0a, 0x00),			\
+		raw_pdu(0x05, 0x01, 0x0a, 0x00, 0x01, 0x29)
+
 #define PRIMARY_DISC_SMALL_DB						\
 		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
 		raw_pdu(0x11, 0x06, 0x10, 0xF0, 0x17, 0xF0, 0x00, 0x18,	\
@@ -966,16 +995,23 @@ static void att_write_cb(struct gatt_db_attribute *att, int err,
 	g_assert(!err);
 }
 
-static struct gatt_db_attribute *add_char_with_value(struct gatt_db *db,
-					struct gatt_db_attribute *service_att,
-					bt_uuid_t *uuid,
-					uint32_t att_permissions,
-					uint8_t char_properties,
-					const void *value, size_t len)
+static struct gatt_db_attribute *
+add_char_with_value(struct gatt_db_attribute *service_att, uint16_t handle,
+				bt_uuid_t *uuid, uint32_t att_permissions,
+				uint8_t char_properties, const void *value,
+				size_t len)
 {
 	struct gatt_db_attribute *attrib;
 
-	attrib = gatt_db_service_add_characteristic(service_att, uuid,
+	if (handle)
+		attrib = gatt_db_service_insert_characteristic(service_att,
+								handle, uuid,
+								att_permissions,
+								char_properties,
+								NULL, NULL,
+								NULL);
+	else
+		attrib = gatt_db_service_add_characteristic(service_att, uuid,
 								att_permissions,
 								char_properties,
 								NULL, NULL,
@@ -990,14 +1026,19 @@ static struct gatt_db_attribute *add_char_with_value(struct gatt_db *db,
 }
 
 static struct gatt_db_attribute *
-add_desc_with_value(struct gatt_db_attribute *att, bt_uuid_t *uuid,
-				uint32_t att_perms, const uint8_t *value,
-				size_t len)
+add_desc_with_value(struct gatt_db_attribute *att, uint16_t handle,
+					bt_uuid_t *uuid, uint32_t att_perms,
+					const uint8_t *value, size_t len)
 {
 	struct gatt_db_attribute *desc_att;
 
-	desc_att = gatt_db_service_add_descriptor(att, uuid, att_perms, NULL,
-								NULL, NULL);
+	if (handle)
+		desc_att = gatt_db_service_insert_descriptor(att, handle, uuid,
+							att_perms, NULL, NULL,
+							NULL);
+	else
+		desc_att = gatt_db_service_add_descriptor(att, uuid, att_perms,
+							NULL, NULL, NULL);
 
 	gatt_db_attribute_write(desc_att, 0, value, len, 0x00, NULL,
 							att_write_cb, NULL);
@@ -1124,7 +1165,7 @@ static struct gatt_db *make_db(const struct att_handle_spec *spec)
 		case CHARACTERISTIC:
 			bt_string_to_uuid(&uuid, spec->uuid);
 
-			add_char_with_value(db, att, &uuid,
+			add_char_with_value(att, spec->handle, &uuid,
 							spec->att_permissions,
 							spec->char_properties,
 							spec->value, spec->len);
@@ -1134,7 +1175,8 @@ static struct gatt_db *make_db(const struct att_handle_spec *spec)
 		case DESCRIPTOR:
 			bt_string_to_uuid(&uuid, spec->uuid);
 
-			add_desc_with_value(att, &uuid, spec->att_permissions,
+			add_desc_with_value(att, spec->handle, &uuid,
+							spec->att_permissions,
 							spec->value, spec->len);
 
 			break;
@@ -1168,6 +1210,52 @@ static struct gatt_db *make_service_data_1_db(void)
 	return make_db(specs);
 }
 
+#define CHARACTERISTIC_STR_AT(chr_handle, chr_uuid, permissions, properties, \
+								string) \
+	{								\
+		.valid = true,						\
+		.handle = chr_handle,					\
+		.type = CHARACTERISTIC,					\
+		.uuid = STR(chr_uuid),					\
+		.att_permissions = permissions,				\
+		.char_properties = properties,				\
+		.value = (uint8_t *)string,				\
+		.len = strlen(string),					\
+	}
+
+#define DESCRIPTOR_STR_AT(desc_handle, desc_uuid, permissions, string)	\
+	{								\
+		.valid = true,						\
+		.handle = desc_handle,					\
+		.type = DESCRIPTOR,					\
+		.uuid = STR(desc_uuid),					\
+		.att_permissions = permissions,				\
+		.value = (uint8_t *)string,				\
+		.len = strlen(string),					\
+	}
+
+static struct gatt_db *make_service_data_2_db(void)
+{
+	const struct att_handle_spec specs[] = {
+		PRIMARY_SERVICE(0x0001, GATT_UUID, 4),
+		CHARACTERISTIC_STR(GATT_CHARAC_DEVICE_NAME, BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ, "BlueZ"),
+		DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID, BT_ATT_PERM_READ,
+								"Device Name"),
+		PRIMARY_SERVICE(0x0005, HEART_RATE_UUID, 6),
+		CHARACTERISTIC_STR_AT(0x0008,
+					GATT_CHARAC_MANUFACTURER_NAME_STRING,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ |
+					BT_GATT_CHRC_PROP_WRITE, ""),
+		DESCRIPTOR_STR_AT(0x000a, GATT_CHARAC_USER_DESC_UUID,
+					BT_ATT_PERM_READ, "Manufacturer Name"),
+		{ }
+	};
+
+	return make_db(specs);
+}
+
 /*
  * Defined Test database 1:
  * Tiny database fits into a single minimum sized-pdu.
@@ -1961,11 +2049,13 @@ static const struct test_step test_indication_server_1 = {
 
 int main(int argc, char *argv[])
 {
-	struct gatt_db *service_db_1, *ts_small_db, *ts_large_db_1;
+	struct gatt_db *service_db_1, *service_db_2;
+	struct gatt_db *ts_small_db, *ts_large_db_1;
 
 	tester_init(&argc, &argv);
 
 	service_db_1 = make_service_data_1_db();
+	service_db_2 = make_service_data_2_db();
 	ts_small_db = make_test_spec_small_db();
 	ts_large_db_1 = make_test_spec_large_db_1();
 
@@ -2273,6 +2363,10 @@ int main(int argc, char *argv[])
 			service_db_1, NULL,
 			SERVICE_DATA_1_PDUS);
 
+	define_test_client("/TP/GAD/CL/BV-06-C/client-2", test_client,
+			service_db_2, NULL,
+			SERVICE_DATA_2_PDUS);
+
 	define_test_server("/TP/GAD/SR/BV-06-C/small", test_server,
 			ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
2.1.0

