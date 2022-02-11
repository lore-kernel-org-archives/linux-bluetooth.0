Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A972C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 02:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347084AbiBKCA6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 21:00:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347045AbiBKCA5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 21:00:57 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4546B5F48
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 18:00:57 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id k60-20020a17090a4cc200b001b932781f3eso3135302pjh.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 18:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WAQz1cmq7S+46Q19Se7FctEmdzmieMxLeZeEwTRluAA=;
        b=ocaDmjuxFlfiYVeIJ3rXTBcAOUnAZPXDPjT0qu2LoPdObMGqa20/0gU560JvHkUVat
         97T4nSMX7ciHymHHYZ74eR5Ld+aIfXoVgEjweXdh4lW2RscK+q+2qPfwK+GXEb7uixT9
         cjAHLNZm5PJktrvnlQ4CyBMZZkpB7WsaAjOuiU/1ms+hILlKF9yuYufoyrYasAVeWQGM
         lyzPimYRE76e9nlsZDn6O0HDKW46EWhut+/APvcTzFs75omcb2sKOlF2hDlDYzgnFeQS
         jECvxEpqsuR8o6hKjAjWE/nhUnpRSULfzF2HrdUJZ36WlmZ9lj2VljhBCx38TgTK8Yg+
         pJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAQz1cmq7S+46Q19Se7FctEmdzmieMxLeZeEwTRluAA=;
        b=O9v4rykfWYeN2a6D2OK3oWvZh07FgMZOkn5cEBcudujO3ljD8oSM2adDWMpBGSQEXm
         DGVOpjFw9a5Iv08VLNh0ne1qsfEbp19mfgWZ9/QxI/NEaNuWC79mQJb5KMTFtnK7sVDA
         5Nmn+lBBZ1ZBmxMps6t2u4wUQwVwEeWRKcINDxibTWNhJ85KZMkSMqLNvMzoe36arcal
         aSdP2Nfv/0y/FmyemF4n94R09A9jvVuyrIFvMGowsAIm3O8CDOzZWFKAwBITcuCfwBRp
         an94jaNUx+3uxJYJT8Aj4avdArg5kPTI5gsK5ViSKqIF7RjQBTiGqTFuAYK7joZWyTmC
         98FA==
X-Gm-Message-State: AOAM5326vANTK8s7Q9/6ikfiPUpDHYIAJz7JTAFATM0CEYdSY0L9WvGr
        OuWx4Wlg9jseWlgIlIPEUGul3TYo9UA=
X-Google-Smtp-Source: ABdhPJx5YUslb7lhB/NM590f4ZASXvUs1/PiFzCfdyL8Qj/UVLnnkYlZm+BkCgS96i8McjhkO/eIrw==
X-Received: by 2002:a17:90b:350c:: with SMTP id ls12mr313898pjb.182.1644544856537;
        Thu, 10 Feb 2022 18:00:56 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::169b])
        by smtp.gmail.com with ESMTPSA id b2sm17752759pgg.59.2022.02.10.18.00.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 18:00:56 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/3] device: Fix the reusing gerror without re-initialization
Date:   Thu, 10 Feb 2022 18:00:53 -0800
Message-Id: <20220211020054.28534-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211020054.28534-1-hj.tedd.an@gmail.com>
References: <20220211020054.28534-1-hj.tedd.an@gmail.com>
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

