Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADE3C56201
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B1B21734
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBRhtl/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbgKDXmo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732846AbgKDXmf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 18:42:35 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2615C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 15:42:33 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f38so207041pgm.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 15:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TDGhHpoe/eWfJsY+oKVEuX03napklo56SUJ6Lc7Lye0=;
        b=rBRhtl/wC/GWgwvcvEI4X8u0nJSTue+xwkyXVUdUb+bhR1vFN/fbttf1qEug50V8kl
         Un3oIUxnFmWJd2SFpnzRidOsg1KdazGeW5ZFwG1Kf68uMEX01SNU78EJZrP0FwHnmg1f
         Cm/x8dqPSEnaC9PKTurdjXbsMkn7AAAPN3tqGeonXhm+uibS125Rz/zYNsaT9g0OhO0P
         U0CWTxuB7N3iTuw6WtVNuCX1FD1RavhnWJfrMCMWqIT8O9THfL4b1VP37uILc7XVEza1
         AjxdQELq8uGOFv1jzAUW2g92b44Iud1YCRZquGU3dVheeM+75bFxuE3luZ0DvLmfKQHW
         EozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDGhHpoe/eWfJsY+oKVEuX03napklo56SUJ6Lc7Lye0=;
        b=HZumO2vdk6UokxF8M4/F990acI1N/RmBAtyJydfnS/+ORE7s/A7bsitll/H5Anol7F
         uE7JGYgZenauCkMsWUhyZn9i8jL8GEHmBUUhBsb3826CeJCZCYI0OrEDx7yZM/dGBWT+
         +OTXyKwQWIhVkExetPj94SyTyQejliz/8CkZOPGlpoNsnZcrgKxEpJh7hkUw9yCA4RvO
         BKJ4ZZNxR0UGwzvL7LUZXTWJElS0JCUDtQIPo5qLc+mtAWoP+RZlaIRSvoD2rHHBfkCZ
         G3p1fjBmEPdsTbdQaTSG9tmeWZmoCzbxNH0NyI5pPy4akGSdUc54F8hLeCrvpkmLWTm0
         HApQ==
X-Gm-Message-State: AOAM530/s3/bkMrqgDF4sOq9pPbr2rbGeglOtyDlJ9p4OnSGPLmFaNa+
        Dx+VuhkkJmAu+tJHeiiZ39mH7q82a5+Ipg==
X-Google-Smtp-Source: ABdhPJzxGDHeIaUN782tj1aNcCfvp3LGpPFhHEyoinZjwlO9a28IXnyUP87fjQu6m1EtFHaSRR1STQ==
X-Received: by 2002:a17:90a:6288:: with SMTP id d8mr336120pjj.210.1604533353393;
        Wed, 04 Nov 2020 15:42:33 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 30sm3361513pgl.45.2020.11.04.15.42.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:42:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/8] mgmt-tester: Print out the HCI received and expected cmd value
Date:   Wed,  4 Nov 2020 15:42:23 -0800
Message-Id: <20201104234228.2257427-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104234228.2257427-1-luiz.dentz@gmail.com>
References: <20201104234228.2257427-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make it simpler to debug when the kernel has been updated and
parameters no longer match:
---
 tools/mgmt-tester.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 27a5f0bab..4775fb18a 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6381,7 +6381,9 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 	}
 
 	if (memcmp(param, expect_hci_param, length) != 0) {
-		tester_warn("Unexpected HCI command parameter value");
+		tester_warn("Unexpected HCI command parameter value:");
+		util_hexdump('>', param, length, print_debug, "");
+		util_hexdump('!', expect_hci_param, length, print_debug, "");
 		tester_test_failed();
 		return;
 	}
-- 
2.26.2

