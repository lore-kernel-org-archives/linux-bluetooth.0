Return-Path: <SRS0=3ySR=RW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1A3C10F03
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 05:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680582133D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 05:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfCSFXt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:23:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:48780 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfCSFXt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Mar 2019 01:23:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 22:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,496,1544515200"; 
   d="scan'208";a="123831415"
Received: from ubuntu16.iind.intel.com ([10.66.226.199])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2019 22:23:46 -0700
From:   Chethan T N <chethan.tumkur.narayan@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] btusb: Re-program BULK IN URBs once the Intel BT controller  is in operational firmware mode.
Date:   Tue, 19 Mar 2019 10:53:06 +0530
Message-Id: <1552972986-32258-1-git-send-email-chethan.tumkur.narayan@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Raghuram Hegde <raghuram.hegde@intel.com>

Once Firmware download is complete, BULK IN URBs need not be
programmed till the Intel Bluetooth controller switches from
bootloader to operational firmware, as there will not be any data
sent on BULK IN endpoint.

If BULK IN URBs are programmed during this time, a USB turn-around
time error is seen for BULK IN tokens. This results in XHCI resetting
the endpoint data toggle sequence leading to data sequence sync-loss
between Host XHCI controller and Bluetooth controller.

The following fix is required to prevent data sequence sync-loss:
Kill the BULK IN URBs once FW download is complete and re-submit them
after Intel BT controller has booted to operational firmware.

Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/btusb.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ded198328f21..e656acdfd84a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2332,6 +2332,15 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
 
 	bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
+
+	/* Once Firmware download is complete, Bulk endpoints will not be
+	 * used until the Bluetooth controller boots with operational
+	 * firmware. If we have the Bulk URBs scheduled when Intel Bluetooth
+	 * controller switches from bootloader to operational firmware, we
+	 * observe Bus Turn-around timeouts for Bulk IN tokens.So, to prevent
+	 * such error condition, kill the URBs scheduled on Bulk endpoint.
+	 */
+	usb_kill_anchored_urbs(&data->bulk_anchor);
 
 done:
 	release_firmware(fw);
@@ -2395,6 +2404,18 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 */
 	btintel_set_event_mask(hdev, false);
 
+	/* As the Intel bluetooth controller has now booted in operational
+	 * mode, re-program the URBs for BULK IN endpoint
+	 */
+	if (test_bit(BTUSB_BULK_RUNNING, &data->flags)) {
+		err = btusb_submit_bulk_urb(hdev, GFP_NOIO);
+		if (err < 0) {
+			clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+			return err;
+		}
+		btusb_submit_bulk_urb(hdev, GFP_NOIO);
+	}
+
 	return 0;
 }
 
-- 
2.7.4

