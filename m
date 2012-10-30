Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 1/6] adapter: Simplify cached name storage
Date: Tue, 30 Oct 2012 18:05:23 +0100
Message-Id: <1351616728-10075-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   75 +++++++++++++++++++++++++--------------------------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2a8e7d5..f4bb622 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -85,6 +85,7 @@
 #define PENDING_FOUND_MAX 5
 
 #define SETTINGS_PATH STORAGEDIR "/%s/settings"
+#define CACHE_PATH STORAGEDIR "/%s/cache/%s"
 
 static GSList *adapter_drivers = NULL;
 
@@ -255,6 +256,32 @@ static void store_adapter_info(struct btd_adapter *adapter)
 	g_key_file_free(key_file);
 }
 
+static void store_cached_name(const bdaddr_t *local, const bdaddr_t *peer,
+				char *name)
+{
+	char filename[PATH_MAX + 1];
+	char s_addr[18], d_addr[18];
+	GKeyFile *key_file;
+	char *data;
+	gsize length = 0;
+
+	ba2str(local, s_addr);
+	ba2str(peer, d_addr);
+	snprintf(filename, PATH_MAX, CACHE_PATH, s_addr, d_addr);
+	filename[PATH_MAX] = '\0';
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	g_key_file_set_string(key_file, "General", "Name", name);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, data, length, NULL);
+	g_free(data);
+
+	g_key_file_free(key_file);
+}
+
 static struct session_req *session_ref(struct session_req *req)
 {
 	req->refcount++;
@@ -2496,11 +2523,8 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 static void convert_names_entry(char *key, char *value, void *user_data)
 {
 	char *address = user_data;
-	char filename[PATH_MAX + 1];
 	char *str = key;
-	GKeyFile *key_file;
-	char *data;
-	gsize length = 0;
+	bdaddr_t local, peer;
 
 	if (strchr(key, '#'))
 		str[17] = '\0';
@@ -2508,19 +2532,9 @@ static void convert_names_entry(char *key, char *value, void *user_data)
 	if (bachk(str) != 0)
 		return;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", address, str);
-	filename[PATH_MAX] = '\0';
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
-	g_key_file_set_string(key_file, "General", "Name", value);
-
-	data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, data, length, NULL);
-	g_free(data);
-
-	g_key_file_free(key_file);
+	str2ba(address, &local);
+	str2ba(str, &peer);
+	store_cached_name(&local, &peer, value);
 }
 
 static void convert_device_storage(struct btd_adapter *adapter)
@@ -2990,31 +3004,8 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 		write_remote_appearance(&adapter->bdaddr, bdaddr, bdaddr_type,
 							eir_data.appearance);
 
-	if (eir_data.name != NULL && eir_data.name_complete) {
-		char filename[PATH_MAX + 1];
-		char s_addr[18], d_addr[18];
-		GKeyFile *key_file;
-		char *data;
-		gsize length = 0;
-
-		ba2str(&adapter->bdaddr, s_addr);
-		ba2str(bdaddr, d_addr);
-		snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
-				s_addr, d_addr);
-		filename[PATH_MAX] = '\0';
-		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-		key_file = g_key_file_new();
-		g_key_file_load_from_file(key_file, filename, 0, NULL);
-		g_key_file_set_string(key_file, "General", "Name",
-					eir_data.name);
-
-		data = g_key_file_to_data(key_file, &length, NULL);
-		g_file_set_contents(filename, data, length, NULL);
-		g_free(data);
-
-		g_key_file_free(key_file);
-	}
+	if (eir_data.name != NULL && eir_data.name_complete)
+		store_cached_name(&adapter->bdaddr, bdaddr, eir_data.name);
 
 	/* Avoid creating LE device if it's not discoverable */
 	if (bdaddr_type != BDADDR_BREDR &&
-- 
1.7.9.5

