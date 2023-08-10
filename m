Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA908C001DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 10:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjHJKwB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Aug 2023 06:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjHJKwA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Aug 2023 06:52:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665C0B4
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691664719; x=1723200719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NbXdYry4m7aAQEbjljWKyYs+KF/RYQPh4qtmnZxDTVQ=;
  b=GV3KOIfH/PA7CQIQFCaqcwERNRNq0V1P7sj42dHJZ9EzmoeMvOCUoPsb
   yqVc9dWwGDxx98wYLhlpJPW2hV8Ku9KlM2JRRI32Rm8Zb9qNitVom7fTB
   9R70mwrgNltjfxBs3mLGBldp8YpH4s7vageAWkKDo7DeHNeIZGJr7Zwy2
   1a8mOYs9dlsKcruae/Tdqs3fNhFbywnEb5biqaUUY9E4LMOyDxURY2/To
   PdhGTn0gam8BFXmUo4gcNIBeyee7hpKVPzbJrF8cQck+souE0Do175i4d
   G/1bPAch/Te4PJQr0Byu5Oa9j9TIBw+yfvFJPv4S4o89nbfJJLibDy35r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="402329133"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="402329133"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 03:51:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="797569051"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="797569051"
Received: from castle-black.iind.intel.com ([10.66.185.63])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2023 03:51:56 -0700
From:   Lokendra Singh <lokendra.singh@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, kiran.k@intel.com,
        seema.sreemantha@intel.com,
        Lokendra Singh <lokendra.singh@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Send new command for PPAG
Date:   Thu, 10 Aug 2023 16:25:04 +0530
Message-Id: <20230810105502.27012-1-lokendra.singh@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Seema Sreemantha <seema.sreemantha@intel.com>

Added support for the new command opcode FE0B
(HCI Intel PPAG Enable).

btmon log:
< HCI Command: Intel PPAG Enable (0x3f|0x020b) plen 4
        Enable: 0x00000002
> HCI Event: Command Complete (0x0e) plen 4
      Intel PPAG Enable (0x3f|0x020b) ncmd 1
        Status: Success (0x00)

Signed-off-by: Seema Sreemantha <seema.sreemantha@intel.com>
Signed-off-by: Lokendra Singh <lokendra.singh@intel.com>
---
 drivers/bluetooth/btintel.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 633e8d9bf58f..71964c99f5f3 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2401,7 +2401,7 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 {
 	struct btintel_ppag ppag;
 	struct sk_buff *skb;
-	struct btintel_loc_aware_reg ppag_cmd;
+	struct hci_ppag_enable_cmd ppag_cmd;
 	acpi_handle handle;
 
 	/* PPAG is not supported if CRF is HrP2, Jfp2, JfP1 */
@@ -2409,6 +2409,8 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 	case 0x504:     /* Hrp2 */
 	case 0x202:     /* Jfp2 */
 	case 0x201:     /* Jfp1 */
+		bt_dev_warn(hdev, "PPAG not supported for Intel CNVr (0x%3x)",
+			    ver->cnvr_top & 0xFFF);
 		return;
 	}
 
@@ -2434,24 +2436,32 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 	}
 
 	if (ppag.domain != 0x12) {
-		bt_dev_warn(hdev, "PPAG-BT: domain is not bluetooth");
+		bt_dev_warn(hdev, "PPAG-BT: Bluetooth domain is disabled in ACPI firmware");
 		return;
 	}
 
-	/* PPAG mode, BIT0 = 0 Disabled, BIT0 = 1 Enabled */
-	if (!(ppag.mode & BIT(0))) {
-		bt_dev_dbg(hdev, "PPAG-BT: disabled");
+	/* PPAG mode
+	 * BIT 0 : 0 Disabled in EU
+	 *         1 Enabled in EU
+	 * BIT 1 : 0 Disabled in China
+	 *         1 Enabled in China
+	 */
+	if((ppag.mode & 0x01) != BIT(0) && (ppag.mode & 0x02) != BIT(1)) {
+		bt_dev_warn(hdev, "PPAG-BT: EU, China mode are disabled in CB/BIOS");
 		return;
 	}
 
-	ppag_cmd.mcc = cpu_to_le32(0);
-	ppag_cmd.sel = cpu_to_le32(0); /* 0 - Enable , 1 - Disable, 2 - Testing mode */
-	ppag_cmd.delta = cpu_to_le32(0);
-	skb = __hci_cmd_sync(hdev, 0xfe19, sizeof(ppag_cmd), &ppag_cmd, HCI_CMD_TIMEOUT);
+	/* HCI_Intel_PpagEnable_CMD - opcode: 0xFE0B
+	 * ppag_enable_flags - ppag mode
+	 */
+	ppag_cmd.ppag_enable_flags = ppag.mode;
+
+	skb = __hci_cmd_sync(hdev, 0xfe0b, sizeof(ppag_cmd), &ppag_cmd, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_warn(hdev, "Failed to send PPAG Enable (%ld)", PTR_ERR(skb));
 		return;
 	}
+	bt_dev_info(hdev, "PPAG-BT: Enabled (Mode %d)", ppag.mode);
 	kfree_skb(skb);
 }
 
-- 
2.25.1

