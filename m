Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0EEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 02:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347085AbiBKCA6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 21:00:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347083AbiBKCA6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 21:00:58 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D25FA4
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 18:00:57 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c3so3463216pls.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 18:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3z6Py4ZnUxwkEa/ciP6EGzTvF/M5d9y32+u5BX0inys=;
        b=K7NIb+vN1V8HR408rNhfdVfyNc81xSwDYeJGFxGH+E8LrNe2o2zZVGwkydZ0ScBxR+
         uYSgKZybfOvCjblVarAUkIRPkmsLu6Gy198DoNutEMb5rKo6YuZKs82XSeiNt2IhLVKI
         XctyaBzZh92pH/fLMwaMojzwhphUKHPVZEOAB2UTXuqEmFxIEJ914gzdf9ieWvLY2yqX
         ICLHgtwwapkCK0FPVo1m76J/FeR7dynV7EPoQ9d66+MrxnzBQUxLi0iHdMATBYsFreap
         Hxm6TNK8vFU2vsy1UToKUgQujs3UHOzcUlU+eA19mhsPJ+NpxKxwHalBBPvDZPURvJj1
         lgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3z6Py4ZnUxwkEa/ciP6EGzTvF/M5d9y32+u5BX0inys=;
        b=cUOCKtY3uI/hZj+1f7Js6MD9hNMYiPUlFfCIFFWzr5mFVZRyoFzkZKFxd06m+Re+zB
         dCko3ivm8XZ9HHzS3+6GDgxG6s1RzE1vXR/pbqtWvPssn2xuwZUoGflEQQCnGhyXDI5/
         rKtrf2jJe+JFF6kJYT34K4D8lm1nf8LYhC9NGyX50DKswLfeRp1duUXZJ5N0ZyNeefCf
         SNpJHr+w+0FpD2jZ1MWWG7oIVJu77gLBmw6sxVWSJRt/LL6/5/IdlhU9qtKLMHdGwFjY
         +MkjogNexVXSDxMB4zdGVZIGpbxEicjP8ZvA2u+gMQoe1CgYIF+Am6apvnCnHksom7ww
         7acQ==
X-Gm-Message-State: AOAM53312JuFzg797+pHs+F1OH3xIMw6Nq66YwqG35K2+maGAJirMj/t
        imqYEwGu97zO1g2REo47p/ZS1j0RD3w=
X-Google-Smtp-Source: ABdhPJy1ymaKEfJ5nH3p4Lv1AcNp13yjV4fQTJVOK0dO26HI6KF0G01gvYh9uNy3hvuUNPqEhs4LoQ==
X-Received: by 2002:a17:902:ce04:: with SMTP id k4mr9866069plg.131.1644544857228;
        Thu, 10 Feb 2022 18:00:57 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::169b])
        by smtp.gmail.com with ESMTPSA id b2sm17752759pgg.59.2022.02.10.18.00.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 18:00:56 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 3/3] profiles: Fix the reusing gerror without re-initialization
Date:   Thu, 10 Feb 2022 18:00:54 -0800
Message-Id: <20220211020054.28534-3-hj.tedd.an@gmail.com>
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

Fixes: 4ad622d592ba5 ("profiles/a2dp: Fix unchecked return value")
---
 profiles/audio/a2dp.c   | 4 ++--
 profiles/health/hdp.c   | 6 +++---
 profiles/input/device.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d0808c77a..9fbcd35f7 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -832,7 +832,7 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	data = g_key_file_get_string(key_file, "Endpoints", "LastUsed",
@@ -1006,7 +1006,7 @@ static void store_last_used(struct a2dp_channel *chan, uint8_t lseid,
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 
 	sprintf(value, "%02hhx:%02hhx", lseid, rseid);
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 40b6cc18a..9d9d1e824 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -576,7 +576,7 @@ static void device_reconnect_mdl_cb(struct mcap_mdl *mdl, GError *err,
 					"Cannot reconnect: %s", gerr->message);
 	g_dbus_send_message(conn, reply);
 	hdp_tmp_dc_data_unref(dc_data);
-	g_error_free(gerr);
+	g_clear_error(&gerr);
 
 	/* Send abort request because remote side is now in PENDING state */
 	if (!mcap_mdl_abort(mdl, abort_mdl_cb, NULL, NULL, &gerr)) {
@@ -1766,7 +1766,7 @@ static void device_create_mdl_cb(struct mcap_mdl *mdl, uint8_t conf,
 		return;
 
 	error("%s", gerr->message);
-	g_error_free(gerr);
+	g_clear_error(&gerr);
 
 	reply = g_dbus_create_reply(hdp_conn->msg,
 					DBUS_TYPE_OBJECT_PATH, &hdp_chan->path,
@@ -1790,7 +1790,7 @@ fail:
 						ERROR_INTERFACE ".HealthError",
 						"%s", gerr->message);
 	g_dbus_send_message(conn, reply);
-	g_error_free(gerr);
+	g_clear_error(&gerr);
 
 	/* Send abort request because remote side is now in PENDING */
 	/* state. Then we have to delete it because we couldn't */
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 013899211..ff4aa771a 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1053,7 +1053,7 @@ static int hidp_add_connection(struct input_device *idev)
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
 	}
 	str = g_key_file_get_string(key_file, "ServiceRecords", handle, NULL);
 	g_key_file_free(key_file);
-- 
2.25.1

