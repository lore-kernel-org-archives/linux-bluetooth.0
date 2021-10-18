Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1551BC43217
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BBB60EE9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhJRRa4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhJRRaz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 13:30:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1AAC06161C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l6so11730351plh.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Br4XuJ9fwyEllCaKkS5Lu5qxgu2Hu1qKrQMaMgU5moo=;
        b=UCZ516YvOvbQHJkUlg08XWMI6pa7tcQKgr1xSuPQ8tacDF+47MnmrSy0zy7dc+CrcB
         ADemAdW+X072rF8XjC6GYEPDXelyJDXyHNIAEXHPZOtD2AtAPdpn85hGDMr1ZI7LhzM5
         p4DFdWkqKgtpR17WDmB1f+atOvYXw5nQQiDjPwTZ87cBHoQRFICpNElfyAcchTV9kEdp
         twCcyVDUOF+KI6Z4F0HnTefHprSI9q1ISbAxLPz27M7ci4wWbfBzWEJ6aSKcUHBLJvp2
         zCgr7uTRrSoLIbdAMxFNNZiSA9k5uok402GaZZPi2Mg9UB/XvmMUfr9fuUWIL0Js6jdP
         oq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Br4XuJ9fwyEllCaKkS5Lu5qxgu2Hu1qKrQMaMgU5moo=;
        b=bORnQe0/vUvAqm/ISpyVpvuDCfhqIST02gVsRh7r3Ym341eRDO+4RYNFdpjLqXf3rU
         OSt1tlYMaouqxFZA9VfvM7wkDPUwaVwHP882ZymxoZrNb4juloEehRmw4hrlhZAbMEXa
         aqjpbgGtQ+EH9Sc1qhHMKEczTYujCN+u6CxjwPZOCxyRcUZKvxkxTFm1DOAsgT+dZIlO
         goaFmg7uSRAJRViozj02rM04MISK1Q0s2PAiMpiQhpY8tisGTDlbxk4YOmzSgY6MIf76
         YvdLS4httfNd03SvFsudtZD4Te3C8d6ZDhurNvpUxALG+U8Cp9WnC7SmKA8xfM+cLi/M
         L0jQ==
X-Gm-Message-State: AOAM530bS4ZFBCnqjlMrdMageN2VtASysW1jmNu5QmjgUiAX0nseyiN6
        wgCUkVg2UZdZJ9KS9jZ16NqYlDYTWsD8KA==
X-Google-Smtp-Source: ABdhPJx1/M8oq193D/LoGmg9+T1FCffMIgCGGrjHnaxWxmKBOp0S8FqXTe2SBnuOmVzVpyw2rCFnvw==
X-Received: by 2002:a17:90b:1910:: with SMTP id mp16mr271356pjb.30.1634578123017;
        Mon, 18 Oct 2021 10:28:43 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:a510:aebd:a4ae:453c])
        by smtp.gmail.com with ESMTPSA id fv9sm51156pjb.26.2021.10.18.10.28.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:28:42 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 5/9] profiles/a2dp: Fix unchecked return value
Date:   Mon, 18 Oct 2021 10:28:29 -0700
Message-Id: <20211018172833.534191-6-hj.tedd.an@gmail.com>
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
 profiles/audio/a2dp.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 031ece628..eba2f9822 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -816,6 +816,7 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	char filename[PATH_MAX];
 	char dst_addr[18];
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char *data;
 	gsize length = 0;
 
@@ -828,7 +829,11 @@ static void store_remote_seps(struct a2dp_channel *chan)
 			btd_adapter_get_storage_dir(device_get_adapter(device)),
 			dst_addr);
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	data = g_key_file_get_string(key_file, "Endpoints", "LastUsed",
 								NULL);
@@ -845,7 +850,11 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	}
 
 	data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, data, length, NULL);
+	if (!g_file_set_contents(filename, data, length, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	g_free(data);
 	g_key_file_free(key_file);
@@ -981,6 +990,7 @@ static void store_last_used(struct a2dp_channel *chan, uint8_t lseid,
 							uint8_t rseid)
 {
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char filename[PATH_MAX];
 	char dst_addr[18];
 	char value[6];
@@ -993,14 +1003,22 @@ static void store_last_used(struct a2dp_channel *chan, uint8_t lseid,
 		btd_adapter_get_storage_dir(device_get_adapter(chan->device)),
 		dst_addr);
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	sprintf(value, "%02hhx:%02hhx", lseid, rseid);
 
 	g_key_file_set_string(key_file, "Endpoints", "LastUsed", value);
 
 	data = g_key_file_to_data(key_file, &len, NULL);
-	g_file_set_contents(filename, data, len, NULL);
+	if (!g_file_set_contents(filename, data, len, &gerr)) {
+		error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	g_free(data);
 	g_key_file_free(key_file);
@@ -2218,6 +2236,7 @@ static void load_remote_seps(struct a2dp_channel *chan)
 	char dst_addr[18];
 	char **keys;
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 
 	ba2str(device_get_address(device), dst_addr);
 
@@ -2225,7 +2244,11 @@ static void load_remote_seps(struct a2dp_channel *chan)
 			btd_adapter_get_storage_dir(device_get_adapter(device)),
 			dst_addr);
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	keys = g_key_file_get_keys(key_file, "Endpoints", NULL, NULL);
 
 	load_remote_sep(chan, key_file, keys);
-- 
2.25.1

