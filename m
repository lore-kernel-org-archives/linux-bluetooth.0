Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FF3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 16:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC1C60551
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 16:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhJMQYP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:24:15 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:33090 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229529AbhJMQYO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 12:24:14 -0400
X-UUID: 6066434251bb44b98f7276b93295e32b-20211014
X-UUID: 6066434251bb44b98f7276b93295e32b-20211014
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mark-yw.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1541090320; Thu, 14 Oct 2021 00:22:06 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 14 Oct 2021 00:22:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Oct
 2021 00:22:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Oct 2021 00:22:05 +0800
From:   <mark-yw.chen@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <mark-yw.chen@mediatek.com>, <will-cy.lee@mediatek.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: btusb: fix memory leak in btusb_mtk_submit_wmt_recv_urb()
Date:   Thu, 14 Oct 2021 00:22:04 +0800
Message-ID: <20211013162204.13919-1-mark-yw.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Mark-YW.Chen <mark-yw.chen@mediatek.com>

Driver should free `usb->setup_packet` to avoid the leak.

$ cat /sys/kernel/debug/kmemleak
unreferenced object 0xffffffa564a58080 (size 128):
    backtrace:
        [<000000007eb8dd70>] kmem_cache_alloc_trace+0x22c/0x384
        [<000000008a44191d>] btusb_mtk_hci_wmt_sync+0x1ec/0x994
    [btusb]
        [<00000000ca7189a3>] btusb_mtk_setup+0x6b8/0x13cc
    [btusb]
        [<00000000c6105069>] hci_dev_do_open+0x290/0x974
    [bluetooth]
        [<00000000a583f8b8>] hci_power_on+0xdc/0x3cc [bluetooth]
        [<000000005d80e687>] process_one_work+0x514/0xc80
        [<00000000f4d57637>] worker_thread+0x818/0xd0c
        [<00000000dc7bdb55>] kthread+0x2f8/0x3b8
        [<00000000f9999513>] ret_from_fork+0x10/0x30

Signed-off-by: Mark-YW.Chen <mark-yw.chen@mediatek.com>
---
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 75c83768c257..1bfcbcabc7d3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2265,6 +2265,7 @@ static void btusb_mtk_wmt_recv(struct urb *urb)
 		skb = bt_skb_alloc(HCI_WMT_MAX_EVENT_SIZE, GFP_ATOMIC);
 		if (!skb) {
 			hdev->stat.err_rx++;
+			kfree(urb->setup_packet);
 			return;
 		}
 
@@ -2285,6 +2286,7 @@ static void btusb_mtk_wmt_recv(struct urb *urb)
 			data->evt_skb = skb_clone(skb, GFP_ATOMIC);
 			if (!data->evt_skb) {
 				kfree_skb(skb);
+				kfree(urb->setup_packet);
 				return;
 			}
 		}
@@ -2293,6 +2295,7 @@ static void btusb_mtk_wmt_recv(struct urb *urb)
 		if (err < 0) {
 			kfree_skb(data->evt_skb);
 			data->evt_skb = NULL;
+			kfree(urb->setup_packet);
 			return;
 		}
 
@@ -2303,6 +2306,7 @@ static void btusb_mtk_wmt_recv(struct urb *urb)
 			wake_up_bit(&data->flags,
 				    BTUSB_TX_WAIT_VND_EVT);
 		}
+		kfree(urb->setup_packet);
 		return;
 	} else if (urb->status == -ENOENT) {
 		/* Avoid suspend failed when usb_kill_urb */
@@ -2323,6 +2327,7 @@ static void btusb_mtk_wmt_recv(struct urb *urb)
 	usb_anchor_urb(urb, &data->ctrl_anchor);
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err < 0) {
+		kfree(urb->setup_packet);
 		/* -EPERM: urb is being killed;
 		 * -ENODEV: device got disconnected
 		 */
-- 
2.18.0

