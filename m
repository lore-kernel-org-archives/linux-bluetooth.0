Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 05/14] unit/gatt: Rework service db definitions
Date: Tue, 30 Dec 2014 16:32:23 -0800
Message-Id: <1419985952-18334-6-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
References: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Introduces a set of macros providing a simple syntax for definining a
test GATT database.

The two defined databases are reconstructed using the new format.
Some old helper methods are not used anymore and are removed.
---
 unit/test-gatt.c | 277 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 159 insertions(+), 118 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 4f5857f..169fbd3 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -676,99 +676,168 @@ add_desc_with_value(struct gatt_db_attribute *att, bt_uuid_t *uuid,
 	return desc_att;
 }
 
-static struct gatt_db_attribute *add_ccc(struct gatt_db_attribute *chrc_att,
-								bool writable)
-{
-	bt_uuid_t uuid;
-	uint16_t tmp;
-
-	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	tmp = 0x0000;
+enum gatt_type {
+	PRIMARY,
+	SECONDARY,
+	INCLUDE,
+	CHARACTERISTIC,
+	DESCRIPTOR
+};
 
-	return add_desc_with_value(chrc_att, &uuid,
-					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
-					(uint8_t *)&tmp, sizeof(tmp));
-}
+struct att_handle_spec {
+	uint16_t handle;
+	const char *uuid;
+	enum gatt_type type;
+	uint8_t char_properties;
+	uint32_t att_permissions;
+	const uint8_t *value;
+	size_t len;
+	bool valid;
+};
 
-static struct gatt_db_attribute *
-add_user_description(struct gatt_db_attribute *chrc_att, const char *desc,
-								bool writable)
-{
-	bt_uuid_t uuid;
+#define PRIMARY_SERVICE(start_handle, srv_uuid, num_handles)	\
+	{							\
+		.valid = true,					\
+		.handle = start_handle,				\
+		.type = PRIMARY,				\
+		.uuid = srv_uuid,				\
+		.len = num_handles,				\
+	}
 
-	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
+#define SECONDARY_SERVICE(start_handle, srv_uuid, num_handles)	\
+	{							\
+		.valid = true,					\
+		.handle = start_handle,				\
+		.type = SECONDARY,				\
+		.uuid = srv_uuid,				\
+		.len = num_handles,				\
+	}
 
-	return add_desc_with_value(chrc_att, &uuid, 0x03, (uint8_t *)desc,
-						strlen(desc));
-}
+#define INCLUDE(include_handle)				\
+	{						\
+		.valid = true,				\
+		.type = INCLUDE,			\
+		.handle = include_handle,		\
+	}
 
+#define STR(x) #x
+
+#define CHARACTERISTIC(chr_uuid, permissions, properties, bytes...)	\
+	{								\
+		.valid = true,						\
+		.type = CHARACTERISTIC,					\
+		.uuid = STR(chr_uuid),					\
+		.att_permissions = permissions,				\
+		.char_properties = properties,				\
+		.value = data(bytes),					\
+		.len = sizeof(data(bytes)),				\
+	}
 
-typedef struct gatt_db_attribute (*add_service_func) (struct gatt_db *db,
-							uint16_t handle,
-							bool primary,
-							uint16_t extra_handles);
+#define CHARACTERISTIC_STR(chr_uuid, permissions, properties, string)	\
+		{							\
+		.valid = true,						\
+		.type = CHARACTERISTIC,					\
+		.uuid = STR(chr_uuid),					\
+		.att_permissions = permissions,				\
+		.char_properties = properties,				\
+		.value = (uint8_t *)string,				\
+		.len = strlen(string),					\
+	}
 
