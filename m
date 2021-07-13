Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74900C07E95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 20:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6102A61175
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 20:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhGMUYm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jul 2021 16:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbhGMUYl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jul 2021 16:24:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09ABC0613DD
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 13:21:51 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y4so20623490pfi.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TV/iHgLEZZt/1TTaz+VnS/XdWsFj+KdeuBG8yo7tRMI=;
        b=q42kT7scWPXjR8mAu6xnv0Q9pBIK16RlGCcvuTy2HXbq9HqDimesA2vIN++PcsjD8b
         5nPTfODa96k2pGFh8o7yID6/apFHuboFfQ5Y+C6Wz4DuV7WYuSS1DjYiiah3cZrpK722
         d82yse2jCpErI78YTfflKNIkxthPjVTGjUDr4VH6xh8aPDHd0Cp19fnosKsqVMqdV/rl
         Ksdda+LDa1c6v9WjOckIwmpTTMESm1vWntogi4FPMYS/6/E9CPf43E6ScG1E6Td2YNTG
         heMaPaka7VDvcdIvqPGIqfjZ9D1t2fdi8q7FYPwNWqYWnX/14olf3sS168m+0Q11+swB
         /JZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TV/iHgLEZZt/1TTaz+VnS/XdWsFj+KdeuBG8yo7tRMI=;
        b=sqaGejeWTClkRaToCbe2+IlcnixmFpAF/B9WAFYQd47kEDg1MfuhBZoyfHTDXNN7aD
         iDqZznldj7f4fCUq+VKR0pizB3au1ByUn7uHaa+9arbDhjEh0tTXG+zUIpPj36DpDGNV
         vFwV9WP2IiYTJOklQxXhgCRq09bs0K/MrwUZ25ZbXTuxz/XZDjtdN+KlFoSvsFyi6IMt
         sabNlIH1WwyZfxrcmsOHOAvh4QE+FDTeji2aMItauZCGcvbvJEYrjNqhHZyoGDlofTgo
         mYsrZPhtV83Eby7y6pY3Ms6BuI+700+/pwZlmbe7PnYUOR+jQhNnjP0OLCxjeCiBGJDh
         WPIQ==
X-Gm-Message-State: AOAM530z6QHBxR6Ssl/QJBsZrgwsMOTlb1c/P/62KPtPFnWp1V9WlHM8
        MreVWK6vt41TVM4ab68RE6sZEr1Vv/s=
X-Google-Smtp-Source: ABdhPJyoouCZPmp3PO3P9vuIUju8F++L61co5kkJfa6Shrvy0imjqbUBx/8ULmCM85+dY44juY1zNQ==
X-Received: by 2002:a05:6a00:189e:b029:32b:9f66:dcbb with SMTP id x30-20020a056a00189eb029032b9f66dcbbmr6467737pfh.72.1626207710331;
        Tue, 13 Jul 2021 13:21:50 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::614f])
        by smtp.gmail.com with ESMTPSA id a23sm33608pff.43.2021.07.13.13.21.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 13:21:49 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] doc: Add kernel config to use SHA512
Date:   Tue, 13 Jul 2021 13:21:47 -0700
Message-Id: <20210713202147.116261-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds kernel config to use SHA512 due to the recent change in
the kernel crypto API which uses SHA256 as a default instead of SHA512.
---
 doc/tester.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/tester.config b/doc/tester.config
index 850fb6a38..6e0ec2950 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -37,6 +37,7 @@ CONFIG_CRYPTO_CMAC=y
 CONFIG_CRYPTO_USER_API=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_USER_API_SKCIPHER=y
+CONFIG_CRYPTO_SHA512=y
 
 CONFIG_UNIX=y
 
-- 
2.26.3

