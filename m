Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 09/10] adapter: Move saved config to ini-file format
Date: Wed, 10 Oct 2012 18:23:30 +0200
Message-Id: <1349886211-18920-10-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1349886211-18920-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349886211-18920-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Read and write config file in ini-file format.
If the file can not be loaded, try to convert legacy configuration.
---
 src/adapter.c |  206 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 174 insertions(+), 32 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 85c5da9..6b4197c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -33,6 +33,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <sys/ioctl.h>
+#include <sys/file.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
@@ -84,6 +85,8 @@
 
 #define OFF_TIMER 3
 
+#define SETTINGS_PATH STORAGEDIR "/%s/settings"
+
 static GSList *adapter_drivers = NULL;
 
 enum session_req_type {
@@ -224,6 +227,54 @@ static uint8_t get_mode(const char *mode)
 		return MODE_UNKNOWN;
 }
 
+static void write_config(struct btd_adapter *adapter)
+{
+	GKeyFile *key_file;
+	char filename[PATH_MAX + 1];
+	char address[18];
+	char *str;
+	gsize length = 0;
+
+	key_file = g_key_file_new();
+
+	g_key_file_set_string(key_file, "General", "Name",
+				adapter->config.name);
+
+	str = g_strdup_printf("0x%2.2x%2.2x%2.2x", adapter->config.class[2],
+				adapter->config.class[1],
+				adapter->config.class[0]);
+	g_key_file_set_string(key_file, "General", "Class", str);
+	g_free(str);
+
+	g_key_file_set_boolean(key_file, "General", "Pairable",
+				adapter->pairable);
+
+	if (adapter->pairable_timeout != main_opts.pairto)
+		g_key_file_set_integer(key_file, "General", "PairableTimeout",
+					adapter->pairable_timeout);
+
+	if (adapter->discov_timeout != main_opts.discovto)
+		g_key_file_set_integer(key_file, "General",
+					"DiscoverableTimeout",
+					adapter->discov_timeout);
+
+	g_key_file_set_string(key_file, "General", "Mode",
+				mode2str(adapter->config.mode));
+	g_key_file_set_string(key_file, "General", "OnMode",
+				mode2str(adapter->config.on_mode));
+
+	ba2str(&adapter->bdaddr, address);
+	snprintf(filename, PATH_MAX, SETTINGS_PATH, address);
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, str, length, NULL);
+	g_free(str);
+
+	g_key_file_free(key_file);
+}
+
 static struct session_req *session_ref(struct session_req *req)
 {
 	req->refcount++;
@@ -293,7 +344,6 @@ static struct session_req *find_session_by_msg(GSList *list, const DBusMessage *
 static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 {
 	int err;
-	const char *modestr;
 
 	if (adapter->pending_mode != NULL)
 		return -EALREADY;
@@ -329,10 +379,9 @@ done:
 	if (new_mode != MODE_OFF)
 		adapter->config.on_mode = new_mode;
 
-	modestr = mode2str(new_mode);
-	write_device_mode(&adapter->bdaddr, modestr);
+	write_config(adapter);
 
-	DBG("%s", modestr);
+	DBG("%s", mode2str(new_mode));
 
 	return 0;
 }
@@ -475,7 +524,7 @@ void btd_adapter_pairable_changed(struct btd_adapter *adapter,
 {
 	adapter->pairable = pairable;
 
-	write_device_pairable(&adapter->bdaddr, pairable);
+	write_config(adapter);
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
 					ADAPTER_INTERFACE, "Pairable");
@@ -692,7 +741,7 @@ static void set_discoverable_timeout(struct btd_adapter *adapter,
 
 	adapter->discov_timeout = timeout;
 
-	write_discoverable_timeout(&adapter->bdaddr, timeout);
+	write_config(adapter);
 
 	g_dbus_emit_property_changed(conn, adapter->path, ADAPTER_INTERFACE,
 						"DiscoverableTimeout");
@@ -712,7 +761,7 @@ static void set_pairable_timeout(struct btd_adapter *adapter,
 
 	adapter->pairable_timeout = timeout;
 
-	write_pairable_timeout(&adapter->bdaddr, timeout);
+	write_config(adapter);
 
 	g_dbus_emit_property_changed(conn, adapter->path, ADAPTER_INTERFACE,
 							"PairableTimeout");
@@ -732,7 +781,7 @@ void btd_adapter_class_changed(struct btd_adapter *adapter, uint8_t *new_class)
 	adapter->config.class[1] = new_class[1];
 	adapter->config.class[2] = new_class[2];
 
-	write_local_class(&adapter->bdaddr, new_class);
+	write_config(adapter);
 
 	adapter->dev_class = class;
 
@@ -792,7 +841,7 @@ int adapter_set_name(struct btd_adapter *adapter, const char *name)
 	g_free(adapter->config.name);
 	adapter->config.name = g_strdup(maxname);
 
-	write_local_name(&adapter->bdaddr, maxname);
+	write_config(adapter);
 
 	return 0;
 }
@@ -2479,17 +2528,15 @@ static void set_mode_complete(struct btd_adapter *adapter)
 {
 	DBusConnection *conn = btd_get_dbus_connection();
 	struct session_req *pending;
-	const char *modestr;
 	int err;
 
 	adapter->config.mode = adapter->mode;
 	if (adapter->mode != MODE_OFF)
 		adapter->config.on_mode = adapter->mode;
 
-	modestr = mode2str(adapter->mode);
-	write_device_mode(&adapter->bdaddr, modestr);
+	write_config(adapter);
 
-	DBG("%s", modestr);
+	DBG("%s", mode2str(adapter->mode));
 
 	if (adapter->mode == MODE_OFF) {
 		g_slist_free_full(adapter->mode_sessions, session_free);
@@ -2656,56 +2703,151 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 	g_free(path);
 }
 
-static void load_config(struct btd_adapter *adapter)
+static void convert_config(struct btd_adapter *adapter, const char *filename,
+				GKeyFile *key_file)
 {
-	char name[MAX_NAME_LENGTH + 1];
 	char address[18];
-	char mode[14];
+	char str[MAX_NAME_LENGTH + 1];
+	char config_path[PATH_MAX + 1];
+	char *converted;
+	uint8_t class[3];
+	gboolean flag;
 	int timeout;
+	char *data;
+	gsize length = 0;
+
+	ba2str(&adapter->bdaddr, address);
+	snprintf(config_path, PATH_MAX, STORAGEDIR "/%s/config", address);
+
+	converted = textfile_get(config_path, "converted");
+	if (converted) {
+		if (strcmp(converted, "yes") == 0) {
+			DBG("Legacy config file already converted");
+			return;
+		}
+
+		g_free(converted);
+	}
+
+	if (read_local_name(&adapter->bdaddr, str) == 0)
+		g_key_file_set_string(key_file, "General", "Name", str);
+
+	if (read_local_class(&adapter->bdaddr, class) == 0) {
+		sprintf(str, "0x%2.2x%2.2x%2.2x", class[2], class[1], class[0]);
+		g_key_file_set_string(key_file, "General", "Class", str);
+	}
+
+	if (read_device_pairable(&adapter->bdaddr, &flag) == 0)
+		g_key_file_set_boolean(key_file, "General", "Pairable", flag);
+
+	if (read_pairable_timeout(address, &timeout) == 0)
+		g_key_file_set_integer(key_file, "General",
+						"PairableTimeout", timeout);
+
+	if (read_discoverable_timeout(address, &timeout) == 0)
+		g_key_file_set_integer(key_file, "General",
+						"DiscoverableTimeout", timeout);
+
+	if (read_device_mode(address, str, sizeof(str)) == 0)
+		g_key_file_set_string(key_file, "General", "Mode", str);
+
+	if (read_on_mode(address, str, sizeof(str)) == 0)
+		g_key_file_set_string(key_file, "General", "OnMode", str);
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, data, length, NULL);
+	g_free(data);
+
+	textfile_put(config_path, "converted", "yes");
+}
+
+static void load_config(struct btd_adapter *adapter)
+{
+	GKeyFile *key_file;
+	char filename[PATH_MAX + 1];
+	char address[18];
+	char *str;
+	GError *gerr = NULL;
 
 	ba2str(&adapter->bdaddr, address);
 
+	key_file = g_key_file_new();
+
+	snprintf(filename, PATH_MAX, SETTINGS_PATH, address);
+
+	if (!g_key_file_load_from_file(key_file, filename, 0, NULL))
+		convert_config(adapter, filename, key_file);
+
 	/* Get name */
-	if (read_local_name(&adapter->bdaddr, name) < 0)
-		adapter->config.name = NULL;
-	else
-		adapter->config.name = g_strdup(name);
+	adapter->config.name = g_key_file_get_string(key_file, "General",
+								"Name", NULL);
 
 	/* Get class */
-	if (read_local_class(&adapter->bdaddr, adapter->config.class) < 0) {
+	str = g_key_file_get_string(key_file, "General", "Class", NULL);
+	if (str) {
+		char tmp[3];
+		int i;
+		uint8_t *class = adapter->config.class;
+
+		memset(tmp, 0, sizeof(tmp));
+		for (i = 0; i < 3; i++) {
+			memcpy(tmp, str + (i * 2) + 2, 2);
+			class[2 - i] = (uint8_t) strtol(tmp, NULL, 16);
+		}
+	} else {
 		uint32_t class = htobl(main_opts.class);
 		memcpy(adapter->config.class, &class, 3);
 	}
+	g_free(str);
 
 	/* Get pairable mode */
-	if (read_device_pairable(&adapter->bdaddr, &adapter->pairable) < 0)
+	adapter->pairable = g_key_file_get_boolean(key_file, "General",
+							"Pairable", &gerr);
+	if (gerr) {
 		adapter->pairable = TRUE;
+		g_error_free(gerr);
+		gerr = NULL;
+	}
 
 	/* Get pairable timeout */
-	if (read_pairable_timeout(address, &timeout) < 0)
+	adapter->pairable_timeout = g_key_file_get_integer(key_file, "General",
+						"PairableTimeout", &gerr);
+	if (gerr) {
 		adapter->pairable_timeout = main_opts.pairto;
-	else
-		adapter->pairable_timeout = timeout;
+		g_error_free(gerr);
+		gerr = NULL;
+	}
 
 	/* Get discoverable timeout */
-	if (read_discoverable_timeout(address, &timeout) < 0)
+	adapter->discov_timeout = g_key_file_get_integer(key_file, "General",
+						"DiscoverableTimeout", &gerr);
+	if (gerr) {
 		adapter->discov_timeout = main_opts.discovto;
-	else
-		adapter->discov_timeout = timeout;
+		g_error_free(gerr);
+		gerr = NULL;
+	}
 
 	/* Get mode */
+	str = g_key_file_get_string(key_file, "General", "Mode", NULL);
 	if (main_opts.remember_powered == FALSE)
 		adapter->config.mode = main_opts.mode;
-	else if (read_device_mode(address, mode, sizeof(mode)) == 0)
-		adapter->config.mode = get_mode(mode);
+	else if (str)
+		adapter->config.mode = get_mode(str);
 	else
 		adapter->config.mode = main_opts.mode;
+	g_free(str);
 
 	/* Get on mode */
-	if (read_on_mode(address, mode, sizeof(mode)) == 0)
-		adapter->config.on_mode = get_mode(mode);
+	str = g_key_file_get_string(key_file, "General", "OnMode", NULL);
+	if (str)
+		adapter->config.on_mode = get_mode(str);
 	else
 		adapter->config.on_mode = MODE_CONNECTABLE;
+	g_free(str);
+
+	g_key_file_free(key_file);
 }
 
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
-- 
1.7.9.5

