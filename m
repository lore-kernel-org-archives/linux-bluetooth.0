Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ v6 3/5] shared/gatt-db: Extend gatt_db_attribute_get_char_data with ext. prop
Date: Wed, 13 Apr 2016 23:09:55 +0200
Message-Id: <1460581797-3541-4-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1460581797-3541-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1460581797-3541-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds way to get extended properties from characteristic
extended property descriptor
---
 profiles/deviceinfo/deviceinfo.c |  2 +-
 profiles/gap/gas.c               |  2 +-
 profiles/scanparam/scan.c        |  2 +-
 src/device.c                     |  2 +-
 src/gatt-client.c                |  3 +-
 src/shared/gatt-client.c         |  6 ++--
 src/shared/gatt-db.c             | 63 ++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h             |  1 +
 tools/btgatt-client.c            |  8 +++--
 tools/btgatt-server.c            |  8 +++--
 unit/test-gatt.c                 |  4 +--
 11 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index d1f51a0..0c48f00 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -88,7 +88,7 @@ static void handle_characteristic(struct gatt_db_attribute *attr,
 	bt_string_to_uuid(&pnpid_uuid, PNPID_UUID);
 
 	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
-								&uuid)) {
+								NULL, &uuid)) {
 		error("Failed to obtain characteristic data");
 		return;
 	}
diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 877c4fd..35b996c 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -181,7 +181,7 @@ static void handle_characteristic(struct gatt_db_attribute *attr,
 	bt_uuid_t uuid;
 
 	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
-								&uuid)) {
+								NULL, &uuid)) {
 		error("Failed to obtain characteristic data");
 		return;
 	}
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 4015b3f..d3ca762 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -140,7 +140,7 @@ static void handle_characteristic(struct gatt_db_attribute *attr,
 	bt_uuid_t uuid, scan_interval_wind_uuid, scan_refresh_uuid;
 
 	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
-								&uuid)) {
+								NULL, &uuid)) {
 		error("Failed to obtain characteristic data");
 		return;
 	}
diff --git a/src/device.c b/src/device.c
index 0d46eba..cd82ef2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1987,7 +1987,7 @@ static void store_chrc(struct gatt_db_attribute *attr, void *user_data)
 	bt_uuid_t uuid;
 
 	if (!gatt_db_attribute_get_char_data(attr, &handle_num, &value_handle,
-							&properties, &uuid)) {
+						&properties, NULL, &uuid)) {
 		warn("Error storing characteristic - can't get data");
 		return;
 	}
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 52add1d..ebb7b35 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1283,7 +1283,8 @@ static struct characteristic *characteristic_create(
 
 	gatt_db_attribute_get_char_data(attr, &chrc->handle,
 							&chrc->value_handle,
-							&chrc->props, &uuid);
+							&chrc->props, NULL,
+							&uuid);
 
 	chrc->attr = gatt_db_get_attribute(service->client->db,
 							chrc->value_handle);
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 34b6cc7..ff49be1 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -243,9 +243,9 @@ static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
 	if (bt_uuid_cmp(&uuid, gatt_db_attribute_get_type(attr)))
 		return NULL;
 
-	if (!gatt_db_attribute_get_char_data(attr, NULL, NULL,
-							&properties, NULL))
-			return NULL;
+	if (!gatt_db_attribute_get_char_data(attr, NULL, NULL, &properties,
+								NULL, NULL))
+		return NULL;
 
 	chrc = new0(struct notify_chrc, 1);
 
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index cc49458..513451f 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -52,6 +52,8 @@ static const bt_uuid_t characteristic_uuid = { .type = BT_UUID16,
 					.value.u16 = GATT_CHARAC_UUID };
 static const bt_uuid_t included_service_uuid = { .type = BT_UUID16,
 					.value.u16 = GATT_INCLUDE_UUID };
