Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 BlueZ 04/12] storage: Store address type in "blocked" file
Date: Fri, 27 Jul 2012 16:43:15 -0300
Message-Id: <1343418203-15335-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 src/device.c  |    6 +++---
 src/storage.c |   31 +++++++++++++++++++++----------
 src/storage.h |    5 +++--
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/src/device.c b/src/device.c
index d4d4d90..1b35d4b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -546,7 +546,7 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 
 	adapter_get_address(device->adapter, &src);
 
-	err = write_blocked(&src, &device->bdaddr, TRUE);
+	err = write_blocked(&src, &device->bdaddr, device->bdaddr_type, TRUE);
 	if (err < 0)
 		error("write_blocked(): %s (%d)", strerror(-err), -err);
 
@@ -578,7 +578,7 @@ int device_unblock(DBusConnection *conn, struct btd_device *device,
 
 	adapter_get_address(device->adapter, &src);
 
-	err = write_blocked(&src, &device->bdaddr, FALSE);
+	err = write_blocked(&src, &device->bdaddr, device->bdaddr_type, FALSE);
 	if (err < 0)
 		error("write_blocked(): %s (%d)", strerror(-err), -err);
 
@@ -1081,7 +1081,7 @@ struct btd_device *device_create(DBusConnection *conn,
 		device->alias = g_strdup(alias);
 	device->trusted = read_trust(&src, address, GLOBAL_TRUST);
 
-	if (read_blocked(&src, &device->bdaddr))
+	if (read_blocked(&src, &device->bdaddr, device->bdaddr_type))
 		device_block(conn, device, FALSE);
 
 	if (read_link_key(&src, &device->bdaddr, NULL, NULL) == 0) {
diff --git a/src/storage.c b/src/storage.c
index df876b4..252b383 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1177,38 +1177,49 @@ int read_device_pairable(bdaddr_t *bdaddr, gboolean *mode)
 	return 0;
 }
 
-gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote)
+gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote,
+							uint8_t remote_type)
 {
-	char filename[PATH_MAX + 1], *str, addr[18];
+	char filename[PATH_MAX + 1], *str, key[20];
 
 	create_filename(filename, PATH_MAX, local, "blocked");
 
-	ba2str(remote, addr);
+	ba2str(remote, key);
+	sprintf(&key[17], "#%hhu", remote_type);
 
-	str = textfile_caseget(filename, addr);
-	if (!str)
+	str = textfile_caseget(filename, key);
+	if (str != NULL)
+		goto done;
+
+	/* Try old format (address only) */
+	key[17] = '\0';
+
+	str = textfile_caseget(filename, key);
+	if (str == NULL)
 		return FALSE;
 
+done:
 	free(str);
 
 	return TRUE;
 }
 
 int write_blocked(const bdaddr_t *local, const bdaddr_t *remote,
-							gboolean blocked)
+				uint8_t remote_type, gboolean blocked)
 {
-	char filename[PATH_MAX + 1], addr[18];
+	char filename[PATH_MAX + 1], key[20];
 
 	create_filename(filename, PATH_MAX, local, "blocked");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	ba2str(remote, addr);
+	ba2str(remote, key);
+	sprintf(&key[17], "#%hhu", remote_type);
 
 	if (blocked == FALSE)
-		return textfile_casedel(filename, addr);
+		return textfile_casedel(filename, key);
 
-	return textfile_caseput(filename, addr, "");
+	return textfile_caseput(filename, key, "");
 }
 
 int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
diff --git a/src/storage.h b/src/storage.h
index 2291390..3231fec 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -79,9 +79,10 @@ int read_device_id(const gchar *src, const gchar *dst,
 					uint16_t *product, uint16_t *version);
 int write_device_pairable(bdaddr_t *local, gboolean mode);
 int read_device_pairable(bdaddr_t *local, gboolean *mode);
-gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote);
+gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote,
+							uint8_t remote_type);
 int write_blocked(const bdaddr_t *local, const bdaddr_t *remote,
-							gboolean blocked);
+				uint8_t remote_type, gboolean blocked);
 int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 				uint8_t bdaddr_type, const char *services);
 int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
-- 
1.7.10.4

