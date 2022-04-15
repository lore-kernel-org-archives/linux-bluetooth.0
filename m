Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26737C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 22:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiDOWd0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 18:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiDOWdY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 18:33:24 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C91881191
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 15:30:52 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t13so8782097pgn.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qW4q+C4Qu0eJhFzHpEGL596O8oKDTIWjXDb4z5ebVgY=;
        b=R0/wH4qOeoIxgLCUE+FQrZ8CBzeF41jsis3XqmF/R54bmJx3pB+jytOAYFucXK1Llj
         2VnQkPOn8jbd9nQaKkHWnLoaqxok002H7l+rX7VD08YMx+2eJtB3nKpx4QSSIoXDpRjn
         DHQMMm7o3wWnGi8Saq+ssdtU8f09XAGh/GJeECB075CRBSYO/oHuwcW9QVqIKVLlwtG4
         Txw1mcboQwgD1Fy18ZGUCHZGMxuRhwl8JTlnB65o+V4FkonkbekjinevlFoKOshxhOZI
         ZH4juNDenE0d79HtG8PkKyDeNN3gHg+hL4IWIWOJcrOoOvosQ0XWYEiK7qJ4BQNytEY5
         2dCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qW4q+C4Qu0eJhFzHpEGL596O8oKDTIWjXDb4z5ebVgY=;
        b=AS7h6nh1et3YVcAkC22NReGX6yE3gEeYzoLu6Ccu+wrbU6QGEWtnwCvU4DsJRxJBQt
         rD1yRb8rXilBu0zW0AE74VjWJEOJYi1gmKV6A4duL1fH18e6JfnK3GY+pOceWO8WPQHd
         oBdq3XL1ieBmhmHQpSPKCeJIA/32bDZBO9so5vP6psgb1d8HwboTQnxSl4oiianVNmXE
         URozSwKi1fxyS5zzU4COJ+P+Bsem/69qULuxzbY7gZsNEb0fpFw8JP05nuT8RDAG6E2U
         9Y85RmoCaL2F3ikOAtOR9UFc2bKiHWfDabypOOurFUkcHRZ3UYqpdCMPh2AuH9wURi19
         NACw==
X-Gm-Message-State: AOAM530qEtmeKY9aMAy4QFfPgwOYbL876w0p8XRfeU1tNXlym5LPwrmc
        QNDmayeU2G+YdfievM/K6YAXBQ0ux70=
X-Google-Smtp-Source: ABdhPJwP2MXAoIo4mRq1njgWZqGcFLVJB8Hvs6aTKC3xWiPnMxROg6h0MyYwh/EDBjwTVzW8NpGqGQ==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id l15-20020a056a00140f00b004e069959c48mr1143118pfu.59.1650061851391;
        Fri, 15 Apr 2022 15:30:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t38-20020a634626000000b0039cc30b7c93sm5132594pga.82.2022.04.15.15.30.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 15:30:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 1/3] storage: Add support for STATE_DIRECTORY environment variable
Date:   Fri, 15 Apr 2022 15:30:47 -0700
Message-Id: <20220415223049.1155838-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When running as a systemd service the STATE_DIRECTORY environment
variable maybe set:

https://www.freedesktop.org/software/systemd/man/systemd.exec.html
---
 profiles/audio/a2dp.c |  10 ++--
 src/adapter.c         | 123 +++++++++++++++++++++---------------------
 src/device.c          |  57 ++++++++++----------
 src/storage.c         |  21 +++-----
 src/textfile.c        |  40 +++++++++++++-
 src/textfile.h        |   5 +-
 6 files changed, 147 insertions(+), 109 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 21b3faa47..6f5b13711 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -40,6 +40,7 @@
 #include "src/service.h"
 #include "src/log.h"
 #include "src/sdpd.h"
+#include "src/textfile.h"
 #include "src/shared/queue.h"
 #include "src/shared/timeout.h"
 #include "src/shared/util.h"
