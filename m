Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25599C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C7A64E6B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhBWTEk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:04:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:19052 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233994AbhBWTEh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 14:04:37 -0500
IronPort-SDR: pxY8K5+07TkbF8P9ltGphQQOQZ7ul7Z7mo16WRq4OR4WIC3xHaoWx03agzF/SGxNxxieGgffN/
 6q403KxBmMqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="246335981"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="246335981"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:55 -0800
IronPort-SDR: gf518TuFCDqL34HUvj9GIuMT5wcvE6HXZwHvuUADbaLNK/dFhWmeVSLVHWoUdPP/o8FctDawLD
 xTEvxTYEOjfg==
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="432831112"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.105.235])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:54 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, luiz.dentz@gmail.com,
        tedd.an@linux.intel.com, marcel@holtmann.org
Subject: [PATCH BlueZ 5/6] src: Cleanup deprecated symbolic file permissions
Date:   Tue, 23 Feb 2021 11:02:51 -0800
Message-Id: <20210223190252.483784-6-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210223190252.483784-1-brian.gix@intel.com>
References: <20210223190252.483784-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/adapter.c        | 32 ++++++++++++++++----------------
 src/attrib-server.c  |  2 +-
 src/device.c         | 16 ++++++++--------
 src/sdpd-server.c    |  2 +-
 src/shared/btsnoop.c |  4 ++--
 src/textfile.c       |  2 +-
 6 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0b6321dd5..051c32753 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -502,7 +502,7 @@ static void store_adapter_info(struct btd_adapter *adapter)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings",
 					btd_adapter_get_storage_dir(adapter));
 
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, str, length, NULL);
@@ -5427,7 +5427,7 @@ static void convert_names_entry(char *key, char *value, void *user_data)
 		return;
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", address, str);
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
@@ -5663,7 +5663,7 @@ static void convert_entry(char *key, char *value, void *user_data)
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
-		create_file(filename, S_IRUSR | S_IWUSR);
+		create_file(filename, 0600);
 		g_file_set_contents(filename, data, length, NULL);
 	}
 
@@ -5759,7 +5759,7 @@ static void store_sdp_record(char *local, char *peer, int handle, char *value)
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
-		create_file(filename, S_IRUSR | S_IWUSR);
+		create_file(filename, 0600);
 		g_file_set_contents(filename, data, length, NULL);
 	}
 
@@ -5833,7 +5833,7 @@ static void convert_sdp_entry(char *key, char *value, void *user_data)
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
-		create_file(filename, S_IRUSR | S_IWUSR);
+		create_file(filename, 0600);
 		g_file_set_contents(filename, data, length, NULL);
 	}
 
@@ -5898,7 +5898,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 	if (length == 0)
 		goto end;
 
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 	g_file_set_contents(filename, data, length, NULL);
 
 	if (device_type < 0)
@@ -5915,7 +5915,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
-		create_file(filename, S_IRUSR | S_IWUSR);
+		create_file(filename, 0600);
 		g_file_set_contents(filename, data, length, NULL);
 	}
 
@@ -5964,7 +5964,7 @@ static void convert_ccc_entry(char *key, char *value, void *user_data)
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
-		create_file(filename, S_IRUSR | S_IWUSR);
+		create_file(filename, 0600);
 		g_file_set_contents(filename, data, length, NULL);
 	}
 
@@ -6011,7 +6011,7 @@ static void convert_gatt_entry(char *key, char *value, void *user_data)
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
-		create_file(filename, S_IRUSR | S_IWUSR);
+		create_file(filename, 0600);
 		g_file_set_contents(filename, data, length, NULL);
 	}
 
@@ -6056,7 +6056,7 @@ static void convert_proximity_entry(char *key, char *value, void *user_data)
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
-		create_file(filename, S_IRUSR | S_IWUSR);
+		create_file(filename, 0600);
 		g_file_set_contents(filename, data, length, NULL);
 	}
 
@@ -6154,7 +6154,7 @@ static void convert_config(struct btd_adapter *adapter, const char *filename,
 	if (read_local_name(&adapter->bdaddr, str) == 0)
 		g_key_file_set_string(key_file, "General", "Alias", str);
 
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, data, length, NULL);
@@ -7962,7 +7962,7 @@ static void store_link_key(struct btd_adapter *adapter,
 	g_key_file_set_integer(key_file, "LinkKey", "Type", type);
 	g_key_file_set_integer(key_file, "LinkKey", "PINLength", pin_length);
 
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, str, length, NULL);
@@ -8059,7 +8059,7 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 	g_key_file_set_integer(key_file, group, "EDiv", ediv);
 	g_key_file_set_uint64(key_file, group, "Rand", rand);
 
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, str, length, NULL);
@@ -8183,7 +8183,7 @@ static void store_csrk(struct btd_adapter *adapter, const bdaddr_t *peer,
 	g_key_file_set_integer(key_file, group, "Counter", counter);
 	g_key_file_set_boolean(key_file, group, "Authenticated", auth);
 
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, str, length, NULL);
@@ -8251,7 +8251,7 @@ static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
 
 	g_key_file_set_string(key_file, "IdentityResolvingKey", "Key", str);
 
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 
 	store_data = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, store_data, length, NULL);
