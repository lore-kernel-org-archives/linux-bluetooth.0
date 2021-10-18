Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CBEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9366108E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhJRRax (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbhJRRaw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 13:30:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A378C06161C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b14so1966706plg.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=66qpyWVaDfHQMre7XUhyu7h/GLvkZFvo7tsk/hPA1w0=;
        b=L+AOgePiQPHBcs9kYjsEeCmjK8w4Udc2zX7OPrVJU+hVuBItIIZxTx6Fc/XzCg3w6n
         PQ88u88l1dn/Vnu/tY8e5oMD997yGYslh1AOekdH3tuqiObnNSRc0QHLZDfq4HsXrYQV
         DA8cOgynllFbBgxbxCI6hoTPfBhQ/yjFXzLZJidWrosvDAa5yH9dzGedzVXNMNsPLfdT
         wFX7+YsXqbu5pEgsdJq/PRUlR91qE5rIPFOXlFT7It0Hn7DymKZg1D+9MltfLnIPRYZF
         3trSFfqiTXR0eYmeJsD+IWfKHcLRh8nfY6L6jYqwo09Kyu/p1YYmp82l+J87XiRC1mRz
         lidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=66qpyWVaDfHQMre7XUhyu7h/GLvkZFvo7tsk/hPA1w0=;
        b=K4XyTxD/h55yCiot33BwGuImlWPcqZTTcqF+7hAxGHYL3YwwA8C92d/UfyUEqMuQMp
         WKh0oMmPjoN5iKqnPHOcDwqVzOs+cfWBMJ3TmRvwKF3eYrCRuqihK+aOdTk0MFKCDYIY
         yrmZxidP6O0DdPXji8sEpjT2YcSUS+VjoqeiIhHgw9S53J1Lm0o3mTD9Wupt+VXg+/jW
         np/wVdGIyfQaWRryhSgFy1CsaiadGX9L4mVEyPnBu6gaXCRkOYuNopRnpsJ+k+I3ZI+j
         Hqf1yLORN9Q0/ADCGRJaYgppyA/lLR1NJN7T4UlSeBqiWZ6buJ5UDwHxM6vcNxa5iJop
         Va/A==
X-Gm-Message-State: AOAM531aKabZJJMTaEnAHdMdNG3fIidhYXW2gRnEzqyWOYAkBFGuNwcj
        1SjYyK9Pwb8Yn6wt4V1Q4XdcUSlBPDnDYQ==
X-Google-Smtp-Source: ABdhPJwGxkQULSbedEbS7OMaiTrXAKVSUFDpqCvcboHbBKSr8A3RgzmTeOBEn6tLaD2eP1XkpRCWpQ==
X-Received: by 2002:a17:90a:73ce:: with SMTP id n14mr188096pjk.215.1634578120385;
        Mon, 18 Oct 2021 10:28:40 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:a510:aebd:a4ae:453c])
        by smtp.gmail.com with ESMTPSA id fv9sm51156pjb.26.2021.10.18.10.28.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:28:39 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/9] device: Fix unchecked return value
Date:   Mon, 18 Oct 2021 10:28:25 -0700
Message-Id: <20211018172833.534191-2-hj.tedd.an@gmail.com>
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
 src/device.c | 141 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 119 insertions(+), 22 deletions(-)

diff --git a/src/device.c b/src/device.c
index ac83cdc9c..d5aae9576 100644
--- a/src/device.c
+++ b/src/device.c
@@ -379,6 +379,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char filename[PATH_MAX];
 	char device_addr[18];
 	char *str;
@@ -394,7 +395,11 @@ static gboolean store_device_info_cb(gpointer user_data)
 				device_addr);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	g_key_file_set_string(key_file, "General", "Name", device->name);
 
@@ -467,7 +472,12 @@ static gboolean store_device_info_cb(gpointer user_data)
 	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, str, length, NULL);
