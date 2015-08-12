Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [BlueZ RFC] src/device: gatt database persistence
Date: Wed, 12 Aug 2015 20:36:52 +0200
Message-Id: <1439404612-2346-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes how gatt database for paired devices is stored between
restarts of bluetoothd. Right now only definition of services is stored.
After applying this patch whole gatt database will be stored/restored.

Storing whole database can have big impact on reconnection time for paired
devices, because full discovery can take up to 10 seconds.
---
 src/device.c | 569 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 439 insertions(+), 130 deletions(-)

diff --git a/src/device.c b/src/device.c
index 3dde8b8..41af842 100644
--- a/src/device.c
+++ b/src/device.c
@@ -87,6 +87,11 @@
 
 #define RSSI_THRESHOLD		8
 
+#define GATT_PRIM_SVC_UUID_STR "0x2800"
+#define GATT_SND_SVC_UUID_STR  "0x2801"
+#define GATT_INCLUDE_UUID_STR "0x2802"
+#define GATT_CHARAC_UUID_STR "0x2803"
+
 static DBusConnection *dbus_conn = NULL;
 static unsigned service_state_cb_id;
 
@@ -1889,67 +1894,148 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	return btd_error_failed(msg, strerror(-err));
 }
 
-static void store_services(struct btd_device *device)
+static void g_key_file_set_uuid(GKeyFile *key_file, const gchar *group_name,
+					const gchar *key, const bt_uuid_t *uuid)
+{
+	char uuid_str[MAX_LEN_UUID_STR];
+
+	bt_uuid_to_string(uuid, uuid_str, sizeof(uuid_str));
+	g_key_file_set_string(key_file, group_name, key, uuid_str);
+}
+
+struct gatt_saver {
+	struct btd_device *device;
+	GKeyFile *key_file;
+};
+
+static void store_desc(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gatt_saver *saver = user_data;
+	GKeyFile *key_file = saver->key_file;
+	const bt_uuid_t *uuid;
+	uint16_t handle_num;
+	char handle[6];
+
+	handle_num = gatt_db_attribute_get_handle(attr);
+	sprintf(handle, "%hu", handle_num);
+
+	uuid = gatt_db_attribute_get_type(attr);
+	g_key_file_set_uuid(key_file, handle, "Type", uuid);
+}
+
+static void store_chrc(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gatt_saver *saver = user_data;
+	GKeyFile *key_file = saver->key_file;
+	uint16_t handle_num, value_handle;
+	uint8_t properties;
+	char handle[6];
+	bt_uuid_t uuid;
+
+	if (!gatt_db_attribute_get_char_data(attr, &handle_num, &value_handle,
+							&properties, &uuid)) {
+		warn("Error storing characteristic - can't get data");
+		return;
+	}
+
+	sprintf(handle, "%hu", handle_num);
+
+	g_key_file_set_string(key_file, handle, "Type", GATT_CHARAC_UUID_STR);
+	g_key_file_set_uuid(key_file, handle, "Value", &uuid);
+	g_key_file_set_integer(key_file, handle, "ValueHandle", value_handle);
+	g_key_file_set_integer(key_file, handle, "Properties", properties);
+
+	gatt_db_service_foreach_desc(attr, store_desc, saver);
+}
+
+static void store_incl(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gatt_saver *saver = user_data;
+	GKeyFile *key_file = saver->key_file;
+	struct gatt_db_attribute *service;
+	uint16_t handle_num, start, end;
+	char handle[6];
+	bt_uuid_t uuid;
+
+	if (!gatt_db_attribute_get_incl_data(attr, &handle_num, &start, &end)) {
+		warn("Error storing included service - can't get data");
+		return;
+	}
+
+	service = gatt_db_get_attribute(saver->device->db, start);
+	if (!service) {
+		warn("Error storing included service - can't find it");
+		return;
+	}
+
+	sprintf(handle, "%hu", handle_num);
+
+	g_key_file_set_string(key_file, handle, "Type", GATT_INCLUDE_UUID_STR);
+	g_key_file_set_uuid(key_file, handle, "Value", &uuid);
+	g_key_file_set_integer(key_file, handle, "Start", start);
+	g_key_file_set_integer(key_file, handle, "End", end);
+}
+
+static void store_service(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gatt_saver *saver = user_data;
+	GKeyFile *key_file = saver->key_file;
+	uint16_t start, end;
+	bt_uuid_t uuid;
+	char handle[6];
+	bool primary;
+
+	if (!gatt_db_attribute_get_service_data(attr, &start, &end, &primary,
+								&uuid)) {
+		warn("Error storing service - can't get data");
+		return;
+	}
+
+	sprintf(handle, "%hu", start);
+
+	if (primary)
+		g_key_file_set_string(key_file, handle, "Type",
+							GATT_PRIM_SVC_UUID_STR);
+	else
+		g_key_file_set_string(key_file, handle, "Type",
+							GATT_SND_SVC_UUID_STR);
+
+	g_key_file_set_uuid(key_file, handle, "Value", &uuid);
+	g_key_file_set_integer(key_file, handle, "EndGroupHandle", end);
+
+	gatt_db_service_foreach_incl(attr, store_incl, saver);
+	gatt_db_service_foreach_char(attr, store_chrc, saver);
+}
+
+static void store_gatt_db(struct btd_device *device)
 {
 	struct btd_adapter *adapter = device->adapter;
 	char filename[PATH_MAX];
 	char src_addr[18], dst_addr[18];
-	uuid_t uuid;
-	char *prim_uuid;
 	GKeyFile *key_file;
 	GSList *l;
 	char *data;
 	gsize length = 0;
+	struct gatt_saver saver;
 
 	if (device_address_is_private(device)) {
-		warn("Can't store services for private addressed device %s",
+		warn("Can't store GATT db for private addressed device %s",
 								device->path);
 		return;
 	}
 
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	prim_uuid = bt_uuid2string(&uuid);
-	if (prim_uuid == NULL)
-		return;
-
 	ba2str(btd_adapter_get_address(adapter), src_addr);
 	ba2str(&device->bdaddr, dst_addr);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", src_addr,
 								dst_addr);
+
 	key_file = g_key_file_new();
 
-	for (l = device->primaries; l; l = l->next) {
-		struct gatt_primary *primary = l->data;
-		char handle[6], uuid_str[33];
-		int i;
+	saver.key_file = key_file;
+	saver.device = device;
 
-		sprintf(handle, "%hu", primary->range.start);
-
-		bt_string2uuid(&uuid, primary->uuid);
-		sdp_uuid128_to_uuid(&uuid);
-
-		switch (uuid.type) {
-		case SDP_UUID16:
-			sprintf(uuid_str, "%4.4X", uuid.value.uuid16);
-			break;
-		case SDP_UUID32:
-			sprintf(uuid_str, "%8.8X", uuid.value.uuid32);
-			break;
-		case SDP_UUID128:
-			for (i = 0; i < 16; i++)
-				sprintf(uuid_str + (i * 2), "%2.2X",
-						uuid.value.uuid128.data[i]);
-			break;
-		default:
-			uuid_str[0] = '\0';
-		}
-
-		g_key_file_set_string(key_file, handle, "UUID", prim_uuid);
-		g_key_file_set_string(key_file, handle, "Value", uuid_str);
-		g_key_file_set_integer(key_file, handle, "EndGroupHandle",
-					primary->range.end);
-	}
+	gatt_db_foreach_service(device->db, NULL, store_service, &saver);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
@@ -1957,7 +2043,6 @@ static void store_services(struct btd_device *device)
 		g_file_set_contents(filename, data, length, NULL);
 	}
 
