Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0015AC4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 01:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE8222EBD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 01:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgLPBIO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 20:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgLPBIN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 20:08:13 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F139BC0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 17:07:32 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id lj6so573665pjb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 17:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJqrCGwAisP2cx/4QBseit/o0jzqoGKtwk0KbWzcKa0=;
        b=jaX7ABy8AyGI4j2leOzZ6lL+JGh5FryInfrERWQ3d12LeWGsFGGdAp03upkeJyiacT
         kKdtpgjEVJOjYEKE2Xo0JCC1+kI/FkMN/tUtKCuhTllmHo2I0qvYwLc1q1QlPGkySaBF
         hm1A2RSMAagsPVCpV3bx0mtAqnaKSoLY1OqsbCWd8TSbZk/Ib0XE7emRJ6NyhPxeXtcH
         IPS9cPw+SWtEJxqNTyTW9GRlXd+cykWbPHIfIorCVtWkQqqfJiWbHf6nHtgcNb0B/ylU
         TKf01ZG5XMJ9eqa9qaTj9IaPpCWwhRSsgm75Ur63biKyMVOf+iUfT4cYm2Pw01OB+3gL
         GvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJqrCGwAisP2cx/4QBseit/o0jzqoGKtwk0KbWzcKa0=;
        b=GAAnWRTbacKnFTIOCzQmve7d3QAAgnSPlgLaEqHOh3gNfxyBMKG8wUcOpE/Wd7AIGN
         dC/VJv2aBK61ABS9jdDupYVi1wf1ToEbH7rwh3XWTWBrHG19f9qgNXpmcUe/Qk6IxYX5
         P+FzKI0F5eZokGkVAT0X8pWFeYfgqqZl41BisZp9tWf5lW4gfV0j+20cxAxHMrmq9PHh
         p7M6DJLLyPvyMzZ9DsODutYEVDHfnVptXj3hMN74M9arENMQ+fQFZ9D3X5zZmWlSnGb9
         wcN+jrpuH8UgGNmnX1GbxTmfl75DGQxmxBhmhUTI41KaxwNYcbq/gwaF6Kf9oi5S1g1F
         BjyA==
X-Gm-Message-State: AOAM530H/Y9dO0OI3l4TJqa0Xed9Z6YVxEapIXNrAQmOUJ5RjH1UhoNh
        gYZTHMjYfGYWj8dgCZOX69dsa99k6fA/Xg==
X-Google-Smtp-Source: ABdhPJyM3zGmpWcvEsiqyIQ8SoEtne5vQ11ZNeRHoAbTF1bTDM8urW0h24y9PZXKZ1y2qMrWyRyrrw==
X-Received: by 2002:a17:902:8ecc:b029:d8:d11d:9612 with SMTP id x12-20020a1709028eccb02900d8d11d9612mr4563969plo.4.1608080852295;
        Tue, 15 Dec 2020 17:07:32 -0800 (PST)
Received: from localhost.localdomain (c-73-164-224-32.hsd1.or.comcast.net. [73.164.224.32])
        by smtp.gmail.com with ESMTPSA id v6sm200007pgk.2.2020.12.15.17.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 17:07:31 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Google-Original-From: Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] tools/test-runner: Add user channel tester
Date:   Tue, 15 Dec 2020 17:07:28 -0800
Message-Id: <20201216010728.989447-1-tedd.an@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a user channel tester to the test table for auto run.
---
 tools/test-runner.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index a17ec594a..ec14c270f 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -524,6 +524,7 @@ static const char *test_table[] = {
 	"rfcomm-tester",
 	"sco-tester",
 	"bnep-tester",
+	"userchan-tester",
 	"check-selftest",
 	"tools/mgmt-tester",
 	"tools/smp-tester",
@@ -531,6 +532,7 @@ static const char *test_table[] = {
 	"tools/rfcomm-tester",
 	"tools/sco-tester",
 	"tools/bnep-tester",
+	"tools/userchan-tester",
 	"tools/check-selftest",
 	NULL
 };
-- 
2.25.1

