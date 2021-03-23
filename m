Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F61EC433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 06:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6F6619AB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 06:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCWG03 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 02:26:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14427 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCWGZ7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 02:25:59 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4LtS1h6Mzkdgp;
        Tue, 23 Mar 2021 14:24:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 14:25:51 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] Bluetooth: Remove trailing semicolon in macros
Date:   Tue, 23 Mar 2021 14:22:56 +0800
Message-ID: <1616480576-5249-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

remove trailing semicolon in macros and coding style fix.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
---

Changes in v2
-Re-base in bluetooth-next 

 net/bluetooth/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index efc19f9..2def906 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -54,7 +54,7 @@
 #define SMP_ALLOW_CMD(smp, code)	set_bit(code, &smp->allow_cmd)
 
 /* Keys which are not distributed with Secure Connections */
-#define SMP_SC_NO_DIST (SMP_DIST_ENC_KEY | SMP_DIST_LINK_KEY);
+#define SMP_SC_NO_DIST (SMP_DIST_ENC_KEY | SMP_DIST_LINK_KEY)
 
 #define SMP_TIMEOUT	msecs_to_jiffies(30000)
 
@@ -398,7 +398,7 @@ static int smp_e(const u8 *k, u8 *r)
 
 	SMP_DBG("r %16phN", r);
 
-	memzero_explicit(&ctx, sizeof (ctx));
+	memzero_explicit(&ctx, sizeof(ctx));
 	return err;
 }
 
-- 
2.8.1

