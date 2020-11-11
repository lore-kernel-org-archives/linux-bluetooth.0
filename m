Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CD3C388F9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B032076E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqkAHzLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgKLBdI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbgKKXEb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 18:04:31 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1ABC0617A7
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:30 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b3so1744010pls.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=msDZd2qOGah4QB3072sVg4wOX4q/SRtp2lmh0VCdYYs=;
        b=NqkAHzLQXxNMyOjZdTKYHT0DMRy7VIydx+fAKwnNr0tXkKChuXJYj15tQrFxSDnawl
         J4hQ2yyitL73xe1mMrNzPVdY8sK4EGo+5XiRQHlItZhqUczrGmxC+go1zMzn7IJ8U8lf
         q54cwxqRjc964h70Kt7rWk9BzQT+/zBdgPbur81xy6pM5GMauvLuikYB4+WXGb1OLn72
         5yHU6ggm8rD12dqmJReP+lhP176cz+1sk1ejSJQQkmES4jBFArGVSkJ3jUR4U3tI9xoZ
         h2oDv4ZOfKuHqRSiay3fNoDqYLJoiiEHfmlFlvaCkKpK6QdiwjUCmTklrhLYyRS03YE8
         WgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msDZd2qOGah4QB3072sVg4wOX4q/SRtp2lmh0VCdYYs=;
        b=qDC81m2JyITl6B02g30H9NmqhiKnXMqkGEv4UgCN0HCxalUUC5llPZo1NlhrsKf6u/
         Zor0SwprAX6h/korKQ6E6KKU6Yw1CItovOVsNDO2L0ufRTPfV14R9OOMpFCTOnYeRjT2
         SCTPEWifKEVlDdQogz8/nHVjCpkhCfvhNIsU/rrqU6iDow4uSmik81DHQZWmsRe2lRMK
         Z0ilacyZ9QQAI/Rjta2Ws9MpwFIuxRyo/qP4ZS16usTHVMb0SQZlAY8ryWn5Sk6JKM76
         coRU0DlwJK0XbYzHKD9RLTKl8MYF7DHJydTFt5OewTtqDH9tvMwXefAZ9wyKkBpgx4oZ
         zBkw==
X-Gm-Message-State: AOAM530MnbXi5ZEe7OhEoletHczu/nHJCdGSR34FYuMrVH5ztrXglBkR
        4+DEcnmsNXoL72Dq6Vpjn0nGBaDCcPK9qg==
X-Google-Smtp-Source: ABdhPJyjakadasno1141qwDPJAG9qMgdg3vZA5SAbgHzSWWldiUr1uakSl/+Ia6WIpzZFuUXvLK3CA==
X-Received: by 2002:a17:902:7482:b029:d6:682d:5c6c with SMTP id h2-20020a1709027482b02900d6682d5c6cmr22439170pll.84.1605135869745;
        Wed, 11 Nov 2020 15:04:29 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n27sm3867767pfq.59.2020.11.11.15.04.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:04:29 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/10] smp-tester: Fix not registering for MGMT_EV_USER_CONFIRM_REQUEST
Date:   Wed, 11 Nov 2020 15:04:15 -0800
Message-Id: <20201111230421.3364932-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111230421.3364932-1-luiz.dentz@gmail.com>
References: <20201111230421.3364932-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

For client test MGMT_EV_USER_CONFIRM_REQUEST shall be resgistered as
well as the kernel has been updated to request user confirmation even
when acting as initiator.
---
 tools/smp-tester.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index 7823b6b17..644c451c2 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -501,6 +501,10 @@ static void setup_powered_client(const void *test_data)
 	const struct smp_data *smp = data->test_data;
 	unsigned char param[] = { 0x01 };
 
+	mgmt_register(data->mgmt, MGMT_EV_USER_CONFIRM_REQUEST,
+			data->mgmt_index, user_confirm_request_callback,
+			data, NULL);
+
 	tester_print("Powering on controller");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
-- 
2.26.2

