Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 09/15] adapter: Move saved config to ini-file format
Date: Thu, 18 Oct 2012 11:00:52 +0200
Message-Id: <1350550858-12239-10-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1350550858-12239-1-git-send-email-frederic.danis@linux.intel.com>
References: <1350550858-12239-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Read and write config file in ini-file format.
If the file can not be loaded, try to convert legacy configuration.
---
 src/adapter.c |  234 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 189 insertions(+), 45 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 155293e..30fda1f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -33,6 +33,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <sys/ioctl.h>
+#include <sys/file.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
@@ -83,6 +84,8 @@
 #define REMOVE_TEMP_TIMEOUT (3 * 60)
 #define PENDING_FOUND_MAX 5
 
+#define SETTINGS_PATH STORAGEDIR "/%s/settings"
+
 static GSList *adapter_drivers = NULL;
 
 enum session_req_type {
@@ -209,6 +212,56 @@ static uint8_t get_mode(const char *mode)
 		return MODE_UNKNOWN;
 }
 
+static void store_adapter_info(struct btd_adapter *adapter)
+{
+	GKeyFile *key_file;
+	char filename[PATH_MAX + 1];
+	char address[18];
+	char *str;
+	gsize length = 0;
+
+	key_file = g_key_file_new();
+
+	g_key_file_set_string(key_file, "General", "Name", adapter->name);
+
+	str = g_strdup_printf("0x%2.2x%2.2x%2.2x",
+				(adapter->dev_class >> 16) & 0xFF,
+				(adapter->dev_class >> 8) & 0xFF,
+				adapter->dev_class & 0xFF);
+	g_key_file_set_string(key_file, "General", "Class", str);
+	g_free(str);
+
+	g_key_file_set_boolean(key_file, "General", "Powered",
+				adapter->mode > MODE_OFF);
+
+	g_key_file_set_boolean(key_file, "General", "Pairable",
+				adapter->pairable);
+
+	if (adapter->pairable_timeout != main_opts.pairto)
+		g_key_file_set_integer(key_file, "General", "PairableTimeout",
+					adapter->pairable_timeout);
+
+	g_key_file_set_boolean(key_file, "General", "Discoverable",
+				adapter->discoverable);
+
+	if (adapter->discov_timeout != main_opts.discovto)
+		g_key_file_set_integer(key_file, "General",
+					"DiscoverableTimeout",
+					adapter->discov_timeout);
+
+	ba2str(&adapter->bdaddr, address);
+	snprintf(filename, PATH_MAX, SETTINGS_PATH, address);
+	filename[PATH_MAX] = '\0';
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
@@ -278,7 +331,6 @@ static struct session_req *find_session_by_msg(GSList *list, const DBusMessage *
 static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 {
 	int err;
-	const char *modestr;
 
 	if (adapter->pending_mode != NULL)
 		return -EALREADY;
@@ -310,10 +362,9 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 		return err;
 
 done:
-	modestr = mode2str(new_mode);
-	write_device_mode(&adapter->bdaddr, modestr);
+	store_adapter_info(adapter);
 
-	DBG("%s", modestr);
+	DBG("%s", mode2str(new_mode));
 
 	return 0;
 }
@@ -451,7 +502,7 @@ void btd_adapter_pairable_changed(struct btd_adapter *adapter,
 {
 	adapter->pairable = pairable;
 
-	write_device_pairable(&adapter->bdaddr, pairable);
+	store_adapter_info(adapter);
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
 					ADAPTER_INTERFACE, "Pairable");
@@ -713,7 +764,7 @@ static void set_discoverable_timeout(struct btd_adapter *adapter,
 
 	adapter->discov_timeout = timeout;
 
-	write_discoverable_timeout(&adapter->bdaddr, timeout);
+	store_adapter_info(adapter);
 
 	g_dbus_emit_property_changed(conn, adapter->path, ADAPTER_INTERFACE,
 						"DiscoverableTimeout");
@@ -733,7 +784,7 @@ static void set_pairable_timeout(struct btd_adapter *adapter,
 
 	adapter->pairable_timeout = timeout;
 
-	write_pairable_timeout(&adapter->bdaddr, timeout);
+	store_adapter_info(adapter);
 
 	g_dbus_emit_property_changed(conn, adapter->path, ADAPTER_INTERFACE,
 							"PairableTimeout");
@@ -749,10 +800,10 @@ void btd_adapter_class_changed(struct btd_adapter *adapter, uint8_t *new_class)
 	if (class == adapter->dev_class)
 		return;
 
-	write_local_class(&adapter->bdaddr, new_class);
-
 	adapter->dev_class = class;
 
+	store_adapter_info(adapter);
+
 	if (main_opts.gatt_enabled) {
 		uint8_t cls[3];
 
@@ -806,7 +857,7 @@ int adapter_set_name(struct btd_adapter *adapter, const char *name)
 		adapter->name = g_strdup(maxname);
 	}
 
-	write_local_name(&adapter->bdaddr, maxname);
+	store_adapter_info(adapter);
 
 	return 0;
 }
@@ -2294,13 +2345,11 @@ static void set_mode_complete(struct btd_adapter *adapter)
 {
 	DBusConnection *conn = btd_get_dbus_connection();
 	struct session_req *pending;
-	const char *modestr;
 	int err;
 
-	modestr = mode2str(adapter->mode);
-	write_device_mode(&adapter->bdaddr, modestr);
+	store_adapter_info(adapter);
 
-	DBG("%s", modestr);
+	DBG("%s", mode2str(adapter->mode));
 
 	if (adapter->mode == MODE_OFF) {
 		g_slist_free_full(adapter->mode_sessions, session_free);
@@ -2462,58 +2511,153 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 	g_free(path);
 }
 
-static void load_config(struct btd_adapter *adapter)
+static void convert_config(struct btd_adapter *adapter, const char *filename,
+				GKeyFile *key_file)
 {
-	char name[MAX_NAME_LENGTH + 1];
-	uint8_t class[3];
 	char address[18];
-	char mode[14];
+	char str[MAX_NAME_LENGTH + 1];
+	char config_path[PATH_MAX + 1];
+	char *converted;
+	uint8_t class[3];
+	gboolean flag;
 	int timeout;
+	uint8_t mode;
+	char *data;
+	gsize length = 0;
+
+	ba2str(&adapter->bdaddr, address);
+	snprintf(config_path, PATH_MAX, STORAGEDIR "/%s/config", address);
+	config_path[PATH_MAX] = '\0';
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
+	if (read_device_mode(address, str, sizeof(str)) == 0) {
+		mode = get_mode(str);
+		g_key_file_set_boolean(key_file, "General", "Powered",
+					mode > MODE_OFF);
+	}
+
+	if (read_on_mode(address, str, sizeof(str)) == 0) {
+		mode = get_mode(str);
+		g_key_file_set_boolean(key_file, "General", "Discoverable",
+					mode == MODE_DISCOVERABLE);
+	}
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
+	gboolean powered;
+	GError *gerr = NULL;
 
 	ba2str(&adapter->bdaddr, address);
 
+	key_file = g_key_file_new();
+
+	snprintf(filename, PATH_MAX, SETTINGS_PATH, address);
+	filename[PATH_MAX] = '\0';
+
+	if (!g_key_file_load_from_file(key_file, filename, 0, NULL))
+		convert_config(adapter, filename, key_file);
+
 	/* Get name */
-	if (read_local_name(&adapter->bdaddr, name) < 0)
-		adapter->name = NULL;
-	else
-		adapter->name = g_strdup(name);
+	adapter->name = g_key_file_get_string(key_file, "General",
+								"Name", NULL);
 
 	/* Get class */
-	if (read_local_class(&adapter->bdaddr, class) == 0)
-		adapter->dev_class = class[0] | (class[1] << 8) |
-					(class[2] << 16);
-	else
+	str = g_key_file_get_string(key_file, "General", "Class", NULL);
+	if (str) {
+		adapter->dev_class = strtol(str, NULL, 16);
+		g_free(str);
+	} else
 		adapter->dev_class = main_opts.class;
 
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
+
+	/* Get discoverable mode */
+	adapter->discoverable = g_key_file_get_boolean(key_file, "General",
+							"Discoverable", &gerr);
+	if (gerr) {
+		adapter->discoverable = (main_opts.mode == MODE_DISCOVERABLE);
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
 
-	/* Get mode */
-	if (main_opts.remember_powered == FALSE)
-		adapter->mode = main_opts.mode;
-	else if (read_device_mode(address, mode, sizeof(mode)) == 0)
-		adapter->mode = get_mode(mode);
-	else
+	/* Get powered mode */
+	powered = g_key_file_get_boolean(key_file, "General", "Powered",
+						&gerr);
+	if (gerr) {
 		adapter->mode = main_opts.mode;
-
-	/* Get on mode */
-	if (read_on_mode(address, mode, sizeof(mode)) == 0)
-		adapter->discoverable = (strcasecmp("discoverable", mode) == 0);
-	else
-		adapter->discoverable = (adapter->mode == MODE_DISCOVERABLE);
+		g_error_free(gerr);
+		gerr = NULL;
+	} else if (powered) {
+		adapter->mode = adapter->discoverable ? MODE_DISCOVERABLE :
+							MODE_CONNECTABLE;
+	} else
+		adapter->mode = MODE_OFF;
 
 	mgmt_set_connectable(adapter->dev_id, TRUE);
 	mgmt_set_discoverable(adapter->dev_id, adapter->discoverable,
-- 
1.7.9.5

