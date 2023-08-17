Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D26EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 11:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350373AbjHQLkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 07:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350467AbjHQLkS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 07:40:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745B31728
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 04:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692272416; x=1723808416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DBUw64P5p+S/jmo3nkfSz2oUF4bFe+Txz/3mito8S6E=;
  b=NvM8UT2/PNaR5ovbMsPEgHVmRYk/Avqj6t9nSxonXFyItenJ1AQlWfSi
   5fOAKHKNndtJLmTa+mdtxVLTbyDEzDeii+Ynq2rDm4UekNZzz/79rT6V3
   7wsABLldI5dEx2svv8zBkazVauexURr2yPJFSsW49Gm+bla7ZM29a75PV
   TbyGdnvrIe6h5cz/ZBjkyzZ9juFkukU4XeKfOYJOWSNjhCCLIQMjt3xIy
   YJkXttDskliWX595UKV2PO+iyHDhVH3LywHvs4tagmU4ReN86T6FxfYNA
   tysAcVIozgUzARRMw//cEvQ2l4szx4pxIq94dAQQjs2TKBrsk+ZNubWki
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375549188"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="375549188"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 04:40:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737686735"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="737686735"
Received: from castle-black.iind.intel.com ([10.66.185.63])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2023 04:40:13 -0700
From:   Lokendra Singh <lokendra.singh@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, tedd.an@intel.com, kiran.k@intel.com,
        Lokendra Singh <lokendra.singh@intel.com>,
        Seema Sreemantha <seema.sreemantha@intel.com>
Subject: [PATCH v3] Bluetooth: btintel: Send new command for PPAG
Date:   Thu, 17 Aug 2023 17:12:50 +0530
Message-Id: <20230817114249.75827-1-lokendra.singh@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
 drivers/bluetooth/btintel.c | 25 ++++++++++++++++---------
 drivers/bluetooth/btintel.h |  7 +++----
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 633e8d9bf58f..9b239ce96fa4 100644
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
+		bt_dev_dbg(hdev, "PPAG not supported for Intel CNVr (0x%3x)",
+			   ver->cnvr_top & 0xFFF);
 		return;
 	}
 
@@ -2434,24 +2436,29 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 	}
 
 	if (ppag.domain != 0x12) {
-		bt_dev_warn(hdev, "PPAG-BT: domain is not bluetooth");
+		bt_dev_dbg(hdev, "PPAG-BT: Bluetooth domain is disabled in ACPI firmware");
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
+	if ((ppag.mode & 0x01) != BIT(0) && (ppag.mode & 0x02) != BIT(1)) {
+		bt_dev_dbg(hdev, "PPAG-BT: EU, China mode are disabled in CB/BIOS");
 		return;
 	}
 
-	ppag_cmd.mcc = cpu_to_le32(0);
-	ppag_cmd.sel = cpu_to_le32(0); /* 0 - Enable , 1 - Disable, 2 - Testing mode */
-	ppag_cmd.delta = cpu_to_le32(0);
-	skb = __hci_cmd_sync(hdev, 0xfe19, sizeof(ppag_cmd), &ppag_cmd, HCI_CMD_TIMEOUT);
+	ppag_cmd.ppag_enable_flags = cpu_to_le32(ppag.mode);
+
+	skb = __hci_cmd_sync(hdev, INTEL_OP_PPAG_CMD, sizeof(ppag_cmd), &ppag_cmd, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_warn(hdev, "Failed to send PPAG Enable (%ld)", PTR_ERR(skb));
 		return;
 	}
+	bt_dev_info(hdev, "PPAG-BT: Enabled (Mode %d)", ppag.mode);
 	kfree_skb(skb);
 }
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 2ed646609dee..3a2d5b4219dd 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -137,10 +137,9 @@ struct intel_offload_use_cases {
 	__u8	preset[8];
 } __packed;
 
-struct btintel_loc_aware_reg {
-	__le32 mcc;
-	__le32 sel;
-	__le32 delta;
+#define INTEL_OP_PPAG_CMD		0xFE0B
+struct hci_ppag_enable_cmd {
+	__le32	ppag_enable_flags;
 } __packed;
 
 #define INTEL_TLV_TYPE_ID		0x01
-- 
2.25.1

