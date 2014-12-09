Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 4/8] unit/gatt: Add test spec "small test database"
Date: Tue,  9 Dec 2014 15:08:36 -0800
Message-Id: <1418166520-32993-5-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
References: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the first of a set of databases which are specified by
the Bluetooth GATT Test Specification document.

It is specifically the "small test database" constructed carefully to
fit the first requirement.

It satisfies the following requirements in section 3.3.2 of the GATT TS:
1. One small test database whose services fit into a single minimum
   sized PDU, with only 16-biy UUIDs
3. At least one of those has a Primary Service at the MAX handle
8. All have some services that are simple, and some that include other
   services
9. Each has at last one instance where the handle of an included service
   is before the handle of the including service
11. Each has instances of simple characteristics (no descriptors) and
    complex characteristics (multiple descriptors)
12. Each has instances of complex characteristics with 16-bit and
    128-bit characteristic descriptor UUIDs, and these are in no
    particular order.
---
 unit/test-gatt.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 1 deletion(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 336bd6e..505e41e 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -147,6 +147,17 @@ struct context {
 		raw_pdu(0x04, 0x08, 0x00, 0x08, 0x00),			\
 		raw_pdu(0x05, 0x01, 0x08, 0x00, 0x01, 0x29)
 
+#define PRIMARY_DISC_SMALL_DB						\
+		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
+		raw_pdu(0x11, 0x06, 0x10, 0xF0, 0x15, 0xF0, 0x00, 0x18,	\
+				0xFF, 0xFF, 0xFF, 0xFF, 0x0a, 0x18)
+
+#define SECONDARY_DISC_SMALL_DB						\
+		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),	\
+		raw_pdu(0x11, 0x06, 0x01, 0x00, 0x0F, 0x00, 0x0a, 0x18),\
+		raw_pdu(0x10, 0x10, 0x00, 0xff, 0xff, 0x01, 0x28),	\
+		raw_pdu(0x01, 0x10, 0x10, 0x00, 0x0a)
+
 #define SERVER_MTU_EXCHANGE_PDU raw_pdu(0x02, 0x17, 0x00)
 
 static bt_uuid_t uuid_16 = {
@@ -647,6 +658,28 @@ static struct gatt_db_attribute *add_char_with_value(struct gatt_db *db,
 	return attrib;
 }
 
+static struct gatt_db_attribute *add_ccc(struct gatt_db_attribute *chrc_att,
+								bool writable)
+{
+	struct gatt_db_attribute *desc_att;
+	bt_uuid_t uuid;
+	uint32_t permissions = BT_ATT_PERM_READ;
+	uint16_t tmp;
+
+	if (writable)
+		permissions |= BT_ATT_PERM_WRITE;
+
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	desc_att = gatt_db_service_add_descriptor(chrc_att, &uuid, permissions,
+							NULL, NULL, NULL);
+
+	tmp = 0x0000;
+	gatt_db_attribute_write(desc_att, 0, (uint8_t *)&tmp, sizeof(uint16_t),
+						0x00, NULL, att_write_cb, NULL);
+
+	return desc_att;
+}
+
 static struct gatt_db_attribute *
 add_user_description(struct gatt_db_attribute *chrc_att, const char *desc,
 								bool writable)
@@ -674,6 +707,34 @@ typedef struct gatt_db_attribute (*add_service_func) (struct gatt_db *db,
 							bool primary,
 							uint16_t extra_handles);
 
+static struct gatt_db_attribute *
+add_device_information_service(struct gatt_db *db, uint16_t handle,
+					bool primary, uint16_t extra_handles)
+{
+	bt_uuid_t uuid;
+	struct gatt_db_attribute *serv_att;
+
+	bt_string_to_uuid(&uuid, DEVICE_INFORMATION_UUID);
+	serv_att = gatt_db_insert_service(db, handle, &uuid, primary,
+							1 + extra_handles);
+
+	return serv_att;
+}
+
+static struct gatt_db_attribute *add_gap(struct gatt_db *db, uint16_t handle,
+							bool primary,
+							uint16_t extra_handles)
+{
+	bt_uuid_t uuid;
+	struct gatt_db_attribute *serv_att;
+
+	bt_string_to_uuid(&uuid, GAP_UUID);
+	serv_att = gatt_db_insert_service(db, handle, &uuid, primary,
+							1 + extra_handles);
+
+	return serv_att;
+}
+
 static struct gatt_db *make_service_data_1_db(void)
 {
 	struct gatt_db *db = gatt_db_new();
@@ -707,6 +768,79 @@ static struct gatt_db *make_service_data_1_db(void)
 	return db;
 }
 
+/*
+ * Defined Test database 1:
+ * Tiny database fits into a single minimum sized-pdu.
+ * Satisfies:
+ * 3. At least one primary seervice at the MAX handle
+ * For each / all databases:
+ * X 7. at least one service uuid with multiple instances
+ * X 8. Some simple services, some with included services
+ * X 9. an instance where handle of included service comes before the including
+ * service
+ * X 11. Simple characteristics (no desc) and complex characteristics
+ *       (multiple descriptors)
+ * X 12. Instances of complex chars with 16-bit and 128-bit uuids
+ * (although not in scrambled order)
+ */
+
+static struct gatt_db *make_test_spec_small_db(void)
+{
+	struct gatt_db *db;
+	struct gatt_db_attribute *serv_att, *dis_att;
+	bt_uuid_t uuid;
+	const char *manuf_device_string = "BlueZ";
+	const char *device_name_string = "BlueZ Unit Tester";
+	const char *user_desc_manuf_name = "Manufacturer Name";
+	uint16_t u16_value;
+	uint8_t u8_value;
+
+	db = gatt_db_new();
+
+	dis_att = add_device_information_service(db, 0x0001, false, 15);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
+	add_char_with_value(db, dis_att, &uuid, BT_ATT_PERM_READ,
+						BT_GATT_CHRC_PROP_READ,
+						manuf_device_string,
+						strlen(manuf_device_string));
+	add_ccc(dis_att, false);
+	add_user_description(dis_att, user_desc_manuf_name, false);
+
+	gatt_db_service_set_active(dis_att, true);
+
+	serv_att = add_gap(db, 0xF010, true, 5);
+
+	gatt_db_service_add_included(serv_att, dis_att);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
+	add_char_with_value(db, serv_att, &uuid, BT_ATT_PERM_READ,
+						BT_GATT_CHRC_PROP_READ,
+						device_name_string,
+						strlen(device_name_string));
+
+	bt_string_to_uuid(&uuid, "0000B009-0000-0000-0123-456789abcdef");
+	u8_value = 0x09;
+	add_char_with_value(db, serv_att, &uuid, BT_ATT_PERM_READ,
+						BT_GATT_CHRC_PROP_READ,
+						&u8_value, sizeof(uint8_t));
+
+	gatt_db_service_set_active(serv_att, true);
+
+	u16_value = 0x0000; /* "Unknown" Appearance */
+	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
+	add_char_with_value(db, serv_att, &uuid, BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ, &u16_value,
+					sizeof(uint16_t));
+
+
+	serv_att = add_device_information_service(db, 0xFFFF, true, 0);
+
+	gatt_db_service_set_active(serv_att, true);
+
+	return db;
+}
+
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
@@ -928,11 +1062,12 @@ static void test_read_by_type(gconstpointer data)
 
 int main(int argc, char *argv[])
 {
-	struct gatt_db *service_db_1;
+	struct gatt_db *service_db_1, *ts_small_db;
 
 	g_test_init(&argc, &argv, NULL);
 
 	service_db_1 = make_service_data_1_db();
+	ts_small_db = make_test_spec_small_db();
 
 	/*
 	 * Server Configuration
@@ -969,6 +1104,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x10, 0x97, 0x00, 0xff, 0xff, 0x00, 0x28),
 			raw_pdu(0x01, 0x10, 0x97, 0x00, 0x0a));
 
+	define_test_att("/TP/GAD/CL/BV-01-C-small", test_search_primary, NULL,
+			NULL,
+			MTU_EXCHANGE_CLIENT_PDUS,
+			PRIMARY_DISC_SMALL_DB);
+
 	define_test_server("/TP/GAD/SR/BV-01-C", test_server, service_db_1,
 			NULL,
 			raw_pdu(0x03, 0x00, 0x02),
@@ -978,6 +1118,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x10, 0x06, 0x00, 0xff, 0xff, 0x00, 0x28),
 			raw_pdu(0x01, 0x10, 0x06, 0x00, 0x0a));
 
+	define_test_server("/TP/GAD/SR/BV-01-C-small", test_server, ts_small_db,
+			NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			PRIMARY_DISC_SMALL_DB);
+
 	define_test_att("/TP/GAD/CL/BV-02-C-1", test_search_primary, &uuid_16,
 			NULL,
 			MTU_EXCHANGE_CLIENT_PDUS,
-- 
2.2.0.rc0.207.ga3a616c

