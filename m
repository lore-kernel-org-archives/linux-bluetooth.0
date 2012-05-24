Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v2 09/16] storage: Store address type in "longtermkeys" file
Date: Thu, 24 May 2012 15:46:06 -0300
Message-Id: <1337885173-9129-10-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337885173-9129-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337885173-9129-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c  |    3 ++-
 src/event.c   |    2 +-
 src/storage.c |   16 ++++++++++------
 src/storage.h |    5 +++--
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index e44ce58..2357684 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1090,7 +1090,8 @@ struct btd_device *device_create(DBusConnection *conn,
 		device_set_bonded(device, TRUE);
 	}
 
-	if (device_is_le(device) && has_longtermkeys(&src, &device->bdaddr)) {
+	if (device_is_le(device) && has_longtermkeys(&src, &device->bdaddr,
+							device->bdaddr_type)) {
 		device_set_paired(device, TRUE);
 		device_set_bonded(device, TRUE);
 	}
diff --git a/src/event.c b/src/event.c
index a1fc016..acfcef3 100644
--- a/src/event.c
+++ b/src/event.c
@@ -397,7 +397,7 @@ static int store_longtermkey(bdaddr_t *local, bdaddr_t *peer,
 	newkey = g_string_append(newkey, str);
 	g_free(str);
 
-	err = write_longtermkeys(local, peer, newkey->str);
+	err = write_longtermkeys(local, peer, bdaddr_type, newkey->str);
 
 	g_string_free(newkey, TRUE);
 
diff --git a/src/storage.c b/src/storage.c
index 1eb916f..caee8f0 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1379,9 +1379,10 @@ void delete_device_ccc(bdaddr_t *local, bdaddr_t *peer)
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
@@ -1391,18 +1392,21 @@ int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key)
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
index 9032801..67364df 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -101,7 +101,8 @@ int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
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

