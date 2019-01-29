Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C5EC169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6A9214DA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfA2MZx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:25:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:20101 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbfA2MZx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 07:25:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 04:25:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="134076046"
Received: from ubuntu16.iind.intel.com ([10.224.186.218])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2019 04:25:51 -0800
From:   raghuram.hegde@intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Subject: [Patch v1] btusb: Add shutdown routine for BTUSB_INTEL_NEW devices
Date:   Tue, 29 Jan 2019 17:54:48 +0530
Message-Id: <1548764688-5429-1-git-send-email-raghuram.hegde@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Raghuram Hegde <raghuram.hegde@intel.com>

Observation:
If BT operations (Eg:BREDR inquiry/LE scan) were triggered
through the stack, followed by BT turn off through
'hciconfig hci0 down', the controller would still be active
and consume power.
Also, there is a possibility that a race condition/
synchronization issue might arise on the subsequent BT turn
on, as the controller might try to push the
events that were queued up before processing the HCI Reset
command.

btusb_shutdown_intel_new routine shall reset the controller
and stop all BT operation.
Advantages:
	1. Power save on the platform
	2. Host and controller will be in Sync.

Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5de0c2e59b97..3aac92be0f87 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2434,6 +2434,24 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
 	return 0;
 }
 
+static int btusb_shutdown_intel_new(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	
+	/* Send HCI Reset to the controller to stop any BT activity which
+	 * were triggered. This will help to save power and maintain the
+	 * sync b/w Host and controller
+	 */
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "HCI reset during shutdown failed");
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 /* Configure an out-of-band gpio as wake-up pin, if specified in device tree */
 static int marvell_config_oob_wake(struct hci_dev *hdev)
@@ -3139,6 +3157,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->manufacturer = 2;
 		hdev->send = btusb_send_frame_intel;
 		hdev->setup = btusb_setup_intel_new;
+		hdev->shutdown = btusb_shutdown_intel_new;
 		hdev->hw_error = btintel_hw_error;
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
-- 
2.7.4

