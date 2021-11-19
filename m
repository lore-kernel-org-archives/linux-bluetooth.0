Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895A4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 22:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbhKSW3I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:29:08 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:53464 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236108AbhKSW3H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 17:29:07 -0500
X-UUID: a5b5d440cfe24b6fbe26ea75fc57eeb6-20211120
X-UUID: a5b5d440cfe24b6fbe26ea75fc57eeb6-20211120
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 276726196; Sat, 20 Nov 2021 06:26:02 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 20 Nov 2021 06:26:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 20 Nov
 2021 06:25:55 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 20 Nov 2021 06:25:54 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <Mark-YW.Chen@mediatek.com>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <michaelfsun@google.com>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mark-yw Chen <mark-yw.chen@mediatek.com>
Subject: [PATCH 4/4] Bluetooth: btmtksdio: add support of processing firmware coredump and log
Date:   Sat, 20 Nov 2021 06:25:46 +0800
Message-ID: <e8480933f01de26143d466b69ab5d0fa70e84ace.1637360076.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4176102d8bbc36e5156e348df666a3e12c5a3d75.1637360076.git.objelf@gmail.com>
References: <4176102d8bbc36e5156e348df666a3e12c5a3d75.1637360076.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add support of processing the firmware coredump and log for the diagnostic
purpose.

Co-developed-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index cae1fcd15512..adf9c89648cc 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -324,8 +324,29 @@ static int btmtksdio_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	return err;
 }
 
+static int btmtksdio_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
+	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
+
+	switch (handle) {
+	case 0xfc6f:
+		/* Firmware dump from device: when the firmware hangs, the
+		 * device can no longer suspend and thus disable auto-suspend.
+		 */
+		pm_runtime_forbid(bdev->dev);
+		fallthrough;
+	case 0x05ff:
+	case 0x05fe:
+		/* Firmware debug logging */
+		return hci_recv_diag(hdev, skb);
+	}
+
+	return hci_recv_frame(hdev, skb);
+}
+
 static const struct h4_recv_pkt mtk_recv_pkts[] = {
-	{ H4_RECV_ACL,      .recv = hci_recv_frame },
+	{ H4_RECV_ACL,      .recv = btmtksdio_recv_acl },
 	{ H4_RECV_SCO,      .recv = hci_recv_frame },
 	{ H4_RECV_EVENT,    .recv = btmtksdio_recv_event },
 };
-- 
2.25.1

