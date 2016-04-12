Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3] core/device: Fix breakage of Bluetooth pairing
Date: Tue, 12 Apr 2016 11:48:27 +0300
Message-Id: <1460450907-25723-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Pawlowski <jpawlowski@chromium.org>

This patch converts old propertis containing list of services available
on remote devices. Without that previously paired devices, i.e.
keyboards, will not work properly.
---
v2: Convert the old entries to Services deleting the entries in the process
v3: Save the contents on file
 src/device.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0d46eba..14ddc6b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2697,6 +2697,61 @@ fail:
 	return NULL;
 }
 
+static void load_services(struct btd_device *device, char **uuids)
+{
+	char **uuid;
+
+	for (uuid = uuids; *uuid; uuid++) {
+		if (g_slist_find_custom(device->uuids, *uuid, bt_uuid_strcmp))
+			continue;
+
+		device->uuids = g_slist_insert_sorted(device->uuids,
+							g_strdup(*uuid),
+							bt_uuid_strcmp);
+	}
+
+	g_strfreev(uuids);
+}
+
+static void convert_info(struct btd_device *device, GKeyFile *key_file)
+{
+	char filename[PATH_MAX];
+	char adapter_addr[18];
+	char device_addr[18];
+	char **uuids;
+	char *str;
+	gsize length = 0;
+
+	/* Load device profile list from legacy properties */
+	uuids = g_key_file_get_string_list(key_file, "General", "SDPServices",
+								NULL, NULL);
+	if (uuids)
+		load_services(device, uuids);
+
+	uuids = g_key_file_get_string_list(key_file, "General", "GATTServices",
+								NULL, NULL);
+	if (uuids)
+		load_services(device, uuids);
+
+	if (!device->uuids)
+		return;
+
+	/* Remove old entries so they are not loaded again */
+	g_key_file_remove_key(key_file, "General", "SDPServices", NULL);
+	g_key_file_remove_key(key_file, "General", "GATTServices", NULL);
+
+	ba2str(btd_adapter_get_address(device->adapter), adapter_addr);
+	ba2str(&device->bdaddr, device_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
+			device_addr);
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, str, length, NULL);
+	g_free(str);
+
+	store_device_info(device);
+}
+
 static void load_info(struct btd_device *device, const char *local,
 			const char *peer, GKeyFile *key_file)
 {
@@ -2793,21 +2848,7 @@ next:
 	uuids = g_key_file_get_string_list(key_file, "General", "Services",
 						NULL, NULL);
 	if (uuids) {
-		char **uuid;
-
-		for (uuid = uuids; *uuid; uuid++) {
-			GSList *match;
-
-			match = g_slist_find_custom(device->uuids, *uuid,
-							bt_uuid_strcmp);
-			if (match)
-				continue;
-
-			device->uuids = g_slist_insert_sorted(device->uuids,
-								g_strdup(*uuid),
-								bt_uuid_strcmp);
-		}
-		g_strfreev(uuids);
+		load_services(device, uuids);
 
 		/* Discovered services restored from storage */
 		device->bredr_state.svc_resolved = true;
@@ -3528,6 +3569,8 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
 	src = btd_adapter_get_address(adapter);
 	ba2str(src, srcaddr);
 
+	convert_info(device, key_file);
+
 	load_info(device, srcaddr, address, key_file);
 	load_att_info(device, srcaddr, address);
 
-- 
2.5.0

