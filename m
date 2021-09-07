Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152F0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 10:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E16610FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 10:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbhIGKIm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:08:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:1677 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243953AbhIGKIl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 06:08:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="200362820"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="200362820"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 03:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="512785107"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga001.jf.intel.com with ESMTP; 07 Sep 2021 03:07:33 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, michaelfsun@google.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v15 03/13] Bluetooth: btintel: Read supported offload use cases
Date:   Tue,  7 Sep 2021 15:42:39 +0530
Message-Id: <20210907101249.7323-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210907101249.7323-1-kiran.k@intel.com>
References: <20210907101249.7323-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Read offload use cases supported by controller.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---

Notes:
    * changes in v15:
     - No changes
    
    * changes in v14:
     - No changes
    
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
index 7236f40b7a9c..60f9866c6792 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2158,6 +2158,35 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
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
@@ -2199,6 +2228,9 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
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

