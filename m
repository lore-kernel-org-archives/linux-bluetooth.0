Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] adapter: Load devices from new storage architecture
Date: Tue, 27 Nov 2012 09:49:48 +0100
Message-Id: <1354006193-7199-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354006193-7199-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354006193-7199-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 163360f..3f184fc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -34,6 +34,7 @@
 #include <stdbool.h>
 #include <sys/ioctl.h>
 #include <sys/file.h>
+#include <dirent.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
@@ -1996,6 +1997,8 @@ static void load_devices(struct btd_adapter *adapter)
 	char srcaddr[18];
 	struct adapter_keys keys = { adapter, NULL };
 	int err;
+	DIR *dir;
+	struct dirent *entry;
 
 	ba2str(&adapter->bdaddr, srcaddr);
 
@@ -2031,6 +2034,33 @@ static void load_devices(struct btd_adapter *adapter)
 
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "blocked");
 	textfile_foreach(filename, create_stored_device_from_blocked, adapter);
+
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
 }
 
 int btd_adapter_block_address(struct btd_adapter *adapter,
-- 
1.7.9.5

