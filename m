Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 BlueZ 01/12] storage: Make it clear that delete_entry only works for addresses
Date: Fri, 27 Jul 2012 16:43:12 -0300
Message-Id: <1343418203-15335-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also, delete_entry should try to erase both addresses styles, with and
without address type, if not we may find some leftovers from deleted
devices.
---
 src/device.c  |   24 +++++++++---------------
 src/storage.c |   22 +++++++++++++++++++---
 src/storage.h |    3 ++-
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/src/device.c b/src/device.c
index cd571f7..28d8a13 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1152,30 +1152,24 @@ uint16_t btd_device_get_version(struct btd_device *device)
 
 static void device_remove_stored(struct btd_device *device)
 {
-	bdaddr_t src;
-	char key[20];
+	bdaddr_t src, dst;
+	uint8_t dst_type;
 	DBusConnection *conn = get_dbus_connection();
 
 	adapter_get_address(device->adapter, &src);
-	ba2str(&device->bdaddr, key);
+	device_get_address(device, &dst, &dst_type);
 
-	/* key: address only */
-	delete_entry(&src, "profiles", key);
-	delete_entry(&src, "trusts", key);
+	delete_entry(&src, "profiles", &dst, dst_type);
+	delete_entry(&src, "trusts", &dst, dst_type);
 
 	if (device_is_bonded(device)) {
-		delete_entry(&src, "linkkeys", key);
-		delete_entry(&src, "aliases", key);
-
-		/* key: address#type */
-		sprintf(&key[17], "#%hhu", device->bdaddr_type);
-
-		delete_entry(&src, "longtermkeys", key);
+		delete_entry(&src, "linkkeys", &dst, dst_type);
+		delete_entry(&src, "aliases", &dst, dst_type);
+		delete_entry(&src, "longtermkeys", &dst, dst_type);
 
 		device_set_bonded(device, FALSE);
 		device->paired = FALSE;
-		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
-							device->bdaddr_type);
+		btd_adapter_remove_bonding(device->adapter, &dst, dst_type);
 	}
 
 	delete_all_records(&src, &device->bdaddr);
diff --git a/src/storage.c b/src/storage.c
index 9289e07..7a3010d 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -800,13 +800,29 @@ int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, const char *profiles)
 	return textfile_put(filename, addr, profiles);
 }
 
-int delete_entry(bdaddr_t *src, const char *storage, const char *key)
+int delete_entry(bdaddr_t *src, const char *storage, bdaddr_t *dst,
+							uint8_t dst_type)
 {
-	char filename[PATH_MAX + 1];
+	char filename[PATH_MAX + 1], key[20];
+	int err, ret;
+
+	ba2str(dst, key);
+	sprintf(&key[17], "#%hhu", dst_type);
 
 	create_filename(filename, PATH_MAX, src, storage);
 
-	return textfile_del(filename, key);
+	err = 0;
+	ret = textfile_del(filename, key);
+	if (ret)
+		err = ret;
+
+	/* Trying without address type */
+	key[17] = '\0';
+	ret = textfile_del(filename, key);
+	if (ret)
+		err = ret;
+
+	return err;
 }
 
 int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec)
diff --git a/src/storage.h b/src/storage.h
index 07de39f..c5fabd1 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -60,7 +60,8 @@ ssize_t read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin);
 gboolean read_trust(const bdaddr_t *local, const char *addr, const char *service);
 int write_trust(const char *src, const char *addr, const char *service, gboolean trust);
 int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, const char *profiles);
-int delete_entry(bdaddr_t *src, const char *storage, const char *key);
+int delete_entry(bdaddr_t *src, const char *storage, bdaddr_t *dst,
+							uint8_t dst_type);
 int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec);
 sdp_record_t *record_from_string(const gchar *str);
 sdp_record_t *fetch_record(const gchar *src, const gchar *dst, const uint32_t handle);
-- 
1.7.10.4