+	if (!g_file_set_contents(filename, str, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
+
 	g_free(str);
 
 	g_key_file_free(key_file);
@@ -509,6 +519,7 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
 	char filename[PATH_MAX];
 	char d_addr[18];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char *data;
 	char *data_old;
 	gsize length = 0;
@@ -526,16 +537,25 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
 	create_file(filename, 0600);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
+
 	data_old = g_key_file_to_data(key_file, &length_old, NULL);
 
 	g_key_file_set_string(key_file, "General", "Name", name);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 
-	if ((length != length_old) || (memcmp(data, data_old, length)))
-		g_file_set_contents(filename, data, length, NULL);
-
+	if ((length != length_old) || (memcmp(data, data_old, length))) {
+		if (!g_file_set_contents(filename, data, length, &gerr)) {
+			error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+			g_error_free(gerr);
+		}
+	}
 	g_free(data);
 	g_free(data_old);
 
@@ -2306,6 +2326,7 @@ static void store_services(struct btd_device *device)
 	uuid_t uuid;
 	char *prim_uuid;
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	GSList *l;
 	char *data;
 	gsize length = 0;
@@ -2363,7 +2384,11 @@ static void store_services(struct btd_device *device)
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
 
 	free(prim_uuid);
@@ -2532,6 +2557,7 @@ static void store_gatt_db(struct btd_device *device)
 	char filename[PATH_MAX];
 	char dst_addr[18];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char *data;
 	gsize length = 0;
 	struct gatt_saver saver;
@@ -2553,7 +2579,11 @@ static void store_gatt_db(struct btd_device *device)
 	create_file(filename, 0600);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	/* Remove current attributes since it might have changed */
 	g_key_file_remove_group(key_file, "Attributes", NULL);
@@ -2564,7 +2594,11 @@ static void store_gatt_db(struct btd_device *device)
 	gatt_db_foreach_service(device->db, NULL, store_service, &saver);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, data, length, NULL);
+	if (!g_file_set_contents(filename, data, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	g_free(data);
 	g_key_file_free(key_file);
@@ -3295,6 +3329,7 @@ static void convert_info(struct btd_device *device, GKeyFile *key_file)
 	char **uuids;
 	char *str;
 	gsize length = 0;
+	GError *gerr = NULL;
 
 	/* Load device profile list from legacy properties */
 	uuids = g_key_file_get_string_list(key_file, "General", "SDPServices",
@@ -3320,7 +3355,11 @@ static void convert_info(struct btd_device *device, GKeyFile *key_file)
 			device_addr);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, str, length, NULL);
+	if (!g_file_set_contents(filename, str, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(str);
 
 	store_device_info(device);
@@ -3466,6 +3505,7 @@ static void load_att_info(struct btd_device *device, const char *local,
 {
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char *prim_uuid, *str;
 	char **groups, **handle, *service_uuid;
 	struct gatt_primary *prim;
@@ -3480,7 +3520,11 @@ static void load_att_info(struct btd_device *device, const char *local,
 			peer);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	groups = g_key_file_get_groups(key_file, NULL);
 
 	for (handle = groups; *handle; handle++) {
@@ -3856,6 +3900,7 @@ static void load_gatt_db(struct btd_device *device, const char *local,
 {
 	char **keys, filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 
 	if (!gatt_cache_is_enabled(device))
 		return;
@@ -3865,7 +3910,11 @@ static void load_gatt_db(struct btd_device *device, const char *local,
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	keys = g_key_file_get_keys(key_file, "Attributes", NULL, NULL);
 
 	if (!keys) {
@@ -4516,6 +4565,7 @@ static void device_remove_stored(struct btd_device *device)
 	char device_addr[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char *data;
 	gsize length = 0;
 
@@ -4543,14 +4593,22 @@ static void device_remove_stored(struct btd_device *device)
 				device_addr);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_key_file_remove_group(key_file, "ServiceRecords", NULL);
 	g_key_file_remove_group(key_file, "Attributes", NULL);
 
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
@@ -4929,6 +4987,8 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 	char att_file[PATH_MAX];
 	GKeyFile *sdp_key_file;
 	GKeyFile *att_key_file;
+	GError *gerr = NULL;
+
 	char *data;
 	gsize length = 0;
 
@@ -4939,13 +4999,21 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 								dstaddr);
 
 	sdp_key_file = g_key_file_new();
-	g_key_file_load_from_file(sdp_key_file, sdp_file, 0, NULL);
+	if (!g_key_file_load_from_file(sdp_key_file, sdp_file, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", sdp_file,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	snprintf(att_file, PATH_MAX, STORAGEDIR "/%s/%s/attributes", srcaddr,
 								dstaddr);
 
 	att_key_file = g_key_file_new();
-	g_key_file_load_from_file(att_key_file, att_file, 0, NULL);
+	if (!g_key_file_load_from_file(att_key_file, att_file, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", att_file,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	for (seq = recs; seq; seq = seq->next) {
 		sdp_record_t *rec = (sdp_record_t *) seq->data;
@@ -5000,7 +5068,12 @@ next:
 		data = g_key_file_to_data(sdp_key_file, &length, NULL);
 		if (length > 0) {
 			create_file(sdp_file, 0600);
-			g_file_set_contents(sdp_file, data, length, NULL);
+			if (!g_file_set_contents(sdp_file, data, length,
+								&gerr)) {
+				error("Unable set contents for %s: (%s)",
+						sdp_file, gerr->message);
+				g_error_free(gerr);
+			}
 		}
 
 		g_free(data);
@@ -5011,7 +5084,12 @@ next:
 		data = g_key_file_to_data(att_key_file, &length, NULL);
 		if (length > 0) {
 			create_file(att_file, 0600);
-			g_file_set_contents(att_file, data, length, NULL);
+			if (!g_file_set_contents(att_file, data, length,
+								&gerr)) {
+				error("Unable set contents for %s: (%s)",
+						att_file, gerr->message);
+				g_error_free(gerr);
+			}
 		}
 
 		g_free(data);
@@ -5897,6 +5975,7 @@ void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
 	char filename[PATH_MAX];
 	char device_addr[18];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	uint16_t old_value;
 	gsize length = 0;
 	char *str;
@@ -5907,7 +5986,11 @@ void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
 				device_addr);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	/* for bonded devices this is done on every connection so limit writes
 	 * to storage if no change needed
@@ -5933,7 +6016,11 @@ void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
 	create_file(filename, 0600);
 
 	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, str, length, NULL);
+	if (!g_file_set_contents(filename, str, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	g_free(str);
 
 done:
@@ -5945,6 +6032,7 @@ void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
 	char filename[PATH_MAX];
 	char device_addr[18];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 
 	ba2str(&device->bdaddr, device_addr);
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
@@ -5952,7 +6040,11 @@ void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
 				device_addr);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	if (!g_key_file_has_group(key_file, "ServiceChanged")) {
 		if (ccc_le)
@@ -6794,6 +6886,7 @@ static sdp_list_t *read_device_records(struct btd_device *device)
 	char local[18], peer[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char **keys, **handle;
 	char *str;
 	sdp_list_t *recs = NULL;
@@ -6805,7 +6898,11 @@ static sdp_list_t *read_device_records(struct btd_device *device)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	keys = g_key_file_get_keys(key_file, "ServiceRecords", NULL, NULL);
 
 	for (handle = keys; handle && *handle; handle++) {
-- 
2.25.1

