Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F1EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 08:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C1C64F67
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 08:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhBCI01 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Feb 2021 03:26:27 -0500
Received: from m12-18.163.com ([220.181.12.18]:48883 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232427AbhBCI00 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Feb 2021 03:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=/bWpvObfO39qBEGDX8
        D1grTxh4oIbIbXTsfFa8Co/9I=; b=a+o1erCP6FqfRoxKW9HnEf548TdLnLss0g
        5XPM77HpQiTRDicluxbIdDi8mJ2RYX1dE5hT+Fxsut1AwG35IN6C6dShzpsRh9jF
        PExuW3XDe/7VypfoSfVB/QgE4JnFHLI/36uUKNieCqbH0/IKXKU/0d7EflV04SGz
        T5bzw6DI4=
Received: from zhongjupeng.ccdomain.com (unknown [218.17.89.92])
        by smtp14 (Coremail) with SMTP id EsCowAC3vgqqWRpgNFyfSQ--.6493S2;
        Wed, 03 Feb 2021 16:07:07 +0800 (CST)
From:   zjp734690220@163.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     Markus.Elfring@web.de, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jupeng Zhong <zhongjupeng@yulong.com>
Subject: [PATCH v3] Bluetooth: btusb: Fix memory leak in btusb_mtk_wmt_recv
Date:   Wed,  3 Feb 2021 16:07:16 +0800
Message-Id: <20210203080716.5632-1-zjp734690220@163.com>
X-Mailer: git-send-email 2.15.0.windows.1
X-CM-TRANSID: EsCowAC3vgqqWRpgNFyfSQ--.6493S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF43Cw1rtw1kKF48Jry5Jwb_yoW8ZF1UpF
        ZrGFy5Ars5Jr4DZw17Ar1rAay5Wa1SqrZrKryjyw1FkFyav3yvqF47Ga4SqrsYkrW8Z39F
        yF15trWS9F4UA3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b1BTOUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 52msljauwzijisq6il2tof0z/xtbCCxMuFF3LfCqltgAAsx
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jupeng Zhong <zhongjupeng@yulong.com>

In btusb_mtk_wmt_recv if skb_clone fails, the alocated memory
should be free.

Omit the labels "err_out" and "err_free_skb" in this function
implementation so that the desired exception handling code
convert usage of two labels to direct code specification.

Fixes: a1c49c434e15 ("btusb: Add protocol support for MediaTek MT7668U USB devices")
Signed-off-by: Jupeng Zhong <zhongjupeng@yulong.com>
---
v3: update the patch description
v2: omit the labels "err_out" and "err_free_skb", and
    update the patch "From:" and "Signed-off-by:"
---
 drivers/bluetooth/btusb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5064b1d79c79..e8ab400e62a7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3200,7 +3200,7 @@ static void btusb_mtk_wmt_recv(struct urb *urb)
 		skb = bt_skb_alloc(HCI_WMT_MAX_EVENT_SIZE, GFP_ATOMIC);
 		if (!skb) {
 			hdev->stat.err_rx++;
-			goto err_out;
+			return;
 		}
 
 		hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
@@ -3218,13 +3218,18 @@ static void btusb_mtk_wmt_recv(struct urb *urb)
 		 */
 		if (test_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags)) {
 			data->evt_skb = skb_clone(skb, GFP_ATOMIC);
-			if (!data->evt_skb)
-				goto err_out;
+			if (!data->evt_skb) {
+				kfree_skb(skb);
+				return;
+			}
 		}
 
 		err = hci_recv_frame(hdev, skb);
-		if (err < 0)
-			goto err_free_skb;
+		if (err < 0) {
+			kfree_skb(data->evt_skb);
+			data->evt_skb = NULL;
+			return;
+		}
 
 		if (test_and_clear_bit(BTUSB_TX_WAIT_VND_EVT,
 				       &data->flags)) {
@@ -3233,11 +3238,6 @@ static void btusb_mtk_wmt_recv(struct urb *urb)
 			wake_up_bit(&data->flags,
 				    BTUSB_TX_WAIT_VND_EVT);
 		}
-err_out:
-		return;
-err_free_skb:
-		kfree_skb(data->evt_skb);
-		data->evt_skb = NULL;
 		return;
 	} else if (urb->status == -ENOENT) {
 		/* Avoid suspend failed when usb_kill_urb */
-- 
1.9.1


