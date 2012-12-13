Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/15] device: Remove stored SDP records on device removal
Date: Thu, 13 Dec 2012 21:39:24 +0100
Message-Id: <1355431170-12897-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also remove management of legacy storage file in device_remove_stored().
Remove no more used storage functions.
---
 src/device.c  |   31 +++++++++++++++++--------
 src/storage.c |   72 ---------------------------------------------------------
 src/storage.h |    6 -----
 3 files changed, 21 insertions(+), 88 deletions(-)

diff --git a/src/device.c b/src/device.c
index 36bf9bc..24e97e6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2067,24 +2067,17 @@ static void device_remove_stored(struct btd_device *device)
 	char adapter_addr[18];
 	char device_addr[18];
 	char filename[PATH_MAX + 1];
-
-	delete_entry(src, "profiles", &device->bdaddr, dst_type);
-	delete_entry(src, "trusts", &device->bdaddr, dst_type);
+	GKeyFile *key_file;
+	char *data;
+	gsize length = 0;
 
 	if (device_is_bonded(device)) {
-		delete_entry(src, "linkkeys", &device->bdaddr, dst_type);
-		delete_entry(src, "aliases", &device->bdaddr, dst_type);
-		delete_entry(src, "longtermkeys", &device->bdaddr, dst_type);
-
 		device_set_bonded(device, FALSE);
 		device->paired = FALSE;
 		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
 								dst_type);
 	}
 
-	delete_all_records(src, &device->bdaddr, dst_type);
-	delete_device_service(src, &device->bdaddr, dst_type);
-
 	if (device->blocked)
 		device_unblock(device, TRUE, FALSE);
 
@@ -2095,6 +2088,24 @@ static void device_remove_stored(struct btd_device *device)
 			device_addr);
 	filename[PATH_MAX] = '\0';
 	delete_folder_tree(filename);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", adapter_addr,
+			device_addr);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	g_key_file_remove_group(key_file, "ServiceRecords", NULL);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR |
+					S_IRGRP | S_IROTH);
+		g_file_set_contents(filename, data, length, NULL);
+	}
+
+	g_free(data);
+	g_key_file_free(key_file);
 }
 
 void device_remove(struct btd_device *device, gboolean remove_stored)
diff --git a/src/storage.c b/src/storage.c
index 74b19c0..d4516ed 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -245,31 +245,6 @@ ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin)
 	return len;
 }
 
-int delete_entry(const bdaddr_t *src, const char *storage, const bdaddr_t *dst,
-							uint8_t dst_type)
-{
-	char filename[PATH_MAX + 1], key[20];
-	int err, ret;
-
-	ba2str(dst, key);
-	sprintf(&key[17], "#%hhu", dst_type);
-
-	create_filename(filename, PATH_MAX, src, storage);
-
-	err = 0;
-	ret = textfile_del(filename, key);
-	if (ret)
-		err = ret;
-
-	/* Trying without address type */
-	key[17] = '\0';
-	ret = textfile_del(filename, key);
-	if (ret)
-		err = ret;
-
-	return err;
-}
-
 int store_record(const gchar *src, const gchar *dst, uint8_t dst_type,
 							sdp_record_t *rec)
 {
@@ -397,26 +372,6 @@ static void create_stored_records_from_keys(char *key, char *value,
 	rec_list->recs = sdp_list_append(rec_list->recs, rec);
 }
 
-void delete_all_records(const bdaddr_t *src, const bdaddr_t *dst,
-							uint8_t dst_type)
-{
-	sdp_list_t *records, *seq;
-	char srcaddr[18], dstaddr[18];
-
-	ba2str(src, srcaddr);
-	ba2str(dst, dstaddr);
-
-	records = read_records(src, dst);
-
-	for (seq = records; seq; seq = seq->next) {
-		sdp_record_t *rec = seq->data;
-		delete_record(srcaddr, dstaddr, dst_type, rec->handle);
-	}
-
-	if (records)
-		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
-}
-
 sdp_list_t *read_records(const bdaddr_t *src, const bdaddr_t *dst)
 {
 	char filename[PATH_MAX + 1];
@@ -526,33 +481,6 @@ done:
 	g_slist_free_full(match.keys, g_free);
 }
 
-int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
-						uint8_t bdaddr_type)
-{
-	char filename[PATH_MAX + 1], key[20];
-
-	memset(key, 0, sizeof(key));
-
-	ba2str(dba, key);
-	sprintf(&key[17], "#%hhu", bdaddr_type);
-
-	/* Deleting all characteristics of a given key */
-	create_filename(filename, PATH_MAX, sba, "characteristics");
-	delete_by_pattern(filename, key);
-
-	/* Deleting all attributes values of a given key */
-	create_filename(filename, PATH_MAX, sba, "attributes");
-	delete_by_pattern(filename, key);
-
-	/* Deleting all CCC values of a given key */
-	create_filename(filename, PATH_MAX, sba, "ccc");
-	delete_by_pattern(filename, key);
-
-	create_filename(filename, PATH_MAX, sba, "primaries");
-
-	return textfile_del(filename, key);
-}
-
 char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 							uint8_t bdaddr_type)
 {
diff --git a/src/storage.h b/src/storage.h
index 2e2889d..ffc6deb 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -35,8 +35,6 @@ int read_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
 int write_lastused_info(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, struct tm *tm);
 ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin);
-int delete_entry(const bdaddr_t *src, const char *storage, const bdaddr_t *dst,
-							uint8_t dst_type);
 int store_record(const gchar *src, const gchar *dst, uint8_t dst_type,
 							sdp_record_t *rec);
 sdp_record_t *record_from_string(const gchar *str);
@@ -44,15 +42,11 @@ sdp_record_t *fetch_record(const gchar *src, const gchar *dst,
 			   uint8_t dst_type, const uint32_t handle);
 int delete_record(const gchar *src, const gchar *dst, uint8_t dst_type,
 							const uint32_t handle);
-void delete_all_records(const bdaddr_t *src, const bdaddr_t *dst,
-							uint8_t dst_type);
 sdp_list_t *read_records(const bdaddr_t *src, const bdaddr_t *dst);
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid);
 int read_device_pairable(const bdaddr_t *local, gboolean *mode);
 int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 				uint8_t bdaddr_type, const char *services);
-int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
-						uint8_t bdaddr_type);
 char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 							uint8_t bdaddr_type);
 int write_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
-- 
1.7.9.5

