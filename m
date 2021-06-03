Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26384C4709B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 07:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E81613E6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 07:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhFCHqD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 03:46:03 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3400 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFCHqB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 03:46:01 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fwd9B0y5kz67s2;
        Thu,  3 Jun 2021 15:40:30 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 15:44:14 +0800
Received: from huawei.com (10.67.165.24) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 15:44:13 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yekai13@huawei.com>
Subject: [PATCH v3 03/12] Bluetooth: hidp: Use the correct print format
Date:   Thu, 3 Jun 2021 15:40:56 +0800
Message-ID: <1622706065-45409-4-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1622706065-45409-1-git-send-email-yekai13@huawei.com>
References: <1622706065-45409-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to Documentation/core-api/printk-formats.rst,
Use the correct print format. Printing an unsigned int value should use %u
instead of %d. Otherwise printk() might end up displaying negative numbers.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 net/bluetooth/hidp/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 0db48c8..1dc8dee 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -508,7 +508,7 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 				unsigned char param)
 {
 	int done_with_skb = 1;
-	BT_DBG("session %p skb %p len %d param 0x%02x", session, skb, skb->len, param);
+	BT_DBG("session %p skb %p len %u param 0x%02x", session, skb, skb->len, param);
 
 	switch (param) {
 	case HIDP_DATA_RTYPE_INPUT:
@@ -553,7 +553,7 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 	unsigned char hdr, type, param;
 	int free_skb = 1;
 
-	BT_DBG("session %p skb %p len %d", session, skb, skb->len);
+	BT_DBG("session %p skb %p len %u", session, skb, skb->len);
 
 	hdr = skb->data[0];
 	skb_pull(skb, 1);
@@ -589,7 +589,7 @@ static void hidp_recv_intr_frame(struct hidp_session *session,
 {
 	unsigned char hdr;
 
-	BT_DBG("session %p skb %p len %d", session, skb, skb->len);
+	BT_DBG("session %p skb %p len %u", session, skb, skb->len);
 
 	hdr = skb->data[0];
 	skb_pull(skb, 1);
-- 
2.8.1

