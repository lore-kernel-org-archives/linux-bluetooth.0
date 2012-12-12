Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/14] device: Load profiles from storage
Date: Wed, 12 Dec 2012 16:47:53 +0100
Message-Id: <1355327283-1558-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add device_get_uuids() to retrieve UUIDs list.
It will allow to call device_probe_profiles() from
load_devices() of adapter.c after device creation.

Remove write_device_profiles from storage.[ch].
---
 src/device.c  |   89 ++++++++++++++++++++++++++++++---------------------------
 src/device.h  |    1 +
 src/storage.c |   18 ------------
 src/storage.h |    2 --
 4 files changed, 48 insertions(+), 62 deletions(-)

diff --git a/src/device.c b/src/device.c
index 99ef77c..242313d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -218,6 +218,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 	char device_addr[18];
 	char *str;
 	char class[9];
+	gchar **uuids = NULL;
 	gsize length = 0;
 
 	device->store_id = 0;
@@ -281,6 +282,19 @@ static gboolean store_device_info_cb(gpointer user_data)
 	g_key_file_set_boolean(key_file, "General", "Blocked",
 							device->blocked);
 
+	if (device->uuids) {
+		GSList *l;
+		int i;
+
+		uuids = g_new0(gchar *, g_slist_length(device->uuids) + 1);
+		for (i = 0, l = device->uuids; l; l = g_slist_next(l), i++)
+			uuids[i] = l->data;
+		g_key_file_set_string_list(key_file, "General", "Profiles",
+						(const gchar **)uuids, i);
+	} else {
+		g_key_file_remove_key(key_file, "General", "Profiles", NULL);
+	}
+
 	if (device->vendor_src) {
 		g_key_file_set_integer(key_file, "DeviceID", "Source",
 					device->vendor_src);
@@ -301,6 +315,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 	g_free(str);
 
 	g_key_file_free(key_file);
+	g_free(uuids);
 
 	return FALSE;
 }
