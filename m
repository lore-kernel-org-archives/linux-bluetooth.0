Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF94AC54FC8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 01:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D0D2343E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 01:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437654AbgLLAKD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Dec 2020 19:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407257AbgLLAJj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Dec 2020 19:09:39 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C749C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 16:08:59 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id hk16so3207475pjb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 16:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=568KsnGbDSih0kPXTRx2MCQjnh51NJ/T0ZWRymkO/lk=;
        b=f6+ki33yn8FNxN7lCf7wexB820PmBGVg19kKdKJqnzkRBMc8kNTl8LGQ3vxmMsTSpY
         3BZApzmx7BWamDNqWVMpnxh4sS0evGZ0WRkaC2d7xgQN7Y/SVredoRifg3HlTwDDKRmj
         vlbhMZC8iVrKWoRpaIdFDzlIz5mTZuSPDRBgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=568KsnGbDSih0kPXTRx2MCQjnh51NJ/T0ZWRymkO/lk=;
        b=gUHvUpSvrkYbT3UjR420ZtqR/CvM70xXTRCQL8d4y1ZoqjxAZ6S0NRcuYC0x7PfXNe
         UGpR6CAvJ4yT0Za3Ap9roPCcAN/DLo5iJoiQvkQvR9WG+i/aG1n0CqFLyd+pD1unXhya
         TsyiNxn0hK2ndRiyDWnOKOE03pioXKo+7Iy9fcHEY9FMsV7qFNA5w/Nxyd9Ej+ecFWfv
         gtr7fVz3u7iNMfebGmVbuAQ7WMpaXLbNUq46O+cz3xEKz1148Ovqf8DtveZUVmNl1+7D
         /Wq0sVm5pSB8CV2qs9kWf/5cVPoo78FxsD7fcqR0ruS08e/OBQeny/QyP3qUakkuVTks
         4rBA==
X-Gm-Message-State: AOAM530QC84huS3lGzBGgZgt30SBLBxOuDN4GMjVlXk7EvqBTJuAG5Ge
        bfqLEHd5PcIwvLO54eVAXlWnpw==
X-Google-Smtp-Source: ABdhPJxJe6eSWslJX/Z7h+jJ1Ax+unTHv5n6Im35+0B3SHdNmWGio26DtO7MxqA0a2ex+DXIPd/weA==
X-Received: by 2002:a17:90a:f311:: with SMTP id ca17mr4577455pjb.180.1607731739003;
        Fri, 11 Dec 2020 16:08:59 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id f7sm11125812pfe.30.2020.12.11.16.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 16:08:58 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [bluez PATCH] adapter: Change noisy log to DBG
Date:   Fri, 11 Dec 2020 16:08:54 -0800
Message-Id: <20201211160831.bluez.1.Ideb5dbf81fdb531ff36814aed2c969980049dd28@changeid>
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