@@ -831,9 +832,10 @@ static void store_remote_seps(struct a2dp_channel *chan)
 
 	ba2str(device_get_address(device), dst_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+	create_filename(filename, PATH_MAX, "/%s/cache/%s",
 			btd_adapter_get_storage_dir(device_get_adapter(device)),
 			dst_addr);
+
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
@@ -1003,9 +1005,10 @@ static void store_last_used(struct a2dp_channel *chan, uint8_t lseid,
 
 	ba2str(device_get_address(chan->device), dst_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+	create_filename(filename, PATH_MAX, "/%s/cache/%s",
 		btd_adapter_get_storage_dir(device_get_adapter(chan->device)),
 		dst_addr);
+
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
@@ -2262,9 +2265,10 @@ static void load_remote_seps(struct a2dp_channel *chan)
 
 	ba2str(device_get_address(device), dst_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+	create_filename(filename, PATH_MAX, "/%s/cache/%s",
 			btd_adapter_get_storage_dir(device_get_adapter(device)),
 			dst_addr);
+
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
diff --git a/src/adapter.c b/src/adapter.c
index f1197684e..db2624c60 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -535,9 +535,8 @@ static void store_adapter_info(struct btd_adapter *adapter)
 		g_key_file_set_string(key_file, "General", "Alias",
 							adapter->stored_alias);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings",
+	create_filename(filename, PATH_MAX, "/%s/settings",
 					btd_adapter_get_storage_dir(adapter));
-
 	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
@@ -3982,7 +3981,7 @@ static int load_irk(struct btd_adapter *adapter, uint8_t *irk)
 	char *str_irk;
 	int ret;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/identity",
+	create_filename(filename, PATH_MAX, "/%s/identity",
 					btd_adapter_get_storage_dir(adapter));
 
 	key_file = g_key_file_new();
@@ -4653,8 +4652,8 @@ static void load_devices(struct btd_adapter *adapter)
 	DIR *dir;
 	struct dirent *entry;
 
-	snprintf(dirname, PATH_MAX, STORAGEDIR "/%s",
-					btd_adapter_get_storage_dir(adapter));
+	create_filename(dirname, PATH_MAX, "/%s",
+				btd_adapter_get_storage_dir(adapter));
 
 	dir = opendir(dirname);
 	if (!dir) {
@@ -4682,7 +4681,7 @@ static void load_devices(struct btd_adapter *adapter)
 		if (entry->d_type != DT_DIR || bachk(entry->d_name) < 0)
 			continue;
 
-		snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+		create_filename(filename, PATH_MAX, "/%s/%s/info",
 					btd_adapter_get_storage_dir(adapter),
 					entry->d_name);
 
@@ -5669,7 +5668,7 @@ static void convert_names_entry(char *key, char *value, void *user_data)
 	if (bachk(str) != 0)
 		return;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", address, str);
+	create_filename(filename, PATH_MAX, "/%s/cache/%s", address, str);
 	create_file(filename, 0600);
 
 	key_file = g_key_file_new();
@@ -5894,7 +5893,7 @@ static void convert_entry(char *key, char *value, void *user_data)
 		struct stat st;
 		int err;
 
-		snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s",
+		create_filename(filename, PATH_MAX, "/%s/%s",
 				converter->address, key);
 
 		err = stat(filename, &st);
@@ -5902,7 +5901,7 @@ static void convert_entry(char *key, char *value, void *user_data)
 			return;
 	}
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+	create_filename(filename, PATH_MAX, "/%s/%s/info",
 			converter->address, key);
 
 	key_file = g_key_file_new();
@@ -5938,7 +5937,7 @@ static void convert_file(char *file, char *address,
 	char filename[PATH_MAX];
 	struct device_converter converter;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", address, file);
+	create_filename(filename, PATH_MAX, "/%s/%s", address, file);
 
 	converter.address = address;
 	converter.cb = cb;
@@ -6009,7 +6008,7 @@ static void store_sdp_record(char *local, char *peer, int handle, char *value)
 	char *data;
 	gsize length = 0;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
+	create_filename(filename, PATH_MAX, "/%s/cache/%s", local, peer);
 
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
@@ -6066,7 +6065,7 @@ static void convert_sdp_entry(char *key, char *value, void *user_data)
 
 	/* Check if the device directory has been created as records should
 	 * only be converted for known devices */
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_addr);
+	create_filename(filename, PATH_MAX, "/%s/%s", src_addr, dst_addr);
 
 	err = stat(filename, &st);
 	if (err || !S_ISDIR(st.st_mode))
@@ -6092,7 +6091,7 @@ static void convert_sdp_entry(char *key, char *value, void *user_data)
 	if (!gatt_parse_record(rec, &uuid, &psm, &start, &end))
 		goto failed;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", src_addr,
+	create_filename(filename, PATH_MAX, "/%s/%s/attributes", src_addr,
 								dst_addr);
 
 	key_file = g_key_file_new();
@@ -6153,8 +6152,8 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	prim_uuid = bt_uuid2string(&uuid);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", address,
-									key);
+	create_filename(filename, PATH_MAX, "/%s/%s/attributes", address, key);
+
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
@@ -6193,7 +6192,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 	g_free(data);
 	g_key_file_free(key_file);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", address, key);
+	create_filename(filename, PATH_MAX, "/%s/%s/info", address, key);
 
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
@@ -6243,14 +6242,14 @@ static void convert_ccc_entry(char *key, char *value, void *user_data)
 
 	/* Check if the device directory has been created as records should
 	 * only be converted for known devices */
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_addr);
+	create_filename(filename, PATH_MAX, "/%s/%s", src_addr, dst_addr);
 
 	err = stat(filename, &st);
 	if (err || !S_ISDIR(st.st_mode))
 		return;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/ccc", src_addr,
-								dst_addr);
+	create_filename(filename, PATH_MAX, "/%s/%s/ccc", src_addr, dst_addr);
+
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
@@ -6299,14 +6298,14 @@ static void convert_gatt_entry(char *key, char *value, void *user_data)
 
 	/* Check if the device directory has been created as records should
 	 * only be converted for known devices */
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, dst_addr);
+	create_filename(filename, PATH_MAX, "/%s/%s", src_addr, dst_addr);
 
 	err = stat(filename, &st);
 	if (err || !S_ISDIR(st.st_mode))
 		return;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/gatt", src_addr,
