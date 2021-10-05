Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2306C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 04:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD61561184
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 04:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhJEEWd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 00:22:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:33226 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhJEEWd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 00:22:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="225546921"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="225546921"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 21:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="487841397"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga008.jf.intel.com with ESMTP; 04 Oct 2021 21:20:41 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Fix bdaddress comparison with garbage value
Date:   Tue,  5 Oct 2021 09:56:13 +0530
Message-Id: <20211005042613.9946-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Intel Read Verision(TLV) data is parsed into a local structure variable
and it contains a field for bd address. Bd address is returned only in
bootloader mode and hence bd address in TLV structure needs to be validated
only if controller is present in boot loader mode.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 9359bff47296..d1703cc99705 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2081,14 +2081,16 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 	if (ver->img_type == 0x03) {
 		btintel_clear_flag(hdev, INTEL_BOOTLOADER);
 		btintel_check_bdaddr(hdev);
-	}
-
-	/* If the OTP has no valid Bluetooth device address, then there will
-	 * also be no valid address for the operational firmware.
-	 */
-	if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
-		bt_dev_info(hdev, "No device address configured");
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	} else {
+		/*
+		 * Check for valid bd address in boot loader mode. Device
+		 * will be marked as unconfigured if empty bd address is
+		 * found.
+		 */
+		if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
+			bt_dev_info(hdev, "No device address configured");
+			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+		}
 	}
 
 	btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
@@ -2466,6 +2468,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		goto exit_error;
 	}
 
+	memset(&ver_tlv, 0, sizeof(ver_tlv));
 	/* For TLV type device, parse the tlv data */
 	err = btintel_parse_version_tlv(hdev, &ver_tlv, skb);
 	if (err) {
-- 
2.17.1

