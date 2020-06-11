Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA2DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 11:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A38C20801
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 11:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgFKLoz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:44:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:26678 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgFKLoz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jun 2020 07:44:55 -0400
IronPort-SDR: Ow6NgsIYKZQkdCee8Vzzb6HbTSGFJ3dxmBGFbsiWlzZi1qVh9CIDE0oBALsehN/lL1THEXuX8z
 S06FaQ4Nz3uA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 04:44:53 -0700
IronPort-SDR: xUj/oDGpCaRfGtvKF6gjUa0Yp3CCIQ0vYUOMjWkAN5lPmepBZnQXcy07A3ZWo3xMcpIo4l0wUo
 ZxjMAxzeIiUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="296562848"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2020 04:44:51 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH 2/4] Bluetooth: btintel: Add helper functions to dump boot/firmware info
Date:   Thu, 11 Jun 2020 17:15:24 +0530
Message-Id: <20200611114526.13594-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611114526.13594-1-kiran.k@intel.com>
References: <20200611114526.13594-1-kiran.k@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Raghuram Hegde <raghuram.hegde@intel.com>

Add helper functions to print boot/firmware version information

Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btintel.c | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5fa5be3c5598..0139857f6a2c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -226,6 +226,53 @@ void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 }
 EXPORT_SYMBOL_GPL(btintel_version_info);
 
+void btintel_boot_info(struct hci_dev *hdev,
+		       struct intel_version_tlv *ver)
+{
+	const char *variant;
+
+	switch (ver->img_type) {
+	case 0x01:
+		variant = "Bootloader";
+		break;
+	case 0x03:
+		variant = "Firmware";
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported image type %x", ver->img_type);
+		return;
+	}
+
+	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u",
+		    variant, 2000 + (ver->timestamp >> 8),
+		    ver->timestamp & 0xff, ver->build_type, ver->build_num);
+}
+EXPORT_SYMBOL_GPL(btintel_boot_info);
+
+void btintel_boot_info_tlv(struct hci_dev *hdev,
+			   struct intel_version_tlv *ver)
+{
+	bt_dev_info(hdev, "Device revision is %u",
+		    ver->dev_rev_id);
+
+	bt_dev_info(hdev, "Secure boot is %s",
+		    ver->secure_boot ? "enabled" : "disabled");
+
+	bt_dev_info(hdev, "OTP lock is %s",
+		    ver->otp_lock ? "enabled" : "disabled");
+
+	bt_dev_info(hdev, "API lock is %s",
+		    ver->api_lock ? "enabled" : "disabled");
+
+	bt_dev_info(hdev, "Debug lock is %s",
+		    ver->debug_lock ? "enabled" : "disabled");
+
+	bt_dev_info(hdev, "Minimum firmware build %u week %u %u",
+		    ver->min_fw_build_nn, ver->min_fw_build_cw,
+		    2000 + ver->min_fw_build_yy);
+}
+EXPORT_SYMBOL_GPL(btintel_boot_info_tlv);
+
 int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param)
 {
-- 
2.17.1

