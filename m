Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B1AC63798
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 18:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B042078E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 18:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGzqEynr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgKWSen (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 13:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgKWSem (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 13:34:42 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B915FC0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 10:34:42 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id w4so15022534pgg.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 10:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjSTmjREhRpyyfmqFOwT1tguRxk6NEJhHsifbvaaLiY=;
        b=FGzqEynrC27XCQqmcQTVkNgbI/ywblgJ6le0rL7fCL7CQ50D7uN6WkyLbKZC9b2t6m
         sQAp5VDNE/8RmISVvCph8ibyRIMvDfvyq4iQw38Vf3jAzjWbl2NM6z6Picf7XdNF5Uku
         vLMIRJG4ZWeYmXj43XNM/mPZbAb4pJsoJnlWwGRAJhxTHI09/JzN48TFkM4hGNavRa4C
         NQozi3foEtrEiT8aS1/TmzTxSHTieNo3v92jpssfX6VJV7gt4XBHxrB/NdGYSejooevF
         GTsYKVXTQTydKl2mua5/dFyp+YKibbq9/H0T3CejKqGFyBYPT0odkyQyR5wBduknQOh/
         aenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjSTmjREhRpyyfmqFOwT1tguRxk6NEJhHsifbvaaLiY=;
        b=Y6VB3dzp+ycjso79SEzoIu6vAx2ht7PHbVgFeXde9nmKn++b77dq1qXA0vlqUtNd4j
         1PPZo3zoZZn8JjFYr+EpiEF4Dm+Zi4kN01jgBfKM2fxL4QNdaduQ4BjJtW0Pnn6f1nqQ
         NG2eu4WgPDr9o40+srcMpcRCf0JlV0idwEVDdH43D7QrCwNdWS/0psPWyZWb7KMasJ8t
         LG6DUNJyp05gT2fPFvQBURWY0PbjhplpP3PBlWFQUkMj1hhnAZlaMdss4RbnYya+Uj1S
         b/GRE5BVdbYy011X6vKBH5rZD7AumCQcf0LgKqGMTMe1y6bkjfZpDYyhuXyN/FMXRa6W
         1Y3A==
X-Gm-Message-State: AOAM530mi+ddwyqH4aQCipotLSUNg1z5tTBf5J/OyRCfLokQl3P3Tyk5
        DDiPtipQCv9RU0WHB6EUAUcYbYdhZXE=
X-Google-Smtp-Source: ABdhPJyNsVilG8RKucnua7fyciECGy4D67fMR/VuOXYJMMGK4lcNdyI5nz3X/5QzLwqYL3UIVeeeQQ==
X-Received: by 2002:aa7:969d:0:b029:196:59ad:ab93 with SMTP id f29-20020aa7969d0000b029019659adab93mr641598pfk.16.1606156481947;
        Mon, 23 Nov 2020 10:34:41 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a21sm84165pjq.37.2020.11.23.10.34.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 10:34:41 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] a2dp: Fix crash when SEP codec has not been initialized
Date:   Mon, 23 Nov 2020 10:34:39 -0800
Message-Id: <20201123183440.433677-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If SEP has not been properly discovered avdtp_get_codec may return NULL
thus causing crashes such as:

https://github.com/bluez/bluez/issues/57
---
 profiles/audio/a2dp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 59d11a0aa..f1e4fa990 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1887,8 +1887,8 @@ static void register_remote_sep(void *data, void *user_data)
 				sep, remote_sep_free) == FALSE) {
 		error("Could not register remote sep %s", sep->path);
 		free(sep->path);
-		sep->path = NULL;
-		goto done;
+		free(sep);
+		return;
 	}
 
 	DBG("Found remote SEP: %s", sep->path);
@@ -2627,10 +2627,15 @@ static void store_remote_sep(void *data, void *user_data)
 	GKeyFile *key_file = user_data;
 	char seid[4], value[256];
 	struct avdtp_service_capability *service = avdtp_get_codec(sep->sep);
-	struct avdtp_media_codec_capability *codec = (void *) service->data;
+	struct avdtp_media_codec_capability *codec;
 	unsigned int i;
 	ssize_t offset;
 
+	if (!service)
+		return;
+
+	codec = (void *) service->data;
+
 	sprintf(seid, "%02hhx", avdtp_get_seid(sep->sep));
 
 	offset = sprintf(value, "%02hhx:%02hhx:%02hhx:",
-- 
2.26.2

