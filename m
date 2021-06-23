Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE07CC48BC2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 04:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5534611C1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 04:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFWEwE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 00:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhFWEwD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 00:52:03 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28971C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jun 2021 21:49:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id p9so737312pgb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jun 2021 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeeLQxuj66jGVpXa6UNilbd/H4ckQmm68Ab/6lrUDk0=;
        b=AD0MW5jzRpPTvE/UmVY0O7XSMC/FLrnqmzN2S2cZXNKAJlo64djxMH2QcmnUHedM8j
         OPG6tbNwuCb+EwDEBpTFHVxs8ayUxuvu6oBkIc4FxrG6/Yv545EV5H9PpT0PioVNjL2Y
         9mVfMCEu47bFG1NMI3ixz7upU27wxAwGyCv0mXdFaK19ejDJX9hLf3I02Row1f3dYIwZ
         L6HYnhNorx68Y3OeZGaJHj3rPyQSmQ4uRpUKlL4t/O5RuSJ3fqCnsHMho0aheJDwyBwK
         F2K179onLLWXJ9Lz32IqEvyYSvf40egHUCVGB7HTXK+svAnsNRgS9MzqRrI6LL3bayKD
         TEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeeLQxuj66jGVpXa6UNilbd/H4ckQmm68Ab/6lrUDk0=;
        b=Ck2GutEBhwu9W7br4EiqEG5SIpwwUKEfIiqRm+a/HrtJnkyLnMfdTG0IhIpywFpsDQ
         5ZgX9cqn69EVU/Q7Wrak/X4+mjXSaqy4SLI97dYDe+KNtAMLmyXAw23JgU/AvdiaPmOa
         lA4oFwxjbK8yeD8nahykd+28THcB1nHwIntMsQKp0Ie6t3n9ky00ewWF1Vd/TCg/ZSdd
         DCXgbNh0uRyz9Q9iAZEggQND7Drj9KuxS5uKPAHT7GnbJAtEuXSIGeMuvWAJh6Huw+SR
         mJQP6oj/JW+pzYy/NbBmCqZpSn+VcszlzNCa63PRPRmNisUs4FhV0N4gJ8H5da1DPVCn
         A4Tg==
X-Gm-Message-State: AOAM533KpCHJ+/rOViOPy1J8EAvRUzqABv2ga2nlz/WIuCfx+2vQQ7m5
        tTWOMVsebioKnwZrrsJbl5ZOlqgADdQ=
X-Google-Smtp-Source: ABdhPJxgvujr+ASphrF+PtxGFMQBthOaC0AfsUvYeUt23fFyr8XQNscuUiNsSflhH8wklI6WoV2E/w==
X-Received: by 2002:a62:d108:0:b029:304:33e5:4dde with SMTP id z8-20020a62d1080000b029030433e54ddemr7103707pfg.74.1624423786409;
        Tue, 22 Jun 2021 21:49:46 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id c184sm900129pfa.38.2021.06.22.21.49.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:49:45 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 1/5] tools/mgmt-tester: Enable High-Speed(HS) test cases
Date:   Tue, 22 Jun 2021 21:49:40 -0700
Message-Id: <20210623044944.602205-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch enables the BT High-Speed(HS) test cases by enabling the HS
in the kernel config.
---
 doc/tester.config   |  1 +
 tools/mgmt-tester.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/doc/tester.config b/doc/tester.config
index 661d7a0b0..850fb6a38 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -29,6 +29,7 @@ CONFIG_BT_RFCOMM=y
 CONFIG_BT_BNEP=y
 CONFIG_BT_HIDP=y
 CONFIG_BT_LE=y
+CONFIG_BT_HS=y
 
 CONFIG_BT_HCIVHCI=y
 
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index fcce699d3..8cae376f4 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5315,7 +5315,7 @@ static const char ext_ctrl_info1[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbe, 0x01, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x00, 0x00, 0x00, /* current settings */
 	0x09, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5360,7 +5360,7 @@ static const char ext_ctrl_info2[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbe, 0x01, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
 	0x0D, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5391,7 +5391,7 @@ static const char ext_ctrl_info3[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbe, 0x01, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
 	0x16, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5426,7 +5426,7 @@ static const char ext_ctrl_info4[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbe, 0x01, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
 	0x1a, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5485,7 +5485,7 @@ static const char ext_ctrl_info5[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbe, 0x01, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
 	0x1a, 0x00, /* eir len */
 	0x04, /* dev class len */
-- 
2.26.3

