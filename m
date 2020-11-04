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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D92DC55179
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4543020BED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTucdWE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbgKDXmm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732855AbgKDXmh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 18:42:37 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B90DC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 15:42:37 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id z3so12287838pfz.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 15:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lJyBuvFuS+TsINhmeX8Fuirpoi1t9/CBaZTC2M3oPQc=;
        b=DTucdWE4kquiLYGYlaqBCQI14/0j1ogag57tOxn0l3NWn9ojYzMB/OL91plK+Ptrc9
         0NovOPuKSbUUK6aW850hE6Ha0kHdi8Xu/RcW1D0HFmNViBpVpQY++GkJY76TjvtMHgHd
         hh7VFMz5Fdx6fwQkMmHiWZVPOGj6XLtGNya6od+slSZ4JKn+qQypR7nQI0bXQxCbjiSu
         YdaPffu1lNnX/jsYSLnqCaVOzHik4Xk/w/N3AYyiY7GOz6uzLAPh2KYZe78irEDwp/aP
         lFfZfqqwZbJ98Vc7GBgesK/o3KZYdZ+OZp6nlUNOwjJ6C0MopOtDbHczDqzDL6ZmYEfo
         WCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJyBuvFuS+TsINhmeX8Fuirpoi1t9/CBaZTC2M3oPQc=;
        b=ai7t/Yu1ZN1Pq/DP1sacQpFpMtdugbJfAQVIYzkvDZ3PHrmZpUSOydRlD/rBPGBsD7
         olS3Ifuor6Q4a5jZcG/6DaLwotAhPZcBQz+jO364vovmnmMvb0jf9IE1BCUekaxjPxOm
         PRTAY4++U2vhv4O/IVbWRWQK6HURQALdDbphL/pTQOsqVXds0FfRgOluFsRvBPXk4c9C
         OpKrNCwHWCB4wTqV+TJPCMRMLvNKIjO+IYPj1jOlhrd0D062ROT1UjYz2/ttgzlYJi8x
         mve5AJ8Grtb1GIeZvEV9mjVENB3zE9ZpvgYCx5/sSbFgqQ7TbwczLoSJgJAMiMqnKapW
         fVJg==
X-Gm-Message-State: AOAM530i7DGIQqQ876dw7Vd3KOY9WrwjHmJiJpXVwJ44LDHiBZoa9Skw
        5/zSjas6omtfpofL3a+j1oMAbiZz8nttHQ==
X-Google-Smtp-Source: ABdhPJzG2YOlr+axnu1c4gPTvdSUsF0pYaB4rgoHqSIaXkOLMTJM76Lfv9Szy4vZGb837nNgnvVsBQ==
X-Received: by 2002:a17:90a:bb0e:: with SMTP id u14mr325240pjr.112.1604533356411;
        Wed, 04 Nov 2020 15:42:36 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 30sm3361513pgl.45.2020.11.04.15.42.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:42:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/8] mgmt-tester: Don't run tests which command fails
Date:   Wed,  4 Nov 2020 15:42:26 -0800
Message-Id: <20201104234228.2257427-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104234228.2257427-1-luiz.dentz@gmail.com>
References: <20201104234228.2257427-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This indicates that emulator don't support the test and until proper
support is added the test shall not be run.
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a67860da4..f6eac30a5 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6304,7 +6304,7 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 			test->send_opcode, mgmt_errstr(status), status);
 
 	if (status != test->expect_status) {
-		tester_test_failed();
+		tester_test_abort();
 		return;
 	}
 
-- 
2.26.2

