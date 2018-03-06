Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] Fix storage for adapters without public address
Date: Tue,  6 Mar 2018 14:28:07 +0100
Message-Id: <20180306132807.6149-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since those have adapter folder prefixed with "static-" this needs
to be taken into account when storing data.
---
 src/adapter.c | 26 +++++++++---------
 src/adapter.h |  1 +
 src/device.c  | 87 +++++++++++++++++++++++++++--------------------------------
 3 files changed, 54 insertions(+), 60 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index eddfd4c25..6d7d61504 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -432,7 +432,7 @@ static uint8_t get_mode(const char *mode)
 		return MODE_UNKNOWN;
 }
 
-static const char *adapter_dir(struct btd_adapter *adapter)
+const char *btd_adapter_get_storage_dir(struct btd_adapter *adapter)
 {
 	static char dir[25];
 
@@ -484,7 +484,7 @@ static void store_adapter_info(struct btd_adapter *adapter)
 							adapter->stored_alias);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings",
-						adapter_dir(adapter));
+					btd_adapter_get_storage_dir(adapter));
 
 	create_file(filename, S_IRUSR | S_IWUSR);
 
@@ -3562,7 +3562,7 @@ static int load_irk(struct btd_adapter *adapter, uint8_t *irk)
 	int ret;
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/identity",
-						adapter_dir(adapter));
+					btd_adapter_get_storage_dir(adapter));
 
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
@@ -4003,7 +4003,8 @@ static void load_devices(struct btd_adapter *adapter)
 	DIR *dir;
 	struct dirent *entry;
 
-	snprintf(dirname, PATH_MAX, STORAGEDIR "/%s", adapter_dir(adapter));
+	snprintf(dirname, PATH_MAX, STORAGEDIR "/%s",
+					btd_adapter_get_storage_dir(adapter));
 
 	dir = opendir(dirname);
 	if (!dir) {
@@ -4030,7 +4031,8 @@ static void load_devices(struct btd_adapter *adapter)
 			continue;
 
 		snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
-					adapter_dir(adapter), entry->d_name);
+					btd_adapter_get_storage_dir(adapter),
+					entry->d_name);
 
 		key_file = g_key_file_new();
 		g_key_file_load_from_file(key_file, filename, 0, NULL);
@@ -5634,7 +5636,7 @@ static void load_config(struct btd_adapter *adapter)
 	key_file = g_key_file_new();
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings",
-						adapter_dir(adapter));
+					btd_adapter_get_storage_dir(adapter));
 
 	if (stat(filename, &st) < 0) {
 		convert_config(adapter, filename, key_file);
@@ -7285,7 +7287,7 @@ static void store_link_key(struct btd_adapter *adapter,
 	ba2str(device_get_address(device), device_addr);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
-					adapter_dir(adapter), device_addr);
+			btd_adapter_get_storage_dir(adapter), device_addr);
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
@@ -7375,7 +7377,7 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 	ba2str(peer, device_addr);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
-					adapter_dir(adapter), device_addr);
+			btd_adapter_get_storage_dir(adapter), device_addr);
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
@@ -7504,7 +7506,7 @@ static void store_csrk(struct btd_adapter *adapter, const bdaddr_t *peer,
 	ba2str(peer, device_addr);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
-					adapter_dir(adapter), device_addr);
+			btd_adapter_get_storage_dir(adapter), device_addr);
 
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
@@ -7575,7 +7577,7 @@ static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
 	ba2str(peer, device_addr);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
-					adapter_dir(adapter), device_addr);
+			btd_adapter_get_storage_dir(adapter), device_addr);
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
@@ -7663,7 +7665,7 @@ static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
 	DBG("");
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
-					adapter_dir(adapter), device_addr);
+			btd_adapter_get_storage_dir(adapter), device_addr);
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
@@ -8242,7 +8244,7 @@ static void remove_keys(struct btd_adapter *adapter,
 	ba2str(device_get_address(device), device_addr);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
-					adapter_dir(adapter), device_addr);
+			btd_adapter_get_storage_dir(adapter), device_addr);
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
diff --git a/src/adapter.h b/src/adapter.h
index 016d3d75b..d0a5253bd 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -95,6 +95,7 @@ struct btd_device *btd_adapter_find_device(struct btd_adapter *adapter,
 const char *adapter_get_path(struct btd_adapter *adapter);
 const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter);
 uint8_t btd_adapter_get_address_type(struct btd_adapter *adapter);
