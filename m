Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05941C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2DCA610C7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhJRRay (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhJRRax (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 13:30:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A19DC06161C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v8so11128850pfu.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HNTn4H7mPsMVJx8sgRyETT/uP9qbRFkoaroKQHhYKh8=;
        b=bigAvK8/VFpzubCIx0/yoek6jtif8sgSRHKaLZO6FZNd7SMODwMw3wjjr6VIevc7x/
         SWj5bPsCal1afF4nnS7Tayo5OTQfs+X/7jHzVWqGSXjeN7aH4kU0NuRSIlOj8UuQZxEt
         MH7gaRCjlbs6wpR9Uqei001t0AYm5ibriuz5yJavFvjldEH1f+ltUZu0ilsIW9rW8SBv
         4/gDcaR3x1eUtGodhe6X+WlgNTijrCDpqoHGbGxQ/hybfoJW+kJ2f1isihB3+UwRkOMZ
         suBzKqHjw9Y5TW2k8mTfk6IJaXx6Z+uH/QejWck8p+PCw7CZqrCQBwayJFyWYKpr0qqO
         o/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNTn4H7mPsMVJx8sgRyETT/uP9qbRFkoaroKQHhYKh8=;
        b=RKIhUeSc5q8MxrYUEIbyEPLOuYD7Gw5iVygLVywFL6yidAn0eT7R/mx8TK5Ou2nuya
         63/+RPevSvUoYEDs/3YXf+fXwFyNy03wpd3feQPrCysUUxVEbLy8tAxKDIdu2XUsQH1f
         drOyNdi/SlXzQmieWleYOyr9xsKOcu3DjKWyxm006RnAAsX12Zix3yQ0Q4dmDpesYVcg
         qcmxhtLucm9P3wFL6MDWDGeMVoE/Z7leQi0TnixRBycVnxVx0PimZeQJjBLPogwqR0Tp
         myRaJBnpbbPxA6UWjA+w0YPJzWoVD557bnDtySEUGamznDJTGbGuv/wmExq4FSmznmDr
         6W0Q==
X-Gm-Message-State: AOAM533XjAI8DJrcQQCBfqlmJOSlmh5gVYdfI2uIWe4APCaroviMBYB3
        2VGEG2ZS1Id4E+LvtzlNk9LbMCRduix19w==
X-Google-Smtp-Source: ABdhPJy/CWHTEheoKt93AggNjp9BJFR/vz7do9Co/44Vwe5rJzyBiX1w0dOKJbwM2Gbum+no6lqZ/A==
X-Received: by 2002:a63:e041:: with SMTP id n1mr25178695pgj.211.1634578121181;
        Mon, 18 Oct 2021 10:28:41 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:a510:aebd:a4ae:453c])
        by smtp.gmail.com with ESMTPSA id fv9sm51156pjb.26.2021.10.18.10.28.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:28:40 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/9] adapter: Fix unchecked return value
Date:   Mon, 18 Oct 2021 10:28:26 -0700
Message-Id: <20211018172833.534191-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211018172833.534191-1-hj.tedd.an@gmail.com>
References: <20211018172833.534191-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the unchecked return value(CWE-252) issues reported by
the Coverity.
---
 src/adapter.c | 249 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 211 insertions(+), 38 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5846f0396..54b6322cc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -515,6 +515,7 @@ uint8_t btd_adapter_get_address_type(struct btd_adapter *adapter)
 static void store_adapter_info(struct btd_adapter *adapter)
 {
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char filename[PATH_MAX];
 	char *str;
 	gsize length = 0;
@@ -550,7 +551,11 @@ static void store_adapter_info(struct btd_adapter *adapter)
 	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, str, length, NULL);
