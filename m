Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 May 2022 22:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiERWRb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 May 2022 18:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiERWR1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 May 2022 18:17:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D25209B79
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:17:25 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v10so3353530pgl.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80Rc8wrOrqHpcMINX27MgcDRfkMFIB557PHl9IiT88g=;
        b=Dpt0DJeYlov751ePJn4TCnt1fIvMiexfkwgDLlfHMmaUemPCrWKpkmQz0Wlm3XIhSM
         MRdcgXixGogI+gcKrQJJHQLwxES+mjEWHNMVUT1d9knbT7hzf42GLUPbZE8zTmxtL+Jb
         KG1p+IbXjbne46cGQJzZNGXCKDzsgrtR+dK8Nr+hVAHbPRuApL12emDoR1X2d70OxEU2
         JLM2Nz8Y86dE3ZlYJ4YR1EVaZSSmakJD6YQzuZJ8ZoSLyKceEl2jRlfhAWt6dM4ntGvv
         yz/Fg2WaXg/P+Yo8CIpONbnpfaE8G0TZxsK+5I7VDm4WABRTwVz/gmihlD+qzwEBuazc
         PwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80Rc8wrOrqHpcMINX27MgcDRfkMFIB557PHl9IiT88g=;
        b=xBneeJJsB0RXiOjG6iQsx3SGNfeAiU+uC0qcxnJvjBH5ompZashBVmveuIzdoDaxo2
         H3QZqQRUKqUzwTUL+wT0AO683PhcFwcrBf5xGzrALl5L1gDSPNvvXFarGAEV8S2SnNzw
         Nj7UYUV/cubUncLkAHd2u/72OrxLhvOm/pzO9NTJGyKLqjUTVyxmCjbMbFnod7yf7aSL
         qAU4CWgGgGneMzVYiPgjlAa2E4y5Xc2iLpCrON+iozCBjBn4Qt7mGCuIFbD+w/UtS6ID
         AwV38LeoDmrR4/1QqpKSC5PFthKABuMHPIemu0xjm8yNVPBkjqN2prlZ9W55FKNud2uc
         UbCQ==
X-Gm-Message-State: AOAM53130C5Nn2bXtntg80T0Cu4hbytY6dGCAV+F0o6Y0cm+ABmb8J0n
        t7qJH9ENvNLVLQk7LWhbDh0mR0S2MMo=
X-Google-Smtp-Source: ABdhPJyNx6MutJdTX7dBPn1/t19D/hsoJQCXoZ2A/1oQEAWbiOqSSvz0siY+8cRpT9oyjOrHvb8WXQ==
X-Received: by 2002:a05:6a00:18a9:b0:50d:d41b:7240 with SMTP id x41-20020a056a0018a900b0050dd41b7240mr1763655pfh.66.1652912243876;
        Wed, 18 May 2022 15:17:23 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id iz15-20020a170902ef8f00b001619b38701bsm2201363plb.72.2022.05.18.15.17.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:17:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] settings: Add btd_settings_gatt_db_{store,load}
Date:   Wed, 18 May 2022 15:16:56 -0700
Message-Id: <20220518221701.2220062-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds helper functions to store and load from/to file so they can
get reused by the likes of gatt-database.c and btmon.
---
 Makefile.am    |   3 +-
 src/device.c   | 499 ++---------------------------------------------
 src/settings.c | 510 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/settings.h |  11 ++
 4 files changed, 534 insertions(+), 489 deletions(-)
 create mode 100644 src/settings.c
 create mode 100644 src/settings.h

diff --git a/Makefile.am b/Makefile.am
index 82125c482..0074ea3ac 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -322,7 +322,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/dbus-common.c src/dbus-common.h \
 			src/eir.h src/eir.c \
 			src/adv_monitor.h src/adv_monitor.c \
-			src/battery.h src/battery.c
+			src/battery.h src/battery.c \
+			src/settings.h src/settings.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			src/libshared-glib.la \
diff --git a/src/device.c b/src/device.c
index 638bad061..0d7c62c9c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -63,6 +63,7 @@
 #include "textfile.h"
 #include "storage.h"
 #include "eir.h"
+#include "settings.h"
 
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		1
@@ -74,11 +75,6 @@
 
 #define RSSI_THRESHOLD		8
 
-#define GATT_PRIM_SVC_UUID_STR "2800"
-#define GATT_SND_SVC_UUID_STR  "2801"
-#define GATT_INCLUDE_UUID_STR "2802"
-#define GATT_CHARAC_UUID_STR "2803"
-
 static DBusConnection *dbus_conn = NULL;
 static unsigned service_state_cb_id;
 
@@ -2517,171 +2513,10 @@ static void store_services(struct btd_device *device)
 	g_key_file_free(key_file);
 }
 