-	free(prim_uuid);
 	g_free(data);
 	g_key_file_free(key_file);
 }
@@ -2051,7 +2136,7 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t bdaddr_type,
 		store_device_info(dev);
 
 	if (bdaddr_type != BDADDR_BREDR && err == 0)
-		store_services(dev);
+		store_gatt_db(dev);
 
 	if (!req)
 		return;
@@ -2678,94 +2763,6 @@ next:
 		store_device_info(device);
 }
 
-static void load_att_info(struct btd_device *device, const char *local,
-				const char *peer)
-{
-	char filename[PATH_MAX];
-	GKeyFile *key_file;
-	char *prim_uuid, *str;
-	char **groups, **handle, *service_uuid;
-	struct gatt_primary *prim;
-	uuid_t uuid;
-	char tmp[3];
-	int i;
-
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	prim_uuid = bt_uuid2string(&uuid);
-
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", local,
-			peer);
-
-	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
-	groups = g_key_file_get_groups(key_file, NULL);
-
-	for (handle = groups; *handle; handle++) {
-		gboolean uuid_ok;
-		int end;
-
-		str = g_key_file_get_string(key_file, *handle, "UUID", NULL);
-		if (!str)
-			continue;
-
-		uuid_ok = g_str_equal(str, prim_uuid);
-		g_free(str);
-
-		if (!uuid_ok)
-			continue;
-
-		str = g_key_file_get_string(key_file, *handle, "Value", NULL);
-		if (!str)
-			continue;
-
-		end = g_key_file_get_integer(key_file, *handle,
-						"EndGroupHandle", NULL);
-		if (end == 0) {
-			g_free(str);
-			continue;
-		}
-
-		prim = g_new0(struct gatt_primary, 1);
-		prim->range.start = atoi(*handle);
-		prim->range.end = end;
-
-		switch (strlen(str)) {
-		case 4:
-			uuid.type = SDP_UUID16;
-			sscanf(str, "%04hx", &uuid.value.uuid16);
-		break;
-		case 8:
-			uuid.type = SDP_UUID32;
-			sscanf(str, "%08x", &uuid.value.uuid32);
-			break;
-		case 32:
-			uuid.type = SDP_UUID128;
-			memset(tmp, 0, sizeof(tmp));
-			for (i = 0; i < 16; i++) {
-				memcpy(tmp, str + (i * 2), 2);
-				uuid.value.uuid128.data[i] =
-						(uint8_t) strtol(tmp, NULL, 16);
-			}
-			break;
-		default:
-			g_free(str);
-			g_free(prim);
-			continue;
-		}
-
-		service_uuid = bt_uuid2string(&uuid);
-		memcpy(prim->uuid, service_uuid, MAX_LEN_UUID_STR);
-		free(service_uuid);
-		g_free(str);
-
-		device->primaries = g_slist_append(device->primaries, prim);
-	}
-
-	g_strfreev(groups);
-	g_key_file_free(key_file);
-	free(prim_uuid);
-}
-
 static void device_register_primaries(struct btd_device *device,
 						GSList *prim_list, int psm)
 {
@@ -2792,6 +2789,318 @@ static void add_primary(struct gatt_db_attribute *attr, void *user_data)
 	*new_services = g_slist_append(*new_services, prim);
 }
 
