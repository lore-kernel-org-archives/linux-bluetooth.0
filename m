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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4822BC43140
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB1961132
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhDAK2O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbhDAK1x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:53 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE0DC0617AB
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Apr 2021 03:25:47 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a6so3147552pfv.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Apr 2021 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JWYpT6XZVBl1zd4kG0m7MOIC9V0I+5W9OEzP70fqw8w=;
        b=M/4iRytEi5wnL//tg48hY04wb18fMKuNNx/mzn/twH9BiKOcnE6Evmp25GWO2JaNVv
         bslpLMKqnQDRyBbfQDH0d+WcNEpu1/PkgAnom9ylGqeO6TMqVC8AnQMKyNSPGvjIIOSQ
         F6rYqHxlvjsSSzaxYvNg/1t8UJFnE4+Is3dtmW1/ws7qAUOFGh7yuLldjAuD+YIax8Mh
         5Dx2JnAtpnpMAhqBeF3a0L1vsmM59f9yaRPln7DwGswTyPRXdgKSuz79Lbf8tHXXUFGt
         ias1SH2BjdWfgWD4fkVowkD4ndh2UZQoFYhdp/NNsIJc58gjMcG2T54Rp0o9EeP/6O9A
         T2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JWYpT6XZVBl1zd4kG0m7MOIC9V0I+5W9OEzP70fqw8w=;
        b=CCs0xsMa4/vNyDYXS0HIuVOunje97Ro2YMurpI0uN5qXCW0ntTee7wPu0NPVbaZtag
         wF2xgQbwelLPsv5aK8HpxU5MVd9G5rrXrEaA1XaaB+XpRBVXy0Bv5VDqWcmoFhBQAOt6
         f1mIYfsp87oKqg8G9Z1RHgUjS7TD3BjHdLABbjp1C/AMpFOzMuzmSza37pCoLLDy0r1Q
         owXDp96N7xEVNwFLRljFWCVGjfrNBmoMA6B9vBLR2iuR1ppH07biyyZqIe0FnPOjQ7/E
         Mvo5hBRh2Iw7n6vElP2MCygHXvlZxcCA6W9BAQCqiV9CIBDl2sr6OVJgPRf3uNBsbTiH
         Jhig==
X-Gm-Message-State: AOAM530pHSnppo7Yr0S8oaNLP/lst42J2KdhTiLywoMGhvj15kLYzUbf
        wCdLBSlSbU4aMy4cLggILA0HClb69gzBvBuMuw+qs9pXVoaWmr+uvyWzokM7zLlxumRiVodmqRY
        a3UpNlNlmDlLQ43GtGaViaWPBZt5wdHhGhdjT/rXv/PGMG+szj6u1UpzJRp1EdlKa6ntvVDg2rV
        y9P6V10KFNGyg=
X-Google-Smtp-Source: ABdhPJx+jBwNetz+nzbGENSJeCMsJR7onmh+PLhRCya9Mq9J961rvV1s0MvnrOzz5tnugd4Dtq8XPcS5jNDBMly8HA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ad88:abe:9fd5:a5fc])
 (user=howardchung job=sendgmr) by 2002:a62:7b83:0:b029:1f1:5ef3:b4d9 with
 SMTP id w125-20020a627b830000b02901f15ef3b4d9mr6919439pfc.65.1617272746722;
 Thu, 01 Apr 2021 03:25:46 -0700 (PDT)
Date:   Thu,  1 Apr 2021 18:24:47 +0800
In-Reply-To: <20210401102447.3958224-1-howardchung@google.com>
Message-Id: <20210401182328.Bluez.8.I41e73e51a6a5d9cf4394903d631f41b69fb14fb6@changeid>
Mime-Version: 1.0
References: <20210401102447.3958224-1-howardchung@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [Bluez PATCH 8/8] core: Initialize uuid_str_arr to NULL
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sonny Sasaka <sonnysasaka@chromium.org>

Not initializing may crash g_free() below.

Reviewed-by: Daniel Winkler <danielwinkler@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index f03eda2abc17..ab4f8a3ca4d7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -483,7 +483,7 @@ static void store_adapter_info(struct btd_adapter *adapter)
 	char *str;
 	gsize length = 0;
 	gboolean discoverable;
-	char **uuid_str_arr;
+	char **uuid_str_arr = NULL;
 	guint num_of_uuid = 0;
 	int i;
 
-- 
2.31.0.291.g576ba9dcdaf-goog

