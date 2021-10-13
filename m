Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE04EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 07:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4CC60EE9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 07:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhJMIBq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 04:01:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:47469 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232711AbhJMIBp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 04:01:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="313574441"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="313574441"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 00:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="547748254"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga004.fm.intel.com with ESMTP; 13 Oct 2021 00:59:41 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, luiz.von.dentz@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Fix bdaddress comparison with garbage value
Date:   Wed, 13 Oct 2021 13:35:11 +0530
Message-Id: <20211013080511.23945-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Intel Read Verision(TLV) data is parsed into a local structure variable
and it contains a field for bd address. Bd address is returned only in
bootloader mode and hence bd address in TLV structure needs to be validated
only if controller is present in boot loader mode.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---

Notes:
    changes in v2:
    - Add comment for memsetting ver_tlv

 drivers/bluetooth/btintel.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 9359bff47296..8f9109b40961 100644
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
@@ -2466,6 +2468,10 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		goto exit_error;
 	}
 
+	/* memset ver_tlv to start with clean state as few fields are exclusive
+	 * to bootloader mode and are not populated in operational mode
+	 */
+	memset(&ver_tlv, 0, sizeof(ver_tlv));
 	/* For TLV type device, parse the tlv data */
 	err = btintel_parse_version_tlv(hdev, &ver_tlv, skb);
 	if (err) {
-- 
2.17.1

