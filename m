Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD91DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 May 2022 22:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242735AbiEPWNL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 May 2022 18:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348403AbiEPWNK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 May 2022 18:13:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0FB2AC51
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 15:13:09 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a10so17499078ioe.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 15:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EhF9CMCiGnnsQMWw2AcnUTFA1xJBYKvdFqXkKgpPp6A=;
        b=Qk5Z/zwR3m4rsDmULTuJ2LmOorUIPwOU3bJLkJNmLJuiFuOQMiMItqEEHk4k9LoFw5
         hEznVu0NBuS5HCWAnvOrZZeV3wpt/3L7+fszr+blBZRG4Ztckl7YarY3lszs7RUw6UTw
         R4WBVpnGEZcFL12mLfR1By4fHYIWb1DU9g/lZ2ibqHc8N5BY2cRaTM0FeINCGH7+qOMP
         PGu5qyRaqhRFyEB/N0YjjGXw/j/W0wczslWZE+eA8Zwv9d7eZbTxdgVLZPVFuNfb/MaO
         uTjidlueJNz+2wRmlyF8VcU1+/F36HDtjo5jf7gGRod3KAufSrnxqV4nW226Ow7y41er
         kKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhF9CMCiGnnsQMWw2AcnUTFA1xJBYKvdFqXkKgpPp6A=;
        b=eDU30vNNxKNs+qH1AVoQtoCMBKfRVbN1mI/x8Ov8hCvyYKJ2PdiWRg2SV8jjh7CNSM
         e82Ng3hGeCZ0hj4vtF+qwdcbxE0ubastG9E9Zwyqs/aO8mtX0Tzcmh1f8C70jJxDGHCV
         CUqgq81S7gHEhowXPP5pJEE3R8vzkDnWpUYo5AgEzG4V/9Xinfwd948boIefbN3uJANR
         EsctZBiXGwEhnlKnU9VDAK4d4IeXUfgNbpoPw0RILbU0JFsjPsdSsymMyY2mgvVSXqeM
         4tYA93MWP+n8p959Iben31UiwO7XUkqRCnK8+ZozX48UCl6GIiqrMq1zPPmBmqNPdZOp
         +YNA==
X-Gm-Message-State: AOAM533Xp5KIvDX+/RcS/s1ihTfuuPIw45okgQNsAj/shOI8U32GXlAk
        Q/81AhBWBUWW9YZuf6z/7MX9E0ucZk8=
X-Google-Smtp-Source: ABdhPJwZD7a4DvgohBjwJ9TQMkgzPPAfQ+jEeKpz7lo9w34jZYrJxgUKCfv7SrJgowdgaO1bF08RNg==
X-Received: by 2002:a05:6638:411d:b0:32b:7465:fee2 with SMTP id ay29-20020a056638411d00b0032b7465fee2mr11073711jab.318.1652739188491;
        Mon, 16 May 2022 15:13:08 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t9-20020a6b5f09000000b005e1729b55ccsm166426iob.1.2022.05.16.15.13.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:13:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/8] mgmt-tester: Fix Read Exp Feature tests
Date:   Mon, 16 May 2022 15:12:59 -0700
Message-Id: <20220516221304.1744026-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516221304.1744026-1-luiz.dentz@gmail.com>
References: <20220516221304.1744026-1-luiz.dentz@gmail.com>
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
index e5319d123..bfa5905e0 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9798,7 +9798,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x03, 0x00,				/* Feature Count */
+	0x04, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
@@ -9810,7 +9810,11 @@ static const uint8_t read_exp_feat_param_success[] = {
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
@@ -9822,11 +9826,15 @@ static const struct generic_data read_exp_feat_success = {
 
 
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
2.35.1

