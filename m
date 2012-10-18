Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 11/15] adapter: Move storage names to cache directory
Date: Thu, 18 Oct 2012 11:00:54 +0200
Message-Id: <1350550858-12239-12-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1350550858-12239-1-git-send-email-frederic.danis@linux.intel.com>
References: <1350550858-12239-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/event.c   |   51 ++++++++++++++++++++++++---
 2 files changed, 150 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 30fda1f..ca47111 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2511,6 +2511,83 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 	g_free(path);
 }
 
+struct converter {
+	char *addr;
+	char *group;
+	char *key;
+};
+
+static void convert_cache(char *key, char *value, void *user_data)
+{
+	struct converter *convert = user_data;
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
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", convert->addr,
+			str);
+	filename[PATH_MAX] = '\0';
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	g_key_file_set_string(key_file, convert->group, convert->key, value);
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
+	struct converter convert;
+
+	ba2str(&adapter->bdaddr, address);
+	convert.addr = address;
+	convert.group = "General";
+
+	/* Convert device's name cache */
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/names", address);
+	filename[PATH_MAX] = '\0';
+
+	str = textfile_get(filename, "converted");
+	if (str && strcmp(str, "yes") == 0) {
+		DBG("Legacy names file already converted");
+	} else {
+		convert.key = "Name";
+		textfile_foreach(filename, convert_cache, &convert);
+		textfile_put(filename, "converted", "yes");
+	}
+	free(str);
+
+	/* Convert lastseen device cache */
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/lastseen", address);
+	filename[PATH_MAX] = '\0';
+
+	str = textfile_get(filename, "converted");
+	if (str && strcmp(str, "yes") == 0) {
+		DBG("Legacy lastseen file already converted");
+	} else {
+		convert.key = "LastSeen";
+		textfile_foreach(filename, convert_cache, &convert);
+		textfile_put(filename, "converted", "yes");
+	}
+	free(str);
+}
+
 static void convert_config(struct btd_adapter *adapter, const char *filename,
 				GKeyFile *key_file)
 {
@@ -2684,6 +2761,7 @@ gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
 		btd_adapter_gatt_server_start(adapter);
 
 	load_config(adapter);
+	convert_device_storage(adapter);
 	load_drivers(adapter);
 	btd_profile_foreach(probe_profile, adapter);
 	clear_blocked(adapter);
@@ -2965,9 +3043,31 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
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
index 48aeffd..b9eb368 100644
--- a/src/event.c
+++ b/src/event.c
@@ -34,6 +34,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <string.h>
+#include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
 
@@ -224,11 +225,36 @@ static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba, uint8_t dba_type)
 {
 	time_t t;
 	struct tm *tm;
+	char filename[PATH_MAX + 1];
+	char s_addr[18], d_addr[18];
+	char str[24];
+	GKeyFile *key_file;
+	char *data;
+	gsize length = 0;
 
 	t = time(NULL);
 	tm = gmtime(&t);
 
-	write_lastseen_info(sba, dba, dba_type, tm);
+
+	memset(str, 0, sizeof(str));
+	strftime(str, sizeof(str), "%Y-%m-%d %H:%M:%S %Z", tm);
+
+	ba2str(sba, s_addr);
+	ba2str(dba, d_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", s_addr,
+			d_addr);
+	filename[PATH_MAX] = '\0';
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	g_key_file_set_string(key_file, "General", "LastSeen", str);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, data, length, NULL);
+	g_free(data);
+
+	g_key_file_free(key_file);
 }
 
 static void update_lastused(bdaddr_t *sba, bdaddr_t *dba, uint8_t dba_type)
@@ -265,7 +291,11 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
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
@@ -282,9 +312,22 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
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

