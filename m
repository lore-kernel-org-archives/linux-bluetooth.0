Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 07/12] storage: Store address type in "profiles" file
Date: Thu, 14 Jun 2012 20:03:59 -0300
Message-Id: <1339715044-13737-8-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    9 +++++++--
 src/device.c  |    5 +++--
 src/storage.c |   11 +++++++----
 src/storage.h |    3 ++-
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 266142f..b16fd78 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1712,15 +1712,20 @@ static const GDBusSignalTable adapter_signals[] = {
 static void create_stored_device_from_profiles(char *key, char *value,
 						void *user_data)
 {
+	char address[18];
+	uint8_t bdaddr_type;
 	struct btd_adapter *adapter = user_data;
 	GSList *list, *uuids = bt_string2list(value);
 	struct btd_device *device;
 
+	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
+		bdaddr_type = BDADDR_BREDR;
+
 	if (g_slist_find_custom(adapter->devices,
-				key, (GCompareFunc) device_address_cmp))
+				address, (GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key, BDADDR_BREDR);
+	device = device_create(connection, adapter, address, bdaddr_type);
 	if (!device)
 		return;
 
diff --git a/src/device.c b/src/device.c
index c61cfc9..685db89 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1539,12 +1539,13 @@ static void store_profiles(struct btd_device *device)
 	adapter_get_address(adapter, &src);
 
 	if (!device->uuids) {
-		write_device_profiles(&src, &device->bdaddr, "");
+		write_device_profiles(&src, &device->bdaddr,
+				      device->bdaddr_type, "");
 		return;
 	}
 
 	str = bt_list2string(device->uuids);
-	write_device_profiles(&src, &device->bdaddr, str);
+	write_device_profiles(&src, &device->bdaddr, device->bdaddr_type, str);
 	g_free(str);
 }
 
diff --git a/src/storage.c b/src/storage.c
index 7c435b9..c475a40 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -807,9 +807,10 @@ gboolean read_trust(const bdaddr_t *local, const char *addr, const char *service
 	return ret;
 }
 
-int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, const char *profiles)
+int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, uint8_t bdaddr_type,
+							const char *profiles)
 {
-	char filename[PATH_MAX + 1], addr[18];
+	char filename[PATH_MAX + 1], key[20];
 
 	if (!profiles)
 		return -EINVAL;
@@ -818,8 +819,10 @@ int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, const char *profiles)
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	ba2str(dst, addr);
-	return textfile_put(filename, addr, profiles);
+	ba2str(dst, key);
+	sprintf(&key[17], "#%hhu", bdaddr_type);
+
+	return textfile_put(filename, key, profiles);
 }
 
 int delete_entry(bdaddr_t *src, const char *storage, const char *key)
diff --git a/src/storage.h b/src/storage.h
index 64bc200..0ac7c03 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -63,7 +63,8 @@ int read_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t *
 ssize_t read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin);
 gboolean read_trust(const bdaddr_t *local, const char *addr, const char *service);
 int write_trust(const char *src, const char *addr, const char *service, gboolean trust);
-int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, const char *profiles);
+int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, uint8_t bdaddr_type,
+							const char *profiles);
 int delete_entry(bdaddr_t *src, const char *storage, const char *key);
 int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec);
 sdp_record_t *record_from_string(const gchar *str);
-- 
1.7.10.2

