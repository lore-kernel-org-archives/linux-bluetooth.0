Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2D3C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 05:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9626103C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 05:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhHTFSs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Aug 2021 01:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbhHTFSs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Aug 2021 01:18:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186CDC061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 22:18:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so6457415pjb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 22:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nPDvDJqSCuWssWpPmAqlRNZkqophHAZC32ywPblLT8=;
        b=nujvBldQ38t5MY0e8mFFNIr1OoyYSQqmkq+NA30EJuGuqdAq541aU1XlfkAaC5AaIQ
         R8Hdpq2kXYB/6vUM1K1WMrPj50vyDGKa1EiowGw21AsqA7H+uHai0BGJkBMtys/dtLfv
         8OtNf+CqT4FOCzO2aRLWp7Mq7GdusTX0TfOA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nPDvDJqSCuWssWpPmAqlRNZkqophHAZC32ywPblLT8=;
        b=kcaumP2m2DirwO2wp0GORwf4f4AcxSH8S0dfPNwr9DhGJSAno3kBHvyvswSaOVGC1K
         a4Tys1uh/by+STxgFW+a4fL7d2TBcAIY/OnuYs3exWj5FAKju0Hr/35wNAm0avcJ1QKw
         Z7xlpaIfz/BiuGz1G6Ssxso0XZbZNCzHHCNP/jH90XE4ASPy4zhIWvwD0GSxeHvLVp2X
         3gFrckPsAULKfnlUBUBmRZZJL9x/RnCLA/ISaGvXjndStDqPrcj1Ye88IRwI6/XEYAHH
         b+pTNkr5hW2cfYBCH5FyDBzmPY+5IR1nqS1GvCdKVAEngziQ+inC2UGftGszoDnr1HyJ
         RBcg==
X-Gm-Message-State: AOAM530CsxmVIY61M7+jV1NdynycOBn53hb8jqvcyBePOeIXja7Q6gh2
        aVbSnTFBSAhI4tgojOzzLPz03gCnDI5SLw==
X-Google-Smtp-Source: ABdhPJzD7iKD0yiuAIISp1GRzH+j2fxVElO8kakLfZ1SXaPPj/R8mhn4bB6We12CDllkKW+g1jfg1Q==
X-Received: by 2002:a17:90a:c244:: with SMTP id d4mr2806459pjx.38.1629436690249;
        Thu, 19 Aug 2021 22:18:10 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:7a7d:6851:a4d:8e9])
        by smtp.gmail.com with ESMTPSA id 15sm10498452pjz.18.2021.08.19.22.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 22:18:09 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v1] tools/mgmt-tester: add a exp feature to Read Exp Feature - Success
Date:   Fri, 20 Aug 2021 13:18:02 +0800
Message-Id: <20210820131751.BlueZ.v1.1.I165b6fc2b20d80c8d18946434005f0269d92f489@changeid>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a new quality report feature to the
"Read Exp Feature - Success" test.

---

 tools/mgmt-tester.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 8afd02c32..da53e4484 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9334,7 +9334,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x02, 0x00,				/* Feature Count */
+	0x03, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
@@ -9343,6 +9343,10 @@ static const uint8_t read_exp_feat_param_success[] = {
 	0xde, 0xb3, 0xea, 0x11, 0x73, 0xc2,
 	0x48, 0xa1, 0xc0, 0x15,
 	0x02, 0x00, 0x00, 0x00,			/* Flags */
+	0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a,	/* UUID - Quality Report */
+	0x70, 0x93, 0x2d, 0x49, 0x06, 0x75,
+	0xbc, 0x59, 0x08, 0x33,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success = {
-- 
2.33.0.rc2.250.ged5fa647cd-goog

