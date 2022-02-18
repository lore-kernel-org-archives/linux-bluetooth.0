Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B6BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 02:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiBRCQX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 21:16:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiBRCQW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 21:16:22 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42232042AC
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 18:16:06 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso11061087pjt.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 18:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/h1YRsh6fLXRWLJjTrAi9809tNygUW1zBfzJzr6M7Q=;
        b=PTgX7EV6EIKbcHQBLG0VjMqAmqnvO+AqHCOsXckB5H/5zsOzvegXKD5G7HIJU7uwBJ
         ZnxrDecXDC145pa20bqTlGA57b5D9UGvD98wtAlG+Gdu19vrPhJQP//LdEDGsmpD80E8
         FwM+LRn2//sBHiR6QQspCB8xeKSi6lwuZmdi7lgKkPU1qlaUOpK70EjKyfLoD9kz/7Vr
         EhzZafQ+OMou4o15S0CesBiDQO5OQg6Km/UpdWd2s4X0yo/K4cGuwSNb3BhSPdYDlLtq
         yTjTxPtbDaNVkQqef4gFOIYz+JdY7+TkkhPpXNgjNuwBADnrPEr0xFuNzbDs1Gb7dIbu
         VmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/h1YRsh6fLXRWLJjTrAi9809tNygUW1zBfzJzr6M7Q=;
        b=OcDusyygYpZ7QC0jHY4vDgaaM4DPYptZ/6K9K5gFCIPyxluhzLblARWnbGYg+o4Sxh
         N1/nYv5Hsthyx8JIc10l/m9afkBPVoo8/KEwa3U/LoUK6g5i+3EODe0z/IGfB3m5EYmR
         5v+1luwsyrcYZ/7azroq48DIOhyN6J6R1QcVcN3HT7Zd7i2Sf1D5VCACQ3hgxZbrBPaO
         LNLdfINZXpSobH2ZQTeGOY13dxhM7gsn5z+SQEzJ0342FFRfpA/zzhmI/3PmGsaHBXRU
         KeCOoJH/+OYWkbB1IdBXhy+epHsjy4rCP5gc0bwt5R7yC6bZSzTJmxkWn41v/eQb6jUk
         mgvA==
X-Gm-Message-State: AOAM532jXh9DzUrxrd8VULXiEYIP+F6yCo1LEpsNVjt/LxI+pu9Kbm8G
        RpNRfhrW16NBAaDg4XxFSg5NXGuTr/wl3A==
X-Google-Smtp-Source: ABdhPJx66nAII650OjXg28UtYyR6xNYRylGdMtt6sAvUH3FZzQoN0OJeFBYtR2ZAY4zEWp3V3V3vyw==
X-Received: by 2002:a17:902:9045:b0:14f:14e7:f3aa with SMTP id w5-20020a170902904500b0014f14e7f3aamr5280514plz.69.1645150566101;
        Thu, 17 Feb 2022 18:16:06 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h14sm959640pfh.95.2022.02.17.18.16.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 18:16:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] main.conf: Fix parsing of mode options
Date:   Thu, 17 Feb 2022 18:16:05 -0800
Message-Id: <20220218021605.3126182-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replace the of g_key_file_get_integer which is limited to only
decimal values to g_key_file_get_string and then use strtol to convert
the string value to integer.

Fixes: https://github.com/bluez/bluez/issues/293
---
 src/main.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index bf9d398e4..a448320c1 100644
--- a/src/main.c
+++ b/src/main.c
@@ -354,13 +354,22 @@ static void parse_mode_config(GKeyFile *config, const char *group,
 
 	for (i = 0; i < params_len; ++i) {
 		GError *err = NULL;
-		int val = g_key_file_get_integer(config, group,
-						params[i].val_name, &err);
+		char *str;
+
+		str = g_key_file_get_string(config, group, params[i].val_name,
+									&err);
 		if (err) {
 			DBG("%s", err->message);
 			g_clear_error(&err);
 		} else {
-			info("%s=%d", params[i].val_name, val);
+			char *endptr = NULL;
+			int val;
+
+			val = strtol(str, &endptr, 0);
+			if (!endptr || *endptr != '\0')
+				continue;
+
+			info("%s=%s(%d)", params[i].val_name, str, val);
 
 			val = MAX(val, params[i].min);
 			val = MIN(val, params[i].max);
-- 
2.35.1

