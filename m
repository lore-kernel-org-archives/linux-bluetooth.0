Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EFFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Mar 2022 01:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiCIBC4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCIBCv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Mar 2022 20:02:51 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2AC13197C;
        Tue,  8 Mar 2022 16:40:30 -0800 (PST)
X-UUID: c682af489d284ab7a8a56aae23edaef5-20220309
X-UUID: c682af489d284ab7a8a56aae23edaef5-20220309
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1317814429; Wed, 09 Mar 2022 08:03:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Mar 2022 08:03:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Mar 2022 08:03:57 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/3] Bluetooth: btmtkuart: add .set_bdaddr support
Date:   Wed, 9 Mar 2022 08:03:53 +0800
Message-ID: <5b4c80f7c7c9731ba6c03c8b8c37c47a6d901b3b.1646783737.git.objelf@gmail.com>
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

add .set_bdaddr support

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtkuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 136b901eb6f2..7d405a16f864 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -878,6 +878,7 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 	hdev->setup    = btmtkuart_setup;
 	hdev->shutdown = btmtkuart_shutdown;
 	hdev->send     = btmtkuart_send_frame;
+	hdev->set_bdaddr = btmtk_set_bdaddr;
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
 	hdev->manufacturer = 70;
-- 
2.25.1

