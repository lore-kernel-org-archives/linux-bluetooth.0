Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC V3 02/12] device: Load device info before updating info file
Date: Fri, 30 Nov 2012 15:46:56 +0100
Message-Id: <1354286826-24016-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data in device info file should not be lost during save
even if they are not in device structure (like link key
and long term key).
---
 src/device.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index a99ca34..1db8a48 100644
--- a/src/device.c
+++ b/src/device.c
@@ -217,17 +217,28 @@ static gboolean store_device_info_cb(gpointer user_data)
 
 	device->store_id = 0;
 
+	ba2str(adapter_get_address(device->adapter), adapter_addr);
+	ba2str(&device->bdaddr, device_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
+			device_addr);
+	filename[PATH_MAX] = '\0';
+
 	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
 	g_key_file_set_string(key_file, "General", "Name", device->name);
 
 	if (device->alias != NULL)
 		g_key_file_set_string(key_file, "General", "Alias",
 								device->alias);
+	else
+		g_key_file_remove_key(key_file, "General", "Alias", NULL);
 
 	if (device->class) {
 		sprintf(class, "0x%6.6x", device->class);
 		g_key_file_set_string(key_file, "General", "Class", class);
+	} else {
+		g_key_file_remove_key(key_file, "General", "Class", NULL);
 	}
 
 	g_key_file_set_boolean(key_file, "General", "Trusted",
@@ -245,14 +256,10 @@ static gboolean store_device_info_cb(gpointer user_data)
 					device->product);
 		g_key_file_set_integer(key_file, "DeviceID", "Version",
 					device->version);
+	} else {
+		g_key_file_remove_group(key_file, "DeviceID", NULL);
 	}
 
-	ba2str(adapter_get_address(device->adapter), adapter_addr);
-	ba2str(&device->bdaddr, device_addr);
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
-			device_addr);
-	filename[PATH_MAX] = '\0';
-
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
-- 
1.7.9.5