-static struct gatt_db_attribute *
-add_device_information_service(struct gatt_db *db, uint16_t handle,
-					bool primary, uint16_t extra_handles)
-{
-	bt_uuid_t uuid;
-	struct gatt_db_attribute *serv_att;
+#define DESCRIPTOR(desc_uuid, permissions, bytes...)	\
+	{						\
+		.valid = true,				\
+		.type = DESCRIPTOR,			\
+		.uuid = STR(desc_uuid),			\
+		.att_permissions = permissions,		\
+		.value = data(bytes),			\
+		.len = sizeof(data(bytes)),		\
+	}
 
-	bt_string_to_uuid(&uuid, DEVICE_INFORMATION_UUID);
-	serv_att = gatt_db_insert_service(db, handle, &uuid, primary,
-							1 + extra_handles);
+#define DESCRIPTOR_STR(desc_uuid, permissions, string)	\
+	{						\
+		.valid = true,				\
+		.type = DESCRIPTOR,			\
+		.uuid = STR(desc_uuid),			\
+		.att_permissions = permissions,		\
+		.value = (uint8_t *)string,		\
+		.len = strlen(string),			\
+	}
 
-	return serv_att;
-}
 
-static struct gatt_db_attribute *add_gap(struct gatt_db *db, uint16_t handle,
-							bool primary,
-							uint16_t extra_handles)
+static struct gatt_db *make_db(const struct att_handle_spec *spec)
 {
+	struct gatt_db *db = gatt_db_new();
+	struct gatt_db_attribute *att, *include_att;
 	bt_uuid_t uuid;
-	struct gatt_db_attribute *serv_att;
 
-	bt_string_to_uuid(&uuid, GAP_UUID);
-	serv_att = gatt_db_insert_service(db, handle, &uuid, primary,
-							1 + extra_handles);
+	att = include_att = NULL;
 
-	return serv_att;
-}
+	for (; spec->valid; spec++) {
+		switch (spec->type) {
+		case PRIMARY:
+		case SECONDARY:
+			bt_string_to_uuid(&uuid, spec->uuid);
 
-static struct gatt_db *make_service_data_1_db(void)
-{
-	struct gatt_db *db = gatt_db_new();
-	struct gatt_db_attribute *serv_att, *chrc_att;
-	bt_uuid_t uuid;
+			if (att)
+				gatt_db_service_set_active(att, true);
 
-	bt_uuid16_create(&uuid, 0x1801);
-	serv_att = gatt_db_insert_service(db, 0x0001, &uuid, true, 4);
+			att = gatt_db_insert_service(db, spec->handle, &uuid,
+					spec->type == PRIMARY, spec->len);
+			break;
 
-	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
-	chrc_att = add_char_with_value(db, serv_att, &uuid, BT_ATT_PERM_READ,
-					BT_GATT_CHRC_PROP_READ, "BlueZ", 5);
+		case INCLUDE:
+			include_att = gatt_db_get_attribute(db, spec->handle);
 
-	add_user_description(chrc_att, "Device Name", false);
+			gatt_db_service_add_included(att, include_att);
+			break;
 
-	gatt_db_service_set_active(serv_att, true);
+		case CHARACTERISTIC:
+			bt_string_to_uuid(&uuid, spec->uuid);
 
-	bt_uuid16_create(&uuid, 0x180d);
-	serv_att = gatt_db_insert_service(db, 0x0005, &uuid, true, 4);
+			add_char_with_value(db, att, &uuid,
+							spec->att_permissions,
+							spec->char_properties,
+							spec->value, spec->len);
 
-	bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
-	chrc_att = gatt_db_service_add_characteristic(serv_att, &uuid,
-							BT_ATT_PERM_READ,
-							BT_GATT_CHRC_PROP_READ,
-							NULL, NULL, NULL);
+			break;
 
-	add_user_description(chrc_att, "Manufacturer Name", false);
+		case DESCRIPTOR:
+			bt_string_to_uuid(&uuid, spec->uuid);
 
-	gatt_db_service_set_active(serv_att, true);
+			add_desc_with_value(att, &uuid, spec->att_permissions,
+							spec->value, spec->len);
+
+			break;
+		};
+	}
+
+	if (att)
+		gatt_db_service_set_active(att, true);
 
 	return db;
 }
 
