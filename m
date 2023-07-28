Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22764C001DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 04:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjG1Eul (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 00:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjG1EuN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 00:50:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACB03A85
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 21:49:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bcc0adab4so239037666b.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 21:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690519767; x=1691124567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VaL2DgaNC+1z327qtfZ1KrQuYZxhQvPHWnqk5Q87V8k=;
        b=AGyR+9bTTmdiFXla0OMf3uaMJMcv1UxaFgmOuM3zxOFqGdAlQrjMMCZmVFPZUR3qBS
         ZK3/7QjTyDDcZXVSt+KxXndgGDPpcBqPZIWX5AHmzxvgSrJWFjK8d4kdwy646PXHNTt4
         vr5ef7xM2UkENRgVW1E3i16mLHYg34BSoqm90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690519767; x=1691124567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VaL2DgaNC+1z327qtfZ1KrQuYZxhQvPHWnqk5Q87V8k=;
        b=X6C1zK0qAGURxs860shjqeerjRz3yEjKg2VAmHPCNxRSYY0IHlg9ev4JGP2wKuhi1W
         CZdFUm39Q80dpBbLlXGlmjmMfvNtYRkSIUnVciodZIdA60zLSwgTX+qKYjLcvSu71JXL
         7P3vdAPXhKBQg/KZGZmOSyF4ETakrJVU63JaSLTkahr1Eo3WL38UJBtbD8JG1UfiePJf
         4PN2IO0BuIZNHbEXq3dWJgt0qMCj+otDf4v+kMTwHLYmVrWZ6mLpbHlovEw1NSk+GKSM
         y6I8xQOvnG1h5JFnkjkVp1Lbdrna5WZH29t9Uba7eH5cil4dh4+qqLfBrijGp67hhbDq
         irmQ==
X-Gm-Message-State: ABy/qLZ7GAQMb9DQvAK9N/t1KrCjJ8LDTJ72A/4iGZbrKOIEmBZ2s2nL
        G0P9ZUNN0WLQsl7k+MP2g5G6zqLYRc8ub6wYvzo=
X-Google-Smtp-Source: APBJJlG47XnUfODCCzVaUCX0IrFJjFmBxcez6fZ5kyWrssYh5zeHN0158Yuh9U4Jn39ETy4HIc8eMw==
X-Received: by 2002:a17:906:cc5c:b0:992:b9f4:85db with SMTP id mm28-20020a170906cc5c00b00992b9f485dbmr912164ejb.39.1690519767577;
        Thu, 27 Jul 2023 21:49:27 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:45e3:52d2:7d93:f842])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906085900b00991d54db2acsm1583094ejd.44.2023.07.27.21.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 21:49:27 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] advertising: Fix setting "BR/EDR not supported" flag
Date:   Fri, 28 Jul 2023 06:49:23 +0200
Message-Id: <20230728044923.576144-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We need to check if adapter is connectable since remote device can connect
to our device even when we are not discoverable according to advertised
MAC address.
---
 src/advertising.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index d959bf38f..b50900029 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -95,6 +95,8 @@ struct dbus_obj_match {
 	const char *path;
 };
 
+static int get_adv_flags(struct btd_adv_client *client);
+
 static bool match_client(const void *a, const void *b)
 {
 	const struct btd_adv_client *client = a;
@@ -736,11 +738,11 @@ static bool set_flags(struct btd_adv_client *client, uint8_t flags)
 	if (!btd_adapter_get_bredr(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
 
-	/* Set BR/EDR Not Supported if adapter is not discoverable but the
+	/* Set BR/EDR Not Supported if adapter is not connectable but the
 	 * instance is.
 	 */
-	if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
-			!btd_adapter_get_discoverable(client->manager->adapter))
+	if ((get_adv_flags(client) & MGMT_ADV_FLAG_CONNECTABLE) &&
+			!btd_adapter_get_connectable(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
 
 	if (!bt_ad_add_flags(client->data, &flags, 1))
-- 
2.34.1