-								dst_addr);
+	create_filename(filename, PATH_MAX, "/%s/%s/gatt", src_addr, dst_addr);
+
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
@@ -6354,14 +6353,14 @@ static void convert_proximity_entry(char *key, char *value, void *user_data)
 
 	/* Check if the device directory has been created as records should
 	 * only be converted for known devices */
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", src_addr, key);
+	create_filename(filename, PATH_MAX, "/%s/%s", src_addr, key);
 
 	err = stat(filename, &st);
 	if (err || !S_ISDIR(st.st_mode))
 		return;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/proximity", src_addr,
-									key);
+	create_filename(filename, PATH_MAX, "/%s/%s/proximity", src_addr, key);
+
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
@@ -6393,7 +6392,7 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	ba2str(&adapter->bdaddr, address);
 
 	/* Convert device's name cache */
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/names", address);
+	create_filename(filename, PATH_MAX, "/%s/names", address);
 	textfile_foreach(filename, convert_names_entry, address);
 
 	/* Convert aliases */
@@ -6409,7 +6408,7 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	convert_file("profiles", address, convert_profiles_entry, TRUE);
 
 	/* Convert primaries */
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/primaries", address);
+	create_filename(filename, PATH_MAX, "/%s/primaries", address);
 	textfile_foreach(filename, convert_primaries_entry, address);
 
 	/* Convert linkkeys */
@@ -6425,22 +6424,22 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	convert_file("did", address, convert_did_entry, FALSE);
 
 	/* Convert sdp */
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/sdp", address);
+	create_filename(filename, PATH_MAX, "/%s/sdp", address);
 	textfile_foreach(filename, convert_sdp_entry, address);
 
 	/* Convert ccc */
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/ccc", address);
+	create_filename(filename, PATH_MAX, "/%s/ccc", address);
 	textfile_foreach(filename, convert_ccc_entry, address);
 
 	/* Convert appearances */
 	convert_file("appearances", address, convert_appearances_entry, FALSE);
 
 	/* Convert gatt */
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/gatt", address);
+	create_filename(filename, PATH_MAX, "/%s/gatt", address);
 	textfile_foreach(filename, convert_gatt_entry, address);
 
 	/* Convert proximity */
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/proximity", address);
+	create_filename(filename, PATH_MAX, "/%s/proximity", address);
 	textfile_foreach(filename, convert_proximity_entry, address);
 }
 
