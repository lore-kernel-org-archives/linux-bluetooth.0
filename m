Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v2 02/16] storage: Store address type in "appearance" file
Date: Thu, 24 May 2012 15:45:59 -0300
Message-Id: <1337885173-9129-3-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337885173-9129-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337885173-9129-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BLE addressing types can be either public or random so the entries in
the "appearance" file did not contain enough information to distinguish
which addressing type it's supposed to be (LE public or LE random).

Appearance is an information related to BLE device only. Entries will
now contain both BLE address number and BLE address type as a single key
in every entry in the file.
---
 src/adapter.c |    4 ++--
 src/device.c  |    6 ++++--
 src/storage.c |   19 +++++++++++--------
 src/storage.h |    6 ++++--
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c6904a1..1542e06 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2731,7 +2731,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 		dev->legacy = FALSE;
 
 		if (read_remote_appearance(&adapter->bdaddr, &dev->bdaddr,
-								&app) == 0)
+						dev->bdaddr_type, &app) == 0)
 			icon = gap_appearance_to_icon(app);
 		else
 			icon = NULL;
@@ -2870,7 +2870,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 		write_remote_class(&adapter->bdaddr, bdaddr, dev_class);
 
 	if (eir_data.appearance != 0)
-		write_remote_appearance(&adapter->bdaddr, bdaddr,
+		write_remote_appearance(&adapter->bdaddr, bdaddr, bdaddr_type,
 							eir_data.appearance);
 
 	if (eir_data.name != NULL && eir_data.name_complete)
diff --git a/src/device.c b/src/device.c
index 7cdd025..eb015ec 100644
--- a/src/device.c
+++ b/src/device.c
@@ -373,7 +373,8 @@ static DBusMessage *get_properties(DBusConnection *conn,
 		icon = class_to_icon(class);
 
 		dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
-	} else if (read_remote_appearance(&src, &device->bdaddr, &app) == 0)
+	} else if (read_remote_appearance(&src, &device->bdaddr,
+						device->bdaddr_type, &app) == 0)
 		/* Appearance */
 		icon = gap_appearance_to_icon(app);
 
@@ -1851,7 +1852,8 @@ static void appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	app = att_get_u16(atval);
 
 	adapter_get_address(adapter, &src);
-	write_remote_appearance(&src, &device->bdaddr, app);
+	write_remote_appearance(&src, &device->bdaddr, device->bdaddr_type,
+									app);
 
 done:
 	att_data_list_free(list);
diff --git a/src/storage.c b/src/storage.c
index b783be0..ab9b1ed 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -281,16 +281,17 @@ int read_local_class(bdaddr_t *bdaddr, uint8_t *class)
 	return 0;
 }
 
-int read_remote_appearance(bdaddr_t *local, bdaddr_t *peer,
+int read_remote_appearance(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 							uint16_t *appearance)
 {
-	char filename[PATH_MAX + 1], addr[18], *str;
+	char filename[PATH_MAX + 1], key[20], *str;
 
 	create_filename(filename, PATH_MAX, local, "appearance");
 
-	ba2str(peer, addr);
+	ba2str(peer, key);
+	sprintf(&key[17], "#%hhu", bdaddr_type);
 
-	str = textfile_get(filename, addr);
+	str = textfile_get(filename, key);
 	if (!str)
 		return -ENOENT;
 
@@ -305,18 +306,20 @@ int read_remote_appearance(bdaddr_t *local, bdaddr_t *peer,
 }
 
 int write_remote_appearance(bdaddr_t *local, bdaddr_t *peer,
-							uint16_t appearance)
+				uint8_t bdaddr_type, uint16_t appearance)
 {
-	char filename[PATH_MAX + 1], addr[18], str[7];
+	char filename[PATH_MAX + 1], key[20], str[7];
 
 	create_filename(filename, PATH_MAX, local, "appearance");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	ba2str(peer, addr);
+	ba2str(peer, key);
+	sprintf(&key[17], "#%hhu", bdaddr_type);
+
 	sprintf(str, "0x%4.4x", appearance);
 
-	return textfile_put(filename, addr, str);
+	return textfile_put(filename, key, str);
 }
 
 int write_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class)
diff --git a/src/storage.h b/src/storage.h
index c3be64a..db33b43 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -36,8 +36,10 @@ int write_local_name(bdaddr_t *bdaddr, const char *name);
 int read_local_name(bdaddr_t *bdaddr, char *name);
 int write_local_class(bdaddr_t *bdaddr, uint8_t *class);
 int read_local_class(bdaddr_t *bdaddr, uint8_t *class);
-int write_remote_appearance(bdaddr_t *local, bdaddr_t *peer, uint16_t appearance);
-int read_remote_appearance(bdaddr_t *local, bdaddr_t *peer, uint16_t *appearance);
+int write_remote_appearance(bdaddr_t *local, bdaddr_t *peer,
+				uint8_t bdaddr_type, uint16_t appearance);
+int read_remote_appearance(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
+							uint16_t *appearance);
 int write_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 int read_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t *class);
 int write_device_name(bdaddr_t *local, bdaddr_t *peer, char *name);
-- 
1.7.7.6

