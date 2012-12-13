Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 15/15] input: Use new storage architecture
Date: Thu, 13 Dec 2012 21:39:30 +0100
Message-Id: <1355431170-12897-15-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Retrieve HID record from device file located in cache directory.

Remove no more used fetch_record().
---
 profiles/input/device.c |   20 ++++++++++++++++----
 src/storage.c           |   27 ---------------------------
 src/storage.h           |    2 --
 3 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 2d8077a..9cea028 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -316,9 +316,11 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 static int hidp_add_connection(struct input_device *idev)
 {
 	struct hidp_connadd_req *req;
-	uint8_t dst_type;
 	sdp_record_t *rec;
 	char src_addr[18], dst_addr[18];
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	char handle[11], *str;
 	GError *gerr = NULL;
 	int err;
 
@@ -331,15 +333,25 @@ static int hidp_add_connection(struct input_device *idev)
 	ba2str(&idev->src, src_addr);
 	ba2str(&idev->dst, dst_addr);
 
-	dst_type = device_get_addr_type(idev->device);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", src_addr,
+								dst_addr);
+	filename[PATH_MAX] = '\0';
+	sprintf(handle, "0x%8.8X", idev->handle);
 
-	rec = fetch_record(src_addr, dst_addr, dst_type, idev->handle);
-	if (!rec) {
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	str = g_key_file_get_string(key_file, "ServiceRecords", handle, NULL);
+	g_key_file_free(key_file);
+
+	if (!str) {
 		error("Rejected connection from unknown device %s", dst_addr);
 		err = -EPERM;
 		goto cleanup;
 	}
 
+	rec = record_from_string(str);
+	g_free(str);
+
 	extract_hid_record(rec, req);
 	sdp_record_free(rec);
 
diff --git a/src/storage.c b/src/storage.c
index d3cbc8f..33da2cb 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -268,33 +268,6 @@ sdp_record_t *record_from_string(const gchar *str)
 }
 
 
-sdp_record_t *fetch_record(const gchar *src, const gchar *dst,
-			   uint8_t dst_type, const uint32_t handle)
-{
-	char filename[PATH_MAX + 1], old_key[28], key[30], *str;
-	sdp_record_t *rec;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "sdp");
-
-	snprintf(key, sizeof(key), "%17s#%hhu#%08X", dst, dst_type, handle);
-	snprintf(old_key, sizeof(old_key), "%17s#%08X", dst, handle);
-
-	str = textfile_get(filename, key);
-	if (str != NULL)
-		goto done;
-
-	/* Try old format (address#handle) */
-	str = textfile_get(filename, old_key);
-	if (str == NULL)
-		return NULL;
-
-done:
-	rec = record_from_string(str);
-	free(str);
-
-	return rec;
-}
-
 int delete_record(const gchar *src, const gchar *dst, uint8_t dst_type,
 							const uint32_t handle)
 {
diff --git a/src/storage.h b/src/storage.h
index 4c99693..b125818 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -36,8 +36,6 @@ int write_lastused_info(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, struct tm *tm);
 ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin);
 sdp_record_t *record_from_string(const gchar *str);
-sdp_record_t *fetch_record(const gchar *src, const gchar *dst,
-			   uint8_t dst_type, const uint32_t handle);
 int delete_record(const gchar *src, const gchar *dst, uint8_t dst_type,
 							const uint32_t handle);
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid);
-- 
1.7.9.5

