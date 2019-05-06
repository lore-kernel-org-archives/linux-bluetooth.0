Return-Path: <SRS0=wqlf=TG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098CBC04A6B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC57320830
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc6JB+IR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfEFMnQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 May 2019 08:43:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42465 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFMnQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 May 2019 08:43:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so15182531eda.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2019 05:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sJGE92oE4Jz1YOV4GEYgBupNI6ZSiaKwlyuNmR0DgWE=;
        b=Bc6JB+IR5yeRQYt3qEDqFq1SzYLf8K8nT6uBGP3/WI8oHol5WSyF2q8DiCagVV3JuQ
         Ug/SdMiBM7H1nUSeUKEqMIna3/yL4VcndDV3kEws8t8KYA7FGlySLlTSF3546d/hC2l/
         aC92yHxrVGVo13Rvaa09WvKJKw4p5c11gd5MYvWKiiTVZw1squL1NZwVpdumGsSfxDTh
         EWzNladWbrGLc+9Wt3+s57qiLDde1jagFihxLdOBii4A+KEM9+qTHP3DuOJCYRfEzwkS
         CFDTztsJFuv+IYpBEVNt0HLI7pMcJMqFu2GowMKHtLVDycCWm7b91baWsn4zjfnpZaUE
         JuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sJGE92oE4Jz1YOV4GEYgBupNI6ZSiaKwlyuNmR0DgWE=;
        b=FnTh65k0b8k6zAQNBYLESNLf5r+JIB9AG9uu2FORadWvwAghH6R+Okr4+JP6nNQH35
         p4L1EFMo0W66QVasRNMA3RoBBXsTeXbL6wvMTV5xjeE3VQb4IuqvpThFeeRrfEVvygro
         iZDUNFya8KzuWGrfGPCLbdDHdsJh6aElLKI+Fq0B2NCmtKGaI3sw954eVX6Un63GtD+W
         VFm2WdJBFOCsI0DxN8mBspqhvRNQaegVc1u95wLZXxlDpHVioNJeJx9cdjDjri+G3SdZ
         B4R610VpQldfGmgpB29j4uU1WT9bG4kOHrYbhqdUVjoUn/mpaUS2yoomFWPwLssOtTKp
         lWFg==
X-Gm-Message-State: APjAAAXQ7ML2uki4taSRbzskoeDwlM1nAo1HdN9iF4adfPqPXAaY4+Vv
        PFAq2Td2TEHz4Ewx2Snymcv3mOfMc4U=
X-Google-Smtp-Source: APXvYqzAev70pKUg/ZSChAz63epdZPiTVS2R+YMR/9aZ6dZnWxbJZoU6f1dx8K7sYs+YlZs+kFneTw==
X-Received: by 2002:a17:906:fccb:: with SMTP id qx11mr18931988ejb.276.1557146593903;
        Mon, 06 May 2019 05:43:13 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id h27sm1025816edb.66.2019.05.06.05.43.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 05:43:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/6] a2dp: Fix crash when endpoint respond with an error
Date:   Mon,  6 May 2019 15:43:05 +0300
Message-Id: <20190506124310.19151-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If endpoint respond with an error the callback will be called with size
set to -1 not 0.
---
 profiles/audio/a2dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d0676b577..74ada3bbe 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2418,7 +2418,7 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 	struct avdtp_media_codec_capability *codec;
 	int err;
 
-	if (size) {
+	if (size >= 0) {
 		caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
 		goto done;
 	}
-- 
2.20.1

