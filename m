Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D3AC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 11:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EF1606A5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 11:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbhHaLwS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:52:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:36804 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241591AbhHaLwS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 07:52:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="205674713"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="205674713"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 04:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="498264480"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 31 Aug 2021 04:51:20 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v13 03/12] Bluetooth: btintel: Read supported offload use cases
Date:   Tue, 31 Aug 2021 17:26:28 +0530
Message-Id: <20210831115637.6713-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210831115637.6713-1-kiran.k@intel.com>
References: <20210831115637.6713-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Read offload use cases supported by controller.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---

Notes:
    * changes in v13:
     - No changes
    
    * changes in v12:
     - s/usecase/use_case/g
    
    * changes in v11:
      - Remove Kconfig related changes
    * changes in v10:
      - restructure patch to have  definition and call of callaback in the
        same patch
    * changes in v9:
      - define a separate patch for core changes

 drivers/bluetooth/btintel.c | 32 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  5 +++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 778d803159f3..628395eda9b3 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2163,6 +2163,35 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 	return err;
 }
 
+static int btintel_configure_offload(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	int err = 0;
+	struct intel_offload_use_cases *use_cases;
+
+	skb = __hci_cmd_sync(hdev, 0xfc86, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading offload use cases failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len < sizeof(*use_cases)) {
+		err = -EIO;
+		goto error;
+	}
+
+	use_cases = (void *)skb->data;
+
+	if (use_cases->status) {
+		err = -bt_to_errno(skb->data[0]);
+		goto error;
+	}
+error:
+	kfree_skb(skb);
+	return err;
+}
+
 static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 					struct intel_version_tlv *ver)
 {
@@ -2204,6 +2233,9 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	 */
 	btintel_load_ddc_config(hdev, ddcname);
 
+	/* Read supported use cases and set callbacks to fetch datapath id */
+	btintel_configure_offload(hdev);
+
 	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
 
 	/* Read the Intel version information after loading the FW  */
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index fe02cb9ac96c..e500c0d7a729 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -132,6 +132,11 @@ struct intel_debug_features {
 	__u8    page1[16];
 } __packed;
 
+struct intel_offload_use_cases {
+	__u8	status;
+	__u8	preset[8];
+} __packed;
+
 #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
 #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
-- 
2.17.1

