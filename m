Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8564CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 00:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbiBKASo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 19:18:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242748AbiBKASm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 19:18:42 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198A9105
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:18:43 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w20so3273636plq.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4c4lSDhQw9gBes/CzLEVSAVialIXB+yXKGpThtYQ4/Q=;
        b=od3icoPD5v7g/2X9SiztzSzj9wBjCKDL0Idt8v5c4N8gZRX3NoZKZ53+h8RtYLhr1m
         wKAq0e3Qm7b+BvEP3Dveb14mkF+02/GilKeYsz56403ginkJfi3nP2ULVA6yKytMJOfZ
         x5KjTM5EDKlMVLEXJC7bcO3umPcv2DjwinyMSDHNU55Fx5qehENWTn2vKq9ZaXjUJTQl
         nb/IuYAlvRb+lBL83XnB9YxCEGDROC8bvc9qx+VmXLmTx/TLKkdpolaWPb8g1p240Rjs
         zJIlSjJYl1M6L8gaEjrwXSCAnCvEuPTt6R6/BEzLr+ZDBYt/1OJoo4omyz2IqQPGPdXX
         Z/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4c4lSDhQw9gBes/CzLEVSAVialIXB+yXKGpThtYQ4/Q=;
        b=UX+Tcom3JJFCJiiFHO2u55i+U1QUfSlOeTy2/jC5AHmd7B9seZi9lk9NRCWQoIk4jB
         yOSwyWMJXVj3KV6XASVDra1PR7ooXU7mVxWy0k+zkg3A9wwbr6hwZIw5GpQRdSZWEBmo
         jKaihbKSU688We8zp+Z5CzaFdDKq6zdZtMtmyNEyDuPH0oOcLvAO6NWBk++iU9pgSI+B
         aMfIob9cs601IECqBsNgIOSI4nURwAbMev8/jIbW8wxJcWBhzVRam0b2PUsFbMgI2cSQ
         xTpIJNrZ4BF6YMbuKIkgvpvaOX4il2GRjiLI+7aHcNFK5qe7sKme1fjcbM7vs+npmrP3
         gp6Q==
X-Gm-Message-State: AOAM530kuEw7KWuGtqYdEBbXD0jDxUIJgWK+ePLDytE2m0vlh8iMvgNL
        uCvhO0/JfmFfbVEB64oMPeMqOgUwUiY=
X-Google-Smtp-Source: ABdhPJwld8UvH0+rhl6LKNEUr2xPJmFw7V/kuZKpUx12iV3sGIFSDLMufdvYuJrrv8NovGABEXXdmQ==
X-Received: by 2002:a17:902:a509:: with SMTP id s9mr10100775plq.134.1644538722348;
        Thu, 10 Feb 2022 16:18:42 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::169b])
        by smtp.gmail.com with ESMTPSA id n37sm8328321pgl.48.2022.02.10.16.18.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:18:41 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/4] adapter: Fix the reusing gerror without re-initialization
Date:   Thu, 10 Feb 2022 16:18:37 -0800
Message-Id: <20220211001840.22566-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

When the GError variable is freeed with g_error_free(), it is not set to
NULL and reusing the same variable again can cause the seg_fault because
it is still pointing the old memory address which is freed.

This patch relaces the g_error_free() to g_clear_error() which frees the
variable and set it to NULL if the variable is used in the function
again.

Fixes: 2287c517ca1bd ("adapter: Fix unchecked return value")
Fixes: https://github.com/bluez/bluez/issues/276
---
 src/adapter.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3ee98431d..eef50f67a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4676,7 +4676,7 @@ static void load_devices(struct btd_adapter *adapter)
 		if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 			error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-			g_error_free(gerr);
+			g_clear_error(&gerr);
 		}
 
 		key_info = get_key_info(key_file, entry->d_name);
@@ -5662,7 +5662,7 @@ static void convert_names_entry(char *key, char *value, void *user_data)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 	g_key_file_set_string(key_file, "General", "Name", value);
 
@@ -5895,7 +5895,7 @@ static void convert_entry(char *key, char *value, void *user_data)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	set_device_type(key_file, type);
@@ -6001,7 +6001,7 @@ static void store_sdp_record(char *local, char *peer, int handle, char *value)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	sprintf(handle_str, "0x%8.8X", handle);
@@ -6085,7 +6085,7 @@ static void convert_sdp_entry(char *key, char *value, void *user_data)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	store_attribute_uuid(key_file, start, end, prim_uuid, uuid);
@@ -6145,7 +6145,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	for (service = services; *service; service++) {
@@ -6170,7 +6170,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 	if (!g_file_set_contents(filename, data, length, &gerr)) {
 		error("Unable set contents for %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	if (device_type < 0)
@@ -6185,7 +6185,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 	set_device_type(key_file, device_type);
 
@@ -6241,7 +6241,7 @@ static void convert_ccc_entry(char *key, char *value, void *user_data)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	sprintf(group, "%hu", handle);
@@ -6297,7 +6297,7 @@ static void convert_gatt_entry(char *key, char *value, void *user_data)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	sprintf(group, "%hu", handle);
@@ -6352,7 +6352,7 @@ static void convert_proximity_entry(char *key, char *value, void *user_data)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	g_key_file_set_string(key_file, alert, "Level", value);
@@ -6556,7 +6556,7 @@ static void load_config(struct btd_adapter *adapter)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	/* Get alias */
@@ -8313,7 +8313,7 @@ static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	for (i = 0; i < 16; i++)
@@ -8479,7 +8479,7 @@ static void store_csrk(struct btd_adapter *adapter, const bdaddr_t *peer,
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	for (i = 0; i < 16; i++)
@@ -8657,7 +8657,7 @@ static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	g_key_file_set_integer(key_file, "ConnectionParameters",
@@ -9316,7 +9316,7 @@ static void remove_keys(struct btd_adapter *adapter,
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	if (type == BDADDR_BREDR) {
@@ -9418,7 +9418,7 @@ static bool get_static_addr(struct btd_adapter *adapter)
 								&gerr)) {
 		error("Unable to load key file from %s: (%s)",
 					STORAGEDIR "/addresses", gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 	addrs = g_key_file_get_string_list(file, "Static", mfg, &len, NULL);
 	if (addrs) {
-- 
2.25.1

