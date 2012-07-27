Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH v3 BlueZ 02/12] storage: Store address type in "aliases" file
Date: Fri, 27 Jul 2012 16:43:13 -0300
Message-Id: <1343418203-15335-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Paulo Alcantara <paulo.alcantara@openbossa.org>

---
 src/device.c  |    7 ++++---
 src/storage.c |   26 +++++++++++++++++++++-----
 src/storage.h |    6 ++++--
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index 28d8a13..d4d4d90 100644
--- a/src/device.c
+++ b/src/device.c
@@ -457,8 +457,8 @@ static DBusMessage *set_alias(DBusConnection *conn, DBusMessage *msg,
 	ba2str(&device->bdaddr, dstaddr);
 
 	/* Remove alias if empty string */
-	err = write_device_alias(srcaddr, dstaddr,
-			g_str_equal(alias, "") ? NULL : alias);
+	err = write_device_alias(srcaddr, dstaddr, device->bdaddr_type,
+					g_str_equal(alias, "") ? NULL : alias);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -1076,7 +1076,8 @@ struct btd_device *device_create(DBusConnection *conn,
 	ba2str(&src, srcaddr);
 
 	read_device_name(srcaddr, address, bdaddr_type, device->name);
-	if (read_device_alias(srcaddr, address, alias, sizeof(alias)) == 0)
+	if (read_device_alias(srcaddr, address, bdaddr_type, alias,
+							sizeof(alias)) == 0)
 		device->alias = g_strdup(alias);
 	device->trusted = read_trust(&src, address, GLOBAL_TRUST);
 
diff --git a/src/storage.c b/src/storage.c
index 7a3010d..df876b4 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -62,17 +62,29 @@ static inline int create_filename(char *buf, size_t size,
 	return create_name(buf, size, STORAGEDIR, addr, name);
 }
 
-int read_device_alias(const char *src, const char *dst, char *alias, size_t size)
+int read_device_alias(const char *src, const char *dst, uint8_t dst_type,
+						char *alias, size_t size)
 {
 	char filename[PATH_MAX + 1], *tmp;
+	char key[20];
 	int err;
 
 	create_name(filename, PATH_MAX, STORAGEDIR, src, "aliases");
 
-	tmp = textfile_get(filename, dst);
-	if (!tmp)
+	snprintf(key, sizeof(key), "%17s#%hhu", dst, dst_type);
+
+	tmp = textfile_get(filename, key);
+	if (tmp != NULL)
+		goto done;
+
+	/* Try old format (address only) */
+	key[17] = '\0';
+
+	tmp = textfile_get(filename, key);
+	if (tmp == NULL)
 		return -ENXIO;
 
+done:
 	err = snprintf(alias, size, "%s", tmp);
 
 	free(tmp);
@@ -80,15 +92,19 @@ int read_device_alias(const char *src, const char *dst, char *alias, size_t size
 	return err < 0 ? -EIO : 0;
 }
 
-int write_device_alias(const char *src, const char *dst, const char *alias)
+int write_device_alias(const char *src, const char *dst, uint8_t dst_type,
+							const char *alias)
 {
 	char filename[PATH_MAX + 1];
+	char key[20];
 
 	create_name(filename, PATH_MAX, STORAGEDIR, src, "aliases");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	return textfile_put(filename, dst, alias);
+	snprintf(key, sizeof(key), "%17s#%hhu", dst, dst_type);
+
+	return textfile_put(filename, key, alias);
 }
 
 int write_discoverable_timeout(bdaddr_t *bdaddr, int timeout)
diff --git a/src/storage.h b/src/storage.h
index c5fabd1..2291390 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -23,8 +23,10 @@
 
 #include "textfile.h"
 
-int read_device_alias(const char *src, const char *dst, char *alias, size_t size);
-int write_device_alias(const char *src, const char *dst, const char *alias);
+int read_device_alias(const char *src, const char *dst, uint8_t dst_type,
+						char *alias, size_t size);
+int write_device_alias(const char *src, const char *dst, uint8_t dst_type,
+							const char *alias);
 int write_discoverable_timeout(bdaddr_t *bdaddr, int timeout);
 int read_discoverable_timeout(const char *src, int *timeout);
 int write_pairable_timeout(bdaddr_t *bdaddr, int timeout);
-- 
1.7.10.4

