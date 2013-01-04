Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [REVIEW] adapter: Fix storage to be used by BlueZ 4 or 5
Date: Fri,  4 Jan 2013 14:12:54 +0100
Message-Id: <1357305174-13313-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Conversion should be performed only one time, but using "converted"
entry in device related files generates a bogus device object with
dev_CONVERTED path when starting BlueZ 4.

If "settings" file has been created we've done the conversion and
we can use it to check if conversion has already been done.

Remove "converted" entries in converted files
---
 src/adapter.c |  179 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 96 insertions(+), 83 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ec2e8bd..ea7b6cf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2143,23 +2143,15 @@ static void convert_file(char *file, char *address,
 {
 	char filename[PATH_MAX + 1];
 	struct device_converter converter;
-	char *str;
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", address, file);
 	filename[PATH_MAX] = '\0';
 
-	str = textfile_get(filename, "converted");
-	if (str && strcmp(str, "yes") == 0) {
-		DBG("Legacy file %s already converted", filename);
-	} else {
-		converter.address = address;
-		converter.cb = cb;
-		converter.force = force;
+	converter.address = address;
+	converter.cb = cb;
+	converter.force = force;
 
-		textfile_foreach(filename, convert_entry, &converter);
-		textfile_put(filename, "converted", "yes");
-	}
-	free(str);
+	textfile_foreach(filename, convert_entry, &converter);
 }
 
 static gboolean record_has_uuid(const sdp_record_t *rec,
@@ -2556,22 +2548,13 @@ static void convert_device_storage(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
 	char address[18];
-	char *str;
 
 	ba2str(&adapter->bdaddr, address);
 
 	/* Convert device's name cache */
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/names", address);
 	filename[PATH_MAX] = '\0';
-
-	str = textfile_get(filename, "converted");
-	if (str && strcmp(str, "yes") == 0) {
-		DBG("Legacy names file already converted");
-	} else {
-		textfile_foreach(filename, convert_names_entry, address);
-		textfile_put(filename, "converted", "yes");
-	}
-	free(str);
+	textfile_foreach(filename, convert_names_entry, address);
 
 	/* Convert aliases */
 	convert_file("aliases", address, convert_aliases_entry, TRUE);
@@ -2588,15 +2571,7 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	/* Convert primaries */
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/primaries", address);
 	filename[PATH_MAX] = '\0';
-
-	str = textfile_get(filename, "converted");
-	if (str && strcmp(str, "yes") == 0) {
-		DBG("Legacy %s file already converted", filename);
-	} else {
-		textfile_foreach(filename, convert_primaries_entry, address);
-		textfile_put(filename, "converted", "yes");
-	}
-	free(str);
+	textfile_foreach(filename, convert_primaries_entry, address);
 
 	/* Convert linkkeys */
 	convert_file("linkkeys", address, convert_linkkey_entry, TRUE);
@@ -2613,28 +2588,12 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	/* Convert sdp */
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/sdp", address);
 	filename[PATH_MAX] = '\0';
-
-	str = textfile_get(filename, "converted");
-	if (str && strcmp(str, "yes") == 0) {
-		DBG("Legacy %s file already converted", filename);
-	} else {
-		textfile_foreach(filename, convert_sdp_entry, address);
-		textfile_put(filename, "converted", "yes");
-	}
-	free(str);
+	textfile_foreach(filename, convert_sdp_entry, address);
 
 	/* Convert ccc */
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/ccc", address);
 	filename[PATH_MAX] = '\0';
-
-	str = textfile_get(filename, "converted");
-	if (str && strcmp(str, "yes") == 0) {
-		DBG("Legacy %s file already converted", filename);
-	} else {
-		textfile_foreach(filename, convert_ccc_entry, address);
-		textfile_put(filename, "converted", "yes");
-	}
-	free(str);
+	textfile_foreach(filename, convert_ccc_entry, address);
 
 	/* Convert appearances */
 	convert_file("appearances", address, convert_appearances_entry, FALSE);
@@ -2642,28 +2601,12 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	/* Convert gatt */
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/gatt", address);
 	filename[PATH_MAX] = '\0';
-
-	str = textfile_get(filename, "converted");
-	if (str && strcmp(str, "yes") == 0) {
-		DBG("Legacy %s file already converted", filename);
-	} else {
-		textfile_foreach(filename, convert_gatt_entry, address);
-		textfile_put(filename, "converted", "yes");
-	}
-	free(str);
+	textfile_foreach(filename, convert_gatt_entry, address);
 
 	/* Convert proximity */
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/proximity", address);
 	filename[PATH_MAX] = '\0';
-
-	str = textfile_get(filename, "converted");
-	if (str && strcmp(str, "yes") == 0) {
-		DBG("Legacy %s file already converted", filename);
-	} else {
-		textfile_foreach(filename, convert_proximity_entry, address);
-		textfile_put(filename, "converted", "yes");
-	}
-	free(str);
+	textfile_foreach(filename, convert_proximity_entry, address);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
@@ -2672,7 +2615,6 @@ static void convert_config(struct btd_adapter *adapter, const char *filename,
 	char address[18];
 	char str[MAX_NAME_LENGTH + 1];
 	char config_path[PATH_MAX + 1];
-	char *converted;
 	gboolean flag;
 	int timeout;
 	uint8_t mode;
@@ -2683,17 +2625,6 @@ static void convert_config(struct btd_adapter *adapter, const char *filename,
 	snprintf(config_path, PATH_MAX, STORAGEDIR "/%s/config", address);
 	config_path[PATH_MAX] = '\0';
 
-	converted = textfile_get(config_path, "converted");
-	if (converted) {
-		if (strcmp(converted, "yes") == 0) {
-			DBG("Legacy config file already converted");
-			free(converted);
-			return;
-		}
-
-		free(converted);
-	}
-
 	if (read_device_pairable(&adapter->bdaddr, &flag) == 0)
 		g_key_file_set_boolean(key_file, "General", "Pairable", flag);
 
@@ -2719,8 +2650,6 @@ static void convert_config(struct btd_adapter *adapter, const char *filename,
 	data = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, data, length, NULL);
 	g_free(data);
-
-	textfile_put(config_path, "converted", "yes");
 }
 
 static void load_config(struct btd_adapter *adapter)
@@ -2728,6 +2657,7 @@ static void load_config(struct btd_adapter *adapter)
 	GKeyFile *key_file;
 	char filename[PATH_MAX + 1];
 	char address[18];
+	struct stat st;
 	GError *gerr = NULL;
 	gboolean stored_discoverable;
 
@@ -2738,8 +2668,12 @@ static void load_config(struct btd_adapter *adapter)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
 	filename[PATH_MAX] = '\0';
 
-	if (!g_key_file_load_from_file(key_file, filename, 0, NULL))
+	if (stat(filename, &st) < 0) {
 		convert_config(adapter, filename, key_file);
+		convert_device_storage(adapter);
+	}
+
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
 	/* Get alias */
 	adapter->stored_name = g_key_file_get_string(key_file, "General",
@@ -2813,6 +2747,85 @@ static void load_config(struct btd_adapter *adapter)
 	g_key_file_free(key_file);
 }
 
+static void fix_storage(struct btd_adapter *adapter)
+{
+	char filename[PATH_MAX + 1];
+	char address[18];
+	char *converted;
+
+	ba2str(&adapter->bdaddr, address);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/config", address);
+	filename[PATH_MAX] = '\0';
+	converted = textfile_get(filename, "converted");
+	if (!converted)
+		return;
+
+	free(converted);
+
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/names", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/aliases", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/trusts", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/blocked", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/profiles", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/primaries", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/linkkeys", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/longtermkeys", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/classes", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/did", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/sdp", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/ccc", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/appearances", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/gatt", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/proximity", address);
+	filename[PATH_MAX] = '\0';
+	textfile_del(filename, "converted");
+}
+
 static gboolean adapter_setup(struct btd_adapter *adapter, uint32_t settings)
 {
 	struct agent *agent;
@@ -2840,7 +2853,7 @@ static gboolean adapter_setup(struct btd_adapter *adapter, uint32_t settings)
 	btd_adapter_gatt_server_start(adapter);
 
 	load_config(adapter);
-	convert_device_storage(adapter);
+	fix_storage(adapter);
 	load_drivers(adapter);
 	btd_profile_foreach(probe_profile, adapter);
 	clear_blocked(adapter);
-- 
1.7.9.5