+const char *btd_adapter_get_storage_dir(struct btd_adapter *adapter);
 int adapter_set_name(struct btd_adapter *adapter, const char *name);
 
 int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec);
diff --git a/src/device.c b/src/device.c
index b86a35c81..8af77dbc8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -369,7 +369,6 @@ static gboolean store_device_info_cb(gpointer user_data)
 	struct btd_device *device = user_data;
 	GKeyFile *key_file;
 	char filename[PATH_MAX];
-	char adapter_addr[18];
 	char device_addr[18];
 	char *str;
 	char class[9];
@@ -378,10 +377,10 @@ static gboolean store_device_info_cb(gpointer user_data)
 
 	device->store_id = 0;
 
-	ba2str(btd_adapter_get_address(device->adapter), adapter_addr);
 	ba2str(&device->bdaddr, device_addr);
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
-			device_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+				btd_adapter_get_storage_dir(device->adapter),
+				device_addr);
 
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
@@ -491,7 +490,7 @@ static void store_device_info(struct btd_device *device)
 void device_store_cached_name(struct btd_device *dev, const char *name)
 {
 	char filename[PATH_MAX];
-	char s_addr[18], d_addr[18];
+	char d_addr[18];
 	GKeyFile *key_file;
 	char *data;
 	gsize length = 0;
@@ -502,9 +501,9 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
 		return;
 	}
 
-	ba2str(btd_adapter_get_address(dev->adapter), s_addr);
 	ba2str(&dev->bdaddr, d_addr);
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", s_addr, d_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+			btd_adapter_get_storage_dir(dev->adapter), d_addr);
 	create_file(filename, S_IRUSR | S_IWUSR);
 
 	key_file = g_key_file_new();
