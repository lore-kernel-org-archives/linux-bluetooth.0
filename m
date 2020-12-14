Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58EEC4361B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 22:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7405D22507
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 22:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439147AbgLNWQQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Dec 2020 17:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408480AbgLNWQA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Dec 2020 17:16:00 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC6C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 14:15:15 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id n3so985986pjm.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 14:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4I36PkaRwnQEwK295eiTY/SP5cBZhbchCA7yLG6aQWo=;
        b=ZBjvbsY3p/1xqj4Kn1cLQ9ab33y8HgRgoXQ8Ss95DB39gjDhjK44QfZzNRjZkQZgwy
         UWaf2XJRbWgJdRnpmRH5T7Yj68nST55ryyN2wQcuZCjzr5Ss0WgZ328EZqhyxPeMH2BI
         PWMGY9tU328MYss0WnZq1m9Lfc8UlXnjhar78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4I36PkaRwnQEwK295eiTY/SP5cBZhbchCA7yLG6aQWo=;
        b=HGCmkomqjLxIjrFJYA1/V20YWyoOARrU7SPpFoRla5MNnGd1iVkBjeI43o1tc1gFyd
         FBG76QcDkKxD8SG6aADLxhlsGNjOwNGCpl2PcMQKWxC7QOTE2jw4f0N07Y5M5Fepz0xR
         9amlwD6jVqXl9CHlAG20We+qFQOH2UPon7b6J3E9P873dhwiCHtndyprOK1P4gDItqWs
         fIbO9NFyyrJr0y0TZZsGno8pe3BJ4C0K+d1jBhEKcRq8ZpbQXhS944OEMwT6lMtovpVA
         MAuZ6fa6kxweWVkUwfDi34HMv1oTCeP66lhYhHXKrxKweqNbP0IEi8BM8zd7CxeOb2K8
         /etw==
X-Gm-Message-State: AOAM5310YKcYTn/FToIL+4fmEtExqOmg5WDR5SwJpFoPmbUkaccMrBWx
        CdJGo6kpucZh6kRgilL7nnmbS9j3cl/4+Q==
X-Google-Smtp-Source: ABdhPJwu/e/0PZ8Y7yx1smEzReEB0FT67JzvKPQ4ElVJi53wN+1Co0Mto+05nT2u4dOv4/pCuwmK+g==
X-Received: by 2002:a17:90a:dd42:: with SMTP id u2mr23470977pjv.125.1607984114607;
        Mon, 14 Dec 2020 14:15:14 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id 24sm24297075pgy.45.2020.12.14.14.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 14:15:13 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH BlueZ v3 1/2] Revert "input/hog: Remove HID device after HoG device disconnects"
Date:   Mon, 14 Dec 2020 14:15:01 -0800
Message-Id: <20201214221502.392676-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reverts commit d6cafa1f0c3ea1989f8a580e52f418b0998a3552.

In commit d6cafa1f0c3e ("input/hog: Remove HID device after HoG device
disconnects"), the bt_hog structure is destroyed in order to fix a bug
where the UHID connection is not destroyed. This fix has the cost of
increasing reconnection time because every reconnection would need to
re-read the report map again. An improvement to this fix is, instead of
removing the bt_hog structure, we can just destroy the UHID with
UHID_DESTROY event and use the existing bt_hog structure to keep the
cache of the report map to avoid re-reading the report map at
reconnection.

Reviewed-by: Alain Michaud <alainm@chromium.org>

---
 profiles/input/hog.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 91de4c70f..d50b82321 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -207,8 +207,6 @@ static int hog_disconnect(struct btd_service *service)
 	struct hog_device *dev = btd_service_get_user_data(service);
 
 	bt_hog_detach(dev->hog);
-	bt_hog_unref(dev->hog);
-	dev->hog = NULL;
 
 	btd_service_disconnecting_complete(service, 0);
 
-- 
2.29.2

