Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F48C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 00:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbiBKASo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 19:18:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346262AbiBKASn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 19:18:43 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF4F558E
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:18:43 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a39so12389763pfx.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WAQz1cmq7S+46Q19Se7FctEmdzmieMxLeZeEwTRluAA=;
        b=IC715ZI6pcKIrJ4owDhJ6/ljhNa5/bqFaREcQ7whNeEiNyOO738XLdk2DgLvJxqbWd
         if3SgJXt06Mj9ish7nuEyNZmca2SPWjoaUG3rsRCTmuXh0233oLHIiavCH1ghAhqGIk4
         dXPLtuMAiEm52+f1YQ3yodb8aflE6vqzVHCLVRdsOURKRf0+fQvhBQbQyWEfhwjACozC
         nvld+zwwA2TMC7kroSIwNM1MZF9Zq4HlA4ZPCIFiaH/cmdJaL2vrxmtdEXjME7+FdHlr
         cUZUxfiOKGLtelCMw6J4gF1LwQr0fYaITUpzDf1ec4epv8qfLuo/1wbAjN9oxAHPVfPk
         RWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAQz1cmq7S+46Q19Se7FctEmdzmieMxLeZeEwTRluAA=;
        b=bvaFXYYHOt5m3yC+0H3ngHIFNYwbJXiNMFjToJS8+V8fXEj5hlux5+EgwWCT0VMWIK
         H2Lq7jJEy1pWqG220dSHzLAyCr8o6in3PkHBb1ZnobcdGwikaI0nnHf3sxJ5UkFCVLuq
         jHN4+CnGM441TeB5/b6xOTAE+WbpDmoFF1GzuyKhHk4qru9DpJwLMBLLyfk96qfS9EVx
         /RB2cfJPvEvtFRrFo0604jH0iCHCmxwr52+s27nHSxWh+6aRZINljqac52nmVevTg/GF
         Mwd8N6rPVHHs/0cepSJjIWRI7wATQIXtmI7cBBhPNb7VISgNUSga0Mo44WzDiMp+b+tf
         B8Tg==
X-Gm-Message-State: AOAM530EZATX2PRe7ooPIbGotZJyvtqWozD/AOni0oUwITlPJ0g9dO0f
        i7zBW+uJqnStaAKzmg3DHqbZv5M6sWM=
X-Google-Smtp-Source: ABdhPJx29AMC5afK+kz/NYHvGSFmbHti/IwW042rh5WYF4ChGusIyzMZOl/C/OKlr16bvLc6A8K1LA==
X-Received: by 2002:a05:6a00:1891:: with SMTP id x17mr10003233pfh.73.1644538723126;
        Thu, 10 Feb 2022 16:18:43 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::169b])
        by smtp.gmail.com with ESMTPSA id n37sm8328321pgl.48.2022.02.10.16.18.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:18:42 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/4] device: Fix the reusing gerror without re-initialization
Date:   Thu, 10 Feb 2022 16:18:38 -0800
Message-Id: <20220211001840.22566-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211001840.22566-1-hj.tedd.an@gmail.com>
References: <20220211001840.22566-1-hj.tedd.an@gmail.com>
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

Fixes: 6a154cd08000b ("device: Fix unchecked return value")
---
 src/device.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6d29eb896..6a7bdd207 100644
--- a/src/device.c
+++ b/src/device.c
@@ -543,7 +543,7 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	data_old = g_key_file_to_data(key_file, &length_old, NULL);
@@ -556,7 +556,7 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
 		if (!g_file_set_contents(filename, data, length, &gerr)) {
 			error("Unable set contents for %s: (%s)", filename,
 								gerr->message);
-			g_error_free(gerr);
+			g_clear_error(&gerr);
 		}
 	}
 	g_free(data);
@@ -592,7 +592,7 @@ static void device_store_cached_name_resolve(struct btd_device *dev)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	failed_time = (uint64_t) dev->name_resolve_failed_time;
@@ -2666,7 +2666,7 @@ static void store_gatt_db(struct btd_device *device)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	/* Remove current attributes since it might have changed */
@@ -3635,7 +3635,7 @@ static void load_att_info(struct btd_device *device, const char *local,
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 	groups = g_key_file_get_groups(key_file, NULL);
 
@@ -6163,7 +6163,7 @@ void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	/* for bonded devices this is done on every connection so limit writes
-- 
2.25.1

