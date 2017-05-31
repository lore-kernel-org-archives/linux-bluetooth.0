Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/gatt: Add KeepCache config option
Date: Wed, 31 May 2017 13:56:39 +0300
Message-Id: <20170531105640.3132-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds [GATT] KeepCache config option to main.conf which can be used
to adjust the cache behavior of attributes found over GATT.
---
 src/device.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/main.c    |  2 +-
 src/main.conf |  6 ++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 50e7f23..dfb7b1f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -261,6 +261,8 @@ static const uint16_t uuid_list[] = {
 	0
 };
 
+static char *gatt_cache;
+
 static int device_browse_gatt(struct btd_device *device, DBusMessage *msg);
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg);
 
@@ -522,11 +524,32 @@ static void browse_request_free(struct browse_req *req)
 	g_free(req);
 }
 
+static bool gatt_keep_cache(struct btd_device *device)
+{
+	if (!strcmp(gatt_cache, "always"))
+		return true;
+
+	if (!strcmp(gatt_cache, "on") &&
+			device_is_paired(device, device->bdaddr_type))
+		return true;
+
+	return false;
+}
+
+static void gatt_cache_cleanup(struct btd_device *device)
+{
+	if (gatt_keep_cache(device))
+		return;
+
+	gatt_db_clear(device->db);
+}
+
 static void gatt_client_cleanup(struct btd_device *device)
 {
 	if (!device->client)
 		return;
 
+	gatt_cache_cleanup(device);
 	bt_gatt_client_set_service_changed(device->client, NULL, NULL, NULL);
 	bt_gatt_client_set_ready_handler(device->client, NULL, NULL, NULL);
 	bt_gatt_client_unref(device->client);
@@ -2124,6 +2147,9 @@ static void store_gatt_db(struct btd_device *device)
 		return;
 	}
 
+	if (!gatt_keep_cache(device))
+		return;
+
 	ba2str(btd_adapter_get_address(adapter), src_addr);
 	ba2str(&device->bdaddr, dst_addr);
 
@@ -3291,6 +3317,9 @@ static void load_gatt_db(struct btd_device *device, const char *local,
 	char **keys, filename[PATH_MAX];
 	GKeyFile *key_file;
 
+	if (!gatt_keep_cache(device))
+		return;
+
 	DBG("Restoring %s gatt database from file", peer);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
@@ -6121,9 +6150,26 @@ struct btd_service *btd_device_get_service(struct btd_device *dev,
 
 void btd_device_init(void)
 {
+	GKeyFile *conf;
+	GError *err = NULL;
+
 	dbus_conn = btd_get_dbus_connection();
 	service_state_cb_id = btd_service_add_state_cb(
 						service_state_changed, NULL);
+
+	conf = btd_get_main_conf();
+	if (!conf) {
+		gatt_cache = g_strdup("always");
+		return;
+	}
+
+	gatt_cache = g_key_file_get_string(conf, "GATT", "KeepCache", &err);
+	if (!err)
+		return;
+
+	DBG("%s", err->message);
+	g_clear_error(&err);
+	gatt_cache = g_strdup("always");
 }
 
 void btd_device_cleanup(void)
diff --git a/src/main.c b/src/main.c
index bcc1e6f..bdc8b50 100644
--- a/src/main.c
+++ b/src/main.c
@@ -151,7 +151,7 @@ done:
 
 static void check_config(GKeyFile *config)
 {
-	const char *valid_groups[] = { "General", "Policy", NULL };
+	const char *valid_groups[] = { "General", "Policy", "GATT", NULL };
 	char **keys;
 	int i;
 
diff --git a/src/main.conf b/src/main.conf
index a649276..948ae6d 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -71,6 +71,12 @@
 # Defaults to "off"
 # Privacy = off
 
+[GATT]
+# Keep cache of service discovery regardless of pairing state.
+# Possible values: always, on, off
+# Default: always
+#KeepCache = always
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.9.4