+bt_uuid_t *g_key_file_get_uuid(GKeyFile *key_file, const gchar *group_name,
+					const gchar *key, GError **error)
+{
+	gchar *uuid_str;
+	bt_uuid_t *uuid;
+
+	uuid_str = g_key_file_get_string(key_file, group_name, key, error);
+	if (!uuid_str)
+		return NULL;
+
+	uuid = g_try_malloc(sizeof(bt_uuid_t));
+	if (!uuid)
+		return NULL;
+
+	if (bt_string_to_uuid(uuid, uuid_str) < 0) {
+		g_free(uuid_str);
+		g_free(uuid);
+		return NULL;
+	}
+
+	g_free(uuid_str);
+	return uuid;
+}
+
+static int load_desc(GKeyFile *key_file, char *handle,
+					struct gatt_db_attribute *service)
+{
+	char uuid_str[MAX_LEN_UUID_STR];
+	struct gatt_db_attribute *att;
+	int properties, value_handle;
+	int handle_int;
+	bt_uuid_t *uuid;
+	char *type;
+
+	if (sscanf(handle, "%d", &handle_int) != 1)
+		return -EIO;
+
+	uuid = g_key_file_get_uuid(key_file, handle, "Type", NULL);
+	if (!uuid)
+		return -EIO;
+
+	bt_uuid_to_string(uuid, uuid_str, sizeof(uuid_str));
+	DBG("loading descriptor handle: 0x%04x, uuid: %s", handle_int,
+								uuid_str);
+
+	att = gatt_db_service_insert_descriptor(service, handle_int, uuid, 0,
+							NULL, NULL, NULL);
+	g_free(uuid);
+
+	if (!att || gatt_db_attribute_get_handle(att) != handle_int) {
+		warn("saving descriptor to db failed");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int load_chrc(GKeyFile *key_file, char *handle,
+					struct gatt_db_attribute *service)
+{
+	uint16_t properties, value_handle, handle_int;
+	char uuid_str[MAX_LEN_UUID_STR];
+	struct gatt_db_attribute *att;
+	bt_uuid_t *uuid;
+	char *type;
+
+	if (sscanf(handle, "%hu", &handle_int) != 1)
+		return -EIO;
+
+	type = g_key_file_get_string(key_file, handle, "Type", NULL);
+	if (!type)
+		return -EIO;
+
+	if (!g_str_equal(type, GATT_CHARAC_UUID_STR))
+		return -EIO;
+
+	uuid = g_key_file_get_uuid(key_file, handle, "Value", NULL);
+	value_handle = g_key_file_get_integer(key_file, handle, "ValueHandle",
+									NULL);
+	properties = g_key_file_get_integer(key_file, handle, "Properties",
+									NULL);
+
+	if (!uuid || !value_handle || !properties) {
+		if (uuid)
+			g_free(uuid);
+		return -EIO;
+	}
+
+	/* Log debug message. */
+	bt_uuid_to_string(uuid, uuid_str, sizeof(uuid_str));
+	DBG("loading characteristic handle: 0x%04x, value handle: 0x%04x,"
+				" properties 0x%04x uuid: %s", handle_int,
+				value_handle, properties, uuid_str);
+
+	att = gatt_db_service_insert_characteristic(service, value_handle, uuid,
+							0, properties, NULL,
+							NULL, NULL);
+
+	g_free(uuid);
+
+	if (!att || gatt_db_attribute_get_handle(att) != value_handle) {
+		warn("saving characteristic to db failed");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int load_incl(GKeyFile *key_file, char *handle,
+					struct gatt_db *db,
+					struct gatt_db_attribute *service)
+{
+	char uuid_str[MAX_LEN_UUID_STR];
+	struct gatt_db_attribute *att;
+	uint16_t start, end;
+	bt_uuid_t *uuid;
+	char *type;
+
+	if (sscanf(handle, "%hu", &start) != 1)
+		return -EIO;
+
+	type = g_key_file_get_string(key_file, handle, "Type", NULL);
+	if (!type)
+		return -EIO;
+
+	if (!g_str_equal(type, GATT_INCLUDE_UUID_STR)) {
+		DBG("got unexpected non-primary service!");
+		return -EIO;
+	}
+
+	uuid = g_key_file_get_uuid(key_file, handle, "Value", NULL);
+	start = g_key_file_get_integer(key_file, handle, "Start", NULL);
+	end = g_key_file_get_integer(key_file, handle, "End", NULL);
+
+	/* Log debug message. */
+	bt_uuid_to_string(uuid, uuid_str, sizeof(uuid_str));
+	DBG("loading included service: 0x%04x, end: 0x%04x, uuid: %s", start,
+								end, uuid_str);
+	g_free(uuid);
+
+	att = gatt_db_get_attribute(db, start);
+
+	if (!att) {
+		warn("saving included service to db failed - no such service");
+		return -EIO;
+	}
+
+	att = gatt_db_service_add_included(service, att);
+	if (!att) {
+		warn("saving included service to db failed");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int load_service(GKeyFile *key_file, char *handle,
+						struct gatt_db *db)
+{
+	char uuid_str[MAX_LEN_UUID_STR];
+	struct gatt_db_attribute *att;
+	uint16_t start, end;
+	bt_uuid_t *uuid;
+	char *type;
+	bool primary;
+
+	if (sscanf(handle, "%hu", &start) != 1)
+		return -EIO;
+
+	type = g_key_file_get_string(key_file, handle, "Type", NULL);
+	if (!type)
+		return -EIO;
+
+	if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR))
+		primary = true;
+	else if (g_str_equal(type, GATT_SND_SVC_UUID_STR))
+		primary = false;
+	else
+		return -EIO;
+
+	uuid = g_key_file_get_uuid(key_file, handle, "Value", NULL);
+	if (!uuid)
+		return -EIO;
+
+	end = g_key_file_get_integer(key_file, handle, "EndGroupHandle", NULL);
+
+	/* Log debug message. */
+	bt_uuid_to_string(uuid, uuid_str, sizeof(uuid_str));
+	DBG("loading service: 0x%04x, end: 0x%04x, uuid: %s",
+							start, end, uuid_str);
+
+	att = gatt_db_insert_service(db, start, uuid, primary,
+						end - start + 1);
+
+	g_free(uuid);
+
+	if (!att) {
+		DBG("ERROR saving service to db!");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int load_gatt_db_impl(GKeyFile *key_file, char **groups,
+							struct gatt_db *db)
+{
+	struct gatt_db_attribute *current_service;
+	char **handle, *type;
+	int ret;
+
+	/* first load service definitions */
+	for (handle = groups; *handle; handle++) {
+		type = g_key_file_get_string(key_file, *handle, "Type", NULL);
+
+		if (!type) {
+			warn("Missing Type in attribute definition");
+			return -EIO;
+		}
+
+		if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR) ||
+				g_str_equal(type, GATT_SND_SVC_UUID_STR)) {
+			ret = load_service(key_file, *handle, db);
+			if (ret)
+				return ret;
+		}
+	}
+
+	current_service = NULL;
+	/* then fill them with data*/
+	for (handle = groups; *handle; handle++) {
+		type = g_key_file_get_string(key_file, *handle, "Type", NULL);
+
+		if (!type) {
+			warn("Missing Type in attribute definition");
+			return -EIO;
+		}
+
+		if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR) ||
+				g_str_equal(type, GATT_SND_SVC_UUID_STR)) {
+			uint16_t tmp;
+			uint16_t start, end;
+			bool primary;
+			bt_uuid_t uuid;
+			char uuid_str[MAX_LEN_UUID_STR];
+
+			if (sscanf(*handle, "%hu", &tmp) != 1) {
+				warn("Unable to parse attribute handle");
+				return -EIO;
+			}
+
+			if (current_service)
+				gatt_db_service_set_active(current_service,
+									true);
+
+			current_service = gatt_db_get_attribute(db, tmp);
+
+			gatt_db_attribute_get_service_data(current_service,
+							&start, &end,
+							&primary, &uuid);
+
+			bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+			DBG("currently loading details of service: 0x%04x, end:"
+				" 0x%04x, uuid: %s", start, end, uuid_str);
+		} else if (g_str_equal(type, GATT_INCLUDE_UUID_STR)) {
+			ret = load_incl(key_file, *handle, db, current_service);
+		} else if (g_str_equal(type, GATT_CHARAC_UUID_STR)) {
+			ret = load_chrc(key_file, *handle, current_service);
+		} else {
+			ret = load_desc(key_file, *handle, current_service);
+		}
+
+		if (ret)
+			return ret;
+	}
+
+	if (current_service)
+		gatt_db_service_set_active(current_service, true);
+
+	return 0;
+}
+
+static void load_gatt_db(struct btd_device *device, const char *local,
+							const char *peer)
+{
+	char filename[PATH_MAX];
+	GKeyFile *key_file;
+	char *str;
+	char **groups, **handle;
+
+	DBG("Restoring %s gatt database from file", peer);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", local,
+			peer);
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	groups = g_key_file_get_groups(key_file, NULL);
+
+	if (load_gatt_db_impl(key_file, groups, device->db))
+		warn("Unable to load gatt db from file for %s", peer);
+
+	g_strfreev(groups);
+	g_key_file_free(key_file);
+
+	g_slist_free_full(device->primaries, g_free);
+	device->primaries = NULL;
+	gatt_db_foreach_service(device->db, NULL, add_primary,
+							&device->primaries);
+
+}
+
 static void device_add_uuids(struct btd_device *device, GSList *uuids)
 {
 	GSList *l;
@@ -3195,7 +3504,7 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
 	ba2str(src, srcaddr);
 
 	load_info(device, srcaddr, address, key_file);
-	load_att_info(device, srcaddr, address);
+	load_gatt_db(device, srcaddr, address);
 
 	return device;
 }
-- 
2.1.4