+static const bt_uuid_t ext_desc_uuid = { .type = BT_UUID16,
+				.value.u16 = GATT_CHARAC_EXT_PROPER_UUID };
 
 struct gatt_db {
 	int ref_count;
@@ -1456,10 +1458,68 @@ bool gatt_db_attribute_get_service_data(const struct gatt_db_attribute *attrib,
 	return le_to_uuid(decl->value, decl->value_len, uuid);
 }
 
+static void read_ext_prop_value(struct gatt_db_attribute *attrib,
+						int err, const uint8_t *value,
+						size_t length, void *user_data)
+{
+	uint16_t *ext_prop = user_data;
+
+	if (err || (length != sizeof(uint16_t)))
+		return;
+
+	*ext_prop = (uint16_t) value[0];
+}
+
+static void read_ext_prop(struct gatt_db_attribute *attrib,
+							void *user_data)
+{
+	uint16_t *ext_prop = user_data;
+
+	/*
+	 * If ext_prop is set that means extended properties descriptor
+	 * has been already found
+	 */
+	if (*ext_prop != 0)
+		return;
+
+	if (bt_uuid_cmp(&ext_desc_uuid, &attrib->uuid))
+		return;
+
+	gatt_db_attribute_read(attrib, 0, BT_ATT_OP_READ_REQ, NULL,
+						read_ext_prop_value, ext_prop);
+}
+
+static uint8_t get_char_extended_prop(const struct gatt_db_attribute *attrib)
+{
+	uint16_t ext_prop;
+
+	if (!attrib)
+		return 0;
+
+	if (bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
+		return 0;
+
+	/* Check properties first */
+	if (!(attrib->value[0] & BT_GATT_CHRC_PROP_EXT_PROP))
+		return 0;
+
+	ext_prop = 0;
+
+	/*
+	 * Cast needed for foreach function. We do not change attrib during
+	 * this call
+	 */
+	gatt_db_service_foreach_desc((struct gatt_db_attribute *) attrib,
+						read_ext_prop, &ext_prop);
+
+	return ext_prop;
+}
+
 bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
 							uint16_t *handle,
 							uint16_t *value_handle,
 							uint8_t *properties,
+							uint16_t *ext_prop,
 							bt_uuid_t *uuid)
 {
 	if (!attrib)
@@ -1484,6 +1544,9 @@ bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
 	if (properties)
 		*properties = attrib->value[0];
 
+	if (ext_prop)
+		*ext_prop = get_char_extended_prop(attrib);
+
 	if (value_handle)
 		*value_handle = get_le16(attrib->value + 1);
 
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 96cceb9..134ec63 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -199,6 +199,7 @@ bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
 							uint16_t *handle,
 							uint16_t *value_handle,
 							uint8_t *properties,
+							uint16_t *ext_prop,
 							bt_uuid_t *uuid);
 
 bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 2153bec..4c8c9dd 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -297,18 +297,20 @@ static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
 {
 	uint16_t handle, value_handle;
 	uint8_t properties;
+	uint16_t ext_prop;
 	bt_uuid_t uuid;
 
 	if (!gatt_db_attribute_get_char_data(attr, &handle,
 								&value_handle,
 								&properties,
+								&ext_prop,
 								&uuid))
 		return;
 
 	printf("\t  " COLOR_YELLOW "charac" COLOR_OFF
-					" - start: 0x%04x, value: 0x%04x, "
-					"props: 0x%02x, uuid: ",
-					handle, value_handle, properties);
+				" - start: 0x%04x, value: 0x%04x, "
+				"props: 0x%02x, ext_props: 0x%04x, uuid: ",
+				handle, value_handle, properties, ext_prop);
 	print_uuid(&uuid);
 
 	gatt_db_service_foreach_desc(attr, print_desc, NULL);
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 099db8a..fadaff2 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -932,18 +932,20 @@ static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
 {
 	uint16_t handle, value_handle;
 	uint8_t properties;
+	uint16_t ext_prop;
 	bt_uuid_t uuid;
 
 	if (!gatt_db_attribute_get_char_data(attr, &handle,
 								&value_handle,
 								&properties,
+								&ext_prop,
 								&uuid))
 		return;
 
 	printf("\t  " COLOR_YELLOW "charac" COLOR_OFF
-					" - start: 0x%04x, value: 0x%04x, "
-					"props: 0x%02x, uuid: ",
-					handle, value_handle, properties);
+				" - start: 0x%04x, value: 0x%04x, "
+				"props: 0x%02x, ext_prop: 0x%04x, uuid: ",
+				handle, value_handle, properties, ext_prop);
 	print_uuid(&uuid);
 
 	gatt_db_service_foreach_desc(attr, print_desc, NULL);
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 126a59f..03925e9 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -526,9 +526,9 @@ static bool matching_char_data(struct gatt_db_attribute *a,
 	bt_uuid_t a_uuid, b_uuid;
 
 	gatt_db_attribute_get_char_data(a, &a_handle, &a_value_handle,
-							&a_properties, &a_uuid);
+						&a_properties, NULL, &a_uuid);
 	gatt_db_attribute_get_char_data(b, &b_handle, &b_value_handle,
-							&b_properties, &b_uuid);
+						&b_properties, NULL, &b_uuid);
 
 	return a_handle == b_handle && a_value_handle == b_value_handle &&
 						a_properties == b_properties &&
-- 
2.5.0

