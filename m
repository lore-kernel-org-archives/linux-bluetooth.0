Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1412AC54EC5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 01:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE4C2343E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 01:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbgLLAEN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Dec 2020 19:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394868AbgLLAD5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Dec 2020 19:03:57 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35346C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 16:03:15 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id j1so5427338pld.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 16:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=568KsnGbDSih0kPXTRx2MCQjnh51NJ/T0ZWRymkO/lk=;
        b=F4WXbzrj0vkDYbbtOV4tauJgfbD9QKeAmpIK5uDlsCI/+Q1tc5c2otePUlT8eUXlyc
         G8HX/u9CHDvddoq9ikWLnomO3fLZQtl3Ufn8Q2lwaEcJ3uBUEHJLLKybivHxuqYL68nJ
         BaL/vAbXJlTWd3SnSlRmUxutVVXN185vSTXkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=568KsnGbDSih0kPXTRx2MCQjnh51NJ/T0ZWRymkO/lk=;
        b=DX/bRFdsIbBnRc+RxAxDZWV17RxC5XPtf7X0eI0xhegzqmvGa5RuO+hbLLVwcpDLt0
         P1e78bWlvPyp66NkA+YM1aA9BrgJrMVUC+hTKmZ0kKzJ7jQ3sEe5hQMDL2vOpz5NWppT
         k6Abd95pXARij3wghy0f8vnrXY7BZKrhQlzjUXDa2mN+eiKwwQMVIgiaeIDV1z+Cs73F
         iGOFLmsEBDs7tKXLx5KgqSEB47T5A4JOe9o+fWYFSaSPczXkLEazeqQfqFxYWevBDI6x
         opjA3M4wXXCsVqfBr8ZppvT+C7xplHjCexsvIfYQQ8fC4sa55CKRpm5eQPqN9GPlviUT
         Xb1Q==
X-Gm-Message-State: AOAM531Dw3OdyHufVonMsdNK9A5/rpSTfRWmYP9aTvq0Zhq/1jenaMg9
        cl3eubg8Ffq8x1MlK2BSw0ysug==
X-Google-Smtp-Source: ABdhPJxXGkD+AfTOB9T7r410N5gTa+nfBpc2fLQhb3xIEEUmEu3QOafAi6zezK5WQBakvlt45F2J6w==
X-Received: by 2002:a17:90b:388:: with SMTP id ga8mr15517711pjb.108.1607731394690;
        Fri, 11 Dec 2020 16:03:14 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id u3sm12776998pjf.52.2020.12.11.16.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 16:03:14 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH] adapter: Change noisy log to DBG
Date:   Fri, 11 Dec 2020 16:03:07 -0800
Message-Id: <20201211160253.1.Ideb5dbf81fdb531ff36814aed2c969980049dd28@changeid>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The controller resume message tends to be pretty noisy (printed on every
resume from suspend) so make it a debug message instead.
---

 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index ec6a6a64c..775c9c921 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8835,7 +8835,7 @@ static void controller_resume_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	info("Controller resume with wake event 0x%x", ev->wake_reason);
+	DBG("Controller resume with wake event 0x%x", ev->wake_reason);
 
 	controller_resume_notify(adapter);
 }
-- 
2.29.2.576.ga3fc446d84-goog

