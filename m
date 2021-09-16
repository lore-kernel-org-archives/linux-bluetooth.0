Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9404EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 20:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FE66108F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 20:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhIPUlo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 16:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbhIPUlo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 16:41:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B420C061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 13:40:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p12-20020a17090adf8c00b0019c959bc795so83045pjv.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A1Q2SJQiyX5am4iuB5/d2/2hGMWNzQxjOdbN8yc7+bQ=;
        b=OM7dfngzg5/2QSKetqmzkyDkhUYqlWnQIuu6D+OFNGiy+UyWDNYVW+yhUgRnjqZFgK
         ljScOiALuo6u67xJ6Ybn8Kcg3iqga3aVRidWyHto2Lg1TWb/aDMhEWtQGaBLOS+4BQ6O
         o2aFltsrTNnaIjBe7kGd3dro/7AgdmP/ftgP3r6gDcLgaiYtjtKrarQPV2bGCUXgQy8F
         ilZSxPnK743cB6CMZK0ISNxyisRtHdYUifvsr/BkXcZpHyUVV4phAQNiRnpyE3oBrc62
         vEM6v8RA1/msuGboLf+ODH+dCyuKWdOm1OBblZZSKHChNy0MPudVcLWvoINHqloGYNaS
         2hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1Q2SJQiyX5am4iuB5/d2/2hGMWNzQxjOdbN8yc7+bQ=;
        b=N0ssI9utblm5sCMu6SkP2EOn6ZtIuj3iMeLFyJsf7ziNszghY5B1v8n6wTS9hIIqEe
         y6Qm/Y+LL4bKaxcd8HrYmPZHsk7VdzFFV3KiPzPDq3q5L1XBc/n2zAWp1pxpU8N8wMeu
         x1HtXc7FyHNr8vw5vyu3lBg6GQAM/MCPKtqrocY1VIl7f1asgnfq1yQuwuoig54eMVLK
         11Hzu61KhvE3YvrSwvYlg6t9Velq8x6+M51fvF4NKZT4swgjrZzkldJSlhe5gQkPlQg/
         6D4zpDUoo6iaTYjIN7WO6gRvIjrCPbGXPm7/h3W+aZstRvXmz5E54+byipdLH8cm4YaF
         p5sQ==
X-Gm-Message-State: AOAM533uNaRyT7w5vtlqdyw47gZjRHxWYWbN4aTbotcrRjkq4ah3jKON
        r6W2YAy1aP7HeUj97K/s5SRC/Vah4bo=
X-Google-Smtp-Source: ABdhPJxZXh7W4rKgldP6Wd2euRQyo7Df7mua/zq8LcUMlcEpkoxe2W/QchIx8yOYPIa2XaImDxTJ3g==
X-Received: by 2002:a17:90b:4f8a:: with SMTP id qe10mr6475512pjb.5.1631824822420;
        Thu, 16 Sep 2021 13:40:22 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u21sm4283355pgk.57.2021.09.16.13.40.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:40:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] policy: Use btd_service_is_initiator
Date:   Thu, 16 Sep 2021 13:40:20 -0700
Message-Id: <20210916204020.118310-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916204020.118310-1-luiz.dentz@gmail.com>
References: <20210916204020.118310-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead of using BTD_SERVICE_STATE_CONNECTING use
btd_service_is_initiator to determine if the service initiated the
connection and then proceed to connect other service immediately.

Fixes: https://github.com/bluez/bluez/issues/205
---
 plugins/policy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index bf93df096..051db82e1 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -279,7 +279,7 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 		/* Check if service initiate the connection then proceed
 		 * immediatelly otherwise set timer
 		 */
-		if (old_state == BTD_SERVICE_STATE_CONNECTING)
+		if (btd_service_is_initiator(service))
 			policy_connect(data, controller);
 		else if (btd_service_get_state(controller) !=
 						BTD_SERVICE_STATE_CONNECTED)
@@ -315,7 +315,7 @@ static void hs_cb(struct btd_service *service, btd_service_state_t old_state,
 		/* Check if service initiate the connection then proceed
 		 * immediately otherwise set timer
 		 */
-		if (old_state == BTD_SERVICE_STATE_CONNECTING)
+		if (btd_service_is_initiator(service))
 			policy_connect(data, sink);
 		else if (btd_service_get_state(sink) !=
 						BTD_SERVICE_STATE_CONNECTED)
@@ -430,7 +430,7 @@ static void source_cb(struct btd_service *service,
 		/* Check if service initiate the connection then proceed
 		 * immediatelly otherwise set timer
 		 */
-		if (old_state == BTD_SERVICE_STATE_CONNECTING)
+		if (btd_service_is_initiator(service))
 			policy_connect(data, target);
 		else if (btd_service_get_state(target) !=
 						BTD_SERVICE_STATE_CONNECTED)
-- 
2.31.1

