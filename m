Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0332BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE60C60EE9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhJRRaz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbhJRRax (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 13:30:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0CCC061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 21so11725675plo.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+FfnDGZAWFELiL6UZ36GXT86gwbpLXHzNQYqIrlobIU=;
        b=MsYhv+eGCsDP1YuM/h8yrUzSxejDpWfLSWO4ZQFHat/0At7EObk2VpfKmY6Ucdr9Of
         4GUMjKoxmoWw9iT8dYKTTereALOMUsLeB/RilVqhAn1TLvLnm92FH+oEIQtjahraAWGx
         8wlnT2oohzf7YRvkbRBckCYZxj/yxskYSmAhi6Dyod02gfpZ1xs6b5sIZMQSpQtrTN3s
         6gKZx0YnsOipDbaD/BlVrYjoqSV21/+LgP8WZwl3QVzXNgLTfwHonCcG9/LRyl7UgOF/
         a0NXK6BIAfKf5NZzAZ0MdwYb9ZSCNA1EkC0Yj1kMzZuOViwKaPfg6lzS9DJiVhDiZ1Bp
         4AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FfnDGZAWFELiL6UZ36GXT86gwbpLXHzNQYqIrlobIU=;
        b=l7EeZn/Cy0FqU2Gdi9LIsUxOX/SifH4mMIjTFO+cCtTFMcsBCJ+2ECFI45mYyv8kbc
         /2yVnfXvs7/C9T2oCSuCmZJ2+2vueDGnnaJCgpx4nshhSw+8puVACSJDJqbvrgExw8jB
         gTquIHnP19iI5T+cDv9HUvLoN/VIOmH5k5gpjsFKH65UqokkJ2nHLixWekdkZOdc/J1B
         W8vfPd7xuXyHJdpJ5Y+nuNefjjOxqosvKpPf7IbfD+hhtUS0M0Po74ViT5FDovhayxsJ
         KMTbol4Idfip5DYB8yQDFlJsuQ6s9bvUq0j3S0qgBbEyKN6hDlpseAsRaBJGzgA1DIDy
         btLw==
X-Gm-Message-State: AOAM5336Af0YM5ceS5HZsrA3qtXlO62sQ7xBSKjJcg95izcqj50tw/nd
        xJUN/WZzGmarwGYZeP4RX+0i5gxHvD/XrQ==
X-Google-Smtp-Source: ABdhPJztVEkZYKlOWfFSnjFCu/YrI0bxXzFHvjAs9yOBZceDOST8awKxvOneMObehGmBDytgGn5C5A==
X-Received: by 2002:a17:90a:cc15:: with SMTP id b21mr216991pju.113.1634578121740;
        Mon, 18 Oct 2021 10:28:41 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:a510:aebd:a4ae:453c])
        by smtp.gmail.com with ESMTPSA id fv9sm51156pjb.26.2021.10.18.10.28.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:28:41 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 3/9] attrib-server: Fix unchecked return value
Date:   Mon, 18 Oct 2021 10:28:27 -0700
Message-Id: <20211018172833.534191-4-hj.tedd.an@gmail.com>
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
 src/attrib-server.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5a178f95e..0063c9534 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -752,6 +752,7 @@ static int read_device_ccc(struct btd_device *device, uint16_t handle,
 {
 	char *filename;
 	GKeyFile *key_file;
+	GError *gerr = NULL;
 	char group[6];
 	char *str;
 	unsigned int config;
@@ -764,7 +765,11 @@ static int read_device_ccc(struct btd_device *device, uint16_t handle,
 	}
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 
 	sprintf(group, "%hu", handle);
 
@@ -867,6 +872,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 	struct attribute *a;
 	uint8_t status;
 	GList *l;
+	GError *gerr = NULL;
 	guint h = handle;
 
 	l = g_list_find_custom(channel->server->database,
@@ -911,7 +917,11 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 		}
 
 		key_file = g_key_file_new();
-		g_key_file_load_from_file(key_file, filename, 0, NULL);
+		if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+			error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+			g_error_free(gerr);
+		}
 
 		sprintf(group, "%hu", handle);
 		sprintf(value, "%hX", cccval);
@@ -920,7 +930,12 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 		data = g_key_file_to_data(key_file, &length, NULL);
 		if (length > 0) {
 			create_file(filename, 0600);
-			g_file_set_contents(filename, data, length, NULL);
+			if (!g_file_set_contents(filename, data, length,
+								&gerr)) {
+				error("Unable set contents for %s: (%s)",
+						filename, gerr->message);
+				g_error_free(gerr);
+			}
 		}
 
 		g_free(data);
-- 
2.25.1

