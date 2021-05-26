Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844BAC2B9F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63385613CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhEZFPB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 01:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhEZFOq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 01:14:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B6DC061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:13:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q6so181380pjj.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tuQ9nKR0cuSGFqJeNxh6e/A49jphmCAZQX2vjqtzuuA=;
        b=cnTmwR4gQztrYqp4GWoiQv3/+XQh/krfS715N7hjTXj1Ews649XxtWGwpHaDNcIByo
         ZvIsZyR2q0y13YLo8E3UNYkxa21l3XUHxxcWPIkbHWl+SFWlGE5vJ87N+LTby5f56kmr
         RescCVTV1sbXcvBdJ82gcpx9aMx3sIB8axM6K9JYT/zzxaht00Yoqp+4WsRJQF/n/vCS
         isKL9X07rXiUZzBJ7PIbN0RbbyMGYR6tygaSdhbPxts6JYC6+01aBmBF2nRDOZHC6Euw
         CfRHnA8R0lJYkiB3rtEkJQya2NUFoNhiVFHhfxTlvYkO5HVrsDtpClDufCecBjTWsWA1
         jseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tuQ9nKR0cuSGFqJeNxh6e/A49jphmCAZQX2vjqtzuuA=;
        b=tOWfN1Vkdg/F9stmmJ4QoHyNI5I400HERFrbzdhgevKy8ecXmrbibka4U8DIRoHU2v
         KHSeQD1d0BZgQgBdITSzj3a6nC/x9eOrIjoj+zMnkhD33HyuTbmoTlVpBAov6GONBh7c
         esN5ld7GGLVIZojYBAjm2fsya+G0y6Iacvs+zUsYxVHYyQYmL3svJjSZNK3NhxXh0Nx6
         7lbGisdTFsbvXzI0lN1soiAsyjO+vcAjMXuNabRBbXnAoFl8tLj155YxYJBhdxzv61A4
         wKvBFfMQ4gJA6/tnVq5M9kzs6ErGSyWaCdYG7W7CUA9q0KZcVerALh9wyb0+3ooXQ9mk
         6mPg==
X-Gm-Message-State: AOAM533kvCVLmgyQEXmRWavrQVzq1W8Lv4gBNTmt2hDhNubWOez9fM1J
        U9DQmD7Q++2hA6H7rxQ87O8W0101SpagLA==
X-Google-Smtp-Source: ABdhPJxRThdEg5ydjHjuBa/G/3CurSvEkfIRaLOvcLrb+2WUORLuscQTRunyDGPdIEhWKLvHwybJNw==
X-Received: by 2002:a17:90a:549:: with SMTP id h9mr2162116pjf.158.1622005994416;
        Tue, 25 May 2021 22:13:14 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::e853])
        by smtp.gmail.com with ESMTPSA id h8sm13865944pfv.60.2021.05.25.22.13.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 22:13:13 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH V2 3/4] tools/mgmt-tester: Print hexdump if mgmt event parameters not match
Date:   Tue, 25 May 2021 22:13:09 -0700
Message-Id: <20210526051310.423630-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210526051310.423630-1-hj.tedd.an@gmail.com>
References: <20210526051310.423630-1-hj.tedd.an@gmail.com>
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

