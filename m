Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/15] device: Delete storage device recursively
Date: Thu, 13 Dec 2012 21:39:21 +0100
Message-Id: <1355431170-12897-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Device storage directory may contain multiple files like info or
attributes but also files stored by plug-ins or profiles,
so completely delete directory.
---
 src/device.c |   36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index 42a7c65..36bf9bc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -34,6 +34,7 @@
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <errno.h>
+#include <dirent.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
@@ -2031,6 +2032,34 @@ uint16_t btd_device_get_version(struct btd_device *device)
 	return device->version;
 }
 
+static void delete_folder_tree(const char *dirname)
+{
+	DIR *dir;
+	struct dirent *entry;
+	char filename[PATH_MAX + 1];
+
+	dir = opendir(dirname);
+	if (dir == NULL)
+		return;
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (g_str_equal(entry->d_name, ".") ||
+				g_str_equal(entry->d_name, ".."))
+			continue;
+
+		snprintf(filename, PATH_MAX, "%s/%s", dirname, entry->d_name);
+		filename[PATH_MAX] = '\0';
+
+		if (entry->d_type == DT_DIR)
+			delete_folder_tree(filename);
+		else
+			unlink(filename);
+	}
+	closedir(dir);
+
+	rmdir(dirname);
+}
+
 static void device_remove_stored(struct btd_device *device)
 {
 	const bdaddr_t *src = adapter_get_address(device->adapter);
@@ -2062,15 +2091,10 @@ static void device_remove_stored(struct btd_device *device)
 	ba2str(src, adapter_addr);
 	ba2str(&device->bdaddr, device_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
-			device_addr);
-	filename[PATH_MAX] = '\0';
-	remove(filename);
-
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", adapter_addr,
 			device_addr);
 	filename[PATH_MAX] = '\0';
-	remove(filename);
+	delete_folder_tree(filename);
 }
 
 void device_remove(struct btd_device *device, gboolean remove_stored)
-- 
1.7.9.5

