Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC V3 06/12] adapter: Load devices from new storage architecture
Date: Fri, 30 Nov 2012 15:47:00 +0100
Message-Id: <1354286826-24016-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse storage directory and create devices from device sub-directories.

Remove create device from 'blocked' file, this is already converted.
---
 src/adapter.c |   50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c5e856d..f3b1c5d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -35,6 +35,7 @@
 #include <sys/ioctl.h>
 #include <sys/file.h>
 #include <sys/stat.h>
+#include <dirent.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
@@ -1893,23 +1894,6 @@ static void create_stored_device_from_ltks(char *key, char *value,
 	}
 }
 
-static void create_stored_device_from_blocked(char *key, char *value,
-							void *user_data)
-{
-	struct btd_adapter *adapter = user_data;
-	struct btd_device *device;
-
-	if (g_slist_find_custom(adapter->devices,
-				key, (GCompareFunc) device_address_cmp))
-		return;
-
-	device = device_create(adapter, key, BDADDR_BREDR);
-	if (device) {
-		device_set_temporary(device, FALSE);
-		adapter->devices = g_slist_append(adapter->devices, device);
-	}
-}
-
 static GSList *string_to_primary_list(char *str)
 {
 	GSList *l = NULL;
@@ -1997,6 +1981,8 @@ static void load_devices(struct btd_adapter *adapter)
 	char srcaddr[18];
 	struct adapter_keys keys = { adapter, NULL };
 	int err;
+	DIR *dir;
+	struct dirent *entry;
 
 	ba2str(&adapter->bdaddr, srcaddr);
 
@@ -2030,8 +2016,34 @@ static void load_devices(struct btd_adapter *adapter)
 	g_slist_free_full(keys.keys, smp_key_free);
 	keys.keys = NULL;
 
-	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "blocked");
-	textfile_foreach(filename, create_stored_device_from_blocked, adapter);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s", srcaddr);
+	filename[PATH_MAX] = '\0';
+
+	dir = opendir(filename);
+	if (!dir) {
+		error("Unable to open adapter storage directory: %s", filename);
+		return;
+	}
+
+	while ((entry = readdir(dir)) != NULL) {
+		struct btd_device *device;
+
+		if (entry->d_type != DT_DIR || bachk(entry->d_name) < 0)
+			continue;
+
+		if (g_slist_find_custom(adapter->devices, entry->d_name,
+					(GCompareFunc) device_address_cmp))
+			continue;
+
+		device = device_create(adapter, entry->d_name, BDADDR_BREDR);
+		if (!device)
+			continue;
+
+		device_set_temporary(device, FALSE);
+		adapter->devices = g_slist_append(adapter->devices, device);
+	}
+
+	closedir(dir);
 }
 
 int btd_adapter_block_address(struct btd_adapter *adapter,
-- 
1.7.9.5

