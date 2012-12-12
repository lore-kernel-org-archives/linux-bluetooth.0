Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] storage: Remove not used functions
Date: Wed, 12 Dec 2012 09:41:28 +0100
Message-Id: <1355301688-30095-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those functions are no more used with new storage architecture.
---
 src/storage.c |  590 ---------------------------------------------------------
 src/storage.h |   43 -----
 2 files changed, 633 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index ac66021..5798ccd 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -65,64 +65,6 @@ static inline int create_filename(char *buf, size_t size,
 	return create_name(buf, size, STORAGEDIR, addr, name);
 }
 
-int read_device_alias(const char *src, const char *dst, uint8_t dst_type,
-						char *alias, size_t size)
-{
-	char filename[PATH_MAX + 1], *tmp;
-	char key[20];
-	int err;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "aliases");
-
-	snprintf(key, sizeof(key), "%17s#%hhu", dst, dst_type);
-
-	tmp = textfile_get(filename, key);
-	if (tmp != NULL)
-		goto done;
-
-	/* Try old format (address only) */
-	key[17] = '\0';
-
-	tmp = textfile_get(filename, key);
-	if (tmp == NULL)
-		return -ENXIO;
-
-done:
-	err = snprintf(alias, size, "%s", tmp);
-
-	free(tmp);
-
-	return err < 0 ? -EIO : 0;
-}
-
-int write_device_alias(const char *src, const char *dst, uint8_t dst_type,
-							const char *alias)
-{
-	char filename[PATH_MAX + 1];
-	char key[20];
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "aliases");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	snprintf(key, sizeof(key), "%17s#%hhu", dst, dst_type);
-
-	return textfile_put(filename, key, alias);
-}
-
-int write_discoverable_timeout(const bdaddr_t *bdaddr, int timeout)
-{
-	char filename[PATH_MAX + 1], str[32];
-
-	snprintf(str, sizeof(str), "%d", timeout);
-
-	create_filename(filename, PATH_MAX, bdaddr, "config");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	return textfile_put(filename, "discovto", str);
-}
-
 int read_discoverable_timeout(const char *src, int *timeout)
 {
 	char filename[PATH_MAX + 1], *str;
@@ -143,19 +85,6 @@ int read_discoverable_timeout(const char *src, int *timeout)
 	return 0;
 }
 
-int write_pairable_timeout(const bdaddr_t *bdaddr, int timeout)
-{
-	char filename[PATH_MAX + 1], str[32];
-
-	snprintf(str, sizeof(str), "%d", timeout);
-
-	create_filename(filename, PATH_MAX, bdaddr, "config");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	return textfile_put(filename, "pairto", str);
-}
-
 int read_pairable_timeout(const char *src, int *timeout)
 {
 	char filename[PATH_MAX + 1], *str;
@@ -176,20 +105,6 @@ int read_pairable_timeout(const char *src, int *timeout)
 	return 0;
 }
 
-int write_device_mode(const bdaddr_t *bdaddr, const char *mode)
-{
-	char filename[PATH_MAX + 1];
-
-	create_filename(filename, PATH_MAX, bdaddr, "config");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	if (strcmp(mode, "off") != 0)
-		textfile_put(filename, "onmode", mode);
-
-	return textfile_put(filename, "mode", mode);
-}
-
 int read_device_mode(const char *src, char *mode, int length)
 {
 	char filename[PATH_MAX + 1], *str;
@@ -226,25 +141,6 @@ int read_on_mode(const char *src, char *mode, int length)
 	return 0;
 }
 
-int write_local_name(const bdaddr_t *bdaddr, const char *name)
-{
-	char filename[PATH_MAX + 1], str[249];
-	int i;
-
-	memset(str, 0, sizeof(str));
-	for (i = 0; i < 248 && name[i]; i++)
-		if ((unsigned char) name[i] < 32 || name[i] == 127)
-			str[i] = '.';
-		else
-			str[i] = name[i];
-
-	create_filename(filename, PATH_MAX, bdaddr, "config");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	return textfile_put(filename, "name", str);
-}
-
 int read_local_name(const bdaddr_t *bdaddr, char *name)
 {
 	char filename[PATH_MAX + 1], *str;
@@ -266,19 +162,6 @@ int read_local_name(const bdaddr_t *bdaddr, char *name)
 	return 0;
 }
 
