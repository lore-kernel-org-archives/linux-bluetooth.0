Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 08/12] storage: Store address type in "did" file
Date: Thu, 14 Jun 2012 20:04:00 -0300
Message-Id: <1339715044-13737-9-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c  |    7 ++++---
 src/storage.c |   33 +++++++++++++++++++++++----------
 src/storage.h |    4 ++--
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/src/device.c b/src/device.c
index 685db89..b606a0d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1094,8 +1094,8 @@ struct btd_device *device_create(DBusConnection *conn,
 		device_set_bonded(device, TRUE);
 	}
 
-	if (read_device_id(srcaddr, address, NULL, &vendor, &product, &version)
-									== 0) {
+	if (read_device_id(srcaddr, address, bdaddr_type, NULL, &vendor,
+						&product, &version) == 0) {
 		device_set_vendor(device, vendor);
 		device_set_product(device, product);
 		device_set_version(device, version);
@@ -1496,7 +1496,8 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 			device_set_version(device, version);
 
 			if (source || vendor || product || version)
-				store_device_id(srcaddr, dstaddr, source,
+				store_device_id(srcaddr, dstaddr,
+						device->bdaddr_type, source,
 						vendor, product, version);
 		}
 
diff --git a/src/storage.c b/src/storage.c
index c475a40..f8d527a 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1021,35 +1021,46 @@ sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid)
 	return NULL;
 }
 
-int store_device_id(const gchar *src, const gchar *dst,
+int store_device_id(const gchar *src, const gchar *dst, uint8_t bdaddr_type,
 				const uint16_t source, const uint16_t vendor,
 				const uint16_t product, const uint16_t version)
 {
-	char filename[PATH_MAX + 1], str[20];
+	char filename[PATH_MAX + 1], key[20], str[20];
 
 	create_name(filename, PATH_MAX, STORAGEDIR, src, "did");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
+	snprintf(key, sizeof(key), "%17s#%hhu", dst, bdaddr_type);
+
 	snprintf(str, sizeof(str), "%04X %04X %04X %04X", source,
 						vendor, product, version);
 
-	return textfile_put(filename, dst, str);
+	return textfile_put(filename, key, str);
 }
 
 static int read_device_id_from_did(const gchar *src, const gchar *dst,
-					uint16_t *source, uint16_t *vendor,
-					uint16_t *product, uint16_t *version)
+				   uint8_t bdaddr_type, uint16_t *source,
+				   uint16_t *vendor, uint16_t *product,
+							uint16_t *version)
 {
 	char filename[PATH_MAX + 1];
-	char *str, *vendor_str, *product_str, *version_str;
+	char key[20], *str, *vendor_str, *product_str, *version_str;
 
 	create_name(filename, PATH_MAX, STORAGEDIR, src, "did");
 
+	snprintf(key, sizeof(key), "%17s#%hhu", dst, bdaddr_type);
+
+	str = textfile_get(filename, key);
+	if (str != NULL)
+		goto done;
+
+	/* Try old format (address only) */
 	str = textfile_get(filename, dst);
 	if (!str)
 		return -ENOENT;
 
+done:
 	vendor_str = strchr(str, ' ');
 	if (!vendor_str) {
 		free(str);
@@ -1086,7 +1097,7 @@ static int read_device_id_from_did(const gchar *src, const gchar *dst,
 }
 
 int read_device_id(const gchar *srcaddr, const gchar *dstaddr,
-					uint16_t *source, uint16_t *vendor,
+		   uint8_t bdaddr_type, uint16_t *source, uint16_t *vendor,
 					uint16_t *product, uint16_t *version)
 {
 	uint16_t lsource, lvendor, lproduct, lversion;
@@ -1095,8 +1106,9 @@ int read_device_id(const gchar *srcaddr, const gchar *dstaddr,
 	bdaddr_t src, dst;
 	int err;
 
-	err = read_device_id_from_did(srcaddr, dstaddr, &lsource,
-						vendor, product, version);
+	err = read_device_id_from_did(srcaddr, dstaddr, bdaddr_type, &lsource,
+								vendor, product,
+								version);
 	if (!err) {
 		if (lsource == 0xffff)
 			err = -ENOENT;
@@ -1141,7 +1153,8 @@ int read_device_id(const gchar *srcaddr, const gchar *dstaddr,
 		lversion = 0x0000;
 	}
 
-	store_device_id(srcaddr, dstaddr, lsource, lvendor, lproduct, lversion);
+	store_device_id(srcaddr, dstaddr, lsource, bdaddr_type, lvendor,
+							lproduct, lversion);
 
 	if (err)
 		return err;
diff --git a/src/storage.h b/src/storage.h
index 0ac7c03..c7750ac 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -73,10 +73,10 @@ int delete_record(const gchar *src, const gchar *dst, const uint32_t handle);
 void delete_all_records(const bdaddr_t *src, const bdaddr_t *dst);
 sdp_list_t *read_records(const bdaddr_t *src, const bdaddr_t *dst);
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid);
-int store_device_id(const gchar *src, const gchar *dst,
+int store_device_id(const gchar *src, const gchar *dst, uint8_t bdaddr_type,
 				const uint16_t source, const uint16_t vendor,
 				const uint16_t product, const uint16_t version);
-int read_device_id(const gchar *src, const gchar *dst,
+int read_device_id(const gchar *src, const gchar *dst, uint8_t bdaddr_type,
 					uint16_t *source, uint16_t *vendor,
 					uint16_t *product, uint16_t *version);
 int write_device_pairable(bdaddr_t *local, gboolean mode);
-- 
1.7.10.2

