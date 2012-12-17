Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/13] gatt: Use new storage architecture
Date: Mon, 17 Dec 2012 16:09:48 +0100
Message-Id: <1355756994-18953-7-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/gatt/gas.c |   80 +++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 2c1dc83..c9353f6 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -77,60 +77,58 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return (gas->device == device ? 0 : -1);
 }
 
-static inline int create_filename(char *buf, size_t size,
-				const bdaddr_t *bdaddr, const char *name)
-{
-	char addr[18];
-
-	ba2str(bdaddr, addr);
-
-	return create_name(buf, size, STORAGEDIR, addr, name);
-}
-
-static int write_ctp_handle(const bdaddr_t *sba, const bdaddr_t *dba,
-					uint8_t bdaddr_type, uint16_t uuid,
+static void write_ctp_handle(struct btd_device *device, uint16_t uuid,
 					uint16_t handle)
 {
-	char filename[PATH_MAX + 1], addr[18], key[27], value[7];
+	char *filename, group[6], value[7];
+	GKeyFile *key_file;
+	char *data;
+	gsize length = 0;
 
-	create_filename(filename, PATH_MAX, sba, "gatt");
+	filename = btd_device_get_storage_path(device, "gatt");
 
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	ba2str(dba, addr);
+	snprintf(group, sizeof(group), "%hu", uuid);
+	snprintf(value, sizeof(value), "0x%4.4X", handle);
+	g_key_file_set_string(key_file, group, "Value", value);
 
-	snprintf(key, sizeof(key), "%17s#%hhu#0x%4.4x", addr, bdaddr_type,
-									uuid);
-	snprintf(value, sizeof(value), "0x%4.4x", handle);
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		g_file_set_contents(filename, data, length, NULL);
+	}
 
-	return textfile_put(filename, key, value);
+	g_free(data);
+	g_free(filename);
+	g_key_file_free(key_file);
 }
 
-static int read_ctp_handle(const bdaddr_t *sba, const bdaddr_t *dba,
-					uint8_t bdaddr_type, uint16_t uuid,
+static int read_ctp_handle(struct btd_device *device, uint16_t uuid,
 					uint16_t *value)
 {
-	char filename[PATH_MAX + 1], addr[18], key[27];
+	char *filename, group[6];
+	GKeyFile *key_file;
 	char *str;
+	int err = 0;
 
-	create_filename(filename, PATH_MAX, sba, "gatt");
+	filename = btd_device_get_storage_path(device, "gatt");
 
-	ba2str(dba, addr);
-	snprintf(key, sizeof(key), "%17s#%hhu#0x%04x", addr, bdaddr_type,
-									uuid);
+	snprintf(group, sizeof(group), "%hu", uuid);
 
-	str = textfile_get(filename, key);
-	if (str == NULL)
-		return -errno;
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	if (sscanf(str, "%hx", value) != 1) {
-		free(str);
-		return -ENOENT;
-	}
+	str = g_key_file_get_string(key_file, group, "Value", NULL);
+	if (str == NULL || sscanf(str, "%hx", value) != 1)
+		err = -ENOENT;
 
-	free(str);
+	g_free(str);
+	g_free(filename);
+	g_key_file_free(key_file);
 
-	return 0;
+	return err;
 }
 
 static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
@@ -214,10 +212,7 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu, guint16 plen,
 						gas->changed_handle,
 						indication_cb, gas, NULL);
 
-	write_ctp_handle(adapter_get_address(device_get_adapter(gas->device)),
-					device_get_address(gas->device),
-					device_get_addr_type(gas->device),
-					GATT_CHARAC_SERVICE_CHANGED,
+	write_ctp_handle(gas->device, GATT_CHARAC_SERVICE_CHANGED,
 					gas->changed_handle);
 }
 
@@ -391,10 +386,7 @@ int gas_register(struct btd_device *device, struct att_range *gap,
 						attio_connected_cb,
 						attio_disconnected_cb, gas);
 
-	read_ctp_handle(adapter_get_address(device_get_adapter(gas->device)),
-					device_get_address(gas->device),
-					device_get_addr_type(gas->device),
-					GATT_CHARAC_SERVICE_CHANGED,
+	read_ctp_handle(gas->device, GATT_CHARAC_SERVICE_CHANGED,
 					&gas->changed_handle);
 
 	return 0;
-- 
1.7.9.5

