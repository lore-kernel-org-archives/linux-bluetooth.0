Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 11/15] storage: Store address type in "attributes" file
Date: Wed, 23 May 2012 15:48:29 -0300
Message-Id: <1337798914-20974-12-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |    6 +++++-
 src/storage.c   |   12 ++++--------
 src/storage.h   |    3 ++-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 8aa2800..7aefd96 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -635,7 +635,9 @@ static GSList *load_characteristics(struct gatt_service *gatt, uint16_t start)
 static void store_attribute(struct gatt_service *gatt, uint16_t handle,
 				uint16_t type, uint8_t *value, gsize len)
 {
+	struct btd_device *device = gatt->dev;
 	bdaddr_t sba, dba;
+	uint8_t bdaddr_type;
 	bt_uuid_t uuid;
 	char *str, *tmp;
 	guint i;
@@ -652,7 +654,9 @@ static void store_attribute(struct gatt_service *gatt, uint16_t handle,
 
 	gatt_get_address(gatt, &sba, &dba, NULL);
 
-	write_device_attribute(&sba, &dba, handle, str);
+	bdaddr_type = device_get_addr_type(device);
+
+	write_device_attribute(&sba, &dba, bdaddr_type, handle, str);
 
 	g_free(str);
 }
diff --git a/src/storage.c b/src/storage.c
index 72dbf68..1f8852f 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1240,14 +1240,10 @@ int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
 	create_filename(filename, PATH_MAX, sba, "characteristic");
 	delete_by_pattern(filename, key);
 
-	key[17] = '\0';
-
 	/* Deleting all attributes values of a given key */
 	create_filename(filename, PATH_MAX, sba, "attributes");
 	delete_by_pattern(filename, key);
 
-	sprintf(&key[17], "#%hhu", bdaddr_type);
-
 	/* Deleting all CCC values of a given key */
 	create_filename(filename, PATH_MAX, sba, "ccc");
 	delete_by_pattern(filename, key);
@@ -1300,17 +1296,17 @@ char *read_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 }
 
 int write_device_attribute(const bdaddr_t *sba, const bdaddr_t *dba,
-					uint16_t handle, const char *chars)
+				uint8_t bdaddr_type, uint16_t handle,
+							const char *chars)
 {
-	char filename[PATH_MAX + 1], addr[18], key[23];
+	char filename[PATH_MAX + 1], addr[18], key[25];
 
 	create_filename(filename, PATH_MAX, sba, "attributes");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 	ba2str(dba, addr);
-
-	snprintf(key, sizeof(key), "%17s#%04X", addr, handle);
+	snprintf(key, sizeof(key), "%17s#%hhu#%04X", addr, bdaddr_type, handle);
 
 	return textfile_put(filename, key, chars);
 }
diff --git a/src/storage.h b/src/storage.h
index 67364df..3705d3d 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -94,7 +94,8 @@ int write_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 char *read_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 					uint8_t bdaddr_type, uint16_t handle);
 int write_device_attribute(const bdaddr_t *sba, const bdaddr_t *dba,
-                                        uint16_t handle, const char *chars);
+				uint8_t bdaddr_type, uint16_t handle,
+							const char *chars);
 int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data);
 int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					uint16_t handle, uint16_t *value);
-- 
1.7.7.6

