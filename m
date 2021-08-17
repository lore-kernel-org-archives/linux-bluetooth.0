Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04296C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 01:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D9D60E52
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 01:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhHQBDO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 21:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbhHQBDN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 21:03:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF39C061764
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 18:02:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a20so22833654plm.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PtpCY7XlVp7UUruLefHBR4urnkCPUL8qFFn9Lei9JA=;
        b=cIOcYRfPo3eZQ280eoTIWPxagXFtjokyryIB596lVPIP1m9qPJqbiqQAMV911eF3Af
         VyBRU6+pXBvRUys/Oz5l1C/NN2aX+I5+z7D8Bz67zlUgdW0B3WTAlxAX7LT9lJaBuZRL
         XMLsezYevagSyfMZnpv03DerZGlVnEyrLuxlDIY5uC2szhxWLge4FviKBHZYnYvHVvZ0
         a4IL3JAycMBOeA1dlCyPqXPiFynvcZ5cmcW8aTF9NKWURo+g2Qlb422nG7ynV344GlYO
         7uJIn8IlDqZPQPiLrOdY7yJF1HMeVkndC2FM1zIrsPP8pU6ZZNRj1qP9xdPHzwxLG1rW
         0CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PtpCY7XlVp7UUruLefHBR4urnkCPUL8qFFn9Lei9JA=;
        b=BjDuzNRAmSrjvpZ25cR2la/N58gLPAbcD2BzAhXFVIPvWrovCOh4wjku04NTfKcv0y
         IYeCkqxRHY2bZyuiq/q8UeTOo7/70dyk1wgtx6KCe+4oHu7F99YOPqQxiVt952+8utoI
         hhCWYRW32Rbesy9NdLlLgKbwuPYmsmxYjdjEo9yk+mC+SBt/yX1NsMUxIoa85dTy1AML
         vYKuwf0LOsBVxycTKqF5t3UDlAJv1V8orSf5uU5jSm4z1ci5fF7/rcpF5gGbExm5RdkK
         zQ5bqKyRSv2gOuOJiZVWc4dBqPAeXxE/lgNnie/R/wbBWPHRjlQn9MdUSqejETEKEfxF
         JLWA==
X-Gm-Message-State: AOAM531njkoUWPpRzgoabFAytuc5foTKJyqdLxyTb1hFrxfB0uDbPIVe
        3vGYF8vY+7Ky/kefuc0Z+KGDnI1HDO4=
X-Google-Smtp-Source: ABdhPJyTpNwAZx8mF4+lFH0S9K7tsp7+ZbMPnOQgc5lrT18k6NWa2Y0yIEUTv9Clw2zRLLGNo1ghyA==
X-Received: by 2002:a63:6705:: with SMTP id b5mr841810pgc.69.1629162160667;
        Mon, 16 Aug 2021 18:02:40 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q26sm347137pff.174.2021.08.16.18.02.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:02:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 1/3] adapter-api: Add Experimental property
Date:   Mon, 16 Aug 2021 18:02:35 -0700
Message-Id: <20210817010237.1792589-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Experimental property which indicates what experimental
features are currently enabled.
---
 doc/adapter-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 464434a81..13e904425 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -335,3 +335,8 @@ Properties	string Address [readonly]
 				"peripheral": Supports the peripheral role.
 				"central-peripheral": Supports both roles
 						      concurrently.
+
+		array{string} Experimental [readonly, optional]
+
+			List of 128-bit UUIDs that represents the experimental
+			features currently enabled.
-- 
2.31.1

