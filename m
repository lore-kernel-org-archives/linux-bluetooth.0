Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6447C48BE6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 16:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9657661245
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 16:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhFPQ3M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 12:29:12 -0400
Received: from m12-12.163.com ([220.181.12.12]:40136 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233563AbhFPQ3L (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 12:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Tr1BB
        GQIeuuHKxbyn8Yph9G7uKAkr8UoYHsUcGkvYAA=; b=YfjwpY6WHHk0h5cX3EkGk
        2wT74mHF2SsrpFqKq41nQBDaPF23HGrZ1cfun6ud8Is67UyXrqvXrUP92T5YBOY1
        tt1v4rfAm/5xDoJsSGnsP3CQQceCCduwkL6+R8jzVPjuLyOHSshqs0dEWW98+IGz
        IWzTvWlYlEb57ALaQzACAc=
Received: from ubuntu.localdomain (unknown [112.37.241.255])
        by smtp8 (Coremail) with SMTP id DMCowAD3grh3tclgNnb_KA--.3520S2;
        Wed, 16 Jun 2021 16:25:28 +0800 (CST)
From:   13145886936@163.com
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: [PATCH] Bluetooth: fix a grammar mistake
Date:   Wed, 16 Jun 2021 16:25:24 +0800
Message-Id: <20210616082524.10754-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAD3grh3tclgNnb_KA--.3520S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFyxZw1fWFWUuw4UXryDAwb_yoW3WFb_X3
        s3ua97urWUGa45XayjyrsIvw1xJw4rur1IqFnxWFWUC3s8Cw4DKwsagw4DWr13W3y3Arya
        kFn5GFWDZr1IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnZjjDUUUUU==
X-Originating-IP: [112.37.241.255]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBdhizg1UMRSAMvQAAsT
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Fix a grammar mistake.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 98ec486743ba..a33838a72f19 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5780,7 +5780,7 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
 			 * for unsupported remote feature gets returned.
 			 *
 			 * In this specific case, allow the connection to
-			 * transition into connected state and mark it as
+			 * transit into connected state and mark it as
 			 * successful.
 			 */
 			if (!conn->out && ev->status == 0x1a &&
-- 
2.25.1