+	if (!g_file_set_contents(filename, str, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(str);
 
 	g_key_file_free(key_file);
@@ -3933,6 +3938,7 @@ static int generate_and_write_irk(uint8_t *irk, GKeyFile *key_file,
 	struct bt_crypto *crypto;
 	char str_irk_out[33];
 	gsize length = 0;
+	GError *gerr = NULL;
 	char *str;
 	int i;
 
@@ -3959,7 +3965,11 @@ static int generate_and_write_irk(uint8_t *irk, GKeyFile *key_file,
 	g_key_file_set_string(key_file, "General", "IdentityResolvingKey",
 								str_irk_out);
 	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, str, length, NULL);
+	if (!g_file_set_contents(filename, str, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(str);
 	DBG("Generated IRK written to file");
 	return 0;
@@ -3969,6 +3979,7 @@ static int load_irk(struct btd_adapter *adapter, uint8_t *irk)
 {
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char *str_irk;
 	int ret;
 
@@ -3976,7 +3987,11 @@ static int load_irk(struct btd_adapter *adapter, uint8_t *irk)
 					btd_adapter_get_storage_dir(adapter));
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	str_irk = g_key_file_get_string(key_file, "General",
 						"IdentityResolvingKey", NULL);
@@ -4664,6 +4679,7 @@ static void load_devices(struct btd_adapter *adapter)
 	GSList *irks = NULL;
 	GSList *params = NULL;
 	GSList *added_devices = NULL;
+	GError *gerr = NULL;
 	DIR *dir;
 	struct dirent *entry;
 
@@ -4701,7 +4717,11 @@ static void load_devices(struct btd_adapter *adapter)
 					entry->d_name);
 
 		key_file = g_key_file_new();
-		g_key_file_load_from_file(key_file, filename, 0, NULL);
+		if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+			error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+			g_error_free(gerr);
+		}
 
 		key_info = get_key_info(key_file, entry->d_name);
 
@@ -5686,6 +5706,7 @@ static void convert_names_entry(char *key, char *value, void *user_data)
 	char *str = key;
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char *data;
 	gsize length = 0;
 
@@ -5699,11 +5720,19 @@ static void convert_names_entry(char *key, char *value, void *user_data)
 	create_file(filename, 0600);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_key_file_set_string(key_file, "General", "Name", value);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, data, length, NULL);
+	if (!g_file_set_contents(filename, data, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(data);
 
 	g_key_file_free(key_file);
@@ -5897,6 +5926,7 @@ static void convert_entry(char *key, char *value, void *user_data)
 	char type = BDADDR_BREDR;
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char *data;
 	gsize length = 0;
 
@@ -5924,7 +5954,11 @@ static void convert_entry(char *key, char *value, void *user_data)
 			converter->address, key);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	set_device_type(key_file, type);
 
@@ -5933,7 +5967,11 @@ static void convert_entry(char *key, char *value, void *user_data)
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
 		create_file(filename, 0600);
-		g_file_set_contents(filename, data, length, NULL);
+		if (!g_file_set_contents(filename, data, length, &gerr)) {
+			error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+			g_error_free(gerr);
+		}
 	}
 
 	g_free(data);
@@ -6014,6 +6052,7 @@ static void store_sdp_record(char *local, char *peer, int handle, char *value)
 {
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char handle_str[11];
 	char *data;
 	gsize length = 0;
@@ -6021,7 +6060,11 @@ static void store_sdp_record(char *local, char *peer, int handle, char *value)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	sprintf(handle_str, "0x%8.8X", handle);
 	g_key_file_set_string(key_file, "ServiceRecords", handle_str, value);
@@ -6029,7 +6072,11 @@ static void store_sdp_record(char *local, char *peer, int handle, char *value)
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
 		create_file(filename, 0600);
-		g_file_set_contents(filename, data, length, NULL);
+		if (!g_file_set_contents(filename, data, length, &gerr)) {
+			error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+			g_error_free(gerr);
+		}
 	}
 
 	g_free(data);
@@ -6045,6 +6092,7 @@ static void convert_sdp_entry(char *key, char *value, void *user_data)
 	int handle, ret;
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	struct stat st;
 	sdp_record_t *rec;
 	uuid_t uuid;
@@ -6096,14 +6144,22 @@ static void convert_sdp_entry(char *key, char *value, void *user_data)
 								dst_addr);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	store_attribute_uuid(key_file, start, end, prim_uuid, uuid);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
 		create_file(filename, 0600);
-		g_file_set_contents(filename, data, length, NULL);
+		if (!g_file_set_contents(filename, data, length, &gerr)) {
+			error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+			g_error_free(gerr);
+		}
 	}
 
 	g_free(data);
@@ -6123,6 +6179,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 	char **services, **service, *prim_uuid;
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	int ret;
 	uint16_t start, end;
 	char uuid_str[MAX_LEN_UUID_STR + 1];