@@ -8343,7 +8343,7 @@ static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
 	g_key_file_set_integer(key_file, "ConnectionParameters",
 						"Timeout", timeout);
 
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 
 	store_data = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, store_data, length, NULL);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 91a10b274..5a178f95e 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -919,7 +919,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 
 		data = g_key_file_to_data(key_file, &length, NULL);
 		if (length > 0) {
-			create_file(filename, S_IRUSR | S_IWUSR);
+			create_file(filename, 0600);
 			g_file_set_contents(filename, data, length, NULL);
 		}
 
diff --git a/src/device.c b/src/device.c
index af13badfc..dfba6ee47 100644
--- a/src/device.c
+++ b/src/device.c
@@ -463,7 +463,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 	if (device->remote_csrk)
 		store_csrk(device->remote_csrk, key_file, "RemoteSignatureKey");
 
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, str, length, NULL);
@@ -522,7 +522,7 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
 	ba2str(&dev->bdaddr, d_addr);
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
 			btd_adapter_get_storage_dir(dev->adapter), d_addr);
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
@@ -2290,7 +2290,7 @@ static void store_services(struct btd_device *device)
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
-		create_file(filename, S_IRUSR | S_IWUSR);
+		create_file(filename, 0600);
 		g_file_set_contents(filename, data, length, NULL);
 	}
 
@@ -2478,7 +2478,7 @@ static void store_gatt_db(struct btd_device *device)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
 				btd_adapter_get_storage_dir(device->adapter),
 				dst_addr);
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
@@ -4439,7 +4439,7 @@ static void device_remove_stored(struct btd_device *device)
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
-		create_file(filename, S_IRUSR | S_IWUSR);
+		create_file(filename, 0600);
 		g_file_set_contents(filename, data, length, NULL);
 	}
 
@@ -4889,7 +4889,7 @@ next:
 	if (sdp_key_file) {
 		data = g_key_file_to_data(sdp_key_file, &length, NULL);
 		if (length > 0) {
-			create_file(sdp_file, S_IRUSR | S_IWUSR);
+			create_file(sdp_file, 0600);
 			g_file_set_contents(sdp_file, data, length, NULL);
 		}
 
@@ -4900,7 +4900,7 @@ next:
 	if (att_key_file) {
 		data = g_key_file_to_data(att_key_file, &length, NULL);
 		if (length > 0) {
-			create_file(att_file, S_IRUSR | S_IWUSR);
+			create_file(att_file, 0600);
 			g_file_set_contents(att_file, data, length, NULL);
 		}
 
@@ -5807,7 +5807,7 @@ void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
 									value);
 	}
 
-	create_file(filename, S_IRUSR | S_IWUSR);
+	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
 	g_file_set_contents(filename, str, length, NULL);
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index dfd8b1f00..306b92a44 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -130,7 +130,7 @@ static int init_server(uint16_t mtu, int master, int compat)
 		return -1;
 	}
 
-	chmod(SDP_UNIX_PATH, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
+	chmod(SDP_UNIX_PATH, 0660);
 
 	return 0;
 }
diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index e2b3747e3..a29bc928f 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -151,7 +151,7 @@ struct btsnoop *btsnoop_create(const char *path, size_t max_size,
 	}
 
 	btsnoop->fd = open(real_path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,
-					S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+									0644);
 	if (btsnoop->fd < 0) {
 		free(btsnoop);
 		return NULL;
@@ -230,7 +230,7 @@ static bool btsnoop_rotate(struct btsnoop *btsnoop)
 	btsnoop->cur_count++;
 
 	btsnoop->fd = open(path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,
-					S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+									0644);
 	if (btsnoop->fd < 0)
 		return false;
 
diff --git a/src/textfile.c b/src/textfile.c
index 7dd62392b..8c8d509b4 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -65,7 +65,7 @@ int create_file(const char *filename, const mode_t mode)
 {
 	int fd;
 
-	create_dirs(filename, S_IRUSR | S_IWUSR | S_IXUSR);
+	create_dirs(filename, 0700);
 
 	fd = open(filename, O_RDWR | O_CREAT, mode);
 	if (fd < 0)
-- 
2.25.4

