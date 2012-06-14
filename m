Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 02/12] storage: Store address type in aliases file
Date: Thu, 14 Jun 2012 20:03:54 -0300
Message-Id: <1339715044-13737-3-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c  |   14 ++++++--------
 src/storage.c |   46 +++++++++++++++++++++++++++++++++++++++-------
 src/storage.h |    6 ++++--
 3 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/src/device.c b/src/device.c
index 09518f3..9a22b21 100644
--- a/src/device.c
+++ b/src/device.c
@@ -456,8 +456,8 @@ static DBusMessage *set_alias(DBusConnection *conn, DBusMessage *msg,
 	ba2str(&device->bdaddr, dstaddr);
 
 	/* Remove alias if empty string */
-	err = write_device_alias(srcaddr, dstaddr,
-			g_str_equal(alias, "") ? NULL : alias);
+	err = write_device_alias(srcaddr, dstaddr, device->bdaddr_type,
+					g_str_equal(alias, "") ? NULL : alias);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -1075,7 +1075,8 @@ struct btd_device *device_create(DBusConnection *conn,
 	ba2str(&src, srcaddr);
 
 	read_device_name(srcaddr, address, bdaddr_type, device->name);
-	if (read_device_alias(srcaddr, address, alias, sizeof(alias)) == 0)
+	if (read_device_alias(srcaddr, address, bdaddr_type, alias,
+							sizeof(alias)) == 0)
 		device->alias = g_strdup(alias);
 	device->trusted = read_trust(&src, address, GLOBAL_TRUST);
 
@@ -1156,19 +1157,16 @@ static void device_remove_stored(struct btd_device *device)
 	DBusConnection *conn = get_dbus_connection();
 
 	adapter_get_address(device->adapter, &src);
+
 	ba2str(&device->bdaddr, key);
+	sprintf(&key[17], "#%hhu", device->bdaddr_type);
 
-	/* key: address only */
 	delete_entry(&src, "profiles", key);
 	delete_entry(&src, "trusts", key);
 
 	if (device_is_bonded(device)) {
 		delete_entry(&src, "linkkeys", key);
 		delete_entry(&src, "aliases", key);
-
-		/* key: address#type */
-		sprintf(&key[17], "#%hhu", device->bdaddr_type);
-
 		delete_entry(&src, "longtermkeys", key);
 
 		device_set_bonded(device, FALSE);
diff --git a/src/storage.c b/src/storage.c
index efdc5b0..36b1d0a 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -62,17 +62,29 @@ static inline int create_filename(char *buf, size_t size,
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
-	if (!tmp)
+	snprintf(key, sizeof(key), "%17s#%hhu", dst, bdaddr_type);
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
@@ -802,11 +818,27 @@ int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, const char *profiles)
 
 int delete_entry(bdaddr_t *src, const char *storage, const char *key)
 {
-	char filename[PATH_MAX + 1];
+	char filename[PATH_MAX + 1], *str;
+	int err;
+
+	str = g_malloc0(strlen(key) + 1);
+
+	/* key: address#type */
+	memcpy(str, key, strlen(key));
 
 	create_filename(filename, PATH_MAX, src, storage);
 
-	return textfile_del(filename, key);
+	err = textfile_del(filename, str);
+	if (err < 0) {
+		/* Try old format (address only) */
+		str[17] = '\0';
+
+		err = textfile_del(filename, str);
+	}
+
+	g_free(str);
+
+	return err;
 }
 
 int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec)
diff --git a/src/storage.h b/src/storage.h
index 015a2a6..43f2f21 100644
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
1.7.10.2

