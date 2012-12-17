Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/13] proximity: Use new storage architecture
Date: Mon, 17 Dec 2012 16:09:50 +0100
Message-Id: <1355756994-18953-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/proximity/monitor.c |   72 ++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index d9ed3ff..0be0ae4 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -83,51 +83,52 @@ struct monitor {
 	guint attioid;
 };
 
-static inline int create_filename(char *buf, size_t size,
-				const bdaddr_t *bdaddr, const char *name)
+static void write_proximity_config(struct btd_device *device, const char *alert,
+					const char *level)
 {
-	char addr[18];
+	char *filename;
+	GKeyFile *key_file;
+	char *data;
+	gsize length = 0;
 
-	ba2str(bdaddr, addr);
+	filename = btd_device_get_storage_path(device, "proximity");
 
-	return create_name(buf, size, STORAGEDIR, addr, name);
-}
-
-static int write_proximity_config(const bdaddr_t *sba, const bdaddr_t *dba,
-					const char *alert, const char *level)
-{
-	char filename[PATH_MAX + 1], addr[18], key[38];
-
-	create_filename(filename, PATH_MAX, sba, "proximity");
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+	if (level)
+		g_key_file_set_string(key_file, alert, "Level", level);
+	else
+		g_key_file_remove_group(key_file, alert, NULL);
 
-	ba2str(dba, addr);
-
-	snprintf(key, sizeof(key), "%17s#%s", addr, alert);
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		g_file_set_contents(filename, data, length, NULL);
+	}
 
-	return textfile_put(filename, key, level);
+	g_free(data);
+	g_free(filename);
+	g_key_file_free(key_file);
 }
 
-static char *read_proximity_config(const bdaddr_t *sba, const bdaddr_t *dba,
-							const char *alert)
+static char *read_proximity_config(struct btd_device *device, const char *alert)
 {
-	char filename[PATH_MAX + 1], addr[18], key[38];
-	char *str, *strnew;
+	char *filename;
+	GKeyFile *key_file;
+	char *str;
 
-	create_filename(filename, PATH_MAX, sba, "proximity");
+	filename = btd_device_get_storage_path(device, "proximity");
 
-	ba2str(dba, addr);
-	snprintf(key, sizeof(key), "%17s#%s", addr, alert);
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	str = textfile_caseget(filename, key);
-	if (str == NULL)
-		return NULL;
+	str = g_key_file_get_string(key_file, alert, "Level", NULL);
 
-	strnew = g_strdup(str);
-	free(str);
+	g_free(filename);
+	g_key_file_free(key_file);
 
-	return strnew;
+	return str;
 }
 
 static uint8_t str2level(const char *level)
@@ -417,7 +418,6 @@ static void property_set_link_loss_level(const GDBusPropertyTable *property,
 		DBusMessageIter *iter, GDBusPendingPropertySet id, void *data)
 {
 	struct monitor *monitor = data;
-	struct btd_device *device = monitor->device;
 	const char *level;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
@@ -438,9 +438,7 @@ static void property_set_link_loss_level(const GDBusPropertyTable *property,
 	g_free(monitor->linklosslevel);
 	monitor->linklosslevel = g_strdup(level);
 
-	write_proximity_config(adapter_get_address(device_get_adapter(device)),
-					device_get_address(device),
-					"LinkLossAlertLevel", level);
+	write_proximity_config(monitor->device, "LinkLossAlertLevel", level);
 
 	if (monitor->attrib)
 		write_alert_level(monitor);
@@ -601,9 +599,7 @@ int monitor_register(struct btd_device *device,
 	struct monitor *monitor;
 	char *level;
 
-	level = read_proximity_config(
-			adapter_get_address(device_get_adapter(device)),
-			device_get_address(device), "LinkLossAlertLevel");
+	level = read_proximity_config(device, "LinkLossAlertLevel");
 
 	monitor = g_new0(struct monitor, 1);
 	monitor->device = btd_device_ref(device);
-- 
1.7.9.5

