Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E4FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 11:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6E1610C8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 11:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbhHTLy2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Aug 2021 07:54:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:18482 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237639AbhHTLy1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Aug 2021 07:54:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="203906565"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="203906565"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="682254212"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 20 Aug 2021 04:53:47 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, luiz.von.dentz@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Fix boot address
Date:   Fri, 20 Aug 2021 17:28:08 +0530
Message-Id: <20210820115808.15895-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Cache Boot address present in firmware file which
is later used Intel_Soft_Reset command to bring
controller from boot mode to operational mode.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index f1705b46fc88..80d6dd7ae51a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1037,8 +1037,9 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
 
 			params = (void *)(fw_ptr + sizeof(*cmd));
 
-			bt_dev_info(hdev, "Boot Address: 0x%x",
-				    le32_to_cpu(params->boot_addr));
+			*boot_addr = le32_to_cpu(params->boot_addr);
+
+			bt_dev_info(hdev, "Boot Address: 0x%x", *boot_addr);
 
 			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
 				    params->fw_build_num, params->fw_build_ww,
@@ -1071,9 +1072,6 @@ int btintel_download_firmware(struct hci_dev *hdev,
 		/* Skip version checking */
 		break;
 	default:
-		/* Skip reading firmware file version in bootloader mode */
-		if (ver->fw_variant == 0x06)
-			break;
 
 		/* Skip download if firmware has the same version */
 		if (btintel_firmware_version(hdev, ver->fw_build_num,
@@ -1114,19 +1112,16 @@ static int btintel_download_fw_tlv(struct hci_dev *hdev,
 	int err;
 	u32 css_header_ver;
 
-	/* Skip reading firmware file version in bootloader mode */
-	if (ver->img_type != 0x01) {
-		/* Skip download if firmware has the same version */
-		if (btintel_firmware_version(hdev, ver->min_fw_build_nn,
-					     ver->min_fw_build_cw,
-					     ver->min_fw_build_yy,
-					     fw, boot_param)) {
-			bt_dev_info(hdev, "Firmware already loaded");
-			/* Return -EALREADY to indicate that firmware has
-			 * already been loaded.
-			 */
-			return -EALREADY;
-		}
+	/* Skip download if firmware has the same version */
+	if (btintel_firmware_version(hdev, ver->min_fw_build_nn,
+				     ver->min_fw_build_cw,
+				     ver->min_fw_build_yy,
+				     fw, boot_param)) {
+		bt_dev_info(hdev, "Firmware already loaded");
+		/* Return -EALREADY to indicate that firmware has
+		 * already been loaded.
+		 */
+		return -EALREADY;
 	}
 
 	/* The firmware variant determines if the device is in bootloader
-- 
2.17.1

