Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 05/15] storage: Store address type in "aliases" file
Date: Wed, 23 May 2012 15:48:23 -0300
Message-Id: <1337798914-20974-6-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 src/device.c  |    7 ++++---
 src/storage.c |   16 ++++++++++++----
 src/storage.h |    6 ++++--
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/src/device.c b/src/device.c
index e239da6..a91eba7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -458,8 +458,8 @@ static DBusMessage *set_alias(DBusConnection *conn, DBusMessage *msg,
 	ba2str(&device->bdaddr, dstaddr);
 
 	/* Remove alias if empty string */
-	err = write_device_alias(srcaddr, dstaddr,
-			g_str_equal(alias, "") ? NULL : alias);
+	err = write_device_alias(srcaddr, dstaddr, device->bdaddr_type,
+					g_str_equal(alias, "") ? NULL : alias);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -1077,7 +1077,8 @@ struct btd_device *device_create(DBusConnection *conn,
 	ba2str(&src, srcaddr);
 
 	read_device_name(srcaddr, address, bdaddr_type, device->name);
-	if (read_device_alias(srcaddr, address, alias, sizeof(alias)) == 0)
+	if (read_device_alias(srcaddr, address, bdaddr_type, alias,
+							sizeof(alias)) == 0)
 		device->alias = g_strdup(alias);
 	device->trusted = read_trust(&src, address, GLOBAL_TRUST);
 
diff --git a/src/storage.c b/src/storage.c
index cb275a3..a77d015 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -61,14 +61,18 @@ static inline int create_filename(char *buf, size_t size,
 	return create_name(buf, size, STORAGEDIR, addr, name);
 }
 
-int read_device_alias(const char *src, const char *dst, char *alias, size_t size)
+int read_device_alias(const char *src, const char *dst, uint8_t bdaddr_type,
+						char *alias, size_t size)
 {
 	char filename[PATH_MAX + 1], *tmp;
+	char key[20];
 	int err;
 
 	create_name(filename, PATH_MAX, STORAGEDIR, src, "aliases");
 
-	tmp = textfile_get(filename, dst);
+	snprintf(key, sizeof(key), "%17s#%hhu", dst, bdaddr_type);
+
+	tmp = textfile_get(filename, key);
 	if (!tmp)
 		return -ENXIO;
 
@@ -79,15 +83,19 @@ int read_device_alias(const char *src, const char *dst, char *alias, size_t size
 	return err < 0 ? -EIO : 0;
 }
 
-int write_device_alias(const char *src, const char *dst, const char *alias)
+int write_device_alias(const char *src, const char *dst, uint8_t bdaddr_type,
+							const char *alias)
 {
 	char filename[PATH_MAX + 1];
+	char key[20];
 
 	create_name(filename, PATH_MAX, STORAGEDIR, src, "aliases");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	return textfile_put(filename, dst, alias);
+	snprintf(key, sizeof(key), "%17s#%hhu", dst, bdaddr_type);
+
+	return textfile_put(filename, key, alias);
 }
 
 int write_discoverable_timeout(bdaddr_t *bdaddr, int timeout)
diff --git a/src/storage.h b/src/storage.h
index 7443d6f..eda7f9b 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -23,8 +23,10 @@
 
 #include "textfile.h"
 
-int read_device_alias(const char *src, const char *dst, char *alias, size_t size);
-int write_device_alias(const char *src, const char *dst, const char *alias);
+int read_device_alias(const char *src, const char *dst, uint8_t bdaddr_type,
+						char *alias, size_t size);
+int write_device_alias(const char *src, const char *dst, uint8_t bdaddr_type,
+							const char *alias);
 int write_discoverable_timeout(bdaddr_t *bdaddr, int timeout);
 int read_discoverable_timeout(const char *src, int *timeout);
 int write_pairable_timeout(bdaddr_t *bdaddr, int timeout);
-- 
1.7.7.6

