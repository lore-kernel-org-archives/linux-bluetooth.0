Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E026CC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7ECC21973
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GUOxIraY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIQGrh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 02:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgIQGrf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 02:47:35 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A33C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:47:34 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id a16so984935qtj.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=e3Ng92DmlzyUG7acvtBMlEmT/DHSWBCFO/IyCWcsolY=;
        b=GUOxIraY5bahPU5r353/Z/Njg8JVTU+4ltLFwCaWwOYGnqLjFvoXHey+rlHXfrLSj0
         mUU36RB5pKDfS8HK4cZw+5qyBHWfBAtvtA437+Se5Ny+cuM9WeAJ3LZBsyy0T30z9Xzl
         VH0l/ajmMLnoR0k26RtX3G+UW3oZ1qMX5hTWVHG+BbTR+UhoyNyFccuwwgvs2PMEFmGr
         PqTXbvLonkpEOWPqDMQIRHCiooRpurEPaaMePu35ETu2OSoeV5n38ZGDCmSWxex+9lYq
         fxfcrir2Ryed8dvRLm5Ej+sFPTMB2sKkeNQFxwRvv5Bmg6FJebcLGTIgUe4QIfn1pYp0
         u2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=e3Ng92DmlzyUG7acvtBMlEmT/DHSWBCFO/IyCWcsolY=;
        b=ud4SClmQczjVA7jc0hIVvkw290Ve2QLr/CYgtg1TLAbYSDllvJlS2nq2uAY3FnvAlm
         iDoho5fxp6hnknCMg4cVX437k34m2ad5QrLgjHmawN7t9bHNI8GN6uWzskL00sEeXIUs
         l/hbAU+YhQvv2T51yosbbD9qH9oWJ9aLXdvcayHc7wK0ZGFyQW5V0DvFVfNJ8Ii5mypw
         wZ0SQpbHJMu2fCE2k99FWr0T0sRO31AOZRAzBy10e/0/8oB7SGOVLZrxGdeqbanDXpst
         bCFCRgurrZ8d0uzXXnGZ2mQ0zyGVIylN3NYTBFgpgTwwxEygjV1Cd77XuT1+Oppuiw0M
         ku5Q==
X-Gm-Message-State: AOAM5319n01D3dGl5iuMQO5l7AzDWj0Yk4Gp6DPzHPYkN8LPuyKPSpEp
        BINrbRq40mUQwxzT4y8DUDKdx/owxB+hetCHsr1P6hRQeAwKB/bYRBjzOk9URumMTawfZa8nuaV
        lc5ZPg0UxB2INlF276Bmetr6/Hplmhh5IqcuYmMWHOKm3AWBE2jJoizQ6y/q/iXvjx7E0Vs9QZC
        JGECNach2OE/g=
X-Google-Smtp-Source: ABdhPJz2ZeYqJoAzMv0NEf5Q0uORxxjToMj3h33BAV9zcwX6MrtEnA4FuxVr8N5UbI8Ms9mO4GMfZFt5a4yfK8gacg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:5745:: with SMTP id
 q5mr27078772qvx.29.1600325253789; Wed, 16 Sep 2020 23:47:33 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:47:29 +0800
Message-Id: <20200917144712.BlueZ.1.I9a1342e299d78f88c2fc8f8ce61fac84baa61a05@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH] core: Correct namings of LEScanAdvMonitor params
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, mmandlik@chromium.org, mcchou@chromium.org,
        luiz.dentz@gmail.com, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

LEScan.*AdvMonitor is already used in src/main.c and src/main.conf
---

 src/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index 038f867b5a6d..d45aed0d9569 100644
--- a/src/main.c
+++ b/src/main.c
@@ -114,8 +114,8 @@ static const char *controller_options[] = {
 	"LEScanWindowSuspend",
 	"LEScanIntervalDiscovery",
 	"LEScanWindowDiscovery",
-	"LEScanIntervalAdvMonitoring",
-	"LEScanWindowAdvMonitoring",
+	"LEScanIntervalAdvMonitor",
+	"LEScanWindowAdvMonitor",
 	"LEScanIntervalConnect",
 	"LEScanWindowConnect",
 	"LEMinConnectionInterval",
-- 
2.28.0.618.gf4bc123cb7-goog

