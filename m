Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] attrib-server: Read/write CCC info from new storage
Date: Fri, 14 Dec 2012 17:45:19 +0100
Message-Id: <1355503519-26573-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355503519-26573-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355503519-26573-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove no more used storage functions.
---
 src/attrib-server.c |   79 +++++++++++++++++++++++++++++++++++++---------
 src/storage.c       |   87 ---------------------------------------------------
 src/storage.h       |    6 ----
 3 files changed, 64 insertions(+), 108 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 8dc0d6a..e3715e8 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -32,6 +32,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <glib.h>
+#include <sys/file.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
@@ -746,6 +747,36 @@ static uint16_t find_by_type(struct gatt_channel *channel, uint16_t start,
 	return len;
 }
 
+static int read_device_ccc(struct btd_device *device, uint16_t handle,
+				uint16_t *value)
+{
+	char *filename;
+	GKeyFile *key_file;
+	char group[6];
+	char *str;
+	unsigned int config;
+	int err = 0;
+
+	filename = btd_device_get_storage_path(device, "ccc");
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	sprintf(group, "%hu", handle);
+
+	str = g_key_file_get_string(key_file, group, "Value", NULL);
+	if (!str || sscanf(str, "%04X", &config) != 1)
+		err = -ENOENT;
+	else
+		*value = config;
+
+	g_free(str);
+	g_free(filename);
+	g_key_file_free(key_file);
+
+	return err;
+}
+
 static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 						uint8_t *pdu, size_t len)
 {
@@ -753,7 +784,6 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 	uint8_t status;
 	GList *l;
 	uint16_t cccval;
-	uint8_t bdaddr_type;
 	guint h = handle;
 
 	l = g_list_find_custom(channel->server->database,
@@ -764,11 +794,8 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 
 	a = l->data;
 
-	bdaddr_type = device_get_addr_type(channel->device);
-
 	if (bt_uuid_cmp(&ccc_uuid, &a->uuid) == 0 &&
-		read_device_ccc(&channel->src, &channel->dst, bdaddr_type,
-							handle, &cccval) == 0) {
+		read_device_ccc(channel->device, handle, &cccval) == 0) {
 		uint8_t config[2];
 
 		att_put_u16(cccval, config);
@@ -794,7 +821,6 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 	uint8_t status;
 	GList *l;
 	uint16_t cccval;
-	uint8_t bdaddr_type;
 	guint h = handle;
 
 	l = g_list_find_custom(channel->server->database,
@@ -809,11 +835,8 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle,
 					ATT_ECODE_INVALID_OFFSET, pdu, len);
 
-	bdaddr_type = device_get_addr_type(channel->device);
-
 	if (bt_uuid_cmp(&ccc_uuid, &a->uuid) == 0 &&
-		read_device_ccc(&channel->src, &channel->dst, bdaddr_type,
-							handle, &cccval) == 0) {
+		read_device_ccc(channel->device, handle, &cccval) == 0) {
 		uint8_t config[2];
 
 		att_put_u16(cccval, config);
@@ -869,10 +892,31 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 		}
 	} else {
 		uint16_t cccval = att_get_u16(value);
-		uint8_t bdaddr_type = device_get_addr_type(channel->device);
+		char *filename;
+		GKeyFile *key_file;
+		char group[6], value[5];
+		char *data;
+		gsize length = 0;
+
+		filename = btd_device_get_storage_path(channel->device, "ccc");
+
+		key_file = g_key_file_new();
+		g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+		sprintf(group, "%hu", handle);
+		sprintf(value, "%hhX", cccval);
+		g_key_file_set_string(key_file, group, "Value", value);
+
+		data = g_key_file_to_data(key_file, &length, NULL);
+		if (length > 0) {
+			create_file(filename,
+					S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+			g_file_set_contents(filename, data, length, NULL);
+		}
 
-		write_device_ccc(&channel->src, &channel->dst, bdaddr_type,
-								handle, cccval);
+		g_free(data);
+		g_free(filename);
+		g_key_file_free(key_file);
 	}
 
 	return enc_write_resp(pdu, len);
@@ -1089,8 +1133,13 @@ guint attrib_channel_attach(GAttrib *attrib)
 	ba2str(&channel->dst, addr);
 
 	device = adapter_find_device(server->adapter, addr);
-	if (device == NULL || device_is_bonded(device) == FALSE)
-		delete_device_ccc(&channel->src, &channel->dst);
+	if (device == NULL || device_is_bonded(device) == FALSE) {
+		char *filename;
+
+		filename = btd_device_get_storage_path(channel->device, "ccc");
+		unlink(filename);
+		g_free(filename);
+	}
 
 	if (cid != ATT_CID) {
 		channel->le = FALSE;
diff --git a/src/storage.c b/src/storage.c
index 02ac1f3..38e5897 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -272,90 +272,3 @@ int read_device_pairable(const bdaddr_t *bdaddr, gboolean *mode)
 
 	return 0;
 }
-
-static void filter_keys(char *key, char *value, void *data)
-{
-	struct match *match = data;
-
-	if (strncasecmp(key, match->pattern, strlen(match->pattern)) == 0)
-		match->keys = g_slist_append(match->keys, g_strdup(key));
-}
-
-static void delete_by_pattern(const char *filename, char *pattern)
-{
-	struct match match;
-	GSList *l;
-	int err;
-
-	memset(&match, 0, sizeof(match));
-	match.pattern = pattern;
-
-	err = textfile_foreach(filename, filter_keys, &match);
-	if (err < 0)
-		goto done;
-
-	for (l = match.keys; l; l = l->next) {
-		const char *key = l->data;
-		textfile_del(filename, key);
-	}
-
-done:
-	g_slist_free_full(match.keys, g_free);
-}
-
-int read_device_ccc(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t bdaddr_type, uint16_t handle,
-					uint16_t *value)
-{
-	char filename[PATH_MAX + 1], addr[18], key[25];
-	char *str;
-	unsigned int config;
-	int err = 0;
-
-	create_filename(filename, PATH_MAX, local, "ccc");
-
-	ba2str(peer, addr);
-	snprintf(key, sizeof(key), "%17s#%hhu#%04X", addr, bdaddr_type, handle);
-
-	str = textfile_caseget(filename, key);
-	if (str == NULL)
-		return -ENOENT;
-
-	if (sscanf(str, "%04X", &config) != 1)
-		err = -ENOENT;
-	else
-		*value = config;
-
-	free(str);
-
-	return err;
-}
-
-int write_device_ccc(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t bdaddr_type, uint16_t handle,
-					uint16_t value)
-{
-	char filename[PATH_MAX + 1], addr[18], key[25], config[5];
-
-	create_filename(filename, PATH_MAX, local, "ccc");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(peer, addr);
-	snprintf(key, sizeof(key), "%17s#%hhu#%04X", addr, bdaddr_type, handle);
-
-	snprintf(config, sizeof(config), "%04X", value);
-
-	return textfile_put(filename, key, config);
-}
-
-void delete_device_ccc(const bdaddr_t *local, const bdaddr_t *peer)
-{
-	char filename[PATH_MAX + 1], addr[18];
-
-	ba2str(peer, addr);
-
-	/* Deleting all CCC values of a given address */
-	create_filename(filename, PATH_MAX, local, "ccc");
-	delete_by_pattern(filename, addr);
-}
diff --git a/src/storage.h b/src/storage.h
index 682523a..cc7f930 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -35,9 +35,3 @@ ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin);
 sdp_record_t *record_from_string(const gchar *str);
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid);
 int read_device_pairable(const bdaddr_t *local, gboolean *mode);
-int read_device_ccc(const bdaddr_t *local, const bdaddr_t *peer,
-			uint8_t bdaddr_type, uint16_t handle, uint16_t *value);
-int write_device_ccc(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t bdaddr_type, uint16_t handle,
-					uint16_t value);
-void delete_device_ccc(const bdaddr_t *local, const bdaddr_t *peer);
-- 
1.7.9.5

