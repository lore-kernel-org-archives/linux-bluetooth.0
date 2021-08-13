Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFCEC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE815610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbhHMMXu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbhHMMXs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:48 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE32C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:23:22 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id u8-20020a0cec880000b029035825559ec4so6860725qvo.22
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tQd6RCihc+bYvebZID9UgOERGPLaqeRDuyLAd9ZgNug=;
        b=W6QY7K9KmRONDs7iT7ZU33+ijkgD7G6MMY1R2E6xmjJbwsVoCJhjgyHo2XKqc2F6xb
         1pZf5aNE3bPPlMYozJ2QOr8ptigDWAVMkKZreukbu/9HmSlzwq0//m2WCNerCopG/GKs
         DHTMbNeGHhVT1tEU1Vvdxl3COcKKgyz4qjVLVKLn2xvDBWoY/Qs8Yb9ExWhRTQiXlWDE
         8FIM4KygnmEomu/Dnfbg1cO/bp8f83WMBNJB3oCysq+yLMxSgwMfGN9W/73HBshE5dru
         feDwCLwh4yBU5DSKYxCEmS+IKjUP9VB+E8XUy62FZOn5BTbcNpI2zcz01rySfihyu9II
         6+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tQd6RCihc+bYvebZID9UgOERGPLaqeRDuyLAd9ZgNug=;
        b=bkXBeeRGSaz3gtc8aMO6oQtfYoDJEtYTKw3jbqigGU1V1R8yfrAIIJSwpsD/y4Iodq
         RvTjInytSpXhVwx7x8GyzE994NsNIdsPLi3zM06ueHKCd1DmLpsLNMc3JT2tytYNxshW
         aCGYuxfo+YjqCnm3TxDvq+DX/rRo/kihqBLdQrDDUpNCNQ6q1/iXIiieAhGq34eYSHHL
         +49TbVepWKOpybs5e4jTV8vscbbQWy/HcacQZeaCZCyCOaum2+LNp9cQFVrCQSexC6sC
         NMNR3rvKQfn8hCt0brJ1ruSguxqCYtpa9ur/3YSQatAQX4q/q970tCu7WYDZhFDjoo+P
         qt7Q==
X-Gm-Message-State: AOAM532vwQkPzfsFOtEORqQ8+iydHoV9obGX/zwnGgS0bdd0U14i0mpT
        1qRiDJVrJmdeQdn9aS/O0fPOuGBz9dp+Se2CsDdoBOzt/BmWZmpdRBN42+oqojfla74zO76ZFCE
        YJHrxVMLOaPd+RDakSX1LWTc9cohAo25aEkUzehcGII8lD2fyNy0gjNFZiiNG7oQ29XwvsA56bU
        8Z
X-Google-Smtp-Source: ABdhPJxLliw5hIiFAp7R8oC2CYWqlBf9qYah+ZcjAQlrASkmg9Gftvhl2MUT6df4FUCsgnxTy8+27tM0gT/R
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:ad4:42a5:: with SMTP id
 e5mr2364970qvr.22.1628857401435; Fri, 13 Aug 2021 05:23:21 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:47 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.62.I33f4d8c79045f07d4ec17d084d973cf727485eda@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 62/62] android: Inclusive language in storing LTK
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"peripheral" is preferred, as reflected in the BT core spec v5.3.
---

 android/bluetooth.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 611b717379..bf26a307b5 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2218,11 +2218,12 @@ static void store_ltk(const bdaddr_t *dst, uint8_t bdaddr_type, bool central,
 
 	ba2str(dst, addr);
 
-	key_s = central ? "LongTermKey" : "SlaveLongTermKey";
-	keytype_s = central ? "LongTermKeyType" : "SlaveLongTermKeyType";
-	encsize_s = central ? "LongTermKeyEncSize" : "SlaveLongTermKeyEncSize";
-	ediv_s = central ? "LongTermKeyEDiv" : "SlaveLongTermKeyEDiv";
-	rand_s = central ? "LongTermKeyRand" : "SlaveLongTermKeyRand";
+	key_s = central ? "LongTermKey" : "PeripheralLongTermKey";
+	keytype_s = central ? "LongTermKeyType" : "PeripheralLongTermKeyType";
+	encsize_s = central ?
+			"LongTermKeyEncSize" : "PeripheralLongTermKeyEncSize";
+	ediv_s = central ? "LongTermKeyEDiv" : "PeripheralLongTermKeyEDiv";
+	rand_s = central ? "LongTermKeyRand" : "PeripheralLongTermKeyRand";
 
 	for (i = 0; i < 16; i++)
 		sprintf(key_str + (i * 2), "%2.2X", key[i]);
@@ -3066,11 +3067,12 @@ static struct mgmt_ltk_info *get_ltk_info(GKeyFile *key_file, const char *peer,
 	char *key;
 	unsigned int i;
 
-	key_s = central ? "LongTermKey" : "SlaveLongTermKey";
-	keytype_s = central ? "LongTermKeyType" : "SlaveLongTermKeyType";
-	encsize_s = central ? "LongTermKeyEncSize" : "SlaveLongTermKeyEncSize";
-	ediv_s = central ? "LongTermKeyEDiv" : "SlaveLongTermKeyEDiv";
-	rand_s = central ? "LongTermKeyRand" : "SlaveLongTermKeyRand";
+	key_s = central ? "LongTermKey" : "PeripheralLongTermKey";
+	keytype_s = central ? "LongTermKeyType" : "PeripheralLongTermKeyType";
+	encsize_s = central ?
+			"LongTermKeyEncSize" : "PeripheralLongTermKeyEncSize";
+	ediv_s = central ? "LongTermKeyEDiv" : "PeripheralLongTermKeyEDiv";
+	rand_s = central ? "LongTermKeyRand" : "PeripheralLongTermKeyRand";
 
 	key = g_key_file_get_string(key_file, peer, key_s, NULL);
 	if (!key || strlen(key) != 32)
-- 
2.33.0.rc1.237.g0d66db33f3-goog

