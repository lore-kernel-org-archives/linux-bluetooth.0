Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] fix breakage of Bluetooth pairing
Date: Mon, 11 Apr 2016 14:27:19 +0200
Message-Id: <1460377639-20056-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Pawlowski <jpawlowski@chromium.org>

This patch adds parsing of old property containing list of services
available on remote devices. Without that previously paired devices,
i.e. keyboards, will not work properly.
---
 src/device.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 0d46eba..a0dc52c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2697,13 +2697,23 @@ fail:
 	return NULL;
 }
 
+static bool device_add_uuid(struct btd_device *device, const char *uuid)
+{
+	if (g_slist_find_custom(device->uuids, uuid, bt_uuid_strcmp))
+		return false;
+
+	device->uuids = g_slist_insert_sorted(device->uuids, g_strdup(uuid), bt_uuid_strcmp);
+
+	return true;
+}
+
 static void load_info(struct btd_device *device, const char *local,
 			const char *peer, GKeyFile *key_file)
 {
 	char *str;
 	gboolean store_needed = FALSE;
 	gboolean blocked;
-	char **uuids;
+	char **uuids, **sdp_uuids, **gatt_uuids;
 	int source, vendor, product, version;
 	char **techno, **t;
 
@@ -2813,6 +2823,33 @@ next:
 		device->bredr_state.svc_resolved = true;
 	}
 
+	/* Load device profile list from legacy property */
+	sdp_uuids = g_key_file_get_string_list(key_file, "General", "SDPServices",
+						NULL, NULL);
+	if (sdp_uuids) {
+		char **uuid;
+
+		for (uuid = sdp_uuids; *uuid; uuid++)
+			device_add_uuid(device, *uuid);
+
+		g_strfreev(sdp_uuids);
+
+		/* Discovered services restored from storage */
+		device->bredr_state.svc_resolved = true;
+	}
+
+	/* Load device profile list from legacy property */
+	gatt_uuids = g_key_file_get_string_list(key_file, "General", "GATTServices",
+						NULL, NULL);
+	if (gatt_uuids) {
+		char **uuid;
+
+		for (uuid = gatt_uuids; *uuid; uuid++)
+			device_add_uuid(device, *uuid);
+
+		g_strfreev(gatt_uuids);
+	}
+
 	/* Load device id */
 	source = g_key_file_get_integer(key_file, "DeviceID", "Source", NULL);
 	if (source) {
-- 
2.7.0

