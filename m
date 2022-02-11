Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50E8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 02:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347069AbiBKCA5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 21:00:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244359AbiBKCA4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 21:00:56 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D429A2A3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 18:00:56 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a39so12743921pfx.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 18:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4c4lSDhQw9gBes/CzLEVSAVialIXB+yXKGpThtYQ4/Q=;
        b=g6GA2AFoXwsO8DwkBn2Uc0Nrv/UBDXyJ93OLTJ6KSxDahyvXuLL4QPuf6BzELhzav6
         olZOTgkjZ2f2zDUEV5hOMWIebISauohzOmVeak4Lojukl5cDwoyurJKf+I26yv0jDjKP
         kdkJovVBh3ecI+kaToh/VJevZrqt/dfDnQCpjTJsiNuacbwmLeZ/EcTrKfsOOU9vZD7Q
         Z100VfC4RcF+EAc0JYekJlOczFpv+HmobUDddVKi/yZJsWeKKc8olbJsEtCozP9zH+0X
         f10bej7HKRY5E+IzuF6GN06UiuS5djcmooMbUJMDFitbjE6Q6rXZLtxqQSMC1iItlCmU
         9BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4c4lSDhQw9gBes/CzLEVSAVialIXB+yXKGpThtYQ4/Q=;
        b=4QnR/X1TmEJhT8l3YkYKvMAJ0M3nFLpgYeR004gERKuFBareJWEk4LHXR7uP0s2Oxt
         o98UwNLyAVP7FpuHk/K2uvXUakEWelyIz8pMPh/7ki5+ujey9ocr2xxYUdGyJAukaILw
         Dynj3r3PgdWaoZcLmsyOiPgKTdBsEVuHQNASQ2JRvClox1jvsawX09tH4wuPco52I2pm
         rna2eKnp9hAaoXRcT+JP8bC5/8k9r5q8eVXTTlJIxOBWmVloNn+8yVMDmjUdupyk4bdd
         v9P3t4PJNWeEhMEmYNwICN0yPYrehFF25Qj0Q/q3+Lgm+vyTH5AtI0pDrsb5OPnco7eK
         Udzg==
X-Gm-Message-State: AOAM531LL5vYw7IVzP831rNSuZUkJebdCKc/p7frUjEublw+pZiaGJ6P
        EBsvtXp477KsHYbeMm2xv/twJPyQ1lU=
X-Google-Smtp-Source: ABdhPJzYtz7XE1At3Rpa9p8JGx0rDsiBB50NBaFVLcTVGorA4HEkxVitBqmTqM2rVOXyXwqNhU1xnA==
X-Received: by 2002:a63:1a21:: with SMTP id a33mr8451702pga.35.1644544855896;
        Thu, 10 Feb 2022 18:00:55 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::169b])
        by smtp.gmail.com with ESMTPSA id b2sm17752759pgg.59.2022.02.10.18.00.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 18:00:55 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/3] adapter: Fix the reusing gerror without re-initialization
Date:   Thu, 10 Feb 2022 18:00:52 -0800
Message-Id: <20220211020054.28534-1-hj.tedd.an@gmail.com>
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

