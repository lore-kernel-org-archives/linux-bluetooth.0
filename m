Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC78C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 00:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346281AbiBKASp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 19:18:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346276AbiBKASo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 19:18:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9881F105
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:18:44 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w1so3288306plb.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3z6Py4ZnUxwkEa/ciP6EGzTvF/M5d9y32+u5BX0inys=;
        b=YVdo6/uFbHaCtGt/9pCXJhQQQNrWkLwJa7hOT2NF5E3szNJFZmo6jIg8RYou/eKlIg
         a99ukzYQ4OWyR+MBT4nHFERu4INTC3bQ50bfIO0pzlBNWRJ2H05c9QJ+FFSQX3kQtCSq
         dxOD7vuizjhu7Q0ZnYC/qwOMnEoGjthSqBub8ZytiZX/sne5+b5iDaMu7qDU0YGYAGyz
         MMj8Hi6XLjg9e+TUt6mHjlLV76lnh3CO+J5+F2lAy8Wi270VP1ToIgAJIyHnAQc/0mh7
         C+FIg6KvhJAJNcByl+u7xt9DJbmWa/9GTpKA/MjlSrbg1dRK4XGtJyjgIm5msa56vjrX
         5mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3z6Py4ZnUxwkEa/ciP6EGzTvF/M5d9y32+u5BX0inys=;
        b=KvtqFgOKfInytF/gMGc5oBb6EVWuPECpCaz1DwH5/KifXh2eUombNLOsUH7XCZp7Lw
         owunn3KHvkTJ+sqvqR07roXHR/T7xPoKNQqcYqVhb3YDMRRaRRHDw/cJpzw2XXA0cD4A
         00l3FBy77Xe9y2/k2DvUxWC7GBqoVLZpXgBlPzVqG4Y6KtI0BFFvWtc12kynVX9sqFNS
         m+d+YjluXFJeMZyqKsCdcC+jzxeqAeRbXMq8cab2JX09ImpQXBNqrK6omPdXFKIca7Qh
         m3e6Pe5rHrqCjqH0VCcD1WpQRSn2pVT/JITt5Us7lZ/EfV8aIEVs/FeXT4BPMR5GUp7o
         GSFQ==
X-Gm-Message-State: AOAM530lu0n47pHrCu/MOklOx2BBjVWycIG/Io4OYT9UI3clvUUVJq6q
        BwVgMCvex3CmD5mumRGa3UgrL2b3Ba8=
X-Google-Smtp-Source: ABdhPJxyyUVfEvh+9RksQw+rGdTL81VS1MxjFN/P7XyRbkYoDs8x7TRN4TAnHJ4176bknArQpjJdkA==
X-Received: by 2002:a17:902:db0d:: with SMTP id m13mr9684455plx.136.1644538723925;
        Thu, 10 Feb 2022 16:18:43 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::169b])
        by smtp.gmail.com with ESMTPSA id n37sm8328321pgl.48.2022.02.10.16.18.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:18:43 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 3/4] profiles: Fix the reusing gerror without re-initialization
Date:   Thu, 10 Feb 2022 16:18:39 -0800
Message-Id: <20220211001840.22566-3-hj.tedd.an@gmail.com>
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

