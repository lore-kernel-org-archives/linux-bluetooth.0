Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75189CDB483
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 02:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjJSCkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 22:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjJSCkV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 22:40:21 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0329412D;
        Wed, 18 Oct 2023 19:40:18 -0700 (PDT)
Received: from king.lan (unknown [103.163.180.22])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 03B2E6062C993;
        Thu, 19 Oct 2023 10:40:01 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.22
From:   king <youwan@nfschina.com>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        youwan Wang <youwan@nfschina.com>
Subject: [PATCH] Bluetooth: btusb: Add return error code
Date:   Thu, 19 Oct 2023 10:39:53 +0800
Message-Id: <20231019023953.218624-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: youwan Wang <youwan@nfschina.com>

Signed-off-by: youwan Wang <youwan@nfschina.com>
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b8e9de887b5d..ec6bdc9687b1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2826,8 +2826,10 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 		goto err_free_wc;
 	}
 
-	if (data->evt_skb == NULL)
+	if (data->evt_skb == NULL) {
+		err = -ENOBUFS;
 		goto err_free_wc;
+	}
 
 	/* Parse and handle the return WMT event */
 	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
-- 
2.25.1

