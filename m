Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FEAC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Mar 2022 01:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiCIBDr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiCIBCy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Mar 2022 20:02:54 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5A8131F40;
        Tue,  8 Mar 2022 16:40:31 -0800 (PST)
X-UUID: 82f8d12d712a45e89511fe7c4249d0c5-20220309
X-UUID: 82f8d12d712a45e89511fe7c4249d0c5-20220309
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 69372533; Wed, 09 Mar 2022 08:03:59 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Mar 2022 08:03:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Mar 2022 08:03:58 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 3/3] Bluetooth: btmtkuart: fix the conflict between mtk and msft vendor event
Date:   Wed, 9 Mar 2022 08:03:54 +0800
Message-ID: <16e90bd42107f67d997fdef8b12430e1efd892ad.1646783737.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <f0167a9631fd0b392490311825ff0f826c054bc1.1646783737.git.objelf@gmail.com>
References: <f0167a9631fd0b392490311825ff0f826c054bc1.1646783737.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

There is a conflict between MediaTek wmt event and msft vendor extension
logic in the core layer since 145373cb1b1f ("Bluetooth: Add framework for
Microsoft vendor extension") was introduced because we changed the type of
mediatek wmt event to the type of msft vendor event in the driver.

But the purpose we reported mediatek event to the core layer is for the
diagnostic purpose with that we are able to see the full packet trace via
monitoring socket with btmon. Thus, it is harmless we keep the original
type of mediatek vendor event here to avoid breaking the msft extension
function especially they can be supported by Mediatek future devices.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtkuart.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 7d405a16f864..695e1225b08c 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -192,13 +192,6 @@ static int btmtkuart_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	struct hci_event_hdr *hdr = (void *)skb->data;
 	int err;
 
-	/* Fix up the vendor event id with 0xff for vendor specific instead
-	 * of 0xe4 so that event send via monitoring socket can be parsed
-	 * properly.
-	 */
-	if (hdr->evt == 0xe4)
-		hdr->evt = HCI_EV_VENDOR;
-
 	/* When someone waits for the WMT event, the skb is being cloned
 	 * and being processed the events from there then.
 	 */
@@ -214,7 +207,7 @@ static int btmtkuart_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	if (err < 0)
 		goto err_free_skb;
 
-	if (hdr->evt == HCI_EV_VENDOR) {
+	if (hdr->evt == HCI_EV_WMT) {
 		if (test_and_clear_bit(BTMTKUART_TX_WAIT_VND_EVT,
 				       &bdev->tx_state)) {
 			/* Barrier to sync with other CPUs */
-- 
2.25.1

