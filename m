Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2] core/gatt: Add KeepCache config option
Date: Wed, 31 May 2017 15:30:51 +0300
Message-Id: <20170531123051.12524-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds [GATT] KeepCache config option to main.conf which can be used
to adjust the cache behavior of attributes found over GATT.
---
v2: Add enum for possible cache values, and change on/off to yes/no.

 src/device.c  | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/main.c    |  2 +-
 src/main.conf |  6 ++++++
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 50e7f23..203515e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -261,6 +261,14 @@ static const uint16_t uuid_list[] = {
 	0
 };
 
+typedef enum {
+	GATT_CACHE_ALWAYS,
+	GATT_CACHE_YES,
+	GATT_CACHE_NO,
+} gatt_cache_t;
+
+static gatt_cache_t gatt_cache;
+
 static int device_browse_gatt(struct btd_device *device, DBusMessage *msg);
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg);
 
@@ -522,11 +530,33 @@ static void browse_request_free(struct browse_req *req)
 	g_free(req);
 }
 
+static bool gatt_cache_is_enabled(struct btd_device *device)
+{
+	switch (gatt_cache) {
+	case GATT_CACHE_YES:
+		return device_is_paired(device, device->bdaddr_type);
+	case GATT_CACHE_NO:
+		return false;
+	case GATT_CACHE_ALWAYS:
+	default:
+		return true;
+	}
+}
+
+static void gatt_cache_cleanup(struct btd_device *device)
+{
+	if (gatt_cache_is_enabled(device))
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
@@ -2124,6 +2154,9 @@ static void store_gatt_db(struct btd_device *device)
 		return;
 	}
 
+	if (!gatt_cache_is_enabled(device))
+		return;
+
 	ba2str(btd_adapter_get_address(adapter), src_addr);
 	ba2str(&device->bdaddr, dst_addr);
 
@@ -3291,6 +3324,9 @@ static void load_gatt_db(struct btd_device *device, const char *local,
 	char **keys, filename[PATH_MAX];
 	GKeyFile *key_file;
 
+	if (!gatt_cache_is_enabled(device))
+		return;
+
 	DBG("Restoring %s gatt database from file", peer);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
@@ -6121,9 +6157,40 @@ struct btd_service *btd_device_get_service(struct btd_device *dev,
 
 void btd_device_init(void)
 {
+	GKeyFile *conf;
+	GError *err = NULL;
+	char *cache;
+
 	dbus_conn = btd_get_dbus_connection();
 	service_state_cb_id = btd_service_add_state_cb(
 						service_state_changed, NULL);
+
+	conf = btd_get_main_conf();
+	if (!conf) {
+		gatt_cache = GATT_CACHE_ALWAYS;
+		return;
+	}
+
+	cache = g_key_file_get_string(conf, "GATT", "KeepCache", &err);
+	if (!err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+		gatt_cache = GATT_CACHE_ALWAYS;
+		return;
+	}
+
+	if (!strcmp(cache, "always")) {
+		gatt_cache = GATT_CACHE_ALWAYS;
+	} else if (!strcmp(cache, "yes")) {
+		gatt_cache = GATT_CACHE_YES;
+	} else if (!strcmp(cache, "no")) {
+		gatt_cache = GATT_CACHE_NO;
+	} else {
+		DBG("Invalid value for KeepCache=%s", cache);
+		gatt_cache = GATT_CACHE_ALWAYS;
+	}
+
+	g_free(cache);
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
index a649276..7658558 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -71,6 +71,12 @@
 # Defaults to "off"
 # Privacy = off
 
+[GATT]
+# Keep cache of service discovery regardless of pairing state.
+# Possible values: always, yes, no
+# Default: always
+#KeepCache = always
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.9.4

