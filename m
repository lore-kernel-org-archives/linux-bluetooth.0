Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF77C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Jul 2022 21:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiGXVeX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Jul 2022 17:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGXVeW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Jul 2022 17:34:22 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Jul 2022 14:34:21 PDT
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D505BC03;
        Sun, 24 Jul 2022 14:34:21 -0700 (PDT)
Received: from localhost (153.red-83-50-200.dynamicip.rima-tde.net [83.50.200.153])
        by iodev.co.uk (Postfix) with ESMTPSA id 8A9D3D0CAC;
        Sun, 24 Jul 2022 23:26:41 +0200 (CEST)
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     Ismael Luceno <ismael@iodev.co.uk>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Bluetooth: hci_sync: Fix opcode format in debug message
Date:   Sun, 24 Jul 2022 23:26:39 +0200
Message-Id: <20220724212639.29269-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 351c2390164d..d86d819465e8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -150,7 +150,7 @@
 	struct sk_buff *skb;
 	int err = 0;
 
-	bt_dev_dbg(hdev, "Opcode 0x%4x", opcode);
+	bt_dev_dbg(hdev, "Opcode 0x%04x", opcode);
 
 	hci_req_init(&req, hdev);
 
-- 
2.36.0

