Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 14/15] device: Update btd_device_get_record to use new storage
Date: Thu, 13 Dec 2012 21:39:29 +0100
Message-Id: <1355431170-12897-14-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove no more used functions from storage.[ch].
---
 src/device.c  |   40 ++++++++++++++++++++++++++++++++++++++--
 src/storage.c |   38 --------------------------------------
 src/storage.h |    1 -
 3 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/src/device.c b/src/device.c
index fc37e51..96b226f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4051,6 +4051,43 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 	uuids_changed(device);
 }
 
+static sdp_list_t *read_device_records(struct btd_device *device)
+{
+	char local[18], peer[18];
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	char **keys, **handle;
+	char *str;
+	sdp_list_t *recs = NULL;
+	sdp_record_t *rec;
+
+	ba2str(adapter_get_address(device->adapter), local);
+	ba2str(&device->bdaddr, peer);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	keys = g_key_file_get_keys(key_file, "ServiceRecords", NULL, NULL);
+
+	for (handle = keys; *handle; handle++) {
+		str = g_key_file_get_string(key_file, "ServiceRecords",
+						*handle, NULL);
+		if (!str)
+			continue;
+
+		rec = record_from_string(str);
+		recs = sdp_list_append(recs, rec);
+		g_free(str);
+	}
+
+	g_strfreev(keys);
+	g_key_file_free(key_file);
+
+	return recs;
+}
+
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 							const char *uuid)
 {
@@ -4066,8 +4103,7 @@ const sdp_record_t *btd_device_get_record(struct btd_device *device,
 		device->tmp_records = NULL;
 	}
 
-	device->tmp_records = read_records(adapter_get_address(device->adapter),
-							&device->bdaddr);
+	device->tmp_records = read_device_records(device);
 	if (!device->tmp_records)
 		return NULL;
 
diff --git a/src/storage.c b/src/storage.c
index 180946f..d3cbc8f 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -319,44 +319,6 @@ int delete_record(const gchar *src, const gchar *dst, uint8_t dst_type,
 	return err;
 }
 
-struct record_list {
-	sdp_list_t *recs;
-	const gchar *addr;
-};
-
-static void create_stored_records_from_keys(char *key, char *value,
-							void *user_data)
-{
-	struct record_list *rec_list = user_data;
-	const gchar *addr = rec_list->addr;
-	sdp_record_t *rec;
-
-	if (strncmp(key, addr, 17))
-		return;
-
-	rec = record_from_string(value);
-
-	rec_list->recs = sdp_list_append(rec_list->recs, rec);
-}
-
-sdp_list_t *read_records(const bdaddr_t *src, const bdaddr_t *dst)
-{
-	char filename[PATH_MAX + 1];
-	struct record_list rec_list;
-	char srcaddr[18], dstaddr[18];
-
-	ba2str(src, srcaddr);
-	ba2str(dst, dstaddr);
-
-	rec_list.addr = dstaddr;
-	rec_list.recs = NULL;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "sdp");
-	textfile_foreach(filename, create_stored_records_from_keys, &rec_list);
-
-	return rec_list.recs;
-}
-
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid)
 {
 	sdp_list_t *seq;
diff --git a/src/storage.h b/src/storage.h
index 262a594..4c99693 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -40,7 +40,6 @@ sdp_record_t *fetch_record(const gchar *src, const gchar *dst,
 			   uint8_t dst_type, const uint32_t handle);
 int delete_record(const gchar *src, const gchar *dst, uint8_t dst_type,
 							const uint32_t handle);
-sdp_list_t *read_records(const bdaddr_t *src, const bdaddr_t *dst);
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid);
 int read_device_pairable(const bdaddr_t *local, gboolean *mode);
 int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
-- 
1.7.9.5