@@ -6147,7 +6204,11 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", address,
 									key);
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	for (service = services; *service; service++) {
 		ret = sscanf(*service, "%04hX#%04hX#%s", &start, &end,
@@ -6168,7 +6229,11 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 		goto end;
 
 	create_file(filename, 0600);
-	g_file_set_contents(filename, data, length, NULL);
+	if (!g_file_set_contents(filename, data, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	if (device_type < 0)
 		goto end;
@@ -6179,13 +6244,21 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", address, key);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	set_device_type(key_file, device_type);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
 		create_file(filename, 0600);
-		g_file_set_contents(filename, data, length, NULL);
+		if (!g_file_set_contents(filename, data, length, &gerr)) {
+			error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+			g_error_free(gerr);
+		}
 	}
 
 end:
@@ -6203,6 +6276,7 @@ static void convert_ccc_entry(char *key, char *value, void *user_data)
 	int ret, err;
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	struct stat st;
 	char group[6];
 	char *data;
@@ -6226,7 +6300,11 @@ static void convert_ccc_entry(char *key, char *value, void *user_data)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/ccc", src_addr,
 								dst_addr);
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	sprintf(group, "%hu", handle);
 	g_key_file_set_string(key_file, group, "Value", value);
@@ -6234,7 +6312,11 @@ static void convert_ccc_entry(char *key, char *value, void *user_data)
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
 		create_file(filename, 0600);
-		g_file_set_contents(filename, data, length, NULL);
+		if (!g_file_set_contents(filename, data, length, &gerr)) {
+			error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+			g_error_free(gerr);
+		}
 	}
 
 	g_free(data);
@@ -6250,6 +6332,7 @@ static void convert_gatt_entry(char *key, char *value, void *user_data)
 	int ret, err;
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	struct stat st;
 	char group[6];
 	char *data;
@@ -6273,7 +6356,11 @@ static void convert_gatt_entry(char *key, char *value, void *user_data)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/gatt", src_addr,
 								dst_addr);
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	sprintf(group, "%hu", handle);
 	g_key_file_set_string(key_file, group, "Value", value);
@@ -6281,7 +6368,11 @@ static void convert_gatt_entry(char *key, char *value, void *user_data)
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
 		create_file(filename, 0600);
-		g_file_set_contents(filename, data, length, NULL);
+		if (!g_file_set_contents(filename, data, length, &gerr)) {
+			error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+			g_error_free(gerr);
+		}
 	}
 
 	g_free(data);
@@ -6294,6 +6385,7 @@ static void convert_proximity_entry(char *key, char *value, void *user_data)
 	char *alert;
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	struct stat st;
 	int err;
 	char *data;
@@ -6319,14 +6411,22 @@ static void convert_proximity_entry(char *key, char *value, void *user_data)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/proximity", src_addr,
 									key);
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	g_key_file_set_string(key_file, alert, "Level", value);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
 		create_file(filename, 0600);
-		g_file_set_contents(filename, data, length, NULL);
+		if (!g_file_set_contents(filename, data, length, &gerr)) {
+			error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+			g_error_free(gerr);
+		}
 	}
 
 	g_free(data);