@@ -6457,7 +6456,7 @@ static void convert_config(struct btd_adapter *adapter, const char *filename,
 	GError *gerr = NULL;
 
 	ba2str(&adapter->bdaddr, address);
-	snprintf(config_path, PATH_MAX, STORAGEDIR "/%s/config", address);
+	create_filename(config_path, PATH_MAX, "/%s/config", address);
 
 	if (read_pairable_timeout(address, &timeout) == 0)
 		g_key_file_set_integer(key_file, "General",
@@ -6495,7 +6494,8 @@ static void fix_storage(struct btd_adapter *adapter)
 
 	ba2str(&adapter->bdaddr, address);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/config", address);
+	create_filename(filename, PATH_MAX, "/%s/config", address);
+
 	converted = textfile_get(filename, "converted");
 	if (!converted)
 		return;
@@ -6504,49 +6504,49 @@ static void fix_storage(struct btd_adapter *adapter)
 
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/names", address);
+	create_filename(filename, PATH_MAX, "/%s/names", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/aliases", address);
+	create_filename(filename, PATH_MAX, "/%s/aliases", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/trusts", address);
+	create_filename(filename, PATH_MAX, "/%s/trusts", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/blocked", address);
+	create_filename(filename, PATH_MAX, "/%s/blocked", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/profiles", address);
+	create_filename(filename, PATH_MAX, "/%s/profiles", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/primaries", address);
+	create_filename(filename, PATH_MAX, "/%s/primaries", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/linkkeys", address);
+	create_filename(filename, PATH_MAX, "/%s/linkkeys", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/longtermkeys", address);
+	create_filename(filename, PATH_MAX, "/%s/longtermkeys", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/classes", address);
+	create_filename(filename, PATH_MAX, "/%s/classes", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/did", address);
+	create_filename(filename, PATH_MAX, "/%s/did", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/sdp", address);
+	create_filename(filename, PATH_MAX, "/%s/sdp", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/ccc", address);
+	create_filename(filename, PATH_MAX, "/%s/ccc", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/appearances", address);
+	create_filename(filename, PATH_MAX, "/%s/appearances", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/gatt", address);
+	create_filename(filename, PATH_MAX, "/%s/gatt", address);
 	textfile_del(filename, "converted");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/proximity", address);
+	create_filename(filename, PATH_MAX, "/%s/proximity", address);
 	textfile_del(filename, "converted");
 }
 
@@ -6559,7 +6559,7 @@ static void load_config(struct btd_adapter *adapter)
 
 	key_file = g_key_file_new();
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings",
+	create_filename(filename, PATH_MAX, "/%s/settings",
 					btd_adapter_get_storage_dir(adapter));
 
 	if (stat(filename, &st) < 0) {
@@ -8226,7 +8226,7 @@ static void store_link_key(struct btd_adapter *adapter,
 
 	ba2str(device_get_address(device), device_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+	create_filename(filename, PATH_MAX, "/%s/%s/info",
 			btd_adapter_get_storage_dir(adapter), device_addr);
 	create_file(filename, 0600);
 
@@ -8321,7 +8321,7 @@ static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
 
 	ba2str(peer, device_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+	create_filename(filename, PATH_MAX, "/%s/%s/info",
 			btd_adapter_get_storage_dir(adapter), device_addr);
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
@@ -8486,7 +8486,7 @@ static void store_csrk(struct btd_adapter *adapter, const bdaddr_t *peer,
 
 	ba2str(peer, device_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+	create_filename(filename, PATH_MAX, "/%s/%s/info",
 			btd_adapter_get_storage_dir(adapter), device_addr);
 
 	key_file = g_key_file_new();
@@ -8566,7 +8566,7 @@ static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
 
 	ba2str(peer, device_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+	create_filename(filename, PATH_MAX, "/%s/%s/info",
 			btd_adapter_get_storage_dir(adapter), device_addr);
 	create_file(filename, 0600);
 
@@ -8665,7 +8665,7 @@ static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
 
 	DBG("");
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+	create_filename(filename, PATH_MAX, "/%s/%s/info",
 			btd_adapter_get_storage_dir(adapter), device_addr);
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
@@ -9324,8 +9324,9 @@ static void remove_keys(struct btd_adapter *adapter,
 
 	ba2str(device_get_address(device), device_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+	create_filename(filename, PATH_MAX, "/%s/%s/info",
 			btd_adapter_get_storage_dir(adapter), device_addr);
+
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
@@ -9419,6 +9420,7 @@ static bool get_static_addr(struct btd_adapter *adapter)
 	struct bt_crypto *crypto;
 	GKeyFile *file;
 	GError *gerr = NULL;
+	char filename[PATH_MAX];
 	char **addrs;
 	char mfg[7];
 	char *str;
@@ -9427,11 +9429,12 @@ static bool get_static_addr(struct btd_adapter *adapter)
 
 	snprintf(mfg, sizeof(mfg), "0x%04x", adapter->manufacturer);
 
+	create_filename(filename, PATH_MAX, "/addresses");
+
 	file = g_key_file_new();
-	if (!g_key_file_load_from_file(file, STORAGEDIR "/addresses", 0,
-								&gerr)) {
+	if (!g_key_file_load_from_file(file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)",
-					STORAGEDIR "/addresses", gerr->message);
+					filename, gerr->message);
 		g_clear_error(&gerr);
 	}
 	addrs = g_key_file_get_string_list(file, "Static", mfg, &len, NULL);
@@ -9487,9 +9490,9 @@ static bool get_static_addr(struct btd_adapter *adapter)
 						(const char **)addrs, len);
 
 	str = g_key_file_to_data(file, &len, NULL);
-	if (!g_file_set_contents(STORAGEDIR "/addresses", str, len, &gerr)) {
+	if (!g_file_set_contents(filename, str, len, &gerr)) {
 		error("Unable set contents for %s: (%s)",
-					STORAGEDIR "/addresses", gerr->message);
+					filename, gerr->message);
 		g_error_free(gerr);
 	}
 	g_free(str);
diff --git a/src/device.c b/src/device.c
index 8dc12d026..38f4993f2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -392,7 +392,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 	device->store_id = 0;
 
 	ba2str(&device->bdaddr, device_addr);
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+	create_filename(filename, PATH_MAX, "/%s/%s/info",
 				btd_adapter_get_storage_dir(device->adapter),
 				device_addr);
 	create_file(filename, 0600);
@@ -535,7 +535,7 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
 	}
 
 	ba2str(&dev->bdaddr, d_addr);
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+	create_filename(filename, PATH_MAX, "/%s/cache/%s",
 			btd_adapter_get_storage_dir(dev->adapter), d_addr);
 	create_file(filename, 0600);
 
@@ -584,7 +584,7 @@ static void device_store_cached_name_resolve(struct btd_device *dev)
 	}
 
 	ba2str(&dev->bdaddr, d_addr);
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+	create_filename(filename, PATH_MAX, "/%s/cache/%s",
 			btd_adapter_get_storage_dir(dev->adapter), d_addr);
 	create_file(filename, 0600);
 
@@ -2428,7 +2428,7 @@ static void store_services(struct btd_device *device)
 
 	ba2str(&device->bdaddr, dst_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes",
+	create_filename(filename, PATH_MAX, "/%s/%s/attributes",
 				btd_adapter_get_storage_dir(device->adapter),
 				dst_addr);
 	key_file = g_key_file_new();
@@ -2657,7 +2657,7 @@ static void store_gatt_db(struct btd_device *device)
 
 	ba2str(&device->bdaddr, dst_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+	create_filename(filename, PATH_MAX, "/%s/cache/%s",
 				btd_adapter_get_storage_dir(device->adapter),
 				dst_addr);
 	create_file(filename, 0600);
@@ -3357,7 +3357,7 @@ static char *load_cached_name(struct btd_device *device, const char *local,
 	if (device_address_is_private(device))
 		return NULL;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
+	create_filename(filename, PATH_MAX, "/%s/cache/%s", local, peer);
 
 	key_file = g_key_file_new();
 
@@ -3387,7 +3387,7 @@ static void load_cached_name_resolve(struct btd_device *device,
 	if (device_address_is_private(device))
 		return;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
+	create_filename(filename, PATH_MAX, "/%s/cache/%s", local, peer);
 
 	key_file = g_key_file_new();
 
@@ -3483,7 +3483,7 @@ static void convert_info(struct btd_device *device, GKeyFile *key_file)
 
 	ba2str(btd_adapter_get_address(device->adapter), adapter_addr);
 	ba2str(&device->bdaddr, device_addr);
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
+	create_filename(filename, PATH_MAX, "/%s/%s/info", adapter_addr,
 			device_addr);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
@@ -3646,8 +3646,7 @@ static void load_att_info(struct btd_device *device, const char *local,
 	char tmp[3];
 	int i;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", local,
-			peer);
+	create_filename(filename, PATH_MAX, "/%s/%s/attributes", local, peer);
 
 	/* Check if attributes file exists */
 	if (stat(filename, &st) < 0)
@@ -4044,7 +4043,7 @@ static void load_gatt_db(struct btd_device *device, const char *local,
 
 	DBG("Restoring %s gatt database from file", peer);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
+	create_filename(filename, PATH_MAX, "/%s/cache/%s", local, peer);
 
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
@@ -4443,9 +4442,9 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	return device;
 }
 
-char *btd_device_get_storage_path(struct btd_device *device,
-				const char *filename)
+char *btd_device_get_storage_path(struct btd_device *device, const char *name)
 {
+	char filename[PATH_MAX];
 	char dstaddr[18];
 
 	if (device_address_is_private(device)) {
@@ -4456,14 +4455,16 @@ char *btd_device_get_storage_path(struct btd_device *device,
 
 	ba2str(&device->bdaddr, dstaddr);
 
-	if (!filename)
-		return g_strdup_printf(STORAGEDIR "/%s/%s",
+	if (!name)
+		create_filename(filename, PATH_MAX, "/%s/%s",
 				btd_adapter_get_storage_dir(device->adapter),
 				dstaddr);
-
-	return g_strdup_printf(STORAGEDIR "/%s/%s/%s",
+	else
+		create_filename(filename, PATH_MAX, "/%s/%s/%s",
 				btd_adapter_get_storage_dir(device->adapter),
-				dstaddr, filename);
+				dstaddr, name);
+
+	return strdup(filename);
 }
 
 void btd_device_device_set_name(struct btd_device *device, const char *name)
@@ -4704,7 +4705,8 @@ static void delete_folder_tree(const char *dirname)
 		if (entry->d_type == DT_UNKNOWN)
 			entry->d_type = util_get_dt(dirname, entry->d_name);
 
-		snprintf(filename, PATH_MAX, "%s/%s", dirname, entry->d_name);
+		create_filename(filename, PATH_MAX, "%s/%s", dirname,
+				entry->d_name);
 
 		if (entry->d_type == DT_DIR)
 			delete_folder_tree(filename);
@@ -4753,12 +4755,12 @@ static void device_remove_stored(struct btd_device *device)
 
 	ba2str(&device->bdaddr, device_addr);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s",
+	create_filename(filename, PATH_MAX, "/%s/%s",
 				btd_adapter_get_storage_dir(device->adapter),
 				device_addr);
 	delete_folder_tree(filename);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+	create_filename(filename, PATH_MAX, "/%s/cache/%s",
 				btd_adapter_get_storage_dir(device->adapter),
 				device_addr);
 
@@ -5165,8 +5167,7 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 	ba2str(btd_adapter_get_address(device->adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
-	snprintf(sdp_file, PATH_MAX, STORAGEDIR "/%s/cache/%s", srcaddr,
-								dstaddr);
+	create_filename(sdp_file, PATH_MAX, "/%s/cache/%s", srcaddr, dstaddr);
 	create_file(sdp_file, 0600);
 
 	sdp_key_file = g_key_file_new();
@@ -5178,8 +5179,8 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 		sdp_key_file = NULL;
 	}
 
-	snprintf(att_file, PATH_MAX, STORAGEDIR "/%s/%s/attributes", srcaddr,
-								dstaddr);
+	create_filename(att_file, PATH_MAX, "/%s/%s/attributes", srcaddr,
+							dstaddr);
 	create_file(att_file, 0600);
 
 	att_key_file = g_key_file_new();
@@ -6155,7 +6156,7 @@ void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
 	char *str;
 
 	ba2str(&device->bdaddr, device_addr);
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+	create_filename(filename, PATH_MAX, "/%s/%s/info",
 				btd_adapter_get_storage_dir(device->adapter),
 				device_addr);
 
@@ -6209,7 +6210,7 @@ void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
 	GError *gerr = NULL;
 
 	ba2str(&device->bdaddr, device_addr);
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
+	create_filename(filename, PATH_MAX, "/%s/%s/info",
 				btd_adapter_get_storage_dir(device->adapter),
 				device_addr);
 
@@ -7069,7 +7070,7 @@ static sdp_list_t *read_device_records(struct btd_device *device)
 	ba2str(btd_adapter_get_address(device->adapter), local);
 	ba2str(&device->bdaddr, peer);
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
+	create_filename(filename, PATH_MAX, "/%s/cache/%s", local, peer);
 
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
diff --git a/src/storage.c b/src/storage.c
index d819c2c1e..6e69be978 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -43,21 +43,11 @@ struct match {
 	char *pattern;
 };
 
-static inline int create_filename(char *buf, size_t size,
-				const bdaddr_t *bdaddr, const char *name)
-{
-	char addr[18];
-
-	ba2str(bdaddr, addr);
-
-	return create_name(buf, size, STORAGEDIR, addr, name);
-}
-
 int read_discoverable_timeout(const char *src, int *timeout)
 {
 	char filename[PATH_MAX], *str;
 
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
+	create_name(filename, PATH_MAX, src, "config");
 
 	str = textfile_get(filename, "discovto");
 	if (!str)
@@ -77,7 +67,7 @@ int read_pairable_timeout(const char *src, int *timeout)
 {
 	char filename[PATH_MAX], *str;
 
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
+	create_name(filename, PATH_MAX, src, "config");
 
 	str = textfile_get(filename, "pairto");
 	if (!str)
@@ -97,7 +87,7 @@ int read_on_mode(const char *src, char *mode, int length)
 {
 	char filename[PATH_MAX], *str;
 
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
+	create_name(filename, PATH_MAX, src, "config");
 
 	str = textfile_get(filename, "onmode");
 	if (!str)
@@ -115,8 +105,11 @@ int read_local_name(const bdaddr_t *bdaddr, char *name)
 {
 	char filename[PATH_MAX], *str;
 	int len;
+	char addr[18];
 
-	create_filename(filename, PATH_MAX, bdaddr, "config");
+	ba2str(bdaddr, addr);
+
+	create_filename(filename, PATH_MAX, "/%s/config", addr);
 
 	str = textfile_get(filename, "name");
 	if (!str)
diff --git a/src/textfile.c b/src/textfile.c
index 8c8d509b4..dcc00c7b1 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -19,6 +19,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <string.h>
 #include <sys/file.h>
 #include <sys/stat.h>
@@ -27,6 +28,41 @@
 
 #include "textfile.h"
 
+int create_filename(char *str, size_t size, const char *fmt, ...)
+{
+	static const char *prefix;
+	static int prefix_len;
+	char suffix[PATH_MAX];
+	va_list ap;
+	int err;
+
+	if (!prefix) {
+		const char *statedir = getenv("STATE_DIRECTORY");
+
+		/* Check if running as service */
+		if (statedir) {
+			prefix = statedir;
+
+			/* Check if there multiple paths given */
+			prefix_len = strstr(prefix, ":") - prefix;
+			if (prefix_len < 0)
+				prefix_len = strlen(prefix);
+		} else {
+			prefix = STORAGEDIR;
+			prefix_len = strlen(prefix);
+		}
+	}
+
+	va_start(ap, fmt);
+	err = vsnprintf(suffix, sizeof(suffix), fmt, ap);
+	va_end(ap);
+
+	if (err < 0)
+		return err;
+
+	return snprintf(str, size, "%*s%s", prefix_len, prefix, suffix);
+}
+
 static int create_dirs(const char *filename, const mode_t mode)
 {
 	struct stat st;
@@ -76,9 +112,9 @@ int create_file(const char *filename, const mode_t mode)
 	return 0;
 }
 
-int create_name(char *buf, size_t size, const char *path, const char *address, const char *name)
+int create_name(char *buf, size_t size, const char *address, const char *name)
 {
-	return snprintf(buf, size, "%s/%s/%s", path, address, name);
+	return create_filename(buf, size, "/%s/%s", address, name);
 }
 
 static inline char *find_key(char *map, size_t size, const char *key, size_t len, int icase)
diff --git a/src/textfile.h b/src/textfile.h
index b4e2e0248..4ecd5ed98 100644
--- a/src/textfile.h
+++ b/src/textfile.h
@@ -8,9 +8,10 @@
  *
  */
 
+int create_filename(char *str, size_t size, const char *fmt, ...)
+					__attribute__((format(printf, 3, 4)));
 int create_file(const char *filename, const mode_t mode);
-int create_name(char *buf, size_t size, const char *path,
-				const char *address, const char *name);
+int create_name(char *buf, size_t size, const char *address, const char *name);
 
 int textfile_put(const char *pathname, const char *key, const char *value);
 int textfile_del(const char *pathname, const char *key);
-- 
2.35.1

