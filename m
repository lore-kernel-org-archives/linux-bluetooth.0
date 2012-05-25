Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v3 07/18] storage: Store address type in blocked file
Date: Fri, 25 May 2012 12:46:59 -0300
Message-Id: <1337960830-3506-8-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337960830-3506-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337960830-3506-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 src/device.c  |    6 +++---
 src/storage.c |   21 ++++++++++++---------
 src/storage.h |    5 +++--
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/src/device.c b/src/device.c
index a91eba7..e44ce58 100644
--- a/src/device.c
+++ b/src/device.c
@@ -547,7 +547,7 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 
 	adapter_get_address(device->adapter, &src);
 
-	err = write_blocked(&src, &device->bdaddr, TRUE);
+	err = write_blocked(&src, &device->bdaddr, device->bdaddr_type, TRUE);
 	if (err < 0)
 		error("write_blocked(): %s (%d)", strerror(-err), -err);
 
@@ -579,7 +579,7 @@ int device_unblock(DBusConnection *conn, struct btd_device *device,
 
 	adapter_get_address(device->adapter, &src);
 
-	err = write_blocked(&src, &device->bdaddr, FALSE);
+	err = write_blocked(&src, &device->bdaddr, device->bdaddr_type, FALSE);
 	if (err < 0)
 		error("write_blocked(): %s (%d)", strerror(-err), -err);
 
@@ -1082,7 +1082,7 @@ struct btd_device *device_create(DBusConnection *conn,
 		device->alias = g_strdup(alias);
 	device->trusted = read_trust(&src, address, GLOBAL_TRUST);
 
-	if (read_blocked(&src, &device->bdaddr))
+	if (read_blocked(&src, &device->bdaddr, device->bdaddr_type))
 		device_block(conn, device, FALSE);
 
 	if (read_link_key(&src, &device->bdaddr, NULL, NULL) == 0) {
diff --git a/src/storage.c b/src/storage.c
index f2eaae1..1eb916f 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1144,15 +1144,17 @@ int read_device_pairable(bdaddr_t *bdaddr, gboolean *mode)
 	return 0;
 }
 
-gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote)
+gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote,
+							uint8_t bdaddr_type)
 {
-	char filename[PATH_MAX + 1], *str, addr[18];
+	char filename[PATH_MAX + 1], *str, key[20];
 
 	create_filename(filename, PATH_MAX, local, "blocked");
 
-	ba2str(remote, addr);
+	ba2str(remote, key);
+	sprintf(&key[17], "#%hhu", bdaddr_type);
 
-	str = textfile_caseget(filename, addr);
+	str = textfile_caseget(filename, key);
 	if (!str)
 		return FALSE;
 
@@ -1162,20 +1164,21 @@ gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote)
 }
 
 int write_blocked(const bdaddr_t *local, const bdaddr_t *remote,
-							gboolean blocked)
+					uint8_t bdaddr_type, gboolean blocked)
 {
-	char filename[PATH_MAX + 1], addr[18];
+	char filename[PATH_MAX + 1], key[20];
 
 	create_filename(filename, PATH_MAX, local, "blocked");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	ba2str(remote, addr);
+	ba2str(remote, key);
+	sprintf(&key[17], "#%hhu", bdaddr_type);
 
 	if (blocked == FALSE)
-		return textfile_casedel(filename, addr);
+		return textfile_casedel(filename, key);
 
-	return textfile_caseput(filename, addr, "");
+	return textfile_caseput(filename, key, "");
 }
 
 int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
diff --git a/src/storage.h b/src/storage.h
index eda7f9b..9032801 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -78,9 +78,10 @@ int read_device_id(const gchar *src, const gchar *dst,
 					uint16_t *product, uint16_t *version);
 int write_device_pairable(bdaddr_t *local, gboolean mode);
 int read_device_pairable(bdaddr_t *local, gboolean *mode);
-gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote);
+gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote,
+							uint8_t bdaddr_type);
 int write_blocked(const bdaddr_t *local, const bdaddr_t *remote,
-							gboolean blocked);
+					uint8_t bdaddr_type, gboolean blocked);
 int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 				uint8_t bdaddr_type, const char *services);
 int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
-- 
1.7.7.6

