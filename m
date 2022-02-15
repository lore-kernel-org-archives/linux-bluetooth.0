Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AD3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 21:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243198AbiBOVED (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:04:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbiBOVEC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 16:04:02 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B500928980
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 13:03:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v4so327826pjh.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 13:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0Drh+g5eDzNtCJI287uxRTG5BGZXB340AQ+gFaOoME=;
        b=idALUJ7FcB+uXSq/cbvzBiaM2t57VEVlgioz39VbTOI209LyocTuM7z3squwt38LDu
         vPwOlIMQqfEvpDzraW3dmWCqqXMSotPby5nTiE5XVpLr1MHGYBU/hieWzlUYnFKscMYz
         o2R2KKohphwZwSvc/galPN5a111piOqcsxlWb/Z/H1ITTIWdNjtyxvVAh0eoEoGuWzhP
         hnfp5yCSxbYZjI18FGxRS/1I9d5KP5vgADwSMYFoJsggoVXJojnTNjApnd8uujqhxMuL
         9XZsWLVyR5oSyxjhetXkzXOJjgRuskgWT/iH+vwlvz2d+NO5ubSIJeE5ueBzy/yaTK4w
         Pt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0Drh+g5eDzNtCJI287uxRTG5BGZXB340AQ+gFaOoME=;
        b=0PP0lJyoN8Ks8Ch3Q7LNVRrQXzAYguCT/I7zzpZi9lBf4K9F7pdasFqD+5JzpvwK82
         qfr/5pPo6yAPYuRRKwLdsxJUMFEeJH80MBOnEI6f3Egu6yD6y6gM6IOWYlaSSKbwQriK
         Q0TF41qp/UJN4ArwGwRNWyZLGVtkgxezVM6AexIwYVlE8xoYwzqEUY5kbUHGc7NWJQ5W
         rDniRKDrNaKqomxq18d3eKphqT/tRldAOrmOYypfDia1Mwtq+P+TXqnjJS0ExOcVyTAI
         NSaYZbwJpJEIJLs+9AapwFCt20Qed4/5zjSpRuEX9jwYj7DPuhewbnGiPO2GH1e/+QDm
         /Rjw==
X-Gm-Message-State: AOAM530jZVNcXrbNuUIGZs2TVoItxeXTRxGdyRSGS4mTIWYelxTiWWii
        yw2LIjSHQ4NPuEIat6HdGveYNYG2y1mAnA==
X-Google-Smtp-Source: ABdhPJyuoiXqZ5BVu64Tfdptjvpq9gi0gypFaftxBLR69ElRBlAPUtGIF4kxuykBmsXi8GMk0A9LBQ==
X-Received: by 2002:a17:903:3093:: with SMTP id u19mr854889plc.107.1644959030804;
        Tue, 15 Feb 2022 13:03:50 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id lx5sm4274588pjb.37.2022.02.15.13.03.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:03:50 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] adapter: Fix loading of connection parameters
Date:   Tue, 15 Feb 2022 13:03:49 -0800
Message-Id: <20220215210349.2134229-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Connection parameters options is part of LE group nowadays.

Fixes: https://github.com/bluez/bluez/issues/293
---
 src/adapter.c | 59 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index eef50f67a..754fa6bcf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3893,24 +3893,55 @@ static struct conn_param *get_conn_param(GKeyFile *key_file, const char *peer,
 							uint8_t bdaddr_type)
 {
 	struct conn_param *param;
+	int min_interval, max_interval, latency, timeout;
+	GError *gerr = NULL;
 
-	if (!g_key_file_has_group(key_file, "ConnectionParameters"))
-		return NULL;
+	min_interval = g_key_file_get_integer(key_file, "LE",
+						"MinConnectionInterval", &gerr);
+	if (gerr) {
+		min_interval = -1;
+		g_clear_error(gerr);
+	}
+
+	max_interval = g_key_file_get_integer(key_file, "LE",
+						"MaxConnetionInterval", NULL);
+	if (gerr) {
+		max_interval = -1;
+		g_clear_error(gerr);
+	}
+
+	latency = g_key_file_get_integer(key_file, "LE",
+					"ConnectionLatency", NULL);
+	if (gerr) {
+		latency = -1;
+		g_clear_error(gerr);
+	}
+
+	timeout = g_key_file_get_integer(key_file, "LE",
+					"ConnetionSupervisionTimeout", NULL);
+	if (gerr) {
+		timeout = -1;
+		g_clear_error(gerr);
+	}
+
+	/* If no field was set don't attempt to load */
+	if (min_interval < 0 && max_interval < 0 && latecy < 0 && timeout < 0)
+		return;
 
 	param = g_new0(struct conn_param, 1);
 
-	param->min_interval = g_key_file_get_integer(key_file,
-							"ConnectionParameters",
-							"MinInterval", NULL);
-	param->max_interval = g_key_file_get_integer(key_file,
-							"ConnectionParameters",
-							"MaxInterval", NULL);
-	param->latency = g_key_file_get_integer(key_file,
-							"ConnectionParameters",
-							"Latency", NULL);
-	param->timeout = g_key_file_get_integer(key_file,
-							"ConnectionParameters",
-							"Timeout", NULL);
+	if (min_interval > 0)
+		param->min_interval = min_interval;
+
+	if (max_interval > 0)
+		param->max_interval = max_interval;
+
+	if (latency > 0)
+		param->latency = latency;
+
+	if (timeout > 0)
+		param->timeout = timeout;
+
 	str2ba(peer, &param->bdaddr);
 	param->bdaddr_type = bdaddr_type;
 
-- 
2.34.1

