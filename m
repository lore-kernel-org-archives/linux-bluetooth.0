Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] core/device: Fix breakage of Bluetooth pairing
Date: Mon, 11 Apr 2016 19:03:02 +0300
Message-Id: <1460390582-16548-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Pawlowski <jpawlowski@chromium.org>

This patch converts old propertis containing list of services available
on remote devices. Without that previously paired devices, i.e.
keyboards, will not work properly.
---
v2: Convert the old entries to Services deleting the entries in the process

 src/device.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0d46eba..b20d389 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2697,6 +2697,65 @@ fail:
 	return NULL;
 }
 
+static bool device_add_uuid(struct btd_device *device, const char *uuid)
+{
+	if (g_slist_find_custom(device->uuids, uuid, bt_uuid_strcmp))
+		return false;
+
+	device->uuids = g_slist_insert_sorted(device->uuids, g_strdup(uuid),
+							bt_uuid_strcmp);
+
+	return true;
+}
+
+static void convert_info(struct btd_device *device, GKeyFile *key_file)
+{
+	char **uuids;
+
+	/* Load device profile list from legacy property */
+	uuids = g_key_file_get_string_list(key_file, "General", "SDPServices",
+								NULL, NULL);
+	if (uuids) {
+		char **uuid;
+
+		for (uuid = uuids; *uuid; uuid++)
+			device_add_uuid(device, *uuid);
+
+		/* Remove SDPServices so it is not loaded again */
+		g_key_file_remove_key(key_file, "General", "SDPServices", NULL);
+		g_strfreev(uuids);
+	}
+
+	/* Load device profile list from legacy property */
+	uuids = g_key_file_get_string_list(key_file, "General", "GATTServices",
+								NULL, NULL);
+	if (uuids) {
+		char **uuid;
+
+		for (uuid = uuids; *uuid; uuid++)
+			device_add_uuid(device, *uuid);
+
+		/* Remove GATTServices so it is not loaded again */
+		g_key_file_remove_key(key_file, "General", "GATTServices",
+								NULL);
+		g_strfreev(uuids);
+	}
+
+	if (device->uuids) {
+		GSList *l;
+		int i;
+
+		uuids = g_new0(char *, g_slist_length(device->uuids) + 1);
+		for (i = 0, l = device->uuids; l; l = g_slist_next(l), i++)
+			uuids[i] = l->data;
+
+		/* Store the list in the Services so it is properly loaded */
+		g_key_file_set_string_list(key_file, "General", "Services",
+						(const char **)uuids, i);
+		g_free(uuids);
+	}
+}
+
 static void load_info(struct btd_device *device, const char *local,
 			const char *peer, GKeyFile *key_file)
 {
@@ -2795,18 +2854,9 @@ next:
 	if (uuids) {
 		char **uuid;
 
-		for (uuid = uuids; *uuid; uuid++) {
-			GSList *match;
-
-			match = g_slist_find_custom(device->uuids, *uuid,
-							bt_uuid_strcmp);
-			if (match)
-				continue;
+		for (uuid = uuids; *uuid; uuid++)
+			device_add_uuid(device, *uuid);
 
-			device->uuids = g_slist_insert_sorted(device->uuids,
-								g_strdup(*uuid),
-								bt_uuid_strcmp);
-		}
 		g_strfreev(uuids);
 
 		/* Discovered services restored from storage */
@@ -3528,6 +3578,8 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
 	src = btd_adapter_get_address(adapter);
 	ba2str(src, srcaddr);
 
+	convert_info(device, key_file);
+
 	load_info(device, srcaddr, address, key_file);
 	load_att_info(device, srcaddr, address);
 
-- 
2.5.0

