Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA658C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 17:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEF3207ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 17:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+jlhwt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgFERs3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgFERs3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 13:48:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEE3C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 10:48:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d8so815158plo.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 10:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wnUBnIGiHnmupdesTjLijqyj8kpX2av7C0AkM6kHts=;
        b=W+jlhwt/R96V7vzukFGj082JvPvOIjRRys5jmwV7SWkrw4+zcyseWOgq7HAQsdDNAS
         1TU3+qUbfy2eYq8MnYrrRVsr4Df2SUyYN+EBUQ7eowGdAe1KtDaVbbSeyczJZY1HzzYF
         prJt1UZ1ZrOVdP6f4Zxpo/j09zWmCchSasnjesbYZaSoYhfPAeaXpgryOI+7zKiZRbos
         /JjpgWZH0+dmA4eP6aptbSRQJ5AEQkgWalA+EI05y/0lkgk+eaqeKsM1K9bVd5U5crk7
         uYfbR4GlpT/haVL1HgYdN6rqHffbDe4Xz+YdKyM2UxqJDdRrTuSsTB7N6vqjc9OT0BYT
         RdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wnUBnIGiHnmupdesTjLijqyj8kpX2av7C0AkM6kHts=;
        b=D6I6xGrRcDRMO9dGzZOwU851oZRXvOt/BqKd4qWXuyGLvq5nx2Khz6Kv1tv9S1EQ95
         an1K/lrKe90h9gUyfQf4a6NWEzL3z4zMiQ2OLeNAx8SGI8A2pbb+j+MpLuhaAjb5s2lK
         8tA5rR4mH/DRNPoZiiRKdsjIgbB/FeOQPUVkZqey/W8OcfBIv8JsLNB68v0bohV0WkAY
         sHpXKVDguEc6dAsHrVaIlE9nTrFmzLsVzQfvaB6dtzn8L5pqhXM1UqIqUSEH73Q3Xhfs
         m1sfPIaKWSJI5o4k7gmaqBD3AMr26qoqz6GgnYX7l+PSe5qUmGk6kp4cirixTiwe9XAH
         Dpzw==
X-Gm-Message-State: AOAM532xNra8CQrXV95g4zRwM/fZuCIcmyZKUTy1DT30LB2lYjXAHlns
        A2tKRYu5cK0XoR0zP/WWocCjrZP3
X-Google-Smtp-Source: ABdhPJw0Ql6MnV3V7gF5cm065wD9dhw6gFXHoo0iBijUxW3EQhuUJTFIvqpOFlQrseOlv3f/NIVptg==
X-Received: by 2002:a17:90a:714c:: with SMTP id g12mr4513131pjs.31.1591379307302;
        Fri, 05 Jun 2020 10:48:27 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 128sm217173pfd.114.2020.06.05.10.48.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 10:48:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/ad: Add defines for possible flags
Date:   Fri,  5 Jun 2020 10:48:24 -0700
Message-Id: <20200605174825.717902-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds defines for limited disverable, general discoveral and BR/EDR
not supported.
---
 src/advertising.c | 9 +++++----
 src/shared/ad.h   | 5 +++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 829c481f6..4c91586c2 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -673,7 +673,7 @@ static bool set_flags(struct btd_adv_client *client, uint8_t flags)
 
 	/* Set BR/EDR Not Supported for LE only */
 	if (!btd_adapter_get_bredr(client->manager->adapter))
-		flags |= 0x04;
+		flags |= BT_AD_FLAG_NO_BREDR;
 
 	if (!bt_ad_add_flags(client->data, &flags, 1))
 		return false;
@@ -700,8 +700,8 @@ static bool parse_discoverable(DBusMessageIter *iter,
 	if (discoverable) {
 		/* Set BR/EDR Not Supported if adapter is no discoverable */
 		if (!btd_adapter_get_discoverable(client->manager->adapter))
-			flags = 0x04;
-		flags |= 0x02;
+			flags = BT_AD_FLAG_NO_BREDR;
+		flags |= BT_AD_FLAG_GENERAL;
 	} else
 		flags = 0x00;
 
@@ -1065,7 +1065,8 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		}
 
 		/* Set Limited Discoverable if DiscoverableTimeout is set */
-		if (client->disc_to_id && !set_flags(client, 0x01)) {
+		if (client->disc_to_id &&
+				!set_flags(client, BT_AD_FLAG_LIMITED)) {
 			error("Failed to set Limited Discoverable Flag");
 			goto fail;
 		}
diff --git a/src/shared/ad.h b/src/shared/ad.h
index a31df0fe5..19aa1d035 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -71,6 +71,11 @@
 #define BT_AD_3D_INFO_DATA		0x3d
 #define BT_AD_MANUFACTURER_DATA		0xff
 
+/* Low Energy Advertising Flags */
+#define BT_AD_FLAG_LIMITED		0x01 /* Limited Discoverable */
+#define BT_AD_FLAG_GENERAL		0x02 /* General Discoverable */
+#define BT_AD_FLAG_NO_BREDR		0x04 /* BR/EDR not supported */
+
 typedef void (*bt_ad_func_t)(void *data, void *user_data);
 
 struct bt_ad;
-- 
2.25.3

