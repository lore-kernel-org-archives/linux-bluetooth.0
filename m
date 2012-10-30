Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 3/6] device: Retrieve name from storage
Date: Tue, 30 Oct 2012 18:05:25 +0100
Message-Id: <1351616728-10075-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351616728-10075-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351616728-10075-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Try to retrieve name from device info file.
If that fails fall back to the cache and save it to device info file.

When device name is updated, save it.
---
 src/device.c |  102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index bc7f8dd..9749bfd 100644
--- a/src/device.c
+++ b/src/device.c
@@ -76,6 +76,9 @@
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		2
 
+#define INFO_PATH STORAGEDIR "/%s/%s/info"
+#define CACHE_PATH STORAGEDIR "/%s/cache/%s"
+
 struct btd_disconnect_data {
 	guint id;
 	disconnect_watch watch;
@@ -202,6 +205,36 @@ static uint16_t uuid_list[] = {
 	0
 };
 
+static void store_device_info(struct btd_device *device)
+{
+	GKeyFile *key_file;
+	char filename[PATH_MAX + 1];
+	char adapter_addr[18];
+	char device_addr[18];
+	char *str;
+	gsize length = 0;
+
+	if (device->temporary)
+		return;
+
+	key_file = g_key_file_new();
+
+	g_key_file_set_string(key_file, "General", "Name", device->name);
+
+	ba2str(adapter_get_address(device->adapter), adapter_addr);
+	ba2str(&device->bdaddr, device_addr);
+	snprintf(filename, PATH_MAX, INFO_PATH, adapter_addr, device_addr);
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
 static void browse_request_free(struct browse_req *req)
 {
 	if (req->listener_id)
@@ -1564,6 +1597,70 @@ static void device_set_version(struct btd_device *device, uint16_t value)
 						DEVICE_INTERFACE, "Version");
 }
 
+static char *load_cached_name(struct btd_device *device, const char *local,
+				const gchar *peer)
+{
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	char *str = NULL;
+	int len;
+
+	snprintf(filename, PATH_MAX, CACHE_PATH, local, peer);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+
+	if (!g_key_file_load_from_file(key_file, filename, 0, NULL))
+		goto failed;
+
+	str = g_key_file_get_string(key_file, "General", "Name", NULL);
+	if (str) {
+		len = strlen(str);
+		if (len > HCI_MAX_NAME_LENGTH)
+			str[HCI_MAX_NAME_LENGTH] = '\0';
+	}
+
+failed:
+	g_key_file_free(key_file);
+
+	return str;
+}
+
+static void load_info(struct btd_device *device, const gchar *local,
+			const gchar *peer)
+{
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	char *str;
+	gboolean store_needed = FALSE;
+
+	snprintf(filename, PATH_MAX, INFO_PATH, local, peer);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	/* Load device name from storage info file, if that fails fall back to
+	 * the cache.
+	 */
+	str = g_key_file_get_string(key_file, "General", "Name", NULL);
+	if (str == NULL) {
+		str = load_cached_name(device, local, peer);
+		if (str)
+			store_needed = TRUE;
+	}
+
+	if (str) {
+		strcpy(device->name, str);
+		g_free(str);
+	}
+
+	if (store_needed)
+		store_device_info(device);
+
+	g_key_file_free(key_file);
+}
+
 struct btd_device *device_create(struct btd_adapter *adapter,
 				const gchar *address, uint8_t bdaddr_type)
 {
@@ -1600,7 +1697,8 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	src = adapter_get_address(adapter);
 	ba2str(src, srcaddr);
 
-	read_device_name(srcaddr, address, bdaddr_type, device->name);
+	load_info(device, srcaddr, address);
+
 	if (read_device_alias(srcaddr, address, bdaddr_type, alias,
 							sizeof(alias)) == 0)
 		device->alias = g_strdup(alias);
@@ -1640,6 +1738,8 @@ void device_set_name(struct btd_device *device, const char *name)
 
 	strncpy(device->name, name, MAX_NAME_LENGTH);
 
+	store_device_info(device);
+
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
 						DEVICE_INTERFACE, "Name");
 
-- 
1.7.9.5

