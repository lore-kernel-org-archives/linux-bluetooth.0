Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044F7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 14:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381636AbhLCPCi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381628AbhLCPCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 10:02:35 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C717C0611F7
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fS2yL2UnMGjTsNu363MYFfJS182LjOB/Q7ttvexi/FQ=;
        t=1638543551; x=1639753151; b=IFGY1UnpMmBxM+mD9tL0eyZiUyGLmffSjX1gMlK8YGrHCnR
        ckh6kDy9waBuYu6oQ543o13EJ/5XEPxBH6JCuSLdspwa8VvGyQqslI5KVeLteoP+eoeWNkmITLel9
        K/c5dcV2crFtSRrT04cv5PHMUn4mwGmafqgszAr+zcieW4m0dOjX8CQ/HHtGz/pz5LK63YOJtD31n
        ZkJhy9HPsk4ngyl5asa9oFhp91FqLNbfdMpqE/2X1XhgF7YyYHba2JpAWafJ9Y9Wxx2T9kqGO9TQO
        zSknGgjDtNN5VjYw6ZiNV22cbfDb1U+2GXuSkoY2y7mpvfM7Gheh+cA6aIG+JCEQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mtA1l-006QDV-PM;
        Fri, 03 Dec 2021 15:59:10 +0100
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Benjamin Berg <bberg@redhat.com>
Subject: [PATCH v2 4/4] Bluetooth: btusb: Cancel sync commands for certain URB errors
Date:   Fri,  3 Dec 2021 15:59:02 +0100
Message-Id: <20211203145902.3223861-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203145902.3223861-1-benjamin@sipsolutions.net>
References: <20211203145902.3223861-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Benjamin Berg <bberg@redhat.com>

Cancel sync commands when transmission of URBs fail. This is done for
both failures to send a command URB and also when the interrupt URB used
to retrieve a response fails.

This approach is sufficient to quickly deal with certain errors such as
a device being disconnected while synchronous commands are done during
initialization.

Signed-off-by: Benjamin Berg <bberg@redhat.com>

---

v2:
 * Do not call handler in btusb_isoc_tx_complete.
 * Only call handler for command SKBs in btusb_tx_complete
---
 drivers/bluetooth/btusb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ab169fc673ea..d9067a8fad60 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -933,6 +933,8 @@ static void btusb_intr_complete(struct urb *urb)
 		if (err != -EPERM && err != -ENODEV)
 			bt_dev_err(hdev, "urb %p failed to resubmit (%d)",
 				   urb, -err);
+		if (err != -EPERM)
+			hci_cmd_sync_cancel(hdev, -err);
 		usb_unanchor_urb(urb);
 	}
 }
@@ -976,6 +978,8 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 		if (err != -EPERM && err != -ENODEV)
 			bt_dev_err(hdev, "urb %p submission failed (%d)",
 				   urb, -err);
+		if (err != -EPERM)
+			hci_cmd_sync_cancel(hdev, -err);
 		usb_unanchor_urb(urb);
 	}
 
@@ -1331,10 +1335,13 @@ static void btusb_tx_complete(struct urb *urb)
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		goto done;
 
-	if (!urb->status)
+	if (!urb->status) {
 		hdev->stat.byte_tx += urb->transfer_buffer_length;
-	else
+	} else {
+		if (hci_skb_pkt_type(skb) == HCI_COMMAND_PKT)
+			hci_cmd_sync_cancel(hdev, -urb->status);
 		hdev->stat.err_tx++;
+	}
 
 done:
 	spin_lock_irqsave(&data->txlock, flags);
-- 
2.33.1

