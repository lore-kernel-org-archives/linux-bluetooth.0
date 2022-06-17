Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D26CCA47E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 22:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347171AbiFQWV0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347009AbiFQWVZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 18:21:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E3060DB7
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:21:24 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id w29so5122041pgl.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6D1hJqWb5CVQpZ+A+TOtKHG9Z9QZXwU0qqN3it9xkP8=;
        b=Sdjidw62sk0//WZcea7hRXJjvZ/vs9Sj6hLDBRfmQXQVchzHY9+nVkJ5gPbocy1Mbv
         7yvrwgUcBQiWU811wWUDrR35ueiHpCIxTxtj1auAoJ8Tw/7kprvptorCd1Ty9UPmLKE5
         XApE/tRw19SWzQrxanhUaFmJQPJcGllr1Z2D/bs+p4bDc64+TjPtz8cb9XCiEO+BMjVG
         IWXzQ8mTUgP6b347PvdxBAmmxb281snys9A4sFVwsO4TW88QYxz1xTU5gN5vwC4ByydN
         VE3RlrqT50m/JCYvJE/JSYxi3KihmxRze9IlzyN9+IB96fh3iDb7iCPcdNuv588RoUp2
         QiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6D1hJqWb5CVQpZ+A+TOtKHG9Z9QZXwU0qqN3it9xkP8=;
        b=P9Pj4jflH01kyh/t8VGHfmFk+yxVCF7YFscWpd5oFdQ6Nzw0t3wnlTPOCe0RWj7mZQ
         7OMS4w0FXUO88FvD2o8sYcmP0pjN5kvL5Qz1ZNH5x85umuBfmrTF9laFRgTtMy2F3Hc5
         E+CAHzMFtq5TSDjhmWGSSuZMC4cWnSwOQrNAUvI0iCxfWbB1KxE44MfEFwi7UriXgQ1R
         lc209P3fZObamSZU+rVDBOmDIcV0nQEnkeAGDWwwIejj5cNQEswcXRmNGlMZgtJrO33b
         +gU9tl800V28eiAVzMcR6E7iZWbuyME/gNk0CylHOiW1JCUX5jO92j1097Rc42DMW1T0
         HizA==
X-Gm-Message-State: AJIora/o2OVnYa1d3EVzV3OjbXxzxWFdEScmRYUp3VmWXpNAh/LzzEPm
        iTCCiHmAtXaIRk2zzZTqsTRM4DRFg68=
X-Google-Smtp-Source: AGRyM1tn0XyZ9BM7aPPm03skNDhSZeaysCx5oc8s/XSg7OWi44TuQQ0hv1n2SFHlUDX42SMC2kTcFA==
X-Received: by 2002:a63:3183:0:b0:3fd:6797:70a8 with SMTP id x125-20020a633183000000b003fd679770a8mr10840197pgx.206.1655504483495;
        Fri, 17 Jun 2022 15:21:23 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v9-20020a056a00148900b0051829b1595dsm4165392pfu.130.2022.06.17.15.21.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 15:21:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v6 3/8] mgmt-tester: Fix Read Exp Feature tests
Date:   Fri, 17 Jun 2022 15:21:14 -0700
Message-Id: <20220617222119.1413958-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220617222119.1413958-1-luiz.dentz@gmail.com>
References: <20220617222119.1413958-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds ISO Socket UUID as response to Read Exp Feature.
---
 tools/mgmt-tester.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 2b27394a1..0d4d7dfe1 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9781,7 +9781,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x03, 0x00,				/* Feature Count */
+	0x04, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
@@ -9793,7 +9793,11 @@ static const uint8_t read_exp_feat_param_success[] = {
 	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
 	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
 	0xce, 0x5a, 0x69, 0xa6,
-	0x00, 0x00, 0x00, 0x00			/* Flags */
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6,	/* UUID - ISO Socket */
+	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
+	0x88, 0xf1, 0xba, 0x6f,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success = {
@@ -9805,11 +9809,15 @@ static const struct generic_data read_exp_feat_success = {
 
 
 static const uint8_t read_exp_feat_param_success_index_none[] = {
-	0x01, 0x00,				/* Feature Count */
+	0x02, 0x00,				/* Feature Count */
 	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c,	/* UUID - Debug */
 	0x01, 0xab, 0x9f, 0x46, 0xec, 0xb9,
 	0x30, 0x25, 0x99, 0xd4,
 	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6,	/* UUID - ISO Socket */
+	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
+	0x88, 0xf1, 0xba, 0x6f,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success_index_none = {
-- 
2.35.3

