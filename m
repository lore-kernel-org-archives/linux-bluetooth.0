Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] core/gatt: Add GATT.Cache config option
Date: Fri,  9 Jun 2017 16:02:48 +0300
Message-Id: <20170609130249.23290-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds GATT.Cache config option to main.conf which can be used
to adjust the cache expected behavior of attributes found over GATT.
---
 src/device.c  | 28 ++++++++++++++++++++++++++++
 src/hcid.h    |  7 +++++++
 src/main.c    | 26 +++++++++++++++++++++++++-
 src/main.conf |  6 ++++++
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 50e7f23..def192f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -522,11 +522,33 @@ static void browse_request_free(struct browse_req *req)
 	g_free(req);
 }
 
+static bool gatt_cache_is_enabled(struct btd_device *device)
+{
+	switch (main_opts.gatt_cache) {
+	case BT_GATT_CACHE_YES:
+		return device_is_paired(device, device->bdaddr_type);
+	case BT_GATT_CACHE_NO:
+		return false;
+	case BT_GATT_CACHE_ALWAYS:
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
@@ -2124,6 +2146,9 @@ static void store_gatt_db(struct btd_device *device)
 		return;
 	}
 
+	if (!gatt_cache_is_enabled(device))
+		return;
+
 	ba2str(btd_adapter_get_address(adapter), src_addr);
 	ba2str(&device->bdaddr, dst_addr);
 
@@ -3291,6 +3316,9 @@ static void load_gatt_db(struct btd_device *device, const char *local,
 	char **keys, filename[PATH_MAX];
 	GKeyFile *key_file;
 
+	if (!gatt_cache_is_enabled(device))
+		return;
+
 	DBG("Restoring %s gatt database from file", peer);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
diff --git a/src/hcid.h b/src/hcid.h
index 0b785ee..552d63bc 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -29,6 +29,12 @@ typedef enum {
 	BT_MODE_LE,
 } bt_mode_t;
 
+typedef enum {
+	BT_GATT_CACHE_ALWAYS,
+	BT_GATT_CACHE_YES,
+	BT_GATT_CACHE_NO,
+} bt_gatt_cache_t;
+
 struct main_opts {
 	char		*name;
 	uint32_t	class;
@@ -48,6 +54,7 @@ struct main_opts {
 	uint16_t	did_version;
 
 	bt_mode_t	mode;
+	bt_gatt_cache_t gatt_cache;
 };
 
 extern struct main_opts main_opts;
diff --git a/src/main.c b/src/main.c
index bcc1e6f..2e3f980 100644
--- a/src/main.c
+++ b/src/main.c
@@ -149,9 +149,22 @@ done:
 	main_opts.did_version = version;
 }
 
+static void parse_gatt_cache(const char *cache)
+{
+	if (!strcmp(cache, "always")) {
+		main_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
+	} else if (!strcmp(cache, "yes")) {
+		main_opts.gatt_cache = BT_GATT_CACHE_YES;
+	} else if (!strcmp(cache, "no")) {
+		main_opts.gatt_cache = BT_GATT_CACHE_NO;
+	} else {
+		DBG("Invalid value for KeepCache=%s", cache);
+	}
+}
+
 static void check_config(GKeyFile *config)
 {
-	const char *valid_groups[] = { "General", "Policy", NULL };
+	const char *valid_groups[] = { "General", "Policy", "GATT", NULL };
 	char **keys;
 	int i;
 
@@ -357,6 +370,17 @@ static void parse_config(GKeyFile *config)
 		g_clear_error(&err);
 	else
 		main_opts.fast_conn = boolean;
+
+	str = g_key_file_get_string(config, "GATT", "Cache", &err);
+	if (err) {
+		g_clear_error(&err);
+		main_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
+		return;
+	}
+
+	parse_gatt_cache(str);
+
+	g_free(str);
 }
 
 static void init_defaults(void)
diff --git a/src/main.conf b/src/main.conf
index a649276..7807a8f 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -71,6 +71,12 @@
 # Defaults to "off"
 # Privacy = off
 
+[GATT]
+# GATT attribute cache.
+# Possible values: always, yes, no
+# Default: always
+#Cache = always
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.9.4

