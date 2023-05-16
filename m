Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EA2C77B7F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 May 2023 20:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjEPU7f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 16:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEPU7b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 16:59:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291E6A69
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae3ed1b08eso1485295ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684270769; x=1686862769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBo++OSugDX16NBEk0VGJUq2Te47F5j23MhSdO7vJs0=;
        b=Eb3u0b2SBjyrd3lRolQJjbpHvVgSNNCxoKudqIPVxpC6EiCQ4n+RzDfEmf+YVNNmej
         o1uFgNJmSWfREQrAyeVsLV84i5ejW3hjJZYvQkgsNzYrkAV2DXPy2+ligQZI5CWOF/YR
         pUW6r23f7yEPAR61/TFwbGrDT3XSUxkVtusuoJtqEp/ig0yCfVfcZHN2ockgqiUo4GHx
         nTEfpnnF6iaTY4d1I9ByHDCG6GNfClFhbgwb1DBhwWmC80QpUsjV1x/pM5o3Sc2Yk75Q
         WHQEoqpYrP/gJKErojcaXYhToU2G8PseFH72ykgvswyRl8LaY6UpxGk4rdEhhVqoX2lE
         PEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270769; x=1686862769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBo++OSugDX16NBEk0VGJUq2Te47F5j23MhSdO7vJs0=;
        b=DiQb3suay6PFkbPLzhKwgOP1q8mmv1QskyBnwzjAs0qS/Wgq+khDc9ZybuHi8ojv3I
         n7Zxc2sdobiV5KrZ31bTR8AM6G7cCyLsHx2NXkk03BZWcD+IgU6jE9Wy8LGGoXEI1RrY
         hvyvsc5ZjDlp8lUyRFbM6cS3D0x5k9fi+ygFlof+rhyb5DrtN9qWPJ8DpHrcidUb9lTv
         uUR5Cz6BbOPAw8TqN01k0PvXw3la6XEBlmBfsTp7//a/ryBbLfHLFRXUs6IAFbpUUcl1
         uz7wvaJ6jIJ5Vir6W4WDEzJ25WzwdnPq3rlQgQjxTh4jhxhwxkVJQKedeSi86U8ZZVPj
         jytg==
X-Gm-Message-State: AC+VfDytvdF8/bTWkipF39/zZrpICs7ge8+x5hiKGH2qeKJRuUyUzN83
        JHyekg9/klD6LP/M3/XzB6ysYs86VQ0=
X-Google-Smtp-Source: ACHHUZ4kxJMjXSGaNKDA1OhAmqDjrwbgGK+mgF/y0YDgbO3e90nuJTY/bCjCoEXJei5zo3EypU992Q==
X-Received: by 2002:a17:902:da91:b0:1ae:f37:c1ab with SMTP id j17-20020a170902da9100b001ae0f37c1abmr13145941plx.25.1684270769152;
        Tue, 16 May 2023 13:59:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001acad024c8asm14272237plo.40.2023.05.16.13.59.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:59:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/10] bap: Mark driver as experimental
Date:   Tue, 16 May 2023 13:59:16 -0700
Message-Id: <20230516205924.1040506-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516205924.1040506-1-luiz.dentz@gmail.com>
References: <20230516205924.1040506-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses the btd_profile.experimental to mark the driver as
experimental.
---
 profiles/audio/bap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8f12fc410f67..1a543a9ce99b 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1354,18 +1354,19 @@ static struct btd_profile bap_profile = {
 	.accept		= bap_accept,
 	.disconnect	= bap_disconnect,
 	.auto_connect	= true,
+	.experimental	= true,
 };
 
 static unsigned int bap_id = 0;
 
 static int bap_init(void)
 {
-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
-		warn("D-Bus experimental not enabled");
-		return -ENOTSUP;
-	}
+	int err;
+
+	err = btd_profile_register(&bap_profile);
+	if (err)
+		return err;
 
-	btd_profile_register(&bap_profile);
 	bap_id = bt_bap_register(bap_attached, bap_detached, NULL);
 
 	return 0;
@@ -1373,10 +1374,8 @@ static int bap_init(void)
 
 static void bap_exit(void)
 {
-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
-		btd_profile_unregister(&bap_profile);
-		bt_bap_unregister(bap_id);
-	}
+	btd_profile_unregister(&bap_profile);
+	bt_bap_unregister(bap_id);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(bap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 
2.40.1