-int write_local_class(const bdaddr_t *bdaddr, uint8_t *class)
-{
-	char filename[PATH_MAX + 1], str[9];
-
-	sprintf(str, "0x%2.2x%2.2x%2.2x", class[2], class[1], class[0]);
-
-	create_filename(filename, PATH_MAX, bdaddr, "config");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	return textfile_put(filename, "class", str);
-}
-
 int read_local_class(const bdaddr_t *bdaddr, uint8_t *class)
 {
 	char filename[PATH_MAX + 1], tmp[3], *str;
@@ -342,117 +225,6 @@ int write_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
 	return textfile_put(filename, key, str);
 }
 
-int write_remote_class(const bdaddr_t *local, const bdaddr_t *peer,
-								uint32_t class)
-{
-	char filename[PATH_MAX + 1], addr[18], str[9];
-
-	create_filename(filename, PATH_MAX, local, "classes");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(peer, addr);
-	sprintf(str, "0x%6.6x", class);
-
-	return textfile_put(filename, addr, str);
-}
-
-int read_remote_class(const bdaddr_t *local, const bdaddr_t *peer,
-							uint32_t *class)
-{
-	char filename[PATH_MAX + 1], addr[18], *str;
-
-	create_filename(filename, PATH_MAX, local, "classes");
-
-	ba2str(peer, addr);
-
-	str = textfile_get(filename, addr);
-	if (!str)
-		return -ENOENT;
-
-	if (sscanf(str, "%x", class) != 1) {
-		free(str);
-		return -ENOENT;
-	}
-
-	free(str);
-
-	return 0;
-}
-
-int write_device_name(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t peer_type, const char *name)
-{
-	char filename[PATH_MAX + 1], key[20], str[HCI_MAX_NAME_LENGTH + 1];
-	int i;
-
-	memset(str, 0, sizeof(str));
-	for (i = 0; i < HCI_MAX_NAME_LENGTH && name[i]; i++)
-		if ((unsigned char) name[i] < 32 || name[i] == 127)
-			str[i] = '.';
-		else
-			str[i] = name[i];
-
-	create_filename(filename, PATH_MAX, local, "names");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(peer, key);
-	sprintf(&key[17], "#%hhu", peer_type);
-
-	return textfile_put(filename, key, str);
-}
-
-int read_device_name(const char *src, const char *dst, uint8_t dst_type,
-								char *name)
-{
-	char filename[PATH_MAX + 1], *str, key[20];
-	int len;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "names");
-
-	snprintf(key, sizeof(key), "%17s#%hhu", dst, dst_type);
-
-	str = textfile_get(filename, key);
-	if (str != NULL)
-		goto done;
-
-	/* Try old format (address only) */
-	key[17] = '\0';
-
-	str = textfile_get(filename, key);
-	if (str == NULL)
-		return -ENOENT;
-
-done:
-	len = strlen(str);
-	if (len > HCI_MAX_NAME_LENGTH)
-		str[HCI_MAX_NAME_LENGTH] = '\0';
-	strcpy(name, str);
-
-	free(str);
-
-	return 0;
-}
-
-int write_lastseen_info(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t peer_type, struct tm *tm)
-{
-	char filename[PATH_MAX + 1], key[20], str[24];
-
-	memset(str, 0, sizeof(str));
-	strftime(str, sizeof(str), "%Y-%m-%d %H:%M:%S %Z", tm);
-
-	create_filename(filename, PATH_MAX, local, "lastseen");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(peer, key);
-	sprintf(&key[17], "#%hhu", peer_type);
-
-	return textfile_put(filename, key, str);
-}
-
 int write_lastused_info(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, struct tm *tm)
 {
@@ -471,82 +243,6 @@ int write_lastused_info(const bdaddr_t *local, const bdaddr_t *peer,
 	return textfile_put(filename, key, str);
 }
 
-int write_link_key(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t peer_type, unsigned char *key,
-					uint8_t type, int length)
-{
-	char filename[PATH_MAX + 1], addr[20], str[38];
-	int i;
-
-	memset(str, 0, sizeof(str));
-	for (i = 0; i < 16; i++)
-		sprintf(str + (i * 2), "%2.2X", key[i]);
-	sprintf(str + 32, " %d %d", type, length);
-
-	create_filename(filename, PATH_MAX, local, "linkkeys");
-
-	create_file(filename, S_IRUSR | S_IWUSR);
-
-	ba2str(peer, addr);
-	sprintf(&addr[17], "#%hhu", peer_type);
-
-	if (length < 0) {
-		char *tmp = textfile_get(filename, addr);
-		if (tmp) {
-			if (strlen(tmp) > 34)
-				memcpy(str + 34, tmp + 34, 3);
-			free(tmp);
-		}
-	}
-
-	return textfile_put(filename, addr, str);
-}
-
-int read_link_key(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t peer_type, unsigned char *key,
-					uint8_t *type)
-{
-	char filename[PATH_MAX + 1], addr[20], tmp[3], *str;
-	int i;
-
-	create_filename(filename, PATH_MAX, local, "linkkeys");
-
-	ba2str(peer, addr);
-	sprintf(&addr[17], "#%hhu", peer_type);
-
-	str = textfile_get(filename, addr);
-	if (str != NULL)
-		goto done;
-
-	/* Try old format (address only) */
-	addr[17] = '\0';
-
-	str = textfile_get(filename, addr);
-	if (!str)
-		return -ENOENT;
-
-done:
-	if (!key) {
-		free(str);
-		return 0;
-	}
-
-	memset(tmp, 0, sizeof(tmp));
-	for (i = 0; i < 16; i++) {
-		memcpy(tmp, str + (i * 2), 2);
-		key[i] = (uint8_t) strtol(tmp, NULL, 16);
-	}
-
-	if (type) {
-		memcpy(tmp, str + 33, 2);
-		*type = (uint8_t) strtol(tmp, NULL, 10);
-	}
-
-	free(str);
-
-	return 0;
-}
-
 ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin)
 {
 	char filename[PATH_MAX + 1], addr[18], *str;
@@ -567,49 +263,6 @@ ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin)
 	return len;
 }
 
