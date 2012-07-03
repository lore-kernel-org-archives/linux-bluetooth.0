Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v2 01/12] storage: Store address type in "names" file
Date: Tue,  3 Jul 2012 17:32:04 -0300
Message-Id: <1341347535-15343-2-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1341347535-15343-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
 <1341347535-15343-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"names" file is shared between BR/EDR and BLE. Addressing types can be
either BR/EDR, BLE public or BLE random so the entries in the "names"
file did not contain enough information to distinguish which addressing
type it's supposed to be. Entries will now contain both address number,
and address type as a single key in every entry in the file.
---
 input/device.c |    6 ++++--
 src/adapter.c  |    3 ++-
 src/device.c   |    3 ++-
 src/event.c    |    7 +++++--
 src/storage.c  |   30 ++++++++++++++++++++++--------
 src/storage.h  |    6 ++++--
 6 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/input/device.c b/input/device.c
index 09a9a39..cf4bfc4 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1096,10 +1096,11 @@ static struct input_device *input_device_new(DBusConnection *conn,
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct input_device *idev;
 	char name[249], src_addr[18], dst_addr[18];
+	uint8_t dst_type;
 
 	idev = g_new0(struct input_device, 1);
 	adapter_get_address(adapter, &idev->src);
-	device_get_address(device, &idev->dst, NULL);
+	device_get_address(device, &idev->dst, &dst_type);
 	idev->device = btd_device_ref(device);
 	idev->path = g_strdup(path);
 	idev->conn = dbus_connection_ref(conn);
@@ -1108,7 +1109,8 @@ static struct input_device *input_device_new(DBusConnection *conn,
 
 	ba2str(&idev->src, src_addr);
 	ba2str(&idev->dst, dst_addr);
-	if (read_device_name(src_addr, dst_addr, name) == 0)
+
+	if (read_device_name(src_addr, dst_addr, dst_type, name) == 0)
 		idev->name = g_strdup(name);
 
 	if (g_dbus_register_interface(conn, idev->path, INPUT_DEVICE_INTERFACE,
diff --git a/src/adapter.c b/src/adapter.c
index f922876..800515d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2880,7 +2880,8 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 							eir_data.appearance);
 
 	if (eir_data.name != NULL && eir_data.name_complete)
-		write_device_name(&adapter->bdaddr, bdaddr, eir_data.name);
+		write_device_name(&adapter->bdaddr, bdaddr, bdaddr_type,
+								eir_data.name);
 
 	dev = adapter_search_found_devices(adapter, bdaddr);
 	if (dev) {
diff --git a/src/device.c b/src/device.c
index c210bcb..09518f3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1073,7 +1073,8 @@ struct btd_device *device_create(DBusConnection *conn,
 	device->bdaddr_type = bdaddr_type;
 	adapter_get_address(adapter, &src);
 	ba2str(&src, srcaddr);
-	read_device_name(srcaddr, address, device->name);
+
+	read_device_name(srcaddr, address, bdaddr_type, device->name);
 	if (read_device_alias(srcaddr, address, alias, sizeof(alias)) == 0)
 		device->alias = g_strdup(alias);
 	device->trusted = read_trust(&src, address, GLOBAL_TRUST);
diff --git a/src/event.c b/src/event.c
index ec5926f..17fc250 100644
--- a/src/event.c
+++ b/src/event.c
@@ -319,6 +319,7 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
+	uint8_t peer_type;
 	struct remote_dev_info *dev_info;
 
 	if (!g_utf8_validate(name, -1, NULL)) {
@@ -333,11 +334,13 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
 		g_strstrip(name);
 	}
 
-	write_device_name(local, peer, name);
-
 	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
 		return;
 
+	peer_type = device_get_addr_type(device);
+
+	write_device_name(local, peer, peer_type, name);
+
 	dev_info = adapter_search_found_devices(adapter, peer);
 	if (dev_info) {
 		g_free(dev_info->name);
diff --git a/src/storage.c b/src/storage.c
index 17e8001..9289e07 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -359,9 +359,10 @@ int read_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t *class)
 	return 0;
 }
 
-int write_device_name(bdaddr_t *local, bdaddr_t *peer, char *name)
+int write_device_name(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+								char *name)
 {
-	char filename[PATH_MAX + 1], addr[18], str[HCI_MAX_NAME_LENGTH + 1];
+	char filename[PATH_MAX + 1], key[20], str[HCI_MAX_NAME_LENGTH + 1];
 	int i;
 
 	memset(str, 0, sizeof(str));
@@ -375,21 +376,34 @@ int write_device_name(bdaddr_t *local, bdaddr_t *peer, char *name)
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	ba2str(peer, addr);
-	return textfile_put(filename, addr, str);
+	ba2str(peer, key);
+	sprintf(&key[17], "#%hhu", peer_type);
+
+	return textfile_put(filename, key, str);
 }
 
-int read_device_name(const char *src, const char *dst, char *name)
+int read_device_name(const char *src, const char *dst, uint8_t dst_type,
+								char *name)
 {
-	char filename[PATH_MAX + 1], *str;
+	char filename[PATH_MAX + 1], *str, key[20];
 	int len;
 
 	create_name(filename, PATH_MAX, STORAGEDIR, src, "names");
 
-	str = textfile_get(filename, dst);
-	if (!str)
+	snprintf(key, sizeof(key), "%17s#%hhu", dst, dst_type);
+
+	str = textfile_get(filename, key);
+	if (str != NULL)
+		goto done;
+
+	/* Try old format (address only) */
+	key[17] = '\0';
+
+	str = textfile_get(filename, key);
+	if (str == NULL)
 		return -ENOENT;
 
+done:
 	len = strlen(str);
 	if (len > HCI_MAX_NAME_LENGTH)
 		str[HCI_MAX_NAME_LENGTH] = '\0';
diff --git a/src/storage.h b/src/storage.h
index cc00e97..07de39f 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -42,8 +42,10 @@ int read_remote_appearance(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 							uint16_t *appearance);
 int write_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 int read_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t *class);
-int write_device_name(bdaddr_t *local, bdaddr_t *peer, char *name);
-int read_device_name(const char *src, const char *dst, char *name);
+int write_device_name(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
+								char *name);
+int read_device_name(const char *src, const char *dst, uint8_t dst_type,
+								char *name);
 int write_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t *data,
 							uint8_t data_len);
 int read_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t *data);
-- 
1.7.9.5

