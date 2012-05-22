Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v3 3/3] core: Fix removing device services from "primary" file
Date: Tue, 22 May 2012 16:45:27 -0300
Message-Id: <1337715927-8821-4-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337715927-8821-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337715927-8821-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The BLE address type needs to be passed as parameter in
delete_device_service() function in order to remove a device from
"primary" file. This is why the entries in "primary" file will be using
the new storage format.
---
 src/device.c  |    2 +-
 src/storage.c |   26 +++++++++++++++-----------
 src/storage.h |    3 ++-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/src/device.c b/src/device.c
index fd13bc3..7cdd025 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1169,7 +1169,7 @@ static void device_remove_stored(struct btd_device *device)
 	delete_entry(&src, "profiles", addr);
 	delete_entry(&src, "trusts", addr);
 	delete_all_records(&src, &device->bdaddr);
-	delete_device_service(&src, &device->bdaddr);
+	delete_device_service(&src, &device->bdaddr, device->bdaddr_type);
 
 	if (device->blocked)
 		device_unblock(conn, device, TRUE, FALSE);
diff --git a/src/storage.c b/src/storage.c
index 33934fb..973d545 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1206,27 +1206,31 @@ done:
 	g_slist_free_full(match.keys, g_free);
 }
 
-int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba)
+int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
+						uint8_t bdaddr_type)
 {
-	char filename[PATH_MAX + 1], address[18];
+	char filename[PATH_MAX + 1], key[20];
 
-	memset(address, 0, sizeof(address));
-	ba2str(dba, address);
+	memset(key, 0, sizeof(key));
+	ba2str(dba, key);
 
-	/* Deleting all characteristics of a given address */
+	/* Deleting all characteristics of a given key */
 	create_filename(filename, PATH_MAX, sba, "characteristic");
-	delete_by_pattern(filename, address);
+	delete_by_pattern(filename, key);
 
-	/* Deleting all attributes values of a given address */
+	/* Deleting all attributes values of a given key */
 	create_filename(filename, PATH_MAX, sba, "attributes");
-	delete_by_pattern(filename, address);
+	delete_by_pattern(filename, key);
 
-	/* Deleting all CCC values of a given address */
+	/* Deleting all CCC values of a given key */
 	create_filename(filename, PATH_MAX, sba, "ccc");
-	delete_by_pattern(filename, address);
+	delete_by_pattern(filename, key);
+
+	sprintf(&key[17], "#%hhu", bdaddr_type);
 
 	create_filename(filename, PATH_MAX, sba, "primary");
-	return textfile_del(filename, address);
+
+	return textfile_del(filename, key);
 }
 
 char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
diff --git a/src/storage.h b/src/storage.h
index 745aff8..d00976f 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -77,7 +77,8 @@ int write_blocked(const bdaddr_t *local, const bdaddr_t *remote,
 							gboolean blocked);
 int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 				uint8_t bdaddr_type, const char *services);
-int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba);
+int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
+						uint8_t bdaddr_type);
 char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 							uint8_t bdaddr_type);
 int write_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
-- 
1.7.7.6

