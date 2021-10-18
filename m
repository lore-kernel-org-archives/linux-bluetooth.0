Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AEAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4608B610C7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhJRRaz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhJRRay (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 13:30:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050CBC06161C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f21so11755965plb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qBtLTgO0XNLNSg3e9uzJw7B6TjrjW0fhOnX+IBGEVRs=;
        b=pmg0N+0Pdagyd5IPP7T0uDf+OOPeuy8Y1+L5S8PGZ8cwfLgBCkEcP0uryLh2ew8JcV
         R78Swn13smX5Ort005jKGGDJBoAWXWkmYUn61sXKpX9EdriBBM4v4LmUvVTzftjb5xK9
         YaIJ6Y45xyO3vmq7STqdoVlpVV12JkuuVOowlfKG6FD0ttsAnAQGrJZDJZhd7jAT+ckD
         lnnI2FaL8aDtwm4hz4mWx4WXJHs6qRoWwvJVMxLVA8AY2ibe/Ka/7QxOvOdmjZ+3Fmvg
         u5AYJ2rkZyjwg9PHf4M3OBZotwoCz5wBQxAm4qR4S6XnJlXxWMlMoDiJv+HEgTCHQqSr
         vJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBtLTgO0XNLNSg3e9uzJw7B6TjrjW0fhOnX+IBGEVRs=;
        b=zr7YPl3lxexRj0aVC/yAGZfHiddwQVXpRVVYylleZheIDfJlecKtf5dunqUu9npHOT
         r0SvdonGlhUmyhyTVxPfu2PF3DX6zAGayHE2LiZWQaHbtRV6w1ZP2p1Y3pO1C15F4EVi
         10tNFRFcIPoYyELOk4Na6e75QsAJ5c91O3E4ir18BAjwAyLrcWJuF7xSXg3pwil62vUB
         8bq0cLx8O4G4gRpn5p+tNAEmUcmPqxmD4BSyt3mtul5XnzI5e/gqyfEbtE4U0ABvl7CO
         pvJKIcAQ9ARCpmWZz9hRyFmK1mwv/GNAy2e3FgZfbQir6OBM35gFrWLr5XaqgDZqpbKh
         Tf+A==
X-Gm-Message-State: AOAM530zbA6k7kZVZ8lmdhBuXOCY0hY0nc7+TevNVfm3ekhykaVBG6NW
        4+IYfjSg5izo72jqcjsEqIbJh/aGvPRbOQ==
X-Google-Smtp-Source: ABdhPJxvlklozO1rvxdCSb9cDdDgNG91LZa0DcjcN5wK8m8bmJgy8ecmPk0p/je2KzFlcwTm+WENyg==
X-Received: by 2002:a17:90b:3a8b:: with SMTP id om11mr236457pjb.216.1634578122344;
        Mon, 18 Oct 2021 10:28:42 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:a510:aebd:a4ae:453c])
        by smtp.gmail.com with ESMTPSA id fv9sm51156pjb.26.2021.10.18.10.28.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:28:42 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 4/9] plugins/admin: Fix unchecked return value
Date:   Mon, 18 Oct 2021 10:28:28 -0700
Message-Id: <20211018172833.534191-5-hj.tedd.an@gmail.com>
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
 plugins/admin.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 7b7190a06..a8e7d2cd7 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -247,6 +247,7 @@ failed:
 static void store_policy_settings(struct btd_admin_policy *admin_policy)
 {
 	GKeyFile *key_file = NULL;
+	GError *gerr = NULL;
 	char *filename = ADMIN_POLICY_STORAGE;
 	char *key_file_data = NULL;
 	char **uuid_strs = NULL;
@@ -274,7 +275,12 @@ static void store_policy_settings(struct btd_admin_policy *admin_policy)
 	}
 
 	key_file_data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(ADMIN_POLICY_STORAGE, key_file_data, length, NULL);
+	if (!g_file_set_contents(ADMIN_POLICY_STORAGE, key_file_data, length,
+								&gerr)) {
+		error("Unable set contents for %s: (%s)", ADMIN_POLICY_STORAGE,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	g_free(key_file_data);
 	free_uuid_strings(uuid_strs, num_uuids);
@@ -335,6 +341,7 @@ failed:
 static void load_policy_settings(struct btd_admin_policy *admin_policy)
 {
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char *filename = ADMIN_POLICY_STORAGE;
 	struct stat st;
 
@@ -343,7 +350,11 @@ static void load_policy_settings(struct btd_admin_policy *admin_policy)
 
 	key_file = g_key_file_new();
 
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	key_file_load_service_allowlist(key_file, admin_policy);
 
-- 
2.25.1