@@ -1928,6 +1943,7 @@ static void load_info(struct btd_device *device, const gchar *local,
 	char *str;
 	gboolean store_needed = FALSE;
 	gboolean blocked;
+	gchar **uuids;
 	int source, vendor, product, version;
 	char **techno, **t;
 	gboolean bredr = FALSE;
@@ -2007,6 +2023,27 @@ next:
 	if (blocked)
 		device_block(device, FALSE);
 
+	/* Load device profile list */
+	uuids = g_key_file_get_string_list(key_file, "General", "Profiles",
+						NULL, NULL);
+	if (uuids) {
+		gchar **uuid;
+
+		for (uuid = uuids; *uuid; uuid++) {
+			GSList *match;
+
+			match = g_slist_find_custom(device->uuids, *uuid,
+							bt_uuid_strcmp);
+			if (match)
+				continue;
+
+			device->uuids = g_slist_insert_sorted(device->uuids,
+								g_strdup(*uuid),
+								bt_uuid_strcmp);
+		}
+		g_strfreev(uuids);
+	}
+
 	/* Load device id */
 	source = g_key_file_get_integer(key_file, "DeviceID", "Source", NULL);
 	if (source) {
@@ -2316,6 +2353,11 @@ static gboolean record_has_uuid(const sdp_record_t *rec,
 	return FALSE;
 }
 
+GSList *device_get_uuids(struct btd_device *device)
+{
+	return device->uuids;
+}
+
 static GSList *device_match_profile(struct btd_device *device,
 					struct btd_profile *profile,
 					GSList *uuids)
@@ -2455,35 +2497,16 @@ add_uuids:
 static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 {
 	char srcaddr[18], dstaddr[18];
-	sdp_list_t *records;
 	GSList *l, *next;
 
 	ba2str(adapter_get_address(device->adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
-	records = read_records(adapter_get_address(device->adapter),
-							&device->bdaddr);
-
 	DBG("Removing profiles for %s", dstaddr);
 
-	for (l = uuids; l != NULL; l = g_slist_next(l)) {
-		sdp_record_t *rec;
-
-		device->uuids = g_slist_remove(device->uuids, l->data);
-
-		rec = find_record_in_list(records, l->data);
-		if (!rec)
-			continue;
-
-		delete_record(srcaddr, dstaddr, device->bdaddr_type,
-							rec->handle);
-
-		records = sdp_list_remove(records, rec);
-		sdp_record_free(rec);
-	}
-
-	if (records)
-		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
+	g_slist_free(device->uuids);
+	device->uuids = NULL;
+	store_device_info(device);
 
 	for (l = device->profiles; l != NULL; l = next) {
 		struct btd_profile *profile = l->data;
@@ -2652,24 +2675,6 @@ static void update_gatt_services(struct browse_req *req, GSList *current,
 	g_slist_free(left);
 }
 
-static void store_profiles(struct btd_device *device)
-{
-	struct btd_adapter *adapter = device->adapter;
-	char *str;
-
-	if (!device->uuids) {
-		write_device_profiles(adapter_get_address(adapter),
-					&device->bdaddr, device->bdaddr_type,
-					"");
-		return;
-	}
-
-	str = bt_list2string(device->uuids);
-	write_device_profiles(adapter_get_address(adapter), &device->bdaddr,
-						device->bdaddr_type, str);
-	g_free(str);
-}
-
 GSList *device_services_from_record(struct btd_device *device, GSList *profiles)
 {
 	GSList *l, *prim_list = NULL;
@@ -2759,7 +2764,7 @@ send_reply:
 	device_svc_resolved(device, err);
 
 	if (!device->temporary)
-		store_profiles(device);
+		store_device_info(device);
 
 	browse_request_free(req);
 }
@@ -4023,7 +4028,7 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 	g_free(new_uuid);
 	g_slist_free(uuid_list);
 
-	store_profiles(device);
+	store_device_info(device);
 	uuids_changed(device);
 }
 
diff --git a/src/device.h b/src/device.h
index 5c55b35..1785a75 100644
--- a/src/device.h
+++ b/src/device.h
@@ -42,6 +42,7 @@ uint16_t btd_device_get_version(struct btd_device *device);
 void device_remove(struct btd_device *device, gboolean remove_stored);
 gint device_address_cmp(struct btd_device *device, const gchar *address);
 gint device_bdaddr_cmp(struct btd_device *device, bdaddr_t *bdaddr);
+GSList *device_get_uuids(struct btd_device *device);
 void device_probe_profiles(struct btd_device *device, GSList *profiles);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
diff --git a/src/storage.c b/src/storage.c
index 5798ccd..17dfc21 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -263,24 +263,6 @@ ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin)
 	return len;
 }
 
-int write_device_profiles(const bdaddr_t *src, const bdaddr_t *dst,
-					uint8_t dst_type, const char *profiles)
-{
-	char filename[PATH_MAX + 1], key[20];
-
-	if (!profiles)
-		return -EINVAL;
-
-	create_filename(filename, PATH_MAX, src, "profiles");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(dst, key);
-	sprintf(&key[17], "#%hhu", dst_type);
-
-	return textfile_put(filename, key, profiles);
-}
-
 int delete_entry(const bdaddr_t *src, const char *storage, const bdaddr_t *dst,
 							uint8_t dst_type)
 {
diff --git a/src/storage.h b/src/storage.h
index c8ae6b0..fdee61c 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -36,8 +36,6 @@ int read_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
 int write_lastused_info(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, struct tm *tm);
 ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin);
-int write_device_profiles(const bdaddr_t *src, const bdaddr_t *dst,
-				uint8_t dst_type, const char *profiles);
 int delete_entry(const bdaddr_t *src, const char *storage, const bdaddr_t *dst,
 							uint8_t dst_type);
 int store_record(const gchar *src, const gchar *dst, uint8_t dst_type,
-- 
1.7.9.5

