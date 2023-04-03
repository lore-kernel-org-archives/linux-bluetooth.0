Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0F4C76196
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 16:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjDCQis (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 12:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjDCQim (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 12:38:42 -0400
Received: from mail-m11878.qiye.163.com (mail-m11878.qiye.163.com [115.236.118.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C7D270C
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 09:38:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [103.29.142.67])
        by mail-m11878.qiye.163.com (Hmail) with ESMTPA id 1515C740781;
        Tue,  4 Apr 2023 00:30:22 +0800 (CST)
From:   Qiqi Zhang <eddy.zhang@rock-chips.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiqi Zhang <eddy.zhang@rock-chips.com>
Subject: [PATCH] Bluetooth: hci_h5: Complements reliable packet processing logic.
Date:   Tue,  4 Apr 2023 00:29:28 +0800
Message-Id: <20230403162928.118172-1-eddy.zhang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT00dVklOQ0JITUhDTE4ZH1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTY6GCo5GD0QPDkrKzMLMj8I
        CQ8KFAxVSlVKTUNLTkhCT0lISUpIVTMWGhIXVR4fHwJVARMaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlPSUo3Bg++
X-HM-Tid: 0a8747f48ed72eb4kusn1515c740781
X-HM-MType: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As shown in the schematic diagram below.There may be a critical
scenario in the current code. If the device does not receive an
pure ack sent by the host due to insufficient receive buffer or
other reasons and triggers a retransmission, the host will always
be in an 'out-of-order' state.The state machine will get stuck.

       host                 device
     SEQ3,ACK4 --------->
               <--------- SEQ4,ACK4
     pure ACK  ---------> (not received)
(out-of-order) <--------- SEQ4,ACK4(retransmission)
		........
(out-of-order) <--------- SEQ4,ACK4(retransmission)

According to the description in the core specification: "whenever
a reliable packet is received, an acknowledgment shall be generated."
we should set H5_TX_ACK_REQ bit to trigger retransmission of pure ack
packet when "out-of-order" occurs.

Signed-off-by: Qiqi Zhang <eddy.zhang@rock-chips.com>
---
 drivers/bluetooth/hci_h5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 6455bc4fb5bb..d05eaeaa4516 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -463,6 +463,8 @@ static int h5_rx_3wire_hdr(struct hci_uart *hu, unsigned char c)
 	if (H5_HDR_RELIABLE(hdr) && H5_HDR_SEQ(hdr) != h5->tx_ack) {
 		bt_dev_err(hu->hdev, "Out-of-order packet arrived (%u != %u)",
 			   H5_HDR_SEQ(hdr), h5->tx_ack);
+		set_bit(H5_TX_ACK_REQ, &h5->flags);
+		hci_uart_tx_wakeup(hu);
 		h5_reset_rx(h5);
 		return 0;
 	}
-- 
2.25.1

