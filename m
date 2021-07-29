Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD5C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B27560FD7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhG2DgL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhG2DgJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:36:09 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48066C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:36:07 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id f9-20020a05622a1a09b02902615523e725so2102866qtb.21
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7ixzuuNDgee9bW2cjdqHBGkL1CtEaTFP5FgsMVEumf4=;
        b=aEspkNGqzizfEYcNrjbxGX0q2ARs+gOXklKjvwLsWIO6thb6R5gwsqGaNBAfQOkJt0
         s/HHOwuv4fOjDNAkp9LKnhv7oJES+xJl9vrhSfK3oXOcSUbfmpRZ9XlGcF8hTKMxOq/u
         Y8ftMjle/PWJNKJduJ38/5i0sH+Z3VHIFf/6i4v3+t3Ooc/j1NMx9/Ha9HFHMKTfZSFX
         MVKgmmE6MrkHIytuiAyGJv2WvFM56KnjTbUYzyTghMnI5AJdyXbLOVQYy//Gmx5Hwt+/
         0t44voPApUws+ufrRm59MENFhcDLlRiZu+Ia0sgsug44I/OhBE2ljjobbHtz1fqfRVD4
         5qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7ixzuuNDgee9bW2cjdqHBGkL1CtEaTFP5FgsMVEumf4=;
        b=hPm+wIGlq1EPjKdPFMJut3LcpBMGhD3X8jKBHOcsp4vILqZF4+QcOb5MuUGOBSupBd
         QWuXFcJMG4HmWQ6ub2sqY6YrmjCSaMc4GBH4YVWtShrPoxPzQJey51RccUb0ToLSaOxW
         N2bksUXUKG7DMjM402J25hGeqjcSQ2l2rkBiYZtTXlX9+NxhNPy5PRN0bHA23Z23w4Ud
         9zygjagTOsKjznHVePs2JqjJ6CuqhuhVHjeRu3nlCDVUTWmpXFr4KB5Ywu2dYsxlje6+
         T78ttA6EPGVmF/0XRVyfkOaPOVczbQ/VF+Zp3P9lwNWzFltv5Nbk6pFjZxylCBp4USZ6
         c+Bw==
X-Gm-Message-State: AOAM532LUIfpqpv8nzH6twYtzZcch2MMeLfBEc0QPTaVMDTq388XX9H1
        fxIEPnQvIH9j4XkqlPGqdplmvK32WoI3aTJu4z8jJO95DydBhR5y/CkR/AEuUuRLUyzhdQugmrC
        m+2OIabyBMHnXVcaOmWFF6lFA/L3+tuvupaowSD0x/8lwAX9TRiT/Yl0Bv4vkiZQ54AtoTCQRt6
        waXQAAK1cPtTw=
X-Google-Smtp-Source: ABdhPJxG5VcNTyfNtYVfvDOX2ul3T21MBgXG7Sgl+PleIxrVog1mk0AQOqwf6O2Zbgf18UfoDh0l7SDFW9H3tGlhCg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a05:6214:262f:: with SMTP id
 gv15mr3334999qvb.36.1627529766330; Wed, 28 Jul 2021 20:36:06 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:36:00 +0800
Message-Id: <20210729113552.Bluez.v3.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v3] gatt-db: remove redundant check in foreach range
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

svc_start < foreach_data->end has already been checked in a few lines
before.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

Changes in v3:
- resore check svc_start < foreach_data->start and update commit message

Changes in v2:
- remove the entire check

 src/shared/gatt-db.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 8bff4d37aaa2..3a02289ce435 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1348,9 +1348,9 @@ static void foreach_in_range(void *data, void *user_data)
 		return;
 
 	if (!foreach_data->attr) {
-		if (svc_start < foreach_data->start ||
-					svc_start > foreach_data->end)
+		if (svc_start < foreach_data->start)
 			return;
+
 		return foreach_service_in_range(data, user_data);
 	}
 
-- 
2.32.0.554.ge1b32706d8-goog

