Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB3EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE71A2311D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 10:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgLVKcd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 05:32:33 -0500
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:57638 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbgLVKcc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 05:32:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 98DC7182CF665;
        Tue, 22 Dec 2020 10:31:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: limit40_2008c822745f
X-Filterd-Recvd-Size: 2725
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 22 Dec 2020 10:31:50 +0000 (UTC)
Message-ID: <45b260bfe6a3d3c11c48e76dd5de7fa40665154c.camel@perches.com>
Subject: [PATCH] Bluetooth: btusb: Remove duplicate newlines from logging
From:   Joe Perches <joe@perches.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 22 Dec 2020 02:31:49 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The bt_dev_<level> macros already append a newline.

Signed-off-by: Joe Perches <joe@perches.com>
---

The "No memory" message could be removed as bt_skb_alloc already does
a dump_stack() on allocation failure.

 drivers/bluetooth/btusb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b630a1d54c02..9ff920de8d26 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1899,7 +1899,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		    le16_to_cpu(rp->lmp_subver) == 0x1012 &&
 		    le16_to_cpu(rp->hci_rev) == 0x0810 &&
 		    le16_to_cpu(rp->hci_ver) == BLUETOOTH_VER_4_0) {
-			bt_dev_warn(hdev, "CSR: detected a fake CSR dongle using a Barrot 8041a02 chip, this chip is very buggy and may have issues\n");
+			bt_dev_warn(hdev, "CSR: detected a fake CSR dongle using a Barrot 8041a02 chip, this chip is very buggy and may have issues");
 
 			pm_runtime_allow(&data->udev->dev);
 
@@ -1907,7 +1907,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 			if (ret >= 0)
 				msleep(200);
 			else
-				bt_dev_err(hdev, "Failed to suspend the device for Barrot 8041a02 receive-issue workaround\n");
+				bt_dev_err(hdev, "Failed to suspend the device for Barrot 8041a02 receive-issue workaround");
 
 			pm_runtime_forbid(&data->udev->dev);
 
@@ -3724,7 +3724,7 @@ static int marvell_config_oob_wake(struct hci_dev *hdev)
 
 	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
 	if (!skb) {
-		bt_dev_err(hdev, "%s: No memory\n", __func__);
+		bt_dev_err(hdev, "%s: No memory", __func__);
 		return -ENOMEM;
 	}
 
@@ -3733,7 +3733,7 @@ static int marvell_config_oob_wake(struct hci_dev *hdev)
 
 	ret = btusb_send_frame(hdev, skb);
 	if (ret) {
-		bt_dev_err(hdev, "%s: configuration failed\n", __func__);
+		bt_dev_err(hdev, "%s: configuration failed", __func__);
 		kfree_skb(skb);
 		return ret;
 	}