-int write_trust(const char *src, const char *addr, uint8_t addr_type,
-							gboolean trust)
-{
-	char filename[PATH_MAX + 1], key[20];
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "trusts");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	snprintf(key, sizeof(key), "%17s#%hhu", addr, addr_type);
-
-	if (trust == FALSE)
-		return textfile_casedel(filename, key);
-
-	return textfile_caseput(filename, key, GLOBAL_TRUST);
-}
-
-gboolean read_trust(const bdaddr_t *local, const char *addr, uint8_t addr_type)
-{
-	char filename[PATH_MAX + 1], key[20], *str;
-	gboolean ret;
-
-	create_filename(filename, PATH_MAX, local, "trusts");
-
-	snprintf(key, sizeof(key), "%17s#%hhu", addr, addr_type);
-
-	str = textfile_caseget(filename, key);
-	if (str == NULL)
-		/* Try old format (address only) */
-		str = textfile_caseget(filename, addr);
-
-	if (str == NULL)
-		return FALSE;
-
-	if (strcmp(str, GLOBAL_TRUST) == 0)
-		ret = TRUE;
-	else
-		ret = FALSE;
-
-	free(str);
-	return ret;
-}
-
 int write_device_profiles(const bdaddr_t *src, const bdaddr_t *dst,
 					uint8_t dst_type, const char *profiles)
 {
@@ -847,167 +500,6 @@ sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid)
 	return NULL;
 }
 
