Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B26BC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 19:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43EC4611AC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 19:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhEDUAw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 16:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhEDUAw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 16:00:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E1BC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 12:59:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n16so5831992plf.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 12:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTu4yP5gb597c6nLmw4fzbslAPezrW5URl9bVlrmc3A=;
        b=uIZnWimPdVFTNSrBR5ljq5TqYZziWSlATCyk45RPKFtSsebmEC4L1jKwS4Prx5KZIR
         n1R/c2cOfPBAxvzOkiAc9oduJuIUad9yvkbKOsA1mA6D4gFa8R4QYilw67gxVWaBOv3Z
         bVpmz4snePL1Okk3IlV24lN1uBurqO8KysOJ+shlFduFRxZwSVPmL+OoKLpJgH7Swfan
         bBPRAP7s9t/ySUT0DIk69IUQnRD6cAFPvhEwoJXW3jwQqExsBvsb7n7yNt/45aEr/rY8
         RGHdi7KW7ODZMfXMmW/KWUkLZhfLWtnsgEamfqyhfo4RjNyx9saRjQqrydd1ISsMm+7w
         8mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTu4yP5gb597c6nLmw4fzbslAPezrW5URl9bVlrmc3A=;
        b=D6lgxmDjlMwViaRyxRpW3aUpNaElZ/ufu8zP/7vbgFbLCHyXVb3t88QnIettZNKEc1
         +wK6vrbWKn/VQPdy81S0urWk3N5nDERRDO4QZaf1yTBk0XeronyMI9fY8wqrQAwNlSUA
         7QpNwQP6X+29SnGc1NSkDQYu2qIF1Gu/YWpLS5ntCtL6/eK0XuU05U+6tNM5S6k+tIXI
         8SlCGLNuGj4a5PTmdPVc3Ec7gPRtHWJR4P/WI3zhIoYmGUzQwjg/BWQfllvbCcADkBuH
         2QV4LJIrYO5F7X36JBMCpmLP8FSVfY4XwVy4HLBq+kaZR+csYYBrb3T94dsGxZqo4utR
         ebnQ==
X-Gm-Message-State: AOAM533cbIm4XyGGaXdEDBAWZVTSYOUmk5b6kCmiIJW6zKA9lQpUplsj
        MsyaHKUC5eCXWYdzDE/QwtCNKw1FEWIxtg==
X-Google-Smtp-Source: ABdhPJzVVCDNTQBTGcRjyQY8lkTzi8Sfn7IaPbQS/5hpMc7JPu8piXd172unhwzs5X8S6mdBsBISIg==
X-Received: by 2002:a17:903:1ca:b029:ee:5aa3:c077 with SMTP id e10-20020a17090301cab02900ee5aa3c077mr27473222plh.51.1620158395351;
        Tue, 04 May 2021 12:59:55 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::f7ee])
        by smtp.gmail.com with ESMTPSA id d26sm9553931pfq.215.2021.05.04.12.59.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 12:59:54 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] checkpatch: ignore SPDX license header check
Date:   Tue,  4 May 2021 12:59:53 -0700
Message-Id: <20210504195953.901987-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds the rule to ignore the SPDX license header check.
---
 .checkpatch.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.checkpatch.conf b/.checkpatch.conf
index 419733832..72c3529c3 100644
--- a/.checkpatch.conf
+++ b/.checkpatch.conf
@@ -12,3 +12,4 @@
 --ignore PREFER_PACKED
 --ignore COMMIT_MESSAGE
 --ignore SSCANF_TO_KSTRTO
+--ignore SPDX_LICENSE_TAG
-- 
2.26.3

