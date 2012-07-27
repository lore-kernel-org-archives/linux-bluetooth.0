Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ] storage: Remove support for trusted services
Date: Fri, 27 Jul 2012 17:19:09 -0300
Message-Id: <1343420349-18877-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since a long time, it is impossible to set individual services as
trusted using our API, so there's no need to have support for storing
this kind of information.
---
Hi,

Do you think it is useful to still maintain support for reading that kind of
information? That "feature" was removed in the 3 -> 4 transition as deprecated.

Cheers,

 src/device.c  |    9 +----
 src/storage.c |  119 +++++++--------------------------------------------------
 src/storage.h |    6 +--
 3 files changed, 19 insertions(+), 115 deletions(-)

diff --git a/src/device.c b/src/device.c
index 1718726..73df561 100644
--- a/src/device.c
+++ b/src/device.c
@@ -69,9 +69,6 @@

 #define AUTO_CONNECTION_INTERVAL	5 /* Next connection attempt */

-/* When all services should trust a remote device */
-#define GLOBAL_TRUST "[all]"
-
 #define APPEARANCE_CHR_UUID 0x2a01

 struct btd_disconnect_data {
@@ -488,8 +485,7 @@ static DBusMessage *set_trust(DBusConnection *conn, DBusMessage *msg,
 	ba2str(&src, srcaddr);
 	ba2str(&device->bdaddr, dstaddr);

-	err = write_trust(srcaddr, dstaddr, device->bdaddr_type, GLOBAL_TRUST,
-									value);
+	err = write_trust(srcaddr, dstaddr, device->bdaddr_type, value);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));

@@ -1080,8 +1076,7 @@ struct btd_device *device_create(DBusConnection *conn,
 	if (read_device_alias(srcaddr, address, bdaddr_type, alias,
 							sizeof(alias)) == 0)
 		device->alias = g_strdup(alias);
-	device->trusted = read_trust(&src, address, device->bdaddr_type,
-								GLOBAL_TRUST);
+	device->trusted = read_trust(&src, address, device->bdaddr_type);

 	if (read_blocked(&src, &device->bdaddr, device->bdaddr_type))
 		device_block(conn, device, FALSE);
diff --git a/src/storage.c b/src/storage.c
index c50e920..3db1754 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -47,6 +47,9 @@
 #include "glib-helper.h"
 #include "storage.h"

+/* When all services should trust a remote device */
+#define GLOBAL_TRUST "[all]"
+
 struct match {
 	GSList *keys;
 	char *pattern;
@@ -714,59 +717,10 @@ ssize_t read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin)
 	return len;
 }

-static GSList *service_string_to_list(char *services)
-{
-	GSList *l = NULL;
-	char *start = services;
-	int i, finished = 0;
-
-	for (i = 0; !finished; i++) {
-		if (services[i] == '\0')
-			finished = 1;
-
-		if (services[i] == ' ' || services[i] == '\0') {
-			services[i] = '\0';
-			l = g_slist_append(l, start);
-			start = services + i + 1;
-		}
-	}
-
-	return l;
-}
-
-static char *service_list_to_string(GSList *services)
-{
-	char str[1024];
-	int len = 0;
-
-	if (!services)
-		return g_strdup("");
-
-	memset(str, 0, sizeof(str));
-
-	while (services) {
-		int ret;
-		char *ident = services->data;
-
-		ret = snprintf(str + len, sizeof(str) - len - 1, "%s%s",
-				ident, services->next ? " " : "");
-
-		if (ret > 0)
-			len += ret;
-
-		services = services->next;
-	}
-
-	return g_strdup(str);
-}
-
 int write_trust(const char *src, const char *addr, uint8_t addr_type,
-					const char *service, gboolean trust)
+							gboolean trust)
 {
-	char filename[PATH_MAX + 1], key[20], *str;
-	GSList *services = NULL, *match;
-	gboolean trusted;
-	int ret;
+	char filename[PATH_MAX + 1], key[20];

 	create_name(filename, PATH_MAX, STORAGEDIR, src, "trusts");

@@ -774,54 +728,15 @@ int write_trust(const char *src, const char *addr, uint8_t addr_type,

 	snprintf(key, sizeof(key), "%17s#%hhu", addr, addr_type);

-	str = textfile_caseget(filename, key);
-	if (str == NULL) {
-		/* Try old format (address only) */
-		str = textfile_caseget(filename, addr);
-		if (str)
-			services = service_string_to_list(str);
-	} else
-		services = service_string_to_list(str);
-
-	match = g_slist_find_custom(services, service, (GCompareFunc) strcmp);
-	trusted = match ? TRUE : FALSE;
-
-	/* If the old setting is the same as the requested one, we're done */
-	if (trusted == trust) {
-		g_slist_free(services);
-		free(str);
-		return 0;
-	}
-
-	if (trust)
-		services = g_slist_append(services, (void *) service);
-	else
-		services = g_slist_remove(services, match->data);
-
-	/* Remove the entry if the last trusted service was removed */
-	if (!trust && !services) {
-		ret = textfile_casedel(filename, key);
-		if (ret < 0)
-			/* Try old format (address only) */
-			ret = textfile_casedel(filename, addr);
-	} else {
-		char *new_str = service_list_to_string(services);
-		ret = textfile_caseput(filename, key, new_str);
-		g_free(new_str);
-	}
-
-	g_slist_free(services);
-
-	free(str);
+	if (trust == FALSE)
+		return textfile_casedel(filename, key);

-	return ret;
+	return textfile_caseput(filename, key, GLOBAL_TRUST);
 }

-gboolean read_trust(const bdaddr_t *local, const char *addr, uint8_t addr_type,
-							const char *service)
+gboolean read_trust(const bdaddr_t *local, const char *addr, uint8_t addr_type)
 {
 	char filename[PATH_MAX + 1], key[20], *str;
-	GSList *services;
 	gboolean ret;

 	create_filename(filename, PATH_MAX, local, "trusts");
@@ -829,25 +744,19 @@ gboolean read_trust(const bdaddr_t *local, const char *addr, uint8_t addr_type,
 	snprintf(key, sizeof(key), "%17s#%hhu", addr, addr_type);

 	str = textfile_caseget(filename, key);
-	if (str != NULL)
-		goto done;
+	if (str == NULL)
+		/* Try old format (address only) */
+		str = textfile_caseget(filename, addr);

-	/* Try old format (address only) */
-	str = textfile_caseget(filename, addr);
-	if (!str)
+	if (str == NULL)
 		return FALSE;

-done:
-	services = service_string_to_list(str);
-
-	if (g_slist_find_custom(services, service, (GCompareFunc) strcmp))
+	if (strcmp(str, GLOBAL_TRUST) == 0)
 		ret = TRUE;
 	else
 		ret = FALSE;

-	g_slist_free(services);
 	free(str);
-
 	return ret;
 }

diff --git a/src/storage.h b/src/storage.h
index c4f13dd..6e2766d 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -64,10 +64,10 @@ int write_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
 int read_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
 					unsigned char *key, uint8_t *type);
 ssize_t read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin);
-gboolean read_trust(const bdaddr_t *local, const char *addr, uint8_t addr_type,
-							const char *service);
+gboolean read_trust(const bdaddr_t *local, const char *addr,
+						uint8_t addr_type);
 int write_trust(const char *src, const char *addr, uint8_t addr_type,
-					const char *service, gboolean trust);
+							gboolean trust);
 int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 							const char *profiles);
 int delete_entry(bdaddr_t *src, const char *storage, bdaddr_t *dst,
--
1.7.10.4
