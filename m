Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v2 12/12] storage: Store address type in "sdp" file
Date: Tue,  3 Jul 2012 17:32:15 -0300
Message-Id: <1341347535-15343-13-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1341347535-15343-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
 <1341347535-15343-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/device.c |    5 ++++-
 src/device.c   |   10 +++++++---
 src/storage.c  |   44 +++++++++++++++++++++++++++++++-------------
 src/storage.h  |   12 ++++++++----
 4 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/input/device.c b/input/device.c
index cf4bfc4..fd34ca9 100644
--- a/input/device.c
+++ b/input/device.c
@@ -604,6 +604,7 @@ static int hidp_add_connection(const struct input_device *idev,
 	struct hidp_connadd_req *req;
 	struct fake_hid *fake_hid;
 	struct fake_input *fake;
+	uint8_t dst_type;
 	sdp_record_t *rec;
 	char src_addr[18], dst_addr[18];
 	GError *gerr = NULL;
@@ -618,7 +619,9 @@ static int hidp_add_connection(const struct input_device *idev,
 	ba2str(&idev->src, src_addr);
 	ba2str(&idev->dst, dst_addr);
 
-	rec = fetch_record(src_addr, dst_addr, idev->handle);
+	dst_type = device_get_addr_type(idev->device);
+
+	rec = fetch_record(src_addr, dst_addr, dst_type, idev->handle);
 	if (!rec) {
 		error("Rejected connection from unknown device %s", dst_addr);
 		err = -EPERM;
diff --git a/src/device.c b/src/device.c
index 6d8e786..6374f06 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1178,7 +1178,7 @@ static void device_remove_stored(struct btd_device *device)
 							device->bdaddr_type);
 	}
 
-	delete_all_records(&src, &device->bdaddr);
+	delete_all_records(&src, &device->bdaddr, device->bdaddr_type);
 	delete_device_service(&src, &device->bdaddr, device->bdaddr_type);
 
 	if (device->blocked)
@@ -1403,7 +1403,8 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 		if (!rec)
 			continue;
 
-		delete_record(srcaddr, dstaddr, rec->handle);
+		delete_record(srcaddr, dstaddr, device->bdaddr_type,
+							rec->handle);
 
 		records = sdp_list_remove(records, rec);
 		sdp_record_free(rec);
@@ -1445,6 +1446,7 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 	struct btd_adapter *adapter = device_get_adapter(device);
 	sdp_list_t *seq;
 	char srcaddr[18], dstaddr[18];
+	uint8_t dst_type;
 	bdaddr_t src;
 
 	adapter_get_address(adapter, &src);
@@ -1511,7 +1513,9 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 			continue;
 		}
 
-		store_record(srcaddr, dstaddr, rec);
+		dst_type = device_get_addr_type(device);
+
+		store_record(srcaddr, dstaddr, dst_type, rec);
 
 		/* Copy record */
 		req->records = sdp_list_append(req->records,
diff --git a/src/storage.c b/src/storage.c
index 0cd6c42..928f14f 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -888,9 +888,10 @@ int delete_entry(bdaddr_t *src, const char *storage, const char *key)
 	return err;
 }
 
-int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec)
+int store_record(const gchar *src, const gchar *dst, uint8_t dst_type,
+							sdp_record_t *rec)
 {
-	char filename[PATH_MAX + 1], key[28];
+	char filename[PATH_MAX + 1], key[30];
 	sdp_buf_t buf;
 	int err, size, i;
 	char *str;
@@ -899,7 +900,8 @@ int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec)
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	snprintf(key, sizeof(key), "%17s#%08X", dst, rec->handle);
+	snprintf(key, sizeof(key), "%17s#%hhu#%08X", dst, dst_type,
+								rec->handle);
 
 	if (sdp_gen_record_pdu(rec, &buf) < 0)
 		return -1;
