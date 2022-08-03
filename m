Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CD8C19F2C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 09:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbiHCJvh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 05:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiHCJvW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 05:51:22 -0400
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E811F5A2EB;
        Wed,  3 Aug 2022 02:49:58 -0700 (PDT)
Received: from localhost (79.red-83-50-138.dynamicip.rima-tde.net [83.50.138.79])
        by iodev.co.uk (Postfix) with ESMTPSA id 607ABD7DEC;
        Wed,  3 Aug 2022 11:49:39 +0200 (CEST)
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     Ismael Luceno <ismael@iodev.co.uk>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH v2] Bluetooth: hci_sync: Fix opcode format in debug message
Date:   Wed,  3 Aug 2022 11:49:33 +0200
Message-Id: <20220803094933.20984-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Pad with zeros instead of spaces. Before:

        Bluetooth: hci1: Opcode 0x c01 failed: -110

After:

        Bluetooth: hci1: Opcode 0x0c01 failed: -110

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---

Changes since v1:
* Fixed another message
* Added description

 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c17021642234..e5ad6607470e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -150,7 +150,7 @@
 	struct sk_buff *skb;
 	int err = 0;
 
-	bt_dev_dbg(hdev, "Opcode 0x%4x", opcode);
+	bt_dev_dbg(hdev, "Opcode 0x%04x", opcode);
 
 	hci_req_init(&req, hdev);
 
@@ -245,7 +245,7 @@ EXPORT_SYMBOL(__hci_cmd_sync_ev);
 
 	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
 	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Opcode 0x%4x failed: %ld", opcode,
+		bt_dev_err(hdev, "Opcode 0x%04x failed: %ld", opcode,
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
-- 
2.37.1

