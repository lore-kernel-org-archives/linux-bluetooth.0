Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD246C4321E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 16:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30016135E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 16:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbhKIQo0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbhKIQoX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 11:44:23 -0500
Received: from sipsolutions.net (unknown [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA91C0613F5
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LwunBjJvTdtZ2UAAi5IgCtwbKk9GqSuN6FAjZ1zyjS4=;
        t=1636476097; x=1637685697; b=aUO4cDYXCfprtIsuGrPD6g3TTtfM5OIS92nt4gmFtPkLCd2
        1lTV5XHttQxWM6hnI4Gpn8BfvAlJAzYjKv02GiOEeCqmYpjB4rfhSn0LTT3Q/b88feXk+spxJFac8
        7uRbX9D33ArCBBoOWEfoKoaO9QsfceGhTyGeqDuccyvNaX7qbHRVuaPjHOCmlL7Ao/SGeHNmqrddp
        w6vGopO7pSkcLPKEqLiXyR/eNOAKtHHJGYxLgK3fXmTsNzbttKXrER0aVCNjOdAo2mtu81hBCyrvj
        lsFarZIU52CZXziLyFTAJNGit/dU7S7BYb73jxTQrSdYmyQQD13YN1+u1qKiXDBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mkUBi-00D1dY-Bf;
        Tue, 09 Nov 2021 17:41:34 +0100
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Benjamin Berg <bberg@redhat.com>
Subject: [PATCH 4/4] Bluetooth: btusb: Signal URB errors as TX failure
Date:   Tue,  9 Nov 2021 17:41:13 +0100
Message-Id: <20211109164113.65981-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211109164113.65981-1-benjamin@sipsolutions.net>
References: <20211109164113.65981-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Benjamin Berg <bberg@redhat.com>

Call the TX failure handler when transmission of URBs fail. This is done
both for failures to send an URB and also when the interrupt URB used to
retrieve a response fails.

This approach is sufficient to quickly deal with certain errors such as
a device being disconnected while synchronous commands are done during
initialization.

Signed-off-by: Benjamin Berg <bberg@redhat.com>
---
 drivers/bluetooth/btusb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 75c83768c257..0c4fe89c6573 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -924,6 +924,8 @@ static void btusb_intr_complete(struct urb *urb)
 		if (err != -EPERM && err != -ENODEV)
 			bt_dev_err(hdev, "urb %p failed to resubmit (%d)",
 				   urb, -err);
+		if (err != -EPERM)
+			hci_tx_error(hdev, -err);
 		usb_unanchor_urb(urb);
 	}
 }
@@ -967,6 +969,8 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 		if (err != -EPERM && err != -ENODEV)
 			bt_dev_err(hdev, "urb %p submission failed (%d)",
 				   urb, -err);
+		if (err != -EPERM)
+			hci_tx_error(hdev, -err);
 		usb_unanchor_urb(urb);
 	}
 
@@ -1322,10 +1326,12 @@ static void btusb_tx_complete(struct urb *urb)
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		goto done;
 
-	if (!urb->status)
+	if (!urb->status) {
 		hdev->stat.byte_tx += urb->transfer_buffer_length;
-	else
+	} else {
+		hci_tx_error(hdev, -urb->status);
 		hdev->stat.err_tx++;
+	}
 
 done:
 	spin_lock_irqsave(&data->txlock, flags);
@@ -1348,10 +1354,12 @@ static void btusb_isoc_tx_complete(struct urb *urb)
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		goto done;
 
-	if (!urb->status)
+	if (!urb->status) {
 		hdev->stat.byte_tx += urb->transfer_buffer_length;
-	else
+	} else {
+		hci_tx_error(hdev, -urb->status);
 		hdev->stat.err_tx++;
+	}
 
 done:
 	kfree(urb->setup_packet);
-- 
2.31.1