@@ -1996,9 +1995,8 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 
 static void store_services(struct btd_device *device)
 {
-	struct btd_adapter *adapter = device->adapter;
 	char filename[PATH_MAX];
-	char src_addr[18], dst_addr[18];
+	char dst_addr[18];
 	uuid_t uuid;
 	char *prim_uuid;
 	GKeyFile *key_file;
@@ -2017,11 +2015,11 @@ static void store_services(struct btd_device *device)
 	if (prim_uuid == NULL)
 		return;
 
-	ba2str(btd_adapter_get_address(adapter), src_addr);
 	ba2str(&device->bdaddr, dst_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", src_addr,
-								dst_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes",
+				btd_adapter_get_storage_dir(device->adapter),
+				dst_addr);
 	key_file = g_key_file_new();
 
 	for (l = device->primaries; l; l = l->next) {
@@ -2187,9 +2185,8 @@ static void store_service(struct gatt_db_attribute *attr, void *user_data)
 
 static void store_gatt_db(struct btd_device *device)
 {
-	struct btd_adapter *adapter = device->adapter;
 	char filename[PATH_MAX];
-	char src_addr[18], dst_addr[18];
+	char dst_addr[18];
 	GKeyFile *key_file;
 	char *data;
 	gsize length = 0;
@@ -2204,11 +2201,11 @@ static void store_gatt_db(struct btd_device *device)
 	if (!gatt_cache_is_enabled(device))
 		return;
 
-	ba2str(btd_adapter_get_address(adapter), src_addr);
 	ba2str(&device->bdaddr, dst_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", src_addr,
-								dst_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+				btd_adapter_get_storage_dir(device->adapter),
+				dst_addr);
 	create_file(filename, S_IRUSR | S_IWUSR);
 
 	key_file = g_key_file_new();
@@ -3738,8 +3735,7 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
 				const char *address, GKeyFile *key_file)
 {
 	struct btd_device *device;
-	const bdaddr_t *src;
-	char srcaddr[18];
+	const char *src_dir;
 
 	DBG("address %s", address);
 
@@ -3747,13 +3743,12 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
 	if (device == NULL)
 		return NULL;
 
-	src = btd_adapter_get_address(adapter);
-	ba2str(src, srcaddr);
-
 	convert_info(device, key_file);
 
-	load_info(device, srcaddr, address, key_file);
-	load_att_info(device, srcaddr, address);
+	src_dir = btd_adapter_get_storage_dir(adapter);
+
+	load_info(device, src_dir, address, key_file);
+	load_att_info(device, src_dir, address);
 
 	return device;
 }
@@ -3762,8 +3757,7 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 				const bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	struct btd_device *device;
-	const bdaddr_t *sba;
-	char src[18], dst[18];
+	char dst[18];
 	char *str;
 
 	ba2str(bdaddr, dst);
@@ -3780,10 +3774,8 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	else
 		device->le = true;
 
-	sba = btd_adapter_get_address(adapter);
-	ba2str(sba, src);
-
-	str = load_cached_name(device, src, dst);
+	str = load_cached_name(device, btd_adapter_get_storage_dir(adapter),
+									dst);
 	if (str) {
 		strcpy(device->name, str);
 		g_free(str);
@@ -3795,7 +3787,7 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 char *btd_device_get_storage_path(struct btd_device *device,
 				const char *filename)
 {
-	char srcaddr[18], dstaddr[18];
+	char dstaddr[18];
 
 	if (device_address_is_private(device)) {
 		warn("Refusing storage path for private addressed device %s",
@@ -3803,14 +3795,16 @@ char *btd_device_get_storage_path(struct btd_device *device,
 		return NULL;
 	}
 
-	ba2str(btd_adapter_get_address(device->adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
 	if (!filename)
-		return g_strdup_printf(STORAGEDIR "/%s/%s", srcaddr, dstaddr);
+		return g_strdup_printf(STORAGEDIR "/%s/%s",
+				btd_adapter_get_storage_dir(device->adapter),
+				dstaddr);
 
-	return g_strdup_printf(STORAGEDIR "/%s/%s/%s", srcaddr, dstaddr,
-							filename);
+	return g_strdup_printf(STORAGEDIR "/%s/%s/%s",
+				btd_adapter_get_storage_dir(device->adapter),
+				dstaddr, filename);
 }
 
 void btd_device_device_set_name(struct btd_device *device, const char *name)
@@ -4007,8 +4001,6 @@ static void delete_folder_tree(const char *dirname)
 
 static void device_remove_stored(struct btd_device *device)
 {
-	const bdaddr_t *src = btd_adapter_get_address(device->adapter);
-	char adapter_addr[18];
 	char device_addr[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
@@ -4033,15 +4025,16 @@ static void device_remove_stored(struct btd_device *device)
 	if (device->blocked)
 		device_unblock(device, TRUE, FALSE);
 
-	ba2str(src, adapter_addr);
 	ba2str(&device->bdaddr, device_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", adapter_addr,
-			device_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s",
+				btd_adapter_get_storage_dir(device->adapter),
+				device_addr);
 	delete_folder_tree(filename);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", adapter_addr,
-			device_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+				btd_adapter_get_storage_dir(device->adapter),
+				device_addr);
 
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
@@ -4875,8 +4868,8 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	uint16_t mtu;
 	uint16_t cid;
 	struct btd_gatt_database *database;
-	const bdaddr_t *src, *dst;
-	char srcaddr[18], dstaddr[18];
+	const bdaddr_t *dst;
+	char dstaddr[18];
 
 	bt_io_get(io, &gerr, BT_IO_OPT_SEC_LEVEL, &sec_level,
 						BT_IO_OPT_IMTU, &mtu,
@@ -4928,14 +4921,12 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 
 	database = btd_adapter_get_database(dev->adapter);
 
-	src = btd_adapter_get_address(dev->adapter);
-	ba2str(src, srcaddr);
-
 	dst = device_get_address(dev);
 	ba2str(dst, dstaddr);
 
 	if (gatt_db_isempty(dev->db))
-		load_gatt_db(dev, srcaddr, dstaddr);
+		load_gatt_db(dev, btd_adapter_get_storage_dir(dev->adapter),
+								dstaddr);
 
 	gatt_client_init(dev);
 	gatt_server_init(dev, btd_gatt_database_get_db(database));
-- 
2.14.3

