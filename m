Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/8] adapter: Convert class to cached file
Date: Wed, 28 Nov 2012 14:39:21 +0100
Message-Id: <1354109967-6238-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354109967-6238-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354109967-6238-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of converting remote device's class directly in
<device storage dir>/info we should saved it in storage
cache directory.
Use 'converted Yes' instead of 'converted yes' to be able
to do conversion even if classes file was already converted
to device directory.

Class should be also saved in cache directory on device
discovery.

When a device is created it should try to retrieve class
from device info file.
If that fails fall back to the cache and save it to device
info file.
---
 src/adapter.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++------
 src/device.c  |   18 +++++++++++++-----
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 163360f..01cf22b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -253,8 +253,8 @@ static void store_adapter_info(struct btd_adapter *adapter)
 	g_key_file_free(key_file);
 }
 
-static void store_cached_name(const bdaddr_t *local, const bdaddr_t *peer,
-				char *name)
+static void store_cached_string(const bdaddr_t *local, const bdaddr_t *peer,
+				const char *key, const char *string)
 {
 	char filename[PATH_MAX + 1];
 	char s_addr[18], d_addr[18];
@@ -270,7 +270,7 @@ static void store_cached_name(const bdaddr_t *local, const bdaddr_t *peer,
 
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
-	g_key_file_set_string(key_file, "General", "Name", name);
+	g_key_file_set_string(key_file, "General", key, string);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, data, length, NULL);
@@ -279,6 +279,18 @@ static void store_cached_name(const bdaddr_t *local, const bdaddr_t *peer,
 	g_key_file_free(key_file);
 }
 
+static void store_cached_name(const bdaddr_t *local, const bdaddr_t *peer,
+				char *name)
+{
+	store_cached_string(local, peer, "Name", name);
+}
+
+static void store_cached_class(const bdaddr_t *local, const bdaddr_t *peer,
+				char *class)
+{
+	store_cached_string(local, peer, "Class", class);
+}
+
 static struct session_req *session_ref(struct session_req *req)
 {
 	req->refcount++;
@@ -2538,9 +2550,21 @@ static void convert_trusts_entry(GKeyFile *key_file, void *value)
 	g_key_file_set_boolean(key_file, "General", "Trusted", TRUE);
 }
 
-static void convert_classes_entry(GKeyFile *key_file, void *value)
+static void convert_classes_entry(char *key, char *value, void *user_data)
 {
-	g_key_file_set_string(key_file, "General", "Class", value);
+	char *address = user_data;
+	char *str = key;
+	bdaddr_t local, peer;
+
+	if (strchr(key, '#'))
+		str[17] = '\0';
+
+	if (bachk(str) != 0)
+		return;
+
+	str2ba(address, &local);
+	str2ba(str, &peer);
+	store_cached_class(&local, &peer, value);
 }
 
 static void convert_blocked_entry(GKeyFile *key_file, void *value)
@@ -2668,7 +2692,18 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	convert_file("trusts", address, convert_trusts_entry);
 
 	/* Convert classes */
-	convert_file("classes", address, convert_classes_entry);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/classes", address);
+	filename[PATH_MAX] = '\0';
+
+	str = textfile_get(filename, "converted");
+	if (str && strcmp(str, "Yes") == 0) {
+		DBG("Legacy classes file already converted");
+	} else {
+		textfile_foreach(filename, convert_classes_entry, address);
+		textfile_put(filename, "converted", "Yes");
+	}
+	free(str);
+
 
 	/* Convert blocked */
 	convert_file("blocked", address, convert_blocked_entry);
@@ -3120,6 +3155,13 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	if (eir_data.name != NULL && eir_data.name_complete)
 		store_cached_name(&adapter->bdaddr, bdaddr, eir_data.name);
 
+	if (eir_data.class != 0) {
+		char class[9];
+
+		sprintf(class, "0x%06X", eir_data.class);
+		store_cached_class(&adapter->bdaddr, bdaddr, class);
+	}
+
 	/* Avoid creating LE device if it's not discoverable */
 	if (bdaddr_type != BDADDR_BREDR &&
 			!(eir_data.flags & (EIR_LIM_DISC | EIR_GEN_DISC))) {
diff --git a/src/device.c b/src/device.c
index a99ca34..f9927da 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1753,8 +1753,8 @@ static void device_set_version(struct btd_device *device, uint16_t value)
 						DEVICE_INTERFACE, "Version");
 }
 
-static char *load_cached_name(struct btd_device *device, const char *local,
-				const gchar *peer)
+static char *load_cached_string(struct btd_device *device, const char *local,
+				const gchar *peer, const char *key)
 {
 	char filename[PATH_MAX + 1];
 	GKeyFile *key_file;
@@ -1769,7 +1769,7 @@ static char *load_cached_name(struct btd_device *device, const char *local,
 	if (!g_key_file_load_from_file(key_file, filename, 0, NULL))
 		goto failed;
 
-	str = g_key_file_get_string(key_file, "General", "Name", NULL);
+	str = g_key_file_get_string(key_file, "General", key, NULL);
 	if (str) {
 		len = strlen(str);
 		if (len > HCI_MAX_NAME_LENGTH)
@@ -1803,7 +1803,7 @@ static void load_info(struct btd_device *device, const gchar *local,
 	 */
 	str = g_key_file_get_string(key_file, "General", "Name", NULL);
 	if (str == NULL) {
-		str = load_cached_name(device, local, peer);
+		str = load_cached_string(device, local, peer, "Name");
 		if (str)
 			store_needed = TRUE;
 	}
@@ -1817,8 +1817,16 @@ static void load_info(struct btd_device *device, const gchar *local,
 	device->alias = g_key_file_get_string(key_file, "General", "Alias",
 									NULL);
 
-	/* Load class */
+	/* Load device class from storage info file, if that fails fall back to
+	 * the cache.
+	 */
 	str = g_key_file_get_string(key_file, "General", "Class", NULL);
+	if (str == NULL) {
+		str = load_cached_string(device, local, peer, "Class");
+		if (str)
+			store_needed = TRUE;
+	}
+
 	if (str) {
 		uint32_t class;
 
-- 
1.7.9.5