-int store_device_id(const gchar *src, const gchar *dst, uint8_t dst_type,
-				const uint16_t source, const uint16_t vendor,
-				const uint16_t product, const uint16_t version)
-{
-	char filename[PATH_MAX + 1], key[20], str[20];
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "did");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	snprintf(key, sizeof(key), "%17s#%hhu", dst, dst_type);
-
-	snprintf(str, sizeof(str), "%04X %04X %04X %04X", source,
-						vendor, product, version);
-
-	return textfile_put(filename, key, str);
-}
-
-static int read_device_id_from_did(const gchar *src, const gchar *dst,
-				   uint8_t dst_type, uint16_t *source,
-				   uint16_t *vendor, uint16_t *product,
-							uint16_t *version)
-{
-	char filename[PATH_MAX + 1];
-	char key[20], *str, *vendor_str, *product_str, *version_str;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "did");
-
-	snprintf(key, sizeof(key), "%17s#%hhu", dst, dst_type);
-
-	str = textfile_get(filename, key);
-	if (str != NULL)
-		goto done;
-
-	/* Try old format (address only) */
-	str = textfile_get(filename, dst);
-	if (!str)
-		return -ENOENT;
-
-done:
-	vendor_str = strchr(str, ' ');
-	if (!vendor_str) {
-		free(str);
-		return -ENOENT;
-	}
-	*(vendor_str++) = 0;
-
-	product_str = strchr(vendor_str, ' ');
-	if (!product_str) {
-		free(str);
-		return -ENOENT;
-	}
-	*(product_str++) = 0;
-
-	version_str = strchr(product_str, ' ');
-	if (!version_str) {
-		free(str);
-		return -ENOENT;
-	}
-	*(version_str++) = 0;
-
-	if (source)
-		*source = (uint16_t) strtol(str, NULL, 16);
-	if (vendor)
-		*vendor = (uint16_t) strtol(vendor_str, NULL, 16);
-	if (product)
-		*product = (uint16_t) strtol(product_str, NULL, 16);
-	if (version)
-		*version = (uint16_t) strtol(version_str, NULL, 16);
-
-	free(str);
-
-	return 0;
-}
-
-int read_device_id(const gchar *srcaddr, const gchar *dstaddr,
-		   uint8_t dst_type, uint16_t *source, uint16_t *vendor,
-					uint16_t *product, uint16_t *version)
-{
-	uint16_t lsource, lvendor, lproduct, lversion;
-	sdp_list_t *recs;
-	sdp_record_t *rec;
-	bdaddr_t src, dst;
-	int err;
-
-	err = read_device_id_from_did(srcaddr, dstaddr, dst_type, &lsource,
-								vendor, product,
-								version);
-	if (!err) {
-		if (lsource == 0xffff)
-			err = -ENOENT;
-
-		return err;
-	}
-
-	str2ba(srcaddr, &src);
-	str2ba(dstaddr, &dst);
-
-	recs = read_records(&src, &dst);
-	rec = find_record_in_list(recs, PNP_UUID);
-
-	if (rec) {
-		sdp_data_t *pdlist;
-
-		pdlist = sdp_data_get(rec, SDP_ATTR_VENDOR_ID_SOURCE);
-		lsource = pdlist ? pdlist->val.uint16 : 0x0000;
-
-		pdlist = sdp_data_get(rec, SDP_ATTR_VENDOR_ID);
-		lvendor = pdlist ? pdlist->val.uint16 : 0x0000;
-
-		pdlist = sdp_data_get(rec, SDP_ATTR_PRODUCT_ID);
-		lproduct = pdlist ? pdlist->val.uint16 : 0x0000;
-
-		pdlist = sdp_data_get(rec, SDP_ATTR_VERSION);
-		lversion = pdlist ? pdlist->val.uint16 : 0x0000;
-
-		err = 0;
-	}
-
-	sdp_list_free(recs, (sdp_free_func_t)sdp_record_free);
-
-	if (err) {
-		/* FIXME: We should try EIR data if we have it, too */
-
-		/* If we don't have the data, we don't want to go through the
-		 * above search every time. */
-		lsource = 0xffff;
-		lvendor = 0x0000;
-		lproduct = 0x0000;
-		lversion = 0x0000;
-	}
-
-	store_device_id(srcaddr, dstaddr, dst_type, lsource, lvendor,
-							lproduct, lversion);
-
-	if (err)
-		return err;
-
-	if (source)
-		*source = lsource;
-	if (vendor)
-		*vendor = lvendor;
-	if (product)
-		*product = lproduct;
-	if (version)
-		*version = lversion;
-
-	return 0;
-}
-
-int write_device_pairable(const bdaddr_t *bdaddr, gboolean mode)
-{
-	char filename[PATH_MAX + 1];
-
-	create_filename(filename, PATH_MAX, bdaddr, "config");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	return textfile_put(filename, "pairable", mode ? "yes" : "no");
-}
-
 int read_device_pairable(const bdaddr_t *bdaddr, gboolean *mode)
 {
 	char filename[PATH_MAX + 1], *str;
@@ -1025,51 +517,6 @@ int read_device_pairable(const bdaddr_t *bdaddr, gboolean *mode)
 	return 0;
 }
 
-gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote,
-							uint8_t remote_type)
-{
-	char filename[PATH_MAX + 1], *str, key[20];
-
-	create_filename(filename, PATH_MAX, local, "blocked");
-
-	ba2str(remote, key);
-	sprintf(&key[17], "#%hhu", remote_type);
-
-	str = textfile_caseget(filename, key);
-	if (str != NULL)
-		goto done;
-
-	/* Try old format (address only) */
-	key[17] = '\0';
-
-	str = textfile_caseget(filename, key);
-	if (str == NULL)
-		return FALSE;
-
-done:
-	free(str);
-
-	return TRUE;
-}
-
-int write_blocked(const bdaddr_t *local, const bdaddr_t *remote,
-				uint8_t remote_type, gboolean blocked)
-{
-	char filename[PATH_MAX + 1], key[20];
-
-	create_filename(filename, PATH_MAX, local, "blocked");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(remote, key);
-	sprintf(&key[17], "#%hhu", remote_type);
-
-	if (blocked == FALSE)
-		return textfile_casedel(filename, key);
-
-	return textfile_caseput(filename, key, "");
-}
-
 int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 			  uint8_t bdaddr_type, const char *services)
 {
@@ -1265,40 +712,3 @@ void delete_device_ccc(const bdaddr_t *local, const bdaddr_t *peer)
 	create_filename(filename, PATH_MAX, local, "ccc");
 	delete_by_pattern(filename, addr);
 }
-
-int write_longtermkeys(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t bdaddr_type, const char *key)
-{
-	char filename[PATH_MAX + 1], addr[20];
-
-	if (!key)
-		return -EINVAL;
-
-	create_filename(filename, PATH_MAX, local, "longtermkeys");
-
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	ba2str(peer, addr);
-	sprintf(&addr[17], "#%hhu", bdaddr_type);
-
-	return textfile_put(filename, addr, key);
-}
-
-gboolean has_longtermkeys(const bdaddr_t *local, const bdaddr_t *peer,
-							uint8_t bdaddr_type)
-{
-	char filename[PATH_MAX + 1], key[20], *str;
-
-	create_filename(filename, PATH_MAX, local, "longtermkeys");
-
-	ba2str(peer, key);
-	sprintf(&key[17], "#%hhu", bdaddr_type);
-
-	str = textfile_caseget(filename, key);
-	if (str) {
-		free(str);
-		return TRUE;
-	}
-
-	return FALSE;
-}
diff --git a/src/storage.h b/src/storage.h
index e334828..c8ae6b0 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -23,47 +23,19 @@
 
 #include "textfile.h"
 
