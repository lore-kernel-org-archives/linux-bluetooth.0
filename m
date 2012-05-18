Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 1/2] storage: Store BLE address type in "primary" file
Date: Fri, 18 May 2012 17:57:46 -0300
Message-Id: <1337374667-17802-2-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BLE addressing types can be either public or random so the entries in
the "primary" file did not contain enough information to distinguish
which addressing type it's supposed to be (LE public or LE random).
Entries will now contain both BLE address number and BLE address type
as a single key in every entry in the file.
---
 src/device.c  |    2 +-
 src/storage.c |   40 ++++++++++++++++++++++++++++++++--------
 src/storage.h |    5 +++--
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/src/device.c b/src/device.c
index 2695b16..fd13bc3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1759,7 +1759,7 @@ static void store_services(struct btd_device *device)
 	adapter_get_address(adapter, &sba);
 	device_get_address(device, &dba, NULL);
 
-	write_device_services(&sba, &dba, str);
+	write_device_services(&sba, &dba, device->bdaddr_type, str);
 
 	g_free(str);
 }
diff --git a/src/storage.c b/src/storage.c
index 14e5ac3..815060e 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -61,6 +61,19 @@ static inline int create_filename(char *buf, size_t size,
 	return create_name(buf, size, STORAGEDIR, addr, name);
 }
 
+static inline char ba_type2char(uint8_t bdaddr_type)
+{
+	switch (bdaddr_type) {
+	case BDADDR_LE_PUBLIC:
+		return '1';
+	case BDADDR_LE_RANDOM:
+		return '2';
+	case BDADDR_BREDR:
+	default:
+		return '0';
+	}
+}
+
 int read_device_alias(const char *src, const char *dst, char *alias, size_t size)
 {
 	char filename[PATH_MAX + 1], *tmp;
@@ -1162,17 +1175,22 @@ int write_blocked(const bdaddr_t *local, const bdaddr_t *remote,
 }
 
 int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
-							const char *services)
+			  uint8_t bdaddr_type, const char *services)
 {
-	char filename[PATH_MAX + 1], addr[18];
+	char filename[PATH_MAX + 1], key[20];
 
 	create_filename(filename, PATH_MAX, sba, "primary");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	ba2str(dba, addr);
+	memset(key, 0, sizeof(key));
 
-	return textfile_put(filename, addr, services);
+	/* New format: address#type */
+	ba2str(dba, key);
+	key[17] = '#';
+	key[18] = ba_type2char(bdaddr_type);
+
+	return textfile_put(filename, key, services);
 }
 
 static void filter_keys(char *key, char *value, void *data)
@@ -1228,15 +1246,21 @@ int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba)
 	return textfile_del(filename, address);
 }
 
-char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba)
+char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
+							uint8_t bdaddr_type)
 {
-	char filename[PATH_MAX + 1], addr[18];
+	char filename[PATH_MAX + 1], key[20];
 
 	create_filename(filename, PATH_MAX, sba, "primary");
 
-	ba2str(dba, addr);
+	memset(key, 0, sizeof(key));
 
-	return textfile_caseget(filename, addr);
+	/* New format: address#type */
+	ba2str(dba, key);
+	key[17] = '#';
+	key[18] = ba_type2char(bdaddr_type);
+
+	return textfile_caseget(filename, key);
 }
 
 int write_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
diff --git a/src/storage.h b/src/storage.h
index 6255ae8..745aff8 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -76,9 +76,10 @@ gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote);
 int write_blocked(const bdaddr_t *local, const bdaddr_t *remote,
 							gboolean blocked);
 int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
-							const char *services);
+				uint8_t bdaddr_type, const char *services);
 int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba);
-char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba);
+char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
+							uint8_t bdaddr_type);
 int write_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 					uint16_t handle, const char *chars);
 char *read_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
-- 
1.7.7.6

