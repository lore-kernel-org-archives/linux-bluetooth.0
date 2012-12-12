Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/14] device: Update services from SDP records
Date: Wed, 12 Dec 2012 16:47:58 +0100
Message-Id: <1355327283-1558-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update attributes file with primary services retrieved from attributes
entry in SDP records.

Remove store_record() from storage.[ch].
---
 src/device.c  |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/storage.c |   33 -------------------------
 src/storage.h |    2 --
 3 files changed, 74 insertions(+), 36 deletions(-)

diff --git a/src/device.c b/src/device.c
index a515266..6c3d5e8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2643,6 +2643,52 @@ static void uuids_changed(struct btd_device *device)
 	g_free(uuids);
 }
 
+static void store_primaries_from_sdp_record(GKeyFile *key_file,
+						sdp_record_t *rec)
+{
+	uuid_t uuid;
+	char *att_uuid, *prim_uuid;
+	uint16_t start = 0, end = 0, psm = 0;
+	char handle[6], uuid_str[33];
+	int i;
+
+	sdp_uuid16_create(&uuid, ATT_UUID);
+	att_uuid = bt_uuid2string(&uuid);
+
+	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	prim_uuid = bt_uuid2string(&uuid);
+
+	if (!record_has_uuid(rec, att_uuid))
+		goto done;
+
+	if (!gatt_parse_record(rec, &uuid, &psm, &start, &end))
+		goto done;
+
+	sprintf(handle, "%hd", start);
+	switch (uuid.type) {
+	case SDP_UUID16:
+		sprintf(uuid_str, "%4.4X", uuid.value.uuid16);
+		break;
+	case SDP_UUID32:
+		sprintf(uuid_str, "%8.8X", uuid.value.uuid32);
+		break;
+	case SDP_UUID128:
+		for (i = 0; i < 16; i++)
+			sprintf(uuid_str + (i * 2), "%2.2X",
+					uuid.value.uuid128.data[i]);
+		break;
+	default:
+		uuid_str[0] = '\0';
+	}
+
+	g_key_file_set_string(key_file, handle, "UUID", prim_uuid);
+	g_key_file_set_string(key_file, handle, "Value", uuid_str);
+
+done:
+	g_free(prim_uuid);
+	g_free(att_uuid);
+}
+
 static int rec_cmp(const void *a, const void *b)
 {
 	const sdp_record_t *r1 = a;
@@ -2656,10 +2702,23 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 	struct btd_device *device = req->device;
 	sdp_list_t *seq;
 	char srcaddr[18], dstaddr[18];
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file = NULL;
+	char *data;
+	gsize length = 0;
 
 	ba2str(adapter_get_address(device->adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
+	if (!device->temporary) {
+		snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes",
+							srcaddr, dstaddr);
+		filename[PATH_MAX] = '\0';
+
+		key_file = g_key_file_new();
+		g_key_file_load_from_file(key_file, filename, 0, NULL);
+	}
+
 	for (seq = recs; seq; seq = seq->next) {
 		sdp_record_t *rec = (sdp_record_t *) seq->data;
 		sdp_list_t *svcclass = NULL;
@@ -2713,7 +2772,8 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 			continue;
 		}
 
-		store_record(srcaddr, dstaddr, device->bdaddr_type, rec);
+		if (key_file)
+			store_primaries_from_sdp_record(key_file, rec);
 
 		/* Copy record */
 		req->records = sdp_list_append(req->records,
@@ -2734,6 +2794,19 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 
 		sdp_list_free(svcclass, free);
 	}
+
+	if (!key_file)
+		return;
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		g_file_set_contents(filename, data, length, NULL);
+	}
+
+	g_free(data);
+
+	g_key_file_free(key_file);
 }
 
 static gint primary_cmp(gconstpointer a, gconstpointer b)
diff --git a/src/storage.c b/src/storage.c
index 17dfc21..5dfb8ea 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -288,39 +288,6 @@ int delete_entry(const bdaddr_t *src, const char *storage, const bdaddr_t *dst,
 	return err;
 }
 
-int store_record(const gchar *src, const gchar *dst, uint8_t dst_type,
-							sdp_record_t *rec)
-{
-	char filename[PATH_MAX + 1], key[30];
-	sdp_buf_t buf;
-	int err, size, i;
-	char *str;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "sdp");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	snprintf(key, sizeof(key), "%17s#%hhu#%08X", dst, dst_type,
-								rec->handle);
-
-	if (sdp_gen_record_pdu(rec, &buf) < 0)
-		return -1;
-
-	size = buf.data_size;
-
-	str = g_malloc0(size*2+1);
-
-	for (i = 0; i < size; i++)
-		sprintf(str + (i * 2), "%02X", buf.data[i]);
-
-	err = textfile_put(filename, key, str);
-
-	free(buf.data);
-	g_free(str);
-
-	return err;
-}
-
 sdp_record_t *record_from_string(const gchar *str)
 {
 	sdp_record_t *rec;
diff --git a/src/storage.h b/src/storage.h
index fdee61c..c390e46 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -38,8 +38,6 @@ int write_lastused_info(const bdaddr_t *local, const bdaddr_t *peer,
 ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin);
 int delete_entry(const bdaddr_t *src, const char *storage, const bdaddr_t *dst,
 							uint8_t dst_type);
-int store_record(const gchar *src, const gchar *dst, uint8_t dst_type,
-							sdp_record_t *rec);
 sdp_record_t *record_from_string(const gchar *str);
 sdp_record_t *fetch_record(const gchar *src, const gchar *dst,
 			   uint8_t dst_type, const uint32_t handle);
-- 
1.7.9.5

