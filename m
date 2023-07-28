Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C484C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 08:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjG1I5r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 04:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjG1I5Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 04:57:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B67D2736
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 01:57:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bed101b70so68042166b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 01:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690534642; x=1691139442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvwrU8X/59pee1qfptP4CoRTFaZVbeHq4fhpo7aiOYM=;
        b=AqFYMub8hjuhTdsufihqTaegK++FqJAHB7wVT3XS0Xj4u1AO8Cw93gUDaFF93bqdjq
         RhSSdGpcwpZynyNXj0/W0Hu5ZBoE6bLd8SOGwWVhlbX56vmjSQNEu4A+qdMNOvocthVb
         9I5JMzGoE7WK5YeFiZcN3QBmRF9gyojE/RBsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690534642; x=1691139442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvwrU8X/59pee1qfptP4CoRTFaZVbeHq4fhpo7aiOYM=;
        b=F4rb1uIZZiS0+v+pmSi/6+8b+wuLfe/OlZaIy4LN77S8fHe205zlNmKlx2jLvVjvH4
         Z+Gy08D089of5FYdlnUN9zMp1F5OFtYemxhXdOXdXPKwLgkt4frori8/aie0/9KmrXgI
         2By8gfdvn4BSigs/MNAO1Anf7OX6hYG/MKcsJVdi69VAwBFdEzAHzdas9WwQJvlZ0c2J
         SD1lfS7Tk/vn64FATVFM2No7c0gxYtnAs7OkwAUe1JLkHfITb6GejhEs6R9+44X6yG8u
         MHyseYdxgjfiZsaiW1cT330MTb/SZe+a2hdFCjtU8BXX4U0pOOWtZpH1/OtmURui6i5y
         vQ9g==
X-Gm-Message-State: ABy/qLaGiE+3LXJf6Lj1ETgl7JEyUqSdM+D45E8I46xNOmJ7ntWoywQ+
        yILwbScYgGzTPNKEEAxGOs1ZDb0zcsuacVpYPbo=
X-Google-Smtp-Source: APBJJlEtZ1W7pfFxwTccqnEdfaT3cjDez4zQJOmGI/fkexoiyRvvlGu+XmYKz16ZJr1k3qy0dpnv4w==
X-Received: by 2002:a17:906:2c6:b0:98e:2097:f23e with SMTP id 6-20020a17090602c600b0098e2097f23emr1385386ejk.77.1690534641715;
        Fri, 28 Jul 2023 01:57:21 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:353d:c2fa:e0df:3251])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906408700b0098de7d28c34sm1782205ejj.193.2023.07.28.01.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:57:21 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] advertising: Fix peripheral adverts when Discoverable = false
Date:   Fri, 28 Jul 2023 10:57:13 +0200
Message-Id: <20230728085713.683655-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is a problem with this configuration: Type = peripheral,
Discoverable = false and Adapter is discoverable

In this state device will start advertise discoverable advertisements
even when user wanted non-discoverable advertisements.

This change will add empty Flags when "Discoverable" parameter is set.

Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 src/advertising.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index d959bf38f..49861e1a2 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -727,11 +727,6 @@ fail:
 
 static bool set_flags(struct btd_adv_client *client, uint8_t flags)
 {
-	if (!flags) {
-		bt_ad_clear_flags(client->data);
-		return true;
-	}
-
 	/* Set BR/EDR Not Supported for LE only */
 	if (!btd_adapter_get_bredr(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
@@ -1447,7 +1442,8 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		}
 	}
 
-	if (bt_ad_has_flags(client->data)) {
+	if (bt_ad_get_flags(client->data) &
+			(BT_AD_FLAG_GENERAL | BT_AD_FLAG_GENERAL)) {
 		/* BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part C
 		 * page 2042:
 		 * A device in the broadcast mode shall not set the
-- 
2.34.1

