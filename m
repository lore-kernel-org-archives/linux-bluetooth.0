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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F93C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 02:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6A764DFA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 02:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhA2C0k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 21:26:40 -0500
Received: from m12-16.163.com ([220.181.12.16]:58142 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231825AbhA2C0V (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 21:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=PfWR0lIbnb1uWIHhio
        b/OGvKqCdkW9xMvg+9yLrowjI=; b=MNcj5tB4+52r0vezc7w1el94NGZF/YCLp9
        P7CnPPqbYlb4Y9j6YcYBPiblefCDiewfQnvTHf8HsEtaQnIybauggmbcPRy/OGnF
        raNNw0tagCrH2cwE6ldu427TEDHv9OtHPJ1qG5U/ZS/F7vlysHTg3VkkRhprCq/V
        N427ix+pk=
Received: from zhongjupeng.ccdomain.com (unknown [119.137.52.46])
        by smtp12 (Coremail) with SMTP id EMCowACXs08VbhNgqt2vZQ--.51471S2;
        Fri, 29 Jan 2021 10:08:22 +0800 (CST)
From:   zjp734690220@163.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjupeng <zhongjupeng@yulong.com>
Subject: [PATCH] bluetooth: fix memory leak in btusb_mtk_wmt_recv
Date:   Fri, 29 Jan 2021 10:08:27 +0800
Message-Id: <20210129020827.27784-1-zjp734690220@163.com>
X-Mailer: git-send-email 2.15.0.windows.1
X-CM-TRANSID: EMCowACXs08VbhNgqt2vZQ--.51471S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1DCF1xArWUWw43ZrW3GFg_yoW3Arb_u3
        WI9r13XrWUGw1xtF1UWrWa9rWFkr98WFn7Ar1ft34rZr9Igr4UCayqvFykWan3Ww1Fgrn7
        Za9rWFZ3Ar1IkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0h0eJUUUUU==
X-Originating-IP: [119.137.52.46]
X-CM-SenderInfo: 52msljauwzijisq6il2tof0z/xtbCCxYpFF3Le+UVLAAAsR
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: zhongjupeng <zhongjupeng@yulong.com>

In btusb_mtk_wmt_recv if skb_clone fails, the alocated skb should be
released.

Signed-off-by: zhongjupeng <zhongjupeng@yulong.com>
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ffec6bc..cf21bba 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3217,8 +3217,10 @@ static void btusb_mtk_wmt_recv(struct urb *urb)
 		 */
 		if (test_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags)) {
 			data->evt_skb = skb_clone(skb, GFP_ATOMIC);
-			if (!data->evt_skb)
+			if (!data->evt_skb) {
+				kfree_skb(skb);
 				goto err_out;
+			}
 		}
 
 		err = hci_recv_frame(hdev, skb);
-- 
1.9.1