-struct gatt_saver {
-	struct btd_device *device;
-	uint16_t ext_props;
-	GKeyFile *key_file;
-};
-
-static void db_hash_read_value_cb(struct gatt_db_attribute *attrib,
-						int err, const uint8_t *value,
-						size_t length, void *user_data)
-{
-	const uint8_t **hash = user_data;
-
-	if (err || (length != 16))
-		return;
-
-	*hash = value;
-}
-
-static void store_desc(struct gatt_db_attribute *attr, void *user_data)
-{
-	struct gatt_saver *saver = user_data;
-	GKeyFile *key_file = saver->key_file;
-	char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
-	const bt_uuid_t *uuid;
-	bt_uuid_t ext_uuid;
-	uint16_t handle_num;
-
-	handle_num = gatt_db_attribute_get_handle(attr);
-	sprintf(handle, "%04hx", handle_num);
-
-	uuid = gatt_db_attribute_get_type(attr);
-	bt_uuid_to_string(uuid, uuid_str, sizeof(uuid_str));
-
-	bt_uuid16_create(&ext_uuid, GATT_CHARAC_EXT_PROPER_UUID);
-	if (!bt_uuid_cmp(uuid, &ext_uuid) && saver->ext_props)
-		sprintf(value, "%04hx:%s", saver->ext_props, uuid_str);
-	else
-		sprintf(value, "%s", uuid_str);
-
-	g_key_file_set_string(key_file, "Attributes", handle, value);
-}
-
-static void store_chrc(struct gatt_db_attribute *attr, void *user_data)
-{
-	struct gatt_saver *saver = user_data;
-	GKeyFile *key_file = saver->key_file;
-	char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
-	uint16_t handle_num, value_handle;
-	uint8_t properties;
-	bt_uuid_t uuid, hash_uuid;
-
-	if (!gatt_db_attribute_get_char_data(attr, &handle_num, &value_handle,
-						&properties, &saver->ext_props,
-						&uuid)) {
-		warn("Error storing characteristic - can't get data");
-		return;
-	}
-
-	sprintf(handle, "%04hx", handle_num);
-	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
-
-	/* Store Database Hash  value if available */
-	bt_uuid16_create(&hash_uuid, GATT_CHARAC_DB_HASH);
-	if (!bt_uuid_cmp(&uuid, &hash_uuid)) {
-		const uint8_t *hash = NULL;
-
-		attr = gatt_db_get_attribute(saver->device->db, value_handle);
-
-		gatt_db_attribute_read(attr, 0, BT_ATT_OP_READ_REQ, NULL,
-					db_hash_read_value_cb, &hash);
-		if (hash)
-			sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hhx:"
-				"%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
-				"%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
-				"%02hhx%02hhx:%s", value_handle, properties,
-				hash[0], hash[1], hash[2], hash[3],
-				hash[4], hash[5], hash[6], hash[7],
-				hash[8], hash[9], hash[10], hash[11],
-				hash[12], hash[13], hash[14], hash[15],
-				uuid_str);
-		else
-			sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hhx:%s",
-				value_handle, properties, uuid_str);
-
-	} else
-		sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hhx:%s",
-				value_handle, properties, uuid_str);
-
-	g_key_file_set_string(key_file, "Attributes", handle, value);
-
-	gatt_db_service_foreach_desc(attr, store_desc, saver);
-}
-
-static void store_incl(struct gatt_db_attribute *attr, void *user_data)
-{
-	struct gatt_saver *saver = user_data;
-	GKeyFile *key_file = saver->key_file;
-	struct gatt_db_attribute *service;
-	char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
-	uint16_t handle_num, start, end;
-	bt_uuid_t uuid;
-
-	if (!gatt_db_attribute_get_incl_data(attr, &handle_num, &start, &end)) {
-		warn("Error storing included service - can't get data");
-		return;
-	}
-
-	service = gatt_db_get_attribute(saver->device->db, start);
-	if (!service) {
-		warn("Error storing included service - can't find it");
-		return;
-	}
-
-	sprintf(handle, "%04hx", handle_num);
-
-	gatt_db_attribute_get_service_uuid(service, &uuid);
-	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
-	sprintf(value, GATT_INCLUDE_UUID_STR ":%04hx:%04hx:%s", start,
-								end, uuid_str);
-
-	g_key_file_set_string(key_file, "Attributes", handle, value);
-}
-
-static void store_service(struct gatt_db_attribute *attr, void *user_data)
-{
-	struct gatt_saver *saver = user_data;
-	GKeyFile *key_file = saver->key_file;
-	char uuid_str[MAX_LEN_UUID_STR], handle[6], value[256];
-	uint16_t start, end;
-	bt_uuid_t uuid;
-	bool primary;
-	char *type;
-
-	if (!gatt_db_attribute_get_service_data(attr, &start, &end, &primary,
-								&uuid)) {
-		warn("Error storing service - can't get data");
-		return;
-	}
-
-	sprintf(handle, "%04hx", start);
-
-	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
-
-	if (primary)
-		type = GATT_PRIM_SVC_UUID_STR;
-	else
-		type = GATT_SND_SVC_UUID_STR;
-
-	sprintf(value, "%s:%04hx:%s", type, end, uuid_str);
-
-	g_key_file_set_string(key_file, "Attributes", handle, value);
-
-	gatt_db_service_foreach_incl(attr, store_incl, saver);
-	gatt_db_service_foreach_char(attr, store_chrc, saver);
-}
-
 static void store_gatt_db(struct btd_device *device)
 {
 	char filename[PATH_MAX];
 	char dst_addr[18];
-	GKeyFile *key_file;
-	GError *gerr = NULL;
-	char *data;
-	gsize length = 0;
-	struct gatt_saver saver;
 
 	if (device_address_is_private(device)) {
 		DBG("Can't store GATT db for private addressed device %s",
@@ -2699,33 +2534,9 @@ static void store_gatt_db(struct btd_device *device)
 				dst_addr);
 	create_file(filename, 0600);
 
-	key_file = g_key_file_new();
-	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
-		error("Unable to load key file from %s: (%s)", filename,
-								gerr->message);
-		g_clear_error(&gerr);
-	}
-
-	/* Remove current attributes since it might have changed */
-	g_key_file_remove_group(key_file, "Attributes", NULL);
-
-	saver.key_file = key_file;
-	saver.device = device;
-
-	gatt_db_foreach_service(device->db, NULL, store_service, &saver);
-
-	data = g_key_file_to_data(key_file, &length, NULL);
-	if (!g_file_set_contents(filename, data, length, &gerr)) {
-		error("Unable set contents for %s: (%s)", filename,
-								gerr->message);
-		g_error_free(gerr);
-	}
-
-	g_free(data);
-	g_key_file_free(key_file);
+	btd_settings_gatt_db_store(device->db, filename);
 }
 
