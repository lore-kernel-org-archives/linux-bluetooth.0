Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331F3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 11:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC27864DD8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 11:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhA1Lxy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 06:53:54 -0500
Received: from m12-18.163.com ([220.181.12.18]:44102 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhA1Lxw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 06:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=d4bdEBtebjJQfdESJ6
        Z0hhcQ6ufp7HGXXUDy8MsIUEQ=; b=S7xfy4Rsm/kdbH9Fut/CS0fNSkt8KERRAF
        d1RlLpkYm4pE9DoaveLYRb8UY2up4vrkmA9sRHkED+WOV5m1ccj5QmtrroNEB6fB
        rbSyUFvvCStX5JXV44Sf1wUOh2QVckP2CvtfjuWO8eXzjmz/fM5am//kNjS9aFOo
        Mlb5+kx5o=
Received: from zhongjupeng.ccdomain.com (unknown [218.17.89.92])
        by smtp14 (Coremail) with SMTP id EsCowAC3YdQ7mhJg7zvHRQ--.6094S2;
        Thu, 28 Jan 2021 19:04:28 +0800 (CST)
From:   zjp734690220@163.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjupeng <zhongjupeng@yulong.com>
Subject: [PATCH] bluetooth: fix typo
Date:   Thu, 28 Jan 2021 19:04:36 +0800
Message-Id: <20210128110436.43092-1-zjp734690220@163.com>
X-Mailer: git-send-email 2.15.0.windows.1
X-CM-TRANSID: EsCowAC3YdQ7mhJg7zvHRQ--.6094S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr47Cr13AF1UGry3Cr4xXrb_yoW3Jrc_u3
        4xZr4xtFWUCrZ7AF1jyrZFvry5K345WFs7ZrnIq34rur9Fgr4DCFyqgryFqF47CwnYgr92
        yay5Wr4Ivr1UGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnBc_7UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 52msljauwzijisq6il2tof0z/xtbBohwoFFaD+qC2uAAAsD
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: zhongjupeng <zhongjupeng@yulong.com>

change 'deivice' to 'device'

Signed-off-by: zhongjupeng <zhongjupeng@yulong.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03b83aa..ffec6bc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3465,7 +3465,7 @@ static int btusb_mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	while (fw_size > 0) {
 		dlen = min_t(int, 250, fw_size);
 
-		/* Tell deivice the position in sequence */
+		/* Tell device the position in sequence */
 		if (fw_size - dlen <= 0)
 			flag = 3;
 		else if (fw_size < fw->size - 30)
-- 
1.9.1


