Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 11/16] adapter: Move storage names to cache directory
Date: Wed, 24 Oct 2012 16:34:13 +0200
Message-Id: <1351089258-25179-12-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/event.c   |   24 ++++++++++++++---
 2 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ecdc948..8e6cbaa 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2493,6 +2493,58 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 	g_free(path);
 }
 
+static void convert_names_entry(char *key, char *value, void *user_data)
+{
+	char *address = user_data;
+	char filename[PATH_MAX + 1];
+	char *str = key;
+	GKeyFile *key_file;
+	char *data;
+	gsize length = 0;
+
+	if (strchr(key, '#'))
+		str[17] = '\0';
+
+	if (bachk(str) != 0)
+		return;
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", address, str);
+	filename[PATH_MAX] = '\0';
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	g_key_file_set_string(key_file, "General", "Name", value);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, data, length, NULL);
+	g_free(data);
+
+	g_key_file_free(key_file);
+}
+
+static void convert_device_storage(struct btd_adapter *adapter)
+{
+	char filename[PATH_MAX + 1];
+	char address[18];
+	char *str;
+
+	ba2str(&adapter->bdaddr, address);
+
+	/* Convert device's name cache */
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/names", address);
+	filename[PATH_MAX] = '\0';
+
+	str = textfile_get(filename, "converted");
+	if (str && strcmp(str, "yes") == 0) {
+		DBG("Legacy names file already converted");
+	} else {
+		textfile_foreach(filename, convert_names_entry, address);
+		textfile_put(filename, "converted", "yes");
+	}
+	free(str);
+}
+
 static void convert_config(struct btd_adapter *adapter, const char *filename,
 				GKeyFile *key_file)
 {
@@ -2654,6 +2706,7 @@ gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
 		btd_adapter_gatt_server_start(adapter);
 
 	load_config(adapter);
+	convert_device_storage(adapter);
 	load_drivers(adapter);
 	btd_profile_foreach(probe_profile, adapter);
 	clear_blocked(adapter);
@@ -2935,9 +2988,31 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 		write_remote_appearance(&adapter->bdaddr, bdaddr, bdaddr_type,
 							eir_data.appearance);
 
-	if (eir_data.name != NULL && eir_data.name_complete)
-		write_device_name(&adapter->bdaddr, bdaddr, bdaddr_type,
-								eir_data.name);
+	if (eir_data.name != NULL && eir_data.name_complete) {
+		char filename[PATH_MAX + 1];
+		char s_addr[18], d_addr[18];
+		GKeyFile *key_file;
+		char *data;
+		gsize length = 0;
+
+		ba2str(&adapter->bdaddr, s_addr);
+		ba2str(bdaddr, d_addr);
+		snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+				s_addr, d_addr);
+		filename[PATH_MAX] = '\0';
+		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+		key_file = g_key_file_new();
+		g_key_file_load_from_file(key_file, filename, 0, NULL);
+		g_key_file_set_string(key_file, "General", "Name",
+					eir_data.name);
+
+		data = g_key_file_to_data(key_file, &length, NULL);
+		g_file_set_contents(filename, data, length, NULL);
+		g_free(data);
+
+		g_key_file_free(key_file);
+	}
 
 	/* Avoid creating LE device if it's not discoverable */
 	if (bdaddr_type != BDADDR_BREDR &&
diff --git a/src/event.c b/src/event.c
index 48aeffd..3c43135 100644
--- a/src/event.c
+++ b/src/event.c
@@ -34,6 +34,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <string.h>
+#include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
 
@@ -265,7 +266,11 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
-	uint8_t peer_type;
+	char filename[PATH_MAX + 1];
+	char local_addr[18], peer_addr[18];
+	GKeyFile *key_file;
+	char *data;
+	gsize length = 0;
 
 	if (!g_utf8_validate(name, -1, NULL)) {
 		int i;
@@ -282,9 +287,22 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
 	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
 		return;
 
-	peer_type = device_get_addr_type(device);
+	ba2str(local, local_addr);
+	ba2str(peer, peer_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local_addr,
+			peer_addr);
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
 
-	write_device_name(local, peer, peer_type, name);
+	g_key_file_free(key_file);
 
 	if (device)
 		device_set_name(device, name);
-- 
1.7.9.5