@@ -943,34 +945,49 @@ sdp_record_t *record_from_string(const gchar *str)
 
 
 sdp_record_t *fetch_record(const gchar *src, const gchar *dst,
-						const uint32_t handle)
+			   uint8_t dst_type, const uint32_t handle)
 {
-	char filename[PATH_MAX + 1], key[28], *str;
+	char filename[PATH_MAX + 1], old_key[28], key[30], *str;
 	sdp_record_t *rec;
 
 	create_name(filename, PATH_MAX, STORAGEDIR, src, "sdp");
 
-	snprintf(key, sizeof(key), "%17s#%08X", dst, handle);
+	snprintf(key, sizeof(key), "%17s#%hhu#%08X", dst, dst_type, handle);
+	snprintf(old_key, sizeof(old_key), "%17s#%08X", dst, handle);
 
 	str = textfile_get(filename, key);
-	if (!str)
+	if (str != NULL)
+		goto done;
+
+	/* Try old format (address#handle) */
+	str = textfile_get(filename, old_key);
+	if (str == NULL)
 		return NULL;
 
+done:
 	rec = record_from_string(str);
 	free(str);
 
 	return rec;
 }
 
-int delete_record(const gchar *src, const gchar *dst, const uint32_t handle)
+int delete_record(const gchar *src, const gchar *dst, uint8_t dst_type,
+							const uint32_t handle)
 {
-	char filename[PATH_MAX + 1], key[28];
+	char filename[PATH_MAX + 1], old_key[28], key[30];
+	int err;
 
 	create_name(filename, PATH_MAX, STORAGEDIR, src, "sdp");
 
-	snprintf(key, sizeof(key), "%17s#%08X", dst, handle);
+	snprintf(key, sizeof(key), "%17s#%hhu#%08X", dst, dst_type, handle);
+	snprintf(old_key, sizeof(old_key), "%17s#%08X", dst, handle);
 
-	return textfile_del(filename, key);
+	err = textfile_del(filename, key);
+	if (err < 0)
+		/* Try old format (address#handle) */
+		err = textfile_del(filename, key);
+
+	return err;
 }
 
 struct record_list {
@@ -993,7 +1010,8 @@ static void create_stored_records_from_keys(char *key, char *value,
 	rec_list->recs = sdp_list_append(rec_list->recs, rec);
 }
 
-void delete_all_records(const bdaddr_t *src, const bdaddr_t *dst)
+void delete_all_records(const bdaddr_t *src, const bdaddr_t *dst,
+							uint8_t dst_type)
 {
 	sdp_list_t *records, *seq;
 	char srcaddr[18], dstaddr[18];
@@ -1005,7 +1023,7 @@ void delete_all_records(const bdaddr_t *src, const bdaddr_t *dst)
 
 	for (seq = records; seq; seq = seq->next) {
 		sdp_record_t *rec = seq->data;
-		delete_record(srcaddr, dstaddr, rec->handle);
+		delete_record(srcaddr, dstaddr, dst_type, rec->handle);
 	}
 
 	if (records)
diff --git a/src/storage.h b/src/storage.h
index f982818..dcd2572 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -71,11 +71,15 @@ int write_trust(const char *src, const char *addr, uint8_t addr_type,
 int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 							const char *profiles);
 int delete_entry(bdaddr_t *src, const char *storage, const char *key);
-int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec);
+int store_record(const gchar *src, const gchar *dst, uint8_t dst_type,
+							sdp_record_t *rec);
 sdp_record_t *record_from_string(const gchar *str);
-sdp_record_t *fetch_record(const gchar *src, const gchar *dst, const uint32_t handle);
-int delete_record(const gchar *src, const gchar *dst, const uint32_t handle);
-void delete_all_records(const bdaddr_t *src, const bdaddr_t *dst);
+sdp_record_t *fetch_record(const gchar *src, const gchar *dst,
+			   uint8_t dst_type, const uint32_t handle);
+int delete_record(const gchar *src, const gchar *dst, uint8_t dst_type,
+							const uint32_t handle);
+void delete_all_records(const bdaddr_t *src, const bdaddr_t *dst,
+							uint8_t dst_type);
 sdp_list_t *read_records(const bdaddr_t *src, const bdaddr_t *dst);
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid);
 int store_device_id(const gchar *src, const gchar *dst, uint8_t dst_type,
-- 
1.7.9.5

