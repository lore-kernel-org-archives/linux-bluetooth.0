Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] device : Add EndGroupHandle key in attributes storage
Date: Fri, 14 Dec 2012 17:45:15 +0100
Message-Id: <1355503519-26573-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

End group handle should also be converted/saved for each
group in device's attributes file.
---
 doc/settings-storage.txt |    8 +++++---
 src/adapter.c            |    8 +++++---
 src/device.c             |   10 ++++++++++
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 351b17e..11b127f 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -94,10 +94,12 @@ Attributes are stored using their handle as group name (decimal format).
 
 Each group contains:
 
-  UUID		String		128-bit UUID of the attribute
+  UUID			String		128-bit UUID of the attribute
 
-  Value		String		Value of the attribute as hexadecimal encoded
-				string
+  Value			String		Value of the attribute as hexadecimal encoded
+					string
+
+  EndGroupHandle	Integer		End group handle in decimal format
 
 Sample:
   [1]
diff --git a/src/adapter.c b/src/adapter.c
index b962bc1..37e85ed 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2419,7 +2419,8 @@ static gboolean record_has_uuid(const sdp_record_t *rec,
 }
 
 static void store_attribute_uuid(GKeyFile *key_file, uint16_t start,
-					char *att_uuid, uuid_t uuid)
+					uint16_t end, char *att_uuid,
+					uuid_t uuid)
 {
 	char handle[6], uuid_str[33];
 	int i;
@@ -2443,6 +2444,7 @@ static void store_attribute_uuid(GKeyFile *key_file, uint16_t start,
 	sprintf(handle, "%hu", start);
 	g_key_file_set_string(key_file, handle, "UUID", att_uuid);
 	g_key_file_set_string(key_file, handle, "Value", uuid_str);
+	g_key_file_set_integer(key_file, handle, "EndGroupHandle", end);
 }
 
 static void store_sdp_record(char *local, char *peer, int handle, char *value)
@@ -2535,7 +2537,7 @@ static void convert_sdp_entry(char *key, char *value, void *user_data)
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	store_attribute_uuid(key_file, start, prim_uuid, uuid);
+	store_attribute_uuid(key_file, start, end, prim_uuid, uuid);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
@@ -2597,7 +2599,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 		bt_string2uuid(&uuid, uuid_str);
 		sdp_uuid128_to_uuid(&uuid);
 
-		store_attribute_uuid(key_file, start, prim_uuid, uuid);
+		store_attribute_uuid(key_file, start, end, prim_uuid, uuid);
 	}
 
 	g_strfreev(services);
diff --git a/src/device.c b/src/device.c
index 77466ff..780a496 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1907,6 +1907,7 @@ static void load_att_info(struct btd_device *device, const gchar *local,
 
 	for (handle = groups; *handle; handle++) {
 		gboolean uuid_ok;
+		gint end;
 
 		str = g_key_file_get_string(key_file, *handle, "UUID", NULL);
 		if (!str)
@@ -1922,8 +1923,16 @@ static void load_att_info(struct btd_device *device, const gchar *local,
 		if (!str)
 			continue;
 
+		end = g_key_file_get_integer(key_file, *handle,
+						"EndGroupHandle", NULL);
+		if (end == 0) {
+			g_free(str);
+			continue;
+		}
+
 		prim = g_new0(struct gatt_primary, 1);
 		prim->range.start = atoi(*handle);
+		prim->range.end = end;
 
 		switch (strlen(str)) {
 		case 4:
@@ -2524,6 +2533,7 @@ static void store_primaries_from_sdp_record(GKeyFile *key_file,
 
 	g_key_file_set_string(key_file, handle, "UUID", prim_uuid);
 	g_key_file_set_string(key_file, handle, "Value", uuid_str);
+	g_key_file_set_integer(key_file, handle, "EndGroupHandle", end);
 
 done:
 	g_free(prim_uuid);
-- 
1.7.9.5

