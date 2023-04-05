Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABA3C7619A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 23:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjDEXLR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 19:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDEXLP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 19:11:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E826E95
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 16:11:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n14so19994139plc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Apr 2023 16:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680736273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kaqayTVDIWTLTbDe2Uwv5TQo6TvQbsXcmK3rO09rfRg=;
        b=WgJVoRMKzUUujDGslreTnEtrjY5PwyB9wHWL3kkNh59aDqexh7nJgj6Svh/nkXwT22
         NHvXLghumYGGEqRf048eqSNmvT52cfjS81e1IJFbWh6YwDOcOUVQ3FopenZAS2Nu4ZAd
         1bijlOoQ8c4ZHFuJ3Q2wzUeSTN4Uu69TpIfd+CfG31xjWVP1Qa5JBB/LmlWGkSrWWEEQ
         Ijlal5LPgpZqFAjnausFjVb2giAZ73Uh4E2vyPSufsnV0FXzGi4EKRLkPILSZ5rU94+Q
         /H8E4gOQIYFQnJemFfYiOdLSvRKkBVl36vBCXRK7Wb0BN7LiZyiNQkMq6YSwXHFWIwxG
         MGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680736273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaqayTVDIWTLTbDe2Uwv5TQo6TvQbsXcmK3rO09rfRg=;
        b=cspBbAN1fGaz+tW6UD8BSYwcf6Zs8kw0QuhrGOxXHBlE10axyLn0VF5EKrknlaxGaF
         lzgflr2GjM/wIX7ApmWN7vBQyuLbYaAReVTyGEpUPjXsYXItI5J1/VfBwGN29Q8qi5ja
         FZN+Mw/KnwIuMKs0UqhjKVCxSal9O56Bf/iE9gHnQ4OVzOoUhMTrJOxL5t/R7rnHe1qJ
         XRqKaK/rz+pcm/GE/Td499YSvDyBpuCJTDpGDzjYKCxXnBRI4mT/alUvMpnQBg4CK10j
         Aqeo/Z1iVTUkEQx6VbbgldlOmXVn3z5Uv8pNQs1cWbZkaLTwHUotJXkAcs5JyJgAPhSH
         e/RA==
X-Gm-Message-State: AAQBX9flPX8anwrzIgWTFbPJZ1mstJj8LJg0l0AJJxS3HdJeFYIP3/io
        53BIgdBqKp+kPBF1jnlkqLuElAlZd94=
X-Google-Smtp-Source: AKy350b/As0gdfXNcUN6CHdUzb9XIXVw2xmFti6BSeNFO7ENm8hUxB0qHwsfSwxFISpUFAkTL92xEA==
X-Received: by 2002:a05:6a20:3b28:b0:de:6e42:e0e5 with SMTP id c40-20020a056a203b2800b000de6e42e0e5mr1001556pzh.13.1680736272833;
        Wed, 05 Apr 2023 16:11:12 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id v12-20020aa7808c000000b006254794d5b2sm11537752pff.94.2023.04.05.16.11.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 16:11:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] main.conf: Fix parsing of CSIS group
Date:   Wed,  5 Apr 2023 16:11:07 -0700
Message-Id: <20230405231111.2636523-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There was a typo in the group name using CSIP instead of CSIS.
---
 src/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/main.c b/src/main.c
index 3198091fc12c..a64b833b58c1 100644
--- a/src/main.c
+++ b/src/main.c
@@ -177,7 +177,7 @@ static const struct group_table {
 	{ "LE",		le_options },
 	{ "Policy",	policy_options },
 	{ "GATT",	gatt_options },
-	{ "CSIP",	csip_options },
+	{ "CSIS",	csip_options },
 	{ "AVDTP",	avdtp_options },
 	{ "AdvMon",	advmon_options },
 	{ }
@@ -1015,7 +1015,7 @@ static void parse_config(GKeyFile *config)
 		btd_opts.gatt_channels = val;
 	}
 
-	str = g_key_file_get_string(config, "CSIP", "SIRK", &err);
+	str = g_key_file_get_string(config, "CSIS", "SIRK", &err);
 	if (err) {
 		DBG("%s", err->message);
 		g_clear_error(&err);
@@ -1031,7 +1031,7 @@ static void parse_config(GKeyFile *config)
 		g_free(str);
 	}
 
-	boolean = g_key_file_get_boolean(config, "CSIP", "SIRK", &err);
+	boolean = g_key_file_get_boolean(config, "CSIS", "Encryption", &err);
 	if (err) {
 		DBG("%s", err->message);
 		g_clear_error(&err);
@@ -1041,7 +1041,7 @@ static void parse_config(GKeyFile *config)
 		btd_opts.csis.encrypt = boolean;
 	}
 
-	val = g_key_file_get_integer(config, "CSIP", "Size", &err);
+	val = g_key_file_get_integer(config, "CSIS", "Size", &err);
 	if (err) {
 		DBG("%s", err->message);
 		g_clear_error(&err);
@@ -1052,7 +1052,7 @@ static void parse_config(GKeyFile *config)
 		btd_opts.csis.size = val;
 	}
 
-	val = g_key_file_get_integer(config, "CSIP", "Rank", &err);
+	val = g_key_file_get_integer(config, "CSIS", "Rank", &err);
 	if (err) {
 		DBG("%s", err->message);
 		g_clear_error(&err);
-- 
2.39.2