-int read_device_alias(const char *src, const char *dst, uint8_t dst_type,
-						char *alias, size_t size);
-int write_device_alias(const char *src, const char *dst, uint8_t dst_type,
-							const char *alias);
-int write_discoverable_timeout(const bdaddr_t *bdaddr, int timeout);
 int read_discoverable_timeout(const char *src, int *timeout);
-int write_pairable_timeout(const bdaddr_t *bdaddr, int timeout);
 int read_pairable_timeout(const char *src, int *timeout);
-int write_device_mode(const bdaddr_t *bdaddr, const char *mode);
 int read_device_mode(const char *src, char *mode, int length);
 int read_on_mode(const char *src, char *mode, int length);
-int write_local_name(const bdaddr_t *bdaddr, const char *name);
 int read_local_name(const bdaddr_t *bdaddr, char *name);
-int write_local_class(const bdaddr_t *bdaddr, uint8_t *class);
 int read_local_class(const bdaddr_t *bdaddr, uint8_t *class);
 int write_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
 				uint8_t bdaddr_type, uint16_t appearance);
 int read_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
 				uint8_t bdaddr_type, uint16_t *appearance);
-int write_remote_class(const bdaddr_t *local, const bdaddr_t *peer,
-							uint32_t class);
-int read_remote_class(const bdaddr_t *local, const bdaddr_t *peer,
-							uint32_t *class);
-int write_device_name(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t peer_type, const char *name);
-int read_device_name(const char *src, const char *dst, uint8_t dst_type,
-								char *name);
-int write_lastseen_info(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t peer_type, struct tm *tm);
 int write_lastused_info(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t peer_type, struct tm *tm);
-int write_link_key(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t peer_type, unsigned char *key,
-					uint8_t type, int length);
-int read_link_key(const bdaddr_t *local, const bdaddr_t *peer,
-			uint8_t peer_type, unsigned char *key, uint8_t *type);
 ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin);
-gboolean read_trust(const bdaddr_t *local, const char *addr,
-						uint8_t addr_type);
-int write_trust(const char *src, const char *addr, uint8_t addr_type,
-							gboolean trust);
 int write_device_profiles(const bdaddr_t *src, const bdaddr_t *dst,
 				uint8_t dst_type, const char *profiles);
 int delete_entry(const bdaddr_t *src, const char *storage, const bdaddr_t *dst,
@@ -79,18 +51,7 @@ void delete_all_records(const bdaddr_t *src, const bdaddr_t *dst,
 							uint8_t dst_type);
 sdp_list_t *read_records(const bdaddr_t *src, const bdaddr_t *dst);
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid);
-int store_device_id(const gchar *src, const gchar *dst, uint8_t dst_type,
-				const uint16_t source, const uint16_t vendor,
-				const uint16_t product, const uint16_t version);
-int read_device_id(const gchar *src, const gchar *dst, uint8_t dst_type,
-					uint16_t *source, uint16_t *vendor,
-					uint16_t *product, uint16_t *version);
-int write_device_pairable(const bdaddr_t *local, gboolean mode);
 int read_device_pairable(const bdaddr_t *local, gboolean *mode);
-gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote,
-							uint8_t remote_type);
-int write_blocked(const bdaddr_t *local, const bdaddr_t *remote,
-				uint8_t remote_type, gboolean blocked);
 int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 				uint8_t bdaddr_type, const char *services);
 int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba,
@@ -112,7 +73,3 @@ int write_device_ccc(const bdaddr_t *local, const bdaddr_t *peer,
 					uint8_t bdaddr_type, uint16_t handle,
 					uint16_t value);
 void delete_device_ccc(const bdaddr_t *local, const bdaddr_t *peer);
-int write_longtermkeys(const bdaddr_t *local, const bdaddr_t *peer,
-					uint8_t bdaddr_type, const char *key);
-gboolean has_longtermkeys(const bdaddr_t *local, const bdaddr_t *peer,
-							uint8_t bdaddr_type);
-- 
1.7.9.5

