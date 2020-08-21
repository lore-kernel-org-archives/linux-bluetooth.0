Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BC8C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A3E20738
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S9PH1WtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgHUGZb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUGZa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 02:25:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68ADC061385
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:25:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so383068pjb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bA5MyBizmygKQda+oeo0TYdwB/AeAf0aaD0m7ntaAyk=;
        b=S9PH1WtEk0y3bdfhwaFG9/XSVmRM+19aPN4lZL6FRZdu8VbFq5a8QIZqBkGDFMsnEQ
         NFMKJwaNq9scn0TxUm4kXtDUCQPugARpoTZSk3AhTRoupyvzz6rUvIw2xCIc6dgSSbdB
         L+HULMdm1ovdFHT22J5nLoojPyFHcfTJWSn2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bA5MyBizmygKQda+oeo0TYdwB/AeAf0aaD0m7ntaAyk=;
        b=aHqDqmYxcjunYMcnNkfwi/tWZ91PWBT17SQeEWi0+rX7H4xT/l9DFyuvzy6ZZcfl5I
         vNcoqUIm/pucgugcNuV9eANCA+ZQSRsz7ArBKoWiIYvyNM5j8bky7jNOhn3ZBcS1SSAX
         Hfu5+VfkIJBVGx4A4LAsUPJXMGLiEGqmQwn43qPjxwVu37QCTAxvG9wOQE/OMKaDLUaL
         N2iRj2aute/w5H95yAqqoddjywzdmlxXg51xVAUx3m+S1U9pTzc81lQNdcAiSb4kMQUV
         livQB6S3QOoO37qnQErfRGw0Rp/mMwHLhPN6OxJYE+mIXOSkoeT/reqHTjOS8DWM4Ouh
         Es0g==
X-Gm-Message-State: AOAM532Afz8CenBBaOVzAflTSSI9WSaSJDiIei4zdkv/j45epZuX6vrt
        hf5U8zvTwciuXPHXlybfbraflGRBLtUpeQ==
X-Google-Smtp-Source: ABdhPJx9w8QmpvzKORFE8qRe83Rgn2YnXKiVeaUGG4jUrNwCmno6uNTcnILf7sey75jWdDEtvGS5OQ==
X-Received: by 2002:a17:902:c111:: with SMTP id 17mr1341653pli.46.1597991129811;
        Thu, 20 Aug 2020 23:25:29 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id c207sm1078895pfc.64.2020.08.20.23.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 23:25:29 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Joseph Hwang <josephsih@chromium.org>
Subject: [PATCH BlueZ] device: unset disconnecting flag when connection is removed
Date:   Thu, 20 Aug 2020 23:25:26 -0700
Message-Id: <20200821062526.16689-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Joseph Hwang <josephsih@chromium.org>

A disconnecting flag has been used to avoid race condition
between the service browsing thread and the disconnecting
thread. We need to unset the flag when connection is removed.

---
 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index 7b7808405..5ab591dd4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3041,6 +3041,9 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 							"Paired");
 	}
 
+	if (device)
+		set_client_diconnecting(device->client, false);
+
 	if (device->bredr_state.connected || device->le_state.connected)
 		return;
 
-- 
2.26.2

