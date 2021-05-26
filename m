Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6A6C4708A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 00:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AAC6140B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 00:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhEZAWA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 20:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbhEZAV6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 20:21:58 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5966AC06175F
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 17:20:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e17so14295634pfl.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 17:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tuQ9nKR0cuSGFqJeNxh6e/A49jphmCAZQX2vjqtzuuA=;
        b=jI+7vIyNOaQc8vv06ucqiOXO34wZA/0HIZF0J/aqwjrz49CNrEKkwEc8eHCFPed1M7
         95NyBFbDUtJNriLKuMnJYeYUBw9E9HzvrdY4fts0u79YUExhYaZ/PP4mcb72FpFjz7fd
         cfzgQulcNLF+90m1B7KueDtJimgucJQDpLkVNAiPdDhmuvJDfV8jE8vN/ri06NACs5QX
         GDetsvYGApRFbGX8nvk/zG8lW1cgtEOnT1woyhve/gjqa1xIVnEfCyi/25gmhi01jY+4
         /WvGG8IEyCS647xDF9sbWoCMHBLWsAiLAeiw2nV1Ru99kRkV07MUXawbaLCBJCSZNqzl
         F3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tuQ9nKR0cuSGFqJeNxh6e/A49jphmCAZQX2vjqtzuuA=;
        b=LqvtTq+aar/UmUCa9of1RYtJuhL7m+VpKwnfuHyCFjzZEmArCgR43N7tofPXqHfKAm
         KmqcISkiAPlVE5GnDiF4IazkJWR8SEFngBFkOo7u2bvyAXY/MXc5fowTPQ8pm9lqmFr+
         rCmgrf38QYbQM2u80XUyGyy5SUZD1Uh5zTjl+HYzM76qv1aQdWuAtentqMu3OXHRb0MU
         0yePMdctP4AODTnSnJI+O3L5bhrOGk7DZsHYIFE2QIig/efqml8lCm0f77KECsAhuhaG
         5xQvnPP2I0C+6MLe1QKMfkmBfFsn6/QjhcMaKUy2H70/H4nR7mw8I3ZvQGTajAAegHfy
         E81w==
X-Gm-Message-State: AOAM531iAlvxmowLryoLQuY6Fe9IvjZRvQBvrctK2Q4PHC6zXE2AQWyb
        zPVaoAvhaIGAaC41s6ddYigyqfQSVFxweQ==
X-Google-Smtp-Source: ABdhPJxDVbkwuRTSfRpd0bbRDG4aURGKU9OvXgR3HWzZ0gYfXEau19dh4pnh72dZi3fmwPN01uHyUg==
X-Received: by 2002:aa7:961a:0:b029:2e1:b984:7edf with SMTP id q26-20020aa7961a0000b02902e1b9847edfmr31149899pfg.34.1621988426700;
        Tue, 25 May 2021 17:20:26 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::e853])
        by smtp.gmail.com with ESMTPSA id t19sm14305726pfq.116.2021.05.25.17.20.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 17:20:26 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 3/4] tools/mgmt-tester: Print hexdump if mgmt event parameters not match
Date:   Tue, 25 May 2021 17:20:23 -0700
Message-Id: <20210526002024.412237-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210526002024.412237-1-hj.tedd.an@gmail.com>
References: <20210526002024.412237-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch displays the hexdump of expected and received mgmt event
parameters.
---
 tools/mgmt-tester.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index c9de770c1..767e010a6 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6780,6 +6780,9 @@ static bool verify_alt_ev(const void *param, uint16_t length)
 	if (test->expect_alt_ev_param &&
 			memcmp(test->expect_alt_ev_param, param, length)) {
 		tester_warn("Event parameters do not match");
+		util_hexdump('>', param, length, print_debug, "");
+		util_hexdump('!', test->expect_alt_ev_param, length,
+							print_debug, "");
 		return false;
 	}
 
-- 
2.26.3

