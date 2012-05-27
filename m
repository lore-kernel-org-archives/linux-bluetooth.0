Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 4/9] storage: Store address type in "longtermkeys" file
Date: Sat, 26 May 2012 21:40:49 -0300
Message-Id: <1338079254-14054-5-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1338079254-14054-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1338079254-14054-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Addressing types can be either BR/EDR, BLE public or BLE random so the
entries in the "longtermkeys" file did not contain enough information to
distinguish which addressing type it's supposed to be. Entries will now
contain both address number and address type as a single key in every
entry in the file.
---
 src/device.c  |   25 +++++++++++++++++--------
 src/event.c   |    6 +++---
 src/storage.c |   16 ++++++++++------
 src/storage.h |    5 +++--
 4 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/src/device.c b/src/device.c
index a01a524..0961ff6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1088,7 +1088,8 @@ struct btd_device *device_create(DBusConnection *conn,
 		device_set_bonded(device, TRUE);
 	}
 
-	if (device_is_le(device) && has_longtermkeys(&src, &device->bdaddr)) {
+	if (device_is_le(device) && has_longtermkeys(&src, &device->bdaddr,
+							device->bdaddr_type)) {
 		device_set_paired(device, TRUE);
 		device_set_bonded(device, TRUE);
 	}
@@ -1152,23 +1153,31 @@ uint16_t btd_device_get_version(struct btd_device *device)
 static void device_remove_stored(struct btd_device *device)
 {
 	bdaddr_t src;
-	char addr[18];
+	char key[20];
 	DBusConnection *conn = get_dbus_connection();
 
 	adapter_get_address(device->adapter, &src);
-	ba2str(&device->bdaddr, addr);
+	ba2str(&device->bdaddr, key);
+
+	/* key: address only */
+	delete_entry(&src, "profiles", key);
+	delete_entry(&src, "trusts", key);
 
 	if (device_is_bonded(device)) {
-		delete_entry(&src, "linkkeys", addr);
-		delete_entry(&src, "aliases", addr);
-		delete_entry(&src, "longtermkeys", addr);
+		delete_entry(&src, "linkkeys", key);
+		delete_entry(&src, "aliases", key);
+
+		/* key: address#type */
+		sprintf(&key[17], "#%hhu", device->bdaddr_type);
+
+		delete_entry(&src, "longtermkeys", key);
+
 		device_set_bonded(device, FALSE);
 		device->paired = FALSE;
 		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
 							device->bdaddr_type);
 	}
-	delete_entry(&src, "profiles", addr);
-	delete_entry(&src, "trusts", addr);
+
 	delete_all_records(&src, &device->bdaddr);
 	delete_device_service(&src, &device->bdaddr, device->bdaddr_type);
 
diff --git a/src/event.c b/src/event.c
index 8ecb942..ec5926f 100644
--- a/src/event.c
+++ b/src/event.c
@@ -380,8 +380,8 @@ static int store_longtermkey(bdaddr_t *local, bdaddr_t *peer,
 	newkey = g_string_new(val);
 	g_free(val);
 
-	g_string_append_printf(newkey, " %d %d %d %d %d ", bdaddr_type,
-					authenticated, master, enc_size, ediv);
+	g_string_append_printf(newkey, " %d %d %d %d ", authenticated, master,
+								enc_size, ediv);
 
 	str = buf2str(rand, 8);
 	if (str == NULL) {
@@ -392,7 +392,7 @@ static int store_longtermkey(bdaddr_t *local, bdaddr_t *peer,
 	newkey = g_string_append(newkey, str);
 	g_free(str);
 
-	err = write_longtermkeys(local, peer, newkey->str);
+	err = write_longtermkeys(local, peer, bdaddr_type, newkey->str);
 
 	g_string_free(newkey, TRUE);
 
diff --git a/src/storage.c b/src/storage.c
index 3cde9c1..f8e9679 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1362,9 +1362,10 @@ void delete_device_ccc(bdaddr_t *local, bdaddr_t *peer)
 	delete_by_pattern(filename, addr);
 }
 
-int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key)
+int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
+								const char *key)
 {
-	char filename[PATH_MAX + 1], addr[18];
+	char filename[PATH_MAX + 1], addr[20];
 
 	if (!key)
 		return -EINVAL;
@@ -1374,18 +1375,21 @@ int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key)
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 	ba2str(peer, addr);
+	sprintf(&addr[17], "#%hhu", bdaddr_type);
+
 	return textfile_put(filename, addr, key);
 }
 
-gboolean has_longtermkeys(bdaddr_t *local, bdaddr_t *peer)
+gboolean has_longtermkeys(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type)
 {
-	char filename[PATH_MAX + 1], addr[18], *str;
+	char filename[PATH_MAX + 1], key[20], *str;
 
 	create_filename(filename, PATH_MAX, local, "longtermkeys");
 
-	ba2str(peer, addr);
+	ba2str(peer, key);
+	sprintf(&key[17], "#%hhu", bdaddr_type);
 
-	str = textfile_caseget(filename, addr);
+	str = textfile_caseget(filename, key);
 	if (str) {
 		free(str);
 		return TRUE;
diff --git a/src/storage.h b/src/storage.h
index b6d24e9..69ade35 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -96,7 +96,8 @@ int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					uint16_t handle, uint16_t value);
 void delete_device_ccc(bdaddr_t *local, bdaddr_t *peer);
-int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key);
-gboolean has_longtermkeys(bdaddr_t *local, bdaddr_t *peer);
+int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
+							const char *key);
+gboolean has_longtermkeys(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type);
 
 #define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
-- 
1.7.7.6

