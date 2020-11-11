Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABE3C4742C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626A52076E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTbZM9U5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgKLBdH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgKKXE3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 18:04:29 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCB6C0617A6
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:29 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so2459207pgg.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=onJPTOr6HU09L4UHiBw13vB5nu+gIxArLKPFlHjjSEo=;
        b=jTbZM9U545EVaFFER142F3kpzR8azADDhGh6Ml/pZfqdM3iLOgGJ4T6Bg1iaO9KhRD
         kTdflRuG7zDFr72QmYEHQctjAjN4VVSDkp0wYy5owPJ6Dbo+1xAHMNYI2x/bh1Hv2WMN
         rsTTr7m+ILYNSe/L20NuYdW1NeSVBgwRI/altnGLSvsc3OWlZHPSeS50qHC/e4KcsSSG
         vhY+fW2HxqKcPrtlCyn7REZCt3n7Aod5bfC8wxh7bTQs3K/aKtDAHvx9X78K1S6EhCUT
         /2eKCda2w+q+WmA6WF03SCM4bDmUsKXLjY9lvh8PjcqIk42H3eIRn3P9EWPantYWu3QP
         ZWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=onJPTOr6HU09L4UHiBw13vB5nu+gIxArLKPFlHjjSEo=;
        b=haM9BOoGbIHIp/1AybdLSdJDeG5vM0bGK3MerLcghZVbFyUQloOxj5XVq5lJG09DxY
         6quedyJSIECSqxorVdSe5G8rkCxuy6aWVh63mjVfQB8JUPLRvh2btOhw1tfG3lZlPgdb
         JA54BDZwC3fo+7Ht6UqAo1XlFaerFS2UD52OP3yKzgTkpDxFod7SfgoF7CEyFM3Q7py3
         36S820WoCy/JJZIhf1tBby4FyEDNojqzoS2kjpMUUrvHASeMZqPWm7afMOTYv+WMzZcH
         akFyetQhAl6a5/5kDdopFaOe8jboR+SRi0gRU8Lg3IZf1rAHe+YSq0SMXz1bGhd/X23O
         h/iw==
X-Gm-Message-State: AOAM533kS6qTGJK3oMpW915WAgulMiFkTCH/KAegLpu01eBxuT5kiGYm
        sgY08LnrKXIRCHcSNgV3U4JCrP2/cxaRyA==
X-Google-Smtp-Source: ABdhPJweiiCWzDNA2OrLcABIjy3taF3wnx3ds27u9RzySAZXsH1s1iscKa0x9r1M7EItO/geGegW1Q==
X-Received: by 2002:a17:90a:6004:: with SMTP id y4mr6257464pji.162.1605135868568;
        Wed, 11 Nov 2020 15:04:28 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n27sm3867767pfq.59.2020.11.11.15.04.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:04:27 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/10] l2cap-tester: Fix L2CAP LE Server - Success
Date:   Wed, 11 Nov 2020 15:04:14 -0800
Message-Id: <20201111230421.3364932-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111230421.3364932-1-luiz.dentz@gmail.com>
References: <20201111230421.3364932-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This test was failing due to the kernel now using different values for
MPS and credits.
---
 tools/l2cap-tester.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index ff641ba1d..11d549f22 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -501,8 +501,8 @@ static const uint8_t le_connect_req[] = {	0x80, 0x00, /* PSM */
 
 static const uint8_t le_connect_rsp[] = {	0x40, 0x00, /* DCID */
 						0xa0, 0x02, /* MTU */
-						0xe6, 0x00, /* MPS */
-						0x0a, 0x00, /* Credits */
+						0xbc, 0x00, /* MPS */
+						0x04, 0x00, /* Credits */
 						0x00, 0x00, /* Result */
 };
 
-- 
2.26.2