@@ -6402,6 +6502,7 @@ static void convert_config(struct btd_adapter *adapter, const char *filename,
 	uint8_t mode;
 	char *data;
 	gsize length = 0;
+	GError *gerr = NULL;
 
 	ba2str(&adapter->bdaddr, address);
 	snprintf(config_path, PATH_MAX, STORAGEDIR "/%s/config", address);
@@ -6426,7 +6527,11 @@ static void convert_config(struct btd_adapter *adapter, const char *filename,
 	create_file(filename, 0600);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, data, length, NULL);
+	if (!g_file_set_contents(filename, data, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(data);
 }
 
@@ -6510,7 +6615,11 @@ static void load_config(struct btd_adapter *adapter)
 		convert_device_storage(adapter);
 	}
 
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	/* Get alias */
 	adapter->stored_alias = g_key_file_get_string(key_file, "General",
@@ -8222,6 +8331,7 @@ static void store_link_key(struct btd_adapter *adapter,
 	char device_addr[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	gsize length = 0;
 	char key_str[33];
 	char *str;
@@ -8232,7 +8342,11 @@ static void store_link_key(struct btd_adapter *adapter,
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
 			btd_adapter_get_storage_dir(adapter), device_addr);
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	for (i = 0; i < 16; i++)
 		sprintf(key_str + (i * 2), "%2.2X", key[i]);
@@ -8245,7 +8359,11 @@ static void store_link_key(struct btd_adapter *adapter,
 	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, str, length, NULL);
+	if (!g_file_set_contents(filename, str, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(str);
 
 	g_key_file_free(key_file);
@@ -8307,6 +8425,7 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 	char device_addr[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char key_str[33];
 	gsize length = 0;
 	char *str;
@@ -8322,7 +8441,11 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
 			btd_adapter_get_storage_dir(adapter), device_addr);
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	/* Old files may contain this so remove it in case it exists */
 	g_key_file_remove_key(key_file, "LongTermKey", "Master", NULL);
@@ -8342,7 +8465,11 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, str, length, NULL);
+	if (!g_file_set_contents(filename, str, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(str);
 
 	g_key_file_free(key_file);
@@ -8420,6 +8547,7 @@ static void store_csrk(struct btd_adapter *adapter, const bdaddr_t *peer,
 	char device_addr[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char key_str[33];
 	gsize length = 0;
 	gboolean auth;
@@ -8454,7 +8582,11 @@ static void store_csrk(struct btd_adapter *adapter, const bdaddr_t *peer,
 			btd_adapter_get_storage_dir(adapter), device_addr);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	for (i = 0; i < 16; i++)
 		sprintf(key_str + (i * 2), "%2.2X", key[i]);
@@ -8466,7 +8598,11 @@ static void store_csrk(struct btd_adapter *adapter, const bdaddr_t *peer,
 	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, str, length, NULL);
+	if (!g_file_set_contents(filename, str, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(str);
 
 	g_key_file_free(key_file);
@@ -8514,6 +8650,7 @@ static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
 	char device_addr[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char *store_data;
 	char str[33];
 	size_t length = 0;
@@ -8524,7 +8661,11 @@ static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
 			btd_adapter_get_storage_dir(adapter), device_addr);
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	for (i = 0; i < 16; i++)
 		sprintf(str + (i * 2), "%2.2X", key[i]);
@@ -8534,7 +8675,11 @@ static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
 	create_file(filename, 0600);
 
 	store_data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, store_data, length, NULL);
+	if (!g_file_set_contents(filename, store_data, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(store_data);
 
 	g_key_file_free(key_file);
@@ -8602,6 +8747,7 @@ static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
 	char device_addr[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char *store_data;
 	size_t length = 0;
 
@@ -8612,7 +8758,11 @@ static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
 			btd_adapter_get_storage_dir(adapter), device_addr);
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	g_key_file_set_integer(key_file, "ConnectionParameters",
 						"MinInterval", min_interval);
@@ -8626,7 +8776,11 @@ static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
 	create_file(filename, 0600);
 
 	store_data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, store_data, length, NULL);
+	if (!g_file_set_contents(filename, store_data, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(store_data);
 
 	g_key_file_free(key_file);
@@ -9254,6 +9408,7 @@ static void remove_keys(struct btd_adapter *adapter,
 	char device_addr[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	gsize length = 0;
 	char *str;
 
@@ -9262,7 +9417,11 @@ static void remove_keys(struct btd_adapter *adapter,
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
 			btd_adapter_get_storage_dir(adapter), device_addr);
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	if (type == BDADDR_BREDR) {
 		g_key_file_remove_group(key_file, "LinkKey", NULL);
@@ -9274,7 +9433,11 @@ static void remove_keys(struct btd_adapter *adapter,
 	}
 
 	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, str, length, NULL);
+	if (!g_file_set_contents(filename, str, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(str);
 
 	g_key_file_free(key_file);
@@ -9345,6 +9508,7 @@ static bool get_static_addr(struct btd_adapter *adapter)
 {
 	struct bt_crypto *crypto;
 	GKeyFile *file;
+	GError *gerr = NULL;
 	char **addrs;
 	char mfg[7];
 	char *str;
@@ -9354,7 +9518,12 @@ static bool get_static_addr(struct btd_adapter *adapter)
 	snprintf(mfg, sizeof(mfg), "0x%04x", adapter->manufacturer);
 
 	file = g_key_file_new();
-	g_key_file_load_from_file(file, STORAGEDIR "/addresses", 0, NULL);
+	if (!g_key_file_load_from_file(file, STORAGEDIR "/addresses", 0,
+								&gerr)) {
+		error("Unable to load key file from %s: (%s)",
+					STORAGEDIR "/addresses", gerr->message);
+		g_error_free(gerr);
+	}
 	addrs = g_key_file_get_string_list(file, "Static", mfg, &len, NULL);
 	if (addrs) {
 		for (i = 0; i < len; i++) {
@@ -9408,7 +9577,11 @@ static bool get_static_addr(struct btd_adapter *adapter)
 						(const char **)addrs, len);
 
 	str = g_key_file_to_data(file, &len, NULL);
-	g_file_set_contents(STORAGEDIR "/addresses", str, len, NULL);
+	if (!g_file_set_contents(STORAGEDIR "/addresses", str, len, &gerr)) {
+		error("Unable set contents for %s: (%s)",
+					STORAGEDIR "/addresses", gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(str);
 
 	ret = true;
-- 
2.25.1

