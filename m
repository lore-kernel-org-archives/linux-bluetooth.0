Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 10/12] storage: Store address type in "trusts" file
Date: Thu, 14 Jun 2012 20:04:02 -0300
Message-Id: <1339715044-13737-11-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c  |    6 ++++--
 src/storage.c |   41 ++++++++++++++++++++++++++++++-----------
 src/storage.h |    6 ++++--
 3 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/src/device.c b/src/device.c
index d879aa2..6d8e786 100644
--- a/src/device.c
+++ b/src/device.c
@@ -487,7 +487,8 @@ static DBusMessage *set_trust(DBusConnection *conn, DBusMessage *msg,
 	ba2str(&src, srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
-	err = write_trust(srcaddr, dstaddr, GLOBAL_TRUST, value);
+	err = write_trust(srcaddr, dstaddr, device->bdaddr_type, GLOBAL_TRUST,
+									value);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -1078,7 +1079,8 @@ struct btd_device *device_create(DBusConnection *conn,
 	if (read_device_alias(srcaddr, address, bdaddr_type, alias,
 							sizeof(alias)) == 0)
 		device->alias = g_strdup(alias);
-	device->trusted = read_trust(&src, address, GLOBAL_TRUST);
+	device->trusted = read_trust(&src, address, device->bdaddr_type,
+								GLOBAL_TRUST);
 
 	if (read_blocked(&src, &device->bdaddr, device->bdaddr_type))
 		device_block(conn, device, FALSE);
diff --git a/src/storage.c b/src/storage.c
index c9ff96b..58c94e2 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -748,10 +748,10 @@ static char *service_list_to_string(GSList *services)
 	return g_strdup(str);
 }
 
-int write_trust(const char *src, const char *addr, const char *service,
-		gboolean trust)
+int write_trust(const char *src, const char *addr, uint8_t bdaddr_type,
+					const char *service, gboolean trust)
 {
-	char filename[PATH_MAX + 1], *str;
+	char filename[PATH_MAX + 1], key[20], *str;
 	GSList *services = NULL, *match;
 	gboolean trusted;
 	int ret;
@@ -760,8 +760,15 @@ int write_trust(const char *src, const char *addr, const char *service,
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	str = textfile_caseget(filename, addr);
-	if (str)
+	snprintf(key, sizeof(key), "%17s#%hhu", addr, bdaddr_type);
+
+	str = textfile_caseget(filename, key);
+	if (str == NULL) {
+		/* Try old format (address only) */
+		str = textfile_caseget(filename, addr);
+		if (str)
+			services = service_string_to_list(str);
+	} else
 		services = service_string_to_list(str);
 
 	match = g_slist_find_custom(services, service, (GCompareFunc) strcmp);
@@ -780,11 +787,14 @@ int write_trust(const char *src, const char *addr, const char *service,
 		services = g_slist_remove(services, match->data);
 
 	/* Remove the entry if the last trusted service was removed */
-	if (!trust && !services)
-		ret = textfile_casedel(filename, addr);
-	else {
+	if (!trust && !services) {
+		ret = textfile_casedel(filename, key);
+		if (ret < 0)
+			/* Try old format (address only) */
+			ret = textfile_casedel(filename, addr);
+	} else {
 		char *new_str = service_list_to_string(services);
-		ret = textfile_caseput(filename, addr, new_str);
+		ret = textfile_caseput(filename, key, new_str);
 		g_free(new_str);
 	}
 
@@ -795,18 +805,27 @@ int write_trust(const char *src, const char *addr, const char *service,
 	return ret;
 }
 
-gboolean read_trust(const bdaddr_t *local, const char *addr, const char *service)
+gboolean read_trust(const bdaddr_t *local, const char *addr, uint8_t bdaddr_type,
+							const char *service)
 {
-	char filename[PATH_MAX + 1], *str;
+	char filename[PATH_MAX + 1], key[20], *str;
 	GSList *services;
 	gboolean ret;
 
 	create_filename(filename, PATH_MAX, local, "trusts");
 
+	snprintf(key, sizeof(key), "%17s#%hhu", addr, bdaddr_type);
+
+	str = textfile_caseget(filename, key);
+	if (str != NULL)
+		goto done;
+
+	/* Try old format (address only) */
 	str = textfile_caseget(filename, addr);
 	if (!str)
 		return FALSE;
 
+done:
 	services = service_string_to_list(str);
 
 	if (g_slist_find_custom(services, service, (GCompareFunc) strcmp))
diff --git a/src/storage.h b/src/storage.h
index 8ddd495..e540e1b 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -63,8 +63,10 @@ int write_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 int read_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					unsigned char *key, uint8_t *type);
 ssize_t read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin);
-gboolean read_trust(const bdaddr_t *local, const char *addr, const char *service);
-int write_trust(const char *src, const char *addr, const char *service, gboolean trust);
+gboolean read_trust(const bdaddr_t *local, const char *addr, uint8_t bdaddr_type,
+							const char *service);
+int write_trust(const char *src, const char *addr, uint8_t bdaddr_type,
+					const char *service, gboolean trust);
 int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, uint8_t bdaddr_type,
 							const char *profiles);
 int delete_entry(bdaddr_t *src, const char *storage, const char *key);
-- 
1.7.10.2

