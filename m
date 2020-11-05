Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D6C00A89
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B1C2071A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u46XGnv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgKEGaE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 01:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgKEGaD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 01:30:03 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2663C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 22:30:03 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a24so766036pfo.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 22:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=1ERKUPf2W0TioMz6bk7mIf8B9LgdLBR9YkYepyUVNC8=;
        b=u46XGnv8FmpktTWXDRZyzlxp82SeLOiCySfzZ8KxXNHnlXHK1y/iZdJnXxNIhHYPRu
         p35esVa/SHzyaSVsZknP8jzG4dqpnQG4IhgJYq7pPyTpPjSTY7Ux6c7yHPfa3MyThffA
         pad5pKt2p1ZDdcCN2JUIVWDonBwBJ6ZzIOGw6Bzc3rwUBuhJXiGmoLkNgBNvSQ7wLcGx
         EWbfKjRyje1V3Irhg/pZPZLRov+cow2gXEO5sRQbbX/zNseTHvzkVmAgWAG0HxLODPbi
         /JmDsylhWZXDeskwGPjR5eor3IKxRaNgkS7EbTVBPoz5hig26cWoeLgJXGjk4l1eKmGl
         8OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=1ERKUPf2W0TioMz6bk7mIf8B9LgdLBR9YkYepyUVNC8=;
        b=eAcgAxMpoFcEDi9TBEMvOFNLx0nrHL8U5GtyYbAlFe5zdZ/BuqN6E9GbzF1F+cAcFI
         2qo/s8Q+55eVjvhu0WDELJt7SouRKCF6PDLO2qL20AszkWx8ErZwtRh4nkhjBjj8tTFI
         6RTz1OhWDPEG7YeGZbmuPJegGwGHO3EP154RLwPSpuQU7m0v0xjk89EVPyLT2wwg/4+7
         ypFnHk2pmLWNel8vZAZGSeS/D2WnbKFXlWDB93Bh85u+Yxofztp2aDSUZ7glyqGu2LK1
         MUHhYfqD0ePBCDgZlYn63AvlhALKBysUchLfcTuJL83xwJTuQ9/4pHihbLmodlGuPlQk
         KLbg==
X-Gm-Message-State: AOAM532QY+1dnM3fOmjfdJM2cWShEz0SXEoFlMcvpHIOMCYrMUx2DJQx
        c+dcPfTYgwSqnBDhfCotOHY/pGentcAUQnH9fcUXQaM/eeY/gIgRqLi8I0IRDU3nREnhxkEkynZ
        DLFkDtJquVOKnBeIrMKnC4wA7bE9JeCInkpxmW8C4dCH08b6hiyQqor0x2peefPwzDVPjRNKgK0
        zx
X-Google-Smtp-Source: ABdhPJyn2S/CtYFU3Lvqe/8w0F8NpeW9ScBUj2p+x3mhF1HF1nOqK3eM6K2uZELSn6Jqw+MDbRN+dwvgO0PR
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:90a:1992:: with SMTP id
 18mr974328pji.67.1604557803233; Wed, 04 Nov 2020 22:30:03 -0800 (PST)
Date:   Thu,  5 Nov 2020 14:29:51 +0800
Message-Id: <20201105142838.Bluez.v2.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v2 1/3] policy: add checks before connecting
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When policy_connect() is called, there might be a case where the
device is not ready, or even the adapter is down. Add some checks
by calling btd_device_connect_services() instead of directly calling
btd_service_connect().
---

Changes in v2:
* Add adapter status check in btd_service_connect() instead of using
  btd_device_connect_services()

 src/service.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/service.c b/src/service.c
index d810fc3b05..21a52762e6 100644
--- a/src/service.c
+++ b/src/service.c
@@ -229,6 +229,9 @@ int btd_service_connect(struct btd_service *service)
 	if (!profile->connect)
 		return -ENOTSUP;
 
+	if (!btd_adapter_get_powered(device_get_adapter(service->device)))
+		return -ENETDOWN;
+
 	switch (service->state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
 		return -EINVAL;
-- 
2.29.1.341.ge80a0c044ae-goog