-
 static void browse_request_complete(struct browse_req *req, uint8_t type,
 						uint8_t bdaddr_type, int err)
 {
@@ -3797,288 +3608,11 @@ static void add_primary(struct gatt_db_attribute *attr, void *user_data)
 	*new_services = g_slist_append(*new_services, prim);
 }
 
-static void load_desc_value(struct gatt_db_attribute *attrib,
-						int err, void *user_data)
-{
-	if (err)
-		warn("loading descriptor value to db failed");
-}
-
-static ssize_t str2val(const char *str, uint8_t *val, size_t len)
-{
-	const char *pos = str;
-	size_t i;
-
-	for (i = 0; i < len; i++) {
-		if (sscanf(pos, "%2hhx", &val[i]) != 1)
-			break;
-		pos += 2;
-	}
-
-	return i;
-}
-
-static int load_desc(char *handle, char *value,
-					struct gatt_db_attribute *service)
-{
-	char uuid_str[MAX_LEN_UUID_STR];
-	struct gatt_db_attribute *att;
-	uint16_t handle_int;
-	uint16_t val;
-	bt_uuid_t uuid, ext_uuid;
-
-	if (sscanf(handle, "%04hx", &handle_int) != 1)
-		return -EIO;
-
-	/* Check if there is any value stored, otherwise it is just the UUID */
-	if (sscanf(value, "%04hx:%36s", &val, uuid_str) != 2) {
-		if (sscanf(value, "%36s", uuid_str) != 1)
-			return -EIO;
-		val = 0;
-	}
-
-	DBG("loading descriptor handle: 0x%04x, value: 0x%04x, value uuid: %s",
-				handle_int, val, uuid_str);
-
-	bt_string_to_uuid(&uuid, uuid_str);
-	bt_uuid16_create(&ext_uuid, GATT_CHARAC_EXT_PROPER_UUID);
-
-	/* If it is CEP then it must contain the value */
-	if (!bt_uuid_cmp(&uuid, &ext_uuid) && !val) {
-		warn("cannot load CEP descriptor without value");
-		return -EIO;
-	}
-
-	att = gatt_db_service_insert_descriptor(service, handle_int, &uuid,
-							0, NULL, NULL, NULL);
-	if (!att || gatt_db_attribute_get_handle(att) != handle_int) {
-		warn("loading descriptor to db failed");
-		return -EIO;
-	}
-
-	if (val) {
-		if (!gatt_db_attribute_write(att, 0, (uint8_t *)&val,
-						sizeof(val), 0, NULL,
-						load_desc_value, NULL))
-			return -EIO;
-	}
-
-	return 0;
-}
-
-static int load_chrc(char *handle, char *value,
-					struct gatt_db_attribute *service)
-{
-	uint16_t properties, value_handle, handle_int;
-	char uuid_str[MAX_LEN_UUID_STR];
-	struct gatt_db_attribute *att;
-	char val_str[33];
-	uint8_t val[16];
-	size_t val_len;
-	bt_uuid_t uuid;
-
-	if (sscanf(handle, "%04hx", &handle_int) != 1)
-		return -EIO;
-
-	/* Check if there is any value stored */
-	if (sscanf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%32s:%36s",
-			&value_handle, &properties, val_str, uuid_str) != 4) {
-		if (sscanf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%36s",
-				&value_handle, &properties, uuid_str) != 3)
-			return -EIO;
-		val_len = 0;
-	} else
-		val_len = str2val(val_str, val, sizeof(val));
-
-	bt_string_to_uuid(&uuid, uuid_str);
-
-	/* Log debug message. */
-	DBG("loading characteristic handle: 0x%04x, value handle: 0x%04x,"
-				" properties 0x%04x value: %s uuid: %s",
-				handle_int, value_handle, properties,
-				val_len ? val_str : "", uuid_str);
-
-	att = gatt_db_service_insert_characteristic(service, value_handle,
-							&uuid, 0, properties,
-							NULL, NULL, NULL);
-	if (!att || gatt_db_attribute_get_handle(att) != value_handle) {
-		warn("loading characteristic to db failed");
-		return -EIO;
-	}
-
-	if (val_len) {
-		if (!gatt_db_attribute_write(att, 0, val, val_len, 0, NULL,
-						load_desc_value, NULL))
-			return -EIO;
-	}
-
-	return 0;
-}
-
-static int load_incl(struct gatt_db *db, char *handle, char *value,
-					struct gatt_db_attribute *service)
-{
-	char uuid_str[MAX_LEN_UUID_STR];
-	struct gatt_db_attribute *att;
-	uint16_t start, end;
-
-	if (sscanf(handle, "%04hx", &start) != 1)
-		return -EIO;
-
-	if (sscanf(value, GATT_INCLUDE_UUID_STR ":%04hx:%04hx:%36s", &start,
-							&end, uuid_str) != 3)
-		return -EIO;
-
-	/* Log debug message. */
-	DBG("loading included service: 0x%04x, end: 0x%04x, uuid: %s", start,
-								end, uuid_str);
-
-	att = gatt_db_get_attribute(db, start);
-	if (!att) {
-		warn("loading included service to db failed - no such service");
-		return -EIO;
-	}
-
-	att = gatt_db_service_add_included(service, att);
-	if (!att) {
-		warn("loading included service to db failed");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static int load_service(struct gatt_db *db, char *handle, char *value)
-{
-	struct gatt_db_attribute *att;
-	uint16_t start, end;
-	char type[MAX_LEN_UUID_STR], uuid_str[MAX_LEN_UUID_STR];
-	bt_uuid_t uuid;
-	bool primary;
-
-	if (sscanf(handle, "%04hx", &start) != 1)
-		return -EIO;
-
-	if (sscanf(value, "%[^:]:%04hx:%36s", type, &end, uuid_str) != 3)
-		return -EIO;
-
-	if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR))
-		primary = true;
-	else if (g_str_equal(type, GATT_SND_SVC_UUID_STR))
-		primary = false;
-	else
-		return -EIO;
-
-	bt_string_to_uuid(&uuid, uuid_str);
-
-	/* Log debug message. */
-	DBG("loading service: 0x%04x, end: 0x%04x, uuid: %s",
-							start, end, uuid_str);
-
-	att = gatt_db_insert_service(db, start, &uuid, primary,
-							end - start + 1);
-	if (!att) {
-		error("Unable load service into db!");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static int load_gatt_db_impl(GKeyFile *key_file, char **keys,
-							struct gatt_db *db)
-{
-	struct gatt_db_attribute *current_service;
-	char **handle, *value, type[MAX_LEN_UUID_STR];
-	int ret;
-
-	/* first load service definitions */
-	for (handle = keys; *handle; handle++) {
-		value = g_key_file_get_string(key_file, "Attributes", *handle,
-									NULL);
-
-		if (sscanf(value, "%[^:]:", type) != 1) {
-			warn("Missing Type in attribute definition");
-			g_free(value);
-			return -EIO;
-		}
-
-		if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR) ||
-				g_str_equal(type, GATT_SND_SVC_UUID_STR)) {
-			ret = load_service(db, *handle, value);
-			if (ret) {
-				g_free(value);
-				return ret;
-			}
-		}
-
-		g_free(value);
-	}
-
-	current_service = NULL;
-	/* then fill them with data*/
-	for (handle = keys; *handle; handle++) {
-		value = g_key_file_get_string(key_file, "Attributes", *handle,
-									NULL);
-
-		if (sscanf(value, "%[^:]:", type) != 1) {
-			warn("Missing Type in attribute definition");
-			g_free(value);
-			return -EIO;
-		}
-
-		if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR) ||
-				g_str_equal(type, GATT_SND_SVC_UUID_STR)) {
-			uint16_t tmp;
-			uint16_t start, end;
-			bool primary;
-			bt_uuid_t uuid;
-			char uuid_str[MAX_LEN_UUID_STR];
-
-			if (sscanf(*handle, "%04hx", &tmp) != 1) {
-				warn("Unable to parse attribute handle");
-				g_free(value);
-				return -EIO;
-			}
-
-			if (current_service)
-				gatt_db_service_set_active(current_service,
-									true);
-
-			current_service = gatt_db_get_attribute(db, tmp);
-
-			gatt_db_attribute_get_service_data(current_service,
-							&start, &end,
-							&primary, &uuid);
-
-			bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
-		} else if (g_str_equal(type, GATT_INCLUDE_UUID_STR)) {
-			ret = load_incl(db, *handle, value, current_service);
-		} else if (g_str_equal(type, GATT_CHARAC_UUID_STR)) {
-			ret = load_chrc(*handle, value, current_service);
-		} else {
-			ret = load_desc(*handle, value, current_service);
-		}
-
-		g_free(value);
-		if (ret) {
-			gatt_db_clear(db);
-			return ret;
-		}
-	}
-
-	if (current_service)
-		gatt_db_service_set_active(current_service, true);
-
-	return 0;
-}
-
 static void load_gatt_db(struct btd_device *device, const char *local,
 							const char *peer)
 {
-	char **keys, filename[PATH_MAX];
-	GKeyFile *key_file;
-	GError *gerr = NULL;
+	char filename[PATH_MAX];
+	int err;
 
 	if (!gatt_cache_is_enabled(device))
 		return;
@@ -4087,25 +3621,14 @@ static void load_gatt_db(struct btd_device *device, const char *local,
 
 	create_filename(filename, PATH_MAX, "/%s/cache/%s", local, peer);
 
-	key_file = g_key_file_new();
-	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
-		error("Unable to load key file from %s: (%s)", filename,
-								gerr->message);
-		g_error_free(gerr);
+	err = btd_settings_gatt_db_load(device->db, filename);
+	if (err < 0) {
+		if (err == -ENOENT)
+			return;
+
+		warn("Error loading db from cache for %s: %s (%d)", peer,
+						strerror(-err), err);
 	}
-	keys = g_key_file_get_keys(key_file, "Attributes", NULL, NULL);
-
-	if (!keys) {
-		warn("No cache for %s", peer);
-		g_key_file_free(key_file);
-		return;
-	}
-
-	if (load_gatt_db_impl(key_file, keys, device->db))
-		warn("Unable to load gatt db from file for %s", peer);
-
-	g_strfreev(keys);
-	g_key_file_free(key_file);
 
 	g_slist_free_full(device->primaries, g_free);
 	device->primaries = NULL;
diff --git a/src/settings.c b/src/settings.c
new file mode 100644
index 000000000..0f0530006
--- /dev/null
+++ b/src/settings.c
@@ -0,0 +1,510 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+
+#include "log.h"
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "settings.h"
+
+#define GATT_PRIM_SVC_UUID_STR "2800"
+#define GATT_SND_SVC_UUID_STR  "2801"
+#define GATT_INCLUDE_UUID_STR "2802"
+#define GATT_CHARAC_UUID_STR "2803"
+
+static ssize_t str2val(const char *str, uint8_t *val, size_t len)
+{
+	const char *pos = str;
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (sscanf(pos, "%2hhx", &val[i]) != 1)
+			break;
+		pos += 2;
+	}
+
+	return i;
+}
+
+static void load_desc_value(struct gatt_db_attribute *attrib, int err,
+							void *user_data)
+{
+}
+
+static int load_desc(struct gatt_db *db, char *handle, char *value,
+					struct gatt_db_attribute *service)
+{
+	char uuid_str[MAX_LEN_UUID_STR];
+	struct gatt_db_attribute *att;
+	uint16_t handle_int;
+	uint16_t val;
+	bt_uuid_t uuid, ext_uuid;
+
+	if (sscanf(handle, "%04hx", &handle_int) != 1)
+		return -EIO;
+
+	/* Check if there is any value stored, otherwise it is just the UUID */
+	if (sscanf(value, "%04hx:%36s", &val, uuid_str) != 2) {
+		if (sscanf(value, "%36s", uuid_str) != 1)
+			return -EIO;
+		val = 0;
+	}
+
+	DBG("loading descriptor handle: 0x%04x, value: 0x%04x, value uuid: %s",
+						handle_int, val, uuid_str);
+
+	bt_string_to_uuid(&uuid, uuid_str);
+	bt_uuid16_create(&ext_uuid, GATT_CHARAC_EXT_PROPER_UUID);
+
+	/* If it is CEP then it must contain the value */
+	if (!bt_uuid_cmp(&uuid, &ext_uuid) && !val)
+		return -EIO;
+
+	att = gatt_db_service_insert_descriptor(service, handle_int, &uuid,
+							0, NULL, NULL, NULL);
+	if (!att || gatt_db_attribute_get_handle(att) != handle_int)
+		return -EIO;
+
+	if (val) {
+		if (!gatt_db_attribute_write(att, 0, (uint8_t *)&val,
+						sizeof(val), 0, NULL,
+						load_desc_value, NULL))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int load_chrc(struct gatt_db *db, char *handle, char *value,
+					struct gatt_db_attribute *service)
+{
+	uint16_t properties, value_handle, handle_int;
+	char uuid_str[MAX_LEN_UUID_STR];
+	struct gatt_db_attribute *att;
+	char val_str[33];
+	uint8_t val[16];
+	size_t val_len;
+	bt_uuid_t uuid;
+
+	if (sscanf(handle, "%04hx", &handle_int) != 1)
+		return -EIO;
+
+	/* Check if there is any value stored */
+	if (sscanf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%32s:%36s",
+			&value_handle, &properties, val_str, uuid_str) != 4) {
+		if (sscanf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%36s",
+				&value_handle, &properties, uuid_str) != 3)
+			return -EIO;
+		val_len = 0;
+	} else
+		val_len = str2val(val_str, val, sizeof(val));
+
+	bt_string_to_uuid(&uuid, uuid_str);
+
+	/* Log debug message. */
+	DBG("loading characteristic handle: 0x%04x, value handle: 0x%04x, "
+				"properties 0x%04x value: %s uuid: %s",
+				handle_int, value_handle,
+				properties, val_len ? val_str : "", uuid_str);
+
+	att = gatt_db_service_insert_characteristic(service, value_handle,
+							&uuid, 0, properties,
+							NULL, NULL, NULL);
+	if (!att || gatt_db_attribute_get_handle(att) != value_handle)
+		return -EIO;
+
+	if (val_len) {
+		if (!gatt_db_attribute_write(att, 0, val, val_len, 0, NULL,
+						load_desc_value, NULL))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int load_incl(struct gatt_db *db, char *handle, char *value,
+					struct gatt_db_attribute *service)
+{
+	char uuid_str[MAX_LEN_UUID_STR];
+	struct gatt_db_attribute *att;
+	uint16_t start, end;
+
+	if (sscanf(handle, "%04hx", &start) != 1)
+		return -EIO;
+
+	if (sscanf(value, GATT_INCLUDE_UUID_STR ":%04hx:%04hx:%36s", &start,
+							&end, uuid_str) != 3)
+		return -EIO;
+
+	/* Log debug message. */
+	DBG("loading included service: 0x%04x, end: 0x%04x, uuid: %s",
+						start, end, uuid_str);
+
+	att = gatt_db_get_attribute(db, start);
+	if (!att)
+		return -EIO;
+
+	att = gatt_db_service_add_included(service, att);
+	if (!att)
+		return -EIO;
+
+	return 0;
+}
+
+static int load_service(struct gatt_db *db, char *handle, char *value)
+{
+	struct gatt_db_attribute *att;
+	uint16_t start, end;
+	char type[MAX_LEN_UUID_STR], uuid_str[MAX_LEN_UUID_STR];
+	bt_uuid_t uuid;
+	bool primary;
+
+	if (sscanf(handle, "%04hx", &start) != 1)
+		return -EIO;
+
+	if (sscanf(value, "%[^:]:%04hx:%36s", type, &end, uuid_str) != 3)
+		return -EIO;
+
+	if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR))
+		primary = true;
+	else if (g_str_equal(type, GATT_SND_SVC_UUID_STR))
+		primary = false;
+	else
+		return -EIO;
+
+	bt_string_to_uuid(&uuid, uuid_str);
+
+	/* Log debug message. */
+	DBG("loading service: 0x%04x, end: 0x%04x, uuid: %s", start, end,
+								uuid_str);
+
+	att = gatt_db_insert_service(db, start, &uuid, primary,
+							end - start + 1);
+	if (!att) {
+		DBG("Unable load service into db!");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int gatt_db_load(struct gatt_db *db, GKeyFile *key_file, char **keys)
+{
+	struct gatt_db_attribute *current_service;
+	char **handle, *value, type[MAX_LEN_UUID_STR];
+	int ret;
+
+	/* first load service definitions */
+	for (handle = keys; *handle; handle++) {
+		value = g_key_file_get_string(key_file, "Attributes", *handle,
+									NULL);
+
+		if (sscanf(value, "%[^:]:", type) != 1) {
+			g_free(value);
+			return -EIO;
+		}
+
+		if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR) ||
+				g_str_equal(type, GATT_SND_SVC_UUID_STR)) {
+			ret = load_service(db, *handle, value);
+			if (ret) {
+				g_free(value);
+				return ret;
+			}
+		}
+
+		g_free(value);
+	}
+
+	current_service = NULL;
+	/* then fill them with data*/
+	for (handle = keys; *handle; handle++) {
+		value = g_key_file_get_string(key_file, "Attributes", *handle,
+									NULL);
+
+		if (sscanf(value, "%[^:]:", type) != 1) {
+			g_free(value);
+			return -EIO;
+		}
+
+		if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR) ||
+				g_str_equal(type, GATT_SND_SVC_UUID_STR)) {
+			uint16_t tmp;
+			uint16_t start, end;
+			bool primary;
+			bt_uuid_t uuid;
+			char uuid_str[MAX_LEN_UUID_STR];
+
+			if (sscanf(*handle, "%04hx", &tmp) != 1) {
+				g_free(value);
+				return -EIO;
+			}
+
+			if (current_service)
+				gatt_db_service_set_active(current_service,
+									true);
+
+			current_service = gatt_db_get_attribute(db, tmp);
+
+			gatt_db_attribute_get_service_data(current_service,
+							&start, &end,
+							&primary, &uuid);
+
+			bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+		} else if (g_str_equal(type, GATT_INCLUDE_UUID_STR)) {
+			ret = load_incl(db, *handle, value, current_service);
+		} else if (g_str_equal(type, GATT_CHARAC_UUID_STR)) {
+			ret = load_chrc(db, *handle, value, current_service);
+		} else {
+			ret = load_desc(db, *handle, value, current_service);
+		}
+
+		g_free(value);
+		if (ret) {
+			gatt_db_clear(db);
+			return ret;
+		}
+	}
+
+	if (current_service)
+		gatt_db_service_set_active(current_service, true);
+
+	return 0;
+}
+
+int btd_settings_gatt_db_load(struct gatt_db *db, const char *filename)
+{
+	char **keys;
+	GKeyFile *key_file;
+	GError *gerr = NULL;
+	int err;
+
+	key_file = g_key_file_new();
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		DBG("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_clear_error(&gerr);
+	}
+
+	keys = g_key_file_get_keys(key_file, "Attributes", NULL, NULL);
+
+	if (!keys) {
+		g_key_file_free(key_file);
+		return -ENOENT;
+	}
+
+	err = gatt_db_load(db, key_file, keys);
+
+	g_strfreev(keys);
+	g_key_file_free(key_file);
+
+	return err;
+}
+
+struct gatt_saver {
+	struct gatt_db *db;
+	uint16_t ext_props;
+	GKeyFile *key_file;
+};
+
+static void db_hash_read_value_cb(struct gatt_db_attribute *attrib,
+						int err, const uint8_t *value,
+						size_t length, void *user_data)
+{
+	const uint8_t **hash = user_data;
+
+	if (err || (length != 16))
+		return;
+
+	*hash = value;
+}
+
+static void store_desc(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gatt_saver *saver = user_data;
+	GKeyFile *key_file = saver->key_file;
+	char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
+	const bt_uuid_t *uuid;
+	bt_uuid_t ext_uuid;
+	uint16_t handle_num;
+
+	handle_num = gatt_db_attribute_get_handle(attr);
+	sprintf(handle, "%04hx", handle_num);
+
+	uuid = gatt_db_attribute_get_type(attr);
+	bt_uuid_to_string(uuid, uuid_str, sizeof(uuid_str));
+
+	bt_uuid16_create(&ext_uuid, GATT_CHARAC_EXT_PROPER_UUID);
+	if (!bt_uuid_cmp(uuid, &ext_uuid) && saver->ext_props)
+		sprintf(value, "%04hx:%s", saver->ext_props, uuid_str);
+	else
+		sprintf(value, "%s", uuid_str);
+
+	g_key_file_set_string(key_file, "Attributes", handle, value);
+}
+
+static void store_chrc(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gatt_saver *saver = user_data;
+	GKeyFile *key_file = saver->key_file;
+	char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
+	uint16_t handle_num, value_handle;
+	uint8_t properties;
+	bt_uuid_t uuid, hash_uuid;
+
+	if (!gatt_db_attribute_get_char_data(attr, &handle_num, &value_handle,
+						&properties, &saver->ext_props,
+						&uuid)) {
+		DBG("Unable to locate Characteristic data");
+		return;
+	}
+
+	sprintf(handle, "%04hx", handle_num);
+	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+
+	/* Store Database Hash  value if available */
+	bt_uuid16_create(&hash_uuid, GATT_CHARAC_DB_HASH);
+	if (!bt_uuid_cmp(&uuid, &hash_uuid)) {
+		const uint8_t *hash = NULL;
+
+		attr = gatt_db_get_attribute(saver->db, value_handle);
+
+		gatt_db_attribute_read(attr, 0, BT_ATT_OP_READ_REQ, NULL,
+					db_hash_read_value_cb, &hash);
+		if (hash)
+			sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hhx:"
+				"%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
+				"%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
+				"%02hhx%02hhx:%s", value_handle, properties,
+				hash[0], hash[1], hash[2], hash[3],
+				hash[4], hash[5], hash[6], hash[7],
+				hash[8], hash[9], hash[10], hash[11],
+				hash[12], hash[13], hash[14], hash[15],
+				uuid_str);
+		else
+			sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hhx:%s",
+				value_handle, properties, uuid_str);
+
+	} else
+		sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hhx:%s",
+				value_handle, properties, uuid_str);
+
+	g_key_file_set_string(key_file, "Attributes", handle, value);
+
+	gatt_db_service_foreach_desc(attr, store_desc, saver);
+}
+
+static void store_incl(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gatt_saver *saver = user_data;
+	GKeyFile *key_file = saver->key_file;
+	struct gatt_db_attribute *service;
+	char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
+	uint16_t handle_num, start, end;
+	bt_uuid_t uuid;
+
+	if (!gatt_db_attribute_get_incl_data(attr, &handle_num, &start, &end)) {
+		DBG("Unable to locate Included data");
+		return;
+	}
+
+	service = gatt_db_get_attribute(saver->db, start);
+	if (!service) {
+		DBG("Unable to locate Included Service");
+		return;
+	}
+
+	sprintf(handle, "%04hx", handle_num);
+
+	gatt_db_attribute_get_service_uuid(service, &uuid);
+	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+	sprintf(value, GATT_INCLUDE_UUID_STR ":%04hx:%04hx:%s", start,
+								end, uuid_str);
+
+	g_key_file_set_string(key_file, "Attributes", handle, value);
+}
+
+static void store_service(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gatt_saver *saver = user_data;
+	GKeyFile *key_file = saver->key_file;
+	char uuid_str[MAX_LEN_UUID_STR], handle[6], value[256];
+	uint16_t start, end;
+	bt_uuid_t uuid;
+	bool primary;
+	char *type;
+
+	if (!gatt_db_attribute_get_service_data(attr, &start, &end, &primary,
+								&uuid)) {
+		DBG("Unable to locate Service data");
+		return;
+	}
+
+	sprintf(handle, "%04hx", start);
+
+	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+
+	if (primary)
+		type = GATT_PRIM_SVC_UUID_STR;
+	else
+		type = GATT_SND_SVC_UUID_STR;
+
+	sprintf(value, "%s:%04hx:%s", type, end, uuid_str);
+
+	g_key_file_set_string(key_file, "Attributes", handle, value);
+
+	gatt_db_service_foreach_incl(attr, store_incl, saver);
+	gatt_db_service_foreach_char(attr, store_chrc, saver);
+}
+
+void btd_settings_gatt_db_store(struct gatt_db *db, const char *filename)
+{
+	GKeyFile *key_file;
+	GError *gerr = NULL;
+	char *data;
+	gsize length = 0;
+	struct gatt_saver saver;
+
+	key_file = g_key_file_new();
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		DBG("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_clear_error(&gerr);
+	}
+
+	/* Remove current attributes since it might have changed */
+	g_key_file_remove_group(key_file, "Attributes", NULL);
+
+	saver.key_file = key_file;
+	saver.db = db;
+
+	gatt_db_foreach_service(db, NULL, store_service, &saver);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (!g_file_set_contents(filename, data, length, &gerr)) {
+		DBG("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
+
+	g_free(data);
+	g_key_file_free(key_file);
+}
diff --git a/src/settings.h b/src/settings.h
new file mode 100644
index 000000000..675f643a6
--- /dev/null
+++ b/src/settings.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation.
+ *
+ */
+
+int btd_settings_gatt_db_load(struct gatt_db *db, const char *filename);
+void btd_settings_gatt_db_store(struct gatt_db *db, const char *filename);
-- 
2.35.1