+static struct gatt_db *make_service_data_1_db(void)
+{
+	const struct att_handle_spec specs[] = {
+		PRIMARY_SERVICE(0x0001, GATT_UUID, 4),
+		CHARACTERISTIC_STR(GATT_CHARAC_DEVICE_NAME, BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ, "BlueZ"),
+		DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID, BT_ATT_PERM_READ,
+								"Device Name"),
+		PRIMARY_SERVICE(0x0005, HEART_RATE_UUID, 4),
+		CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
+						BT_ATT_PERM_READ,
+						BT_GATT_CHRC_PROP_READ, ""),
+		DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID, BT_ATT_PERM_READ,
+							"Manufacturer Name"),
+		{ }
+	};
+
+	return make_db(specs);
+}
+
 /*
  * Defined Test database 1:
  * Tiny database fits into a single minimum sized-pdu.
@@ -787,59 +856,31 @@ static struct gatt_db *make_service_data_1_db(void)
 
 static struct gatt_db *make_test_spec_small_db(void)
 {
-	struct gatt_db *db;
-	struct gatt_db_attribute *serv_att, *dis_att;
-	bt_uuid_t uuid;
-	const char *manuf_device_string = "BlueZ";
-	const char *device_name_string = "BlueZ Unit Tester";
-	const char *user_desc_manuf_name = "Manufacturer Name";
-	uint16_t u16_value;
-	uint8_t u8_value;
-
-	db = gatt_db_new();
-
-	dis_att = add_device_information_service(db, 0x0001, false, 15);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
-	add_char_with_value(db, dis_att, &uuid, BT_ATT_PERM_READ,
+	const struct att_handle_spec specs[] = {
+		SECONDARY_SERVICE(0x0001, DEVICE_INFORMATION_UUID, 16),
+		CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
+						BT_ATT_PERM_READ,
 						BT_GATT_CHRC_PROP_READ,
-						manuf_device_string,
-						strlen(manuf_device_string));
-	add_ccc(dis_att, false);
-	add_user_description(dis_att, user_desc_manuf_name, false);
-
-	gatt_db_service_set_active(dis_att, true);
-
-	serv_att = add_gap(db, 0xF010, true, 7);
-
-	gatt_db_service_add_included(serv_att, dis_att);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
-	add_char_with_value(db, serv_att, &uuid, BT_ATT_PERM_READ,
-						BT_GATT_CHRC_PROP_READ,
-						device_name_string,
-						strlen(device_name_string));
-
-	bt_string_to_uuid(&uuid, "0000B009-0000-0000-0123-456789abcdef");
-	u8_value = 0x09;
-	add_char_with_value(db, serv_att, &uuid, BT_ATT_PERM_READ,
-						BT_GATT_CHRC_PROP_READ,
-						&u8_value, sizeof(uint8_t));
-
-	gatt_db_service_set_active(serv_att, true);
-
-	u16_value = 0x0000; /* "Unknown" Appearance */
-	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
-	add_char_with_value(db, serv_att, &uuid, BT_ATT_PERM_READ,
-					BT_GATT_CHRC_PROP_READ, &u16_value,
-					sizeof(uint16_t));
-
-
-	serv_att = add_device_information_service(db, 0xFFFF, true, 0);
-
-	gatt_db_service_set_active(serv_att, true);
-
-	return db;
+						"BlueZ"),
+		DESCRIPTOR(GATT_CLIENT_CHARAC_CFG_UUID, BT_ATT_PERM_READ, 0x00,
+									0x00),
+		DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID, BT_ATT_PERM_READ,
+							"Manufacturer Name"),
+		PRIMARY_SERVICE(0xF010, GAP_UUID, 8),
+		INCLUDE(0x0001),
+		CHARACTERISTIC_STR(GATT_CHARAC_DEVICE_NAME, BT_ATT_PERM_READ,
+							BT_GATT_CHRC_PROP_READ,
+							"BlueZ Unit Tester"),
+		CHARACTERISTIC(0000B009-0000-0000-0123-456789abcdef,
+						BT_ATT_PERM_READ,
+						BT_GATT_CHRC_PROP_READ, 0x09),
+		CHARACTERISTIC(GATT_CHARAC_APPEARANCE, BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ, 0x00, 0x00),
+		PRIMARY_SERVICE(0xFFFF, DEVICE_INFORMATION_UUID, 1),
+		{ }
+	};
+
+	return make_db(specs);
 }
 
 static void test_client(gconstpointer data)
-- 
2.2.0.rc0.207.ga3a616c

