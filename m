Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B31C432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 08:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B881611BF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 08:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhG0Im4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 04:42:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:2131 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235933AbhG0Imz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 04:42:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="192677085"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="192677085"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 01:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="662541267"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jul 2021 01:42:54 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v11 03/10] Bluetooth: btintel: Read supported offload usecases
Date:   Tue, 27 Jul 2021 14:17:06 +0530
Message-Id: <20210727084713.23038-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210727084713.23038-1-kiran.k@intel.com>
References: <20210727084713.23038-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Read offload usecases supported by controller.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
* changes in v11:
  - Remove Kconfig related changes
* changes in v10:
  - restructure patch to have  definition and call of callaback in the
    same patch
* changes in v9:
  - define a separate patch for core changes

 drivers/bluetooth/btintel.c | 30 ++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h | 10 ++++++++++
 drivers/bluetooth/btusb.c   |  3 +++
 3 files changed, 43 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..a6b81914766e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1272,6 +1272,36 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
 
+int btintel_configure_offload_usecases(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	int err = 0;
+	struct intel_offload_usecases *usecases;
+
+	skb = __hci_cmd_sync(hdev, 0xfc86, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading offload usecases failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len < sizeof(*usecases)) {
+		err = -EIO;
+		goto error;
+	}
+
+	usecases = (void *)skb->data;
+
+	if (usecases->status) {
+		err = -bt_to_errno(skb->data[0]);
+		goto error;
+	}
+error:
+	kfree_skb(skb);
+	return err;
+}
+EXPORT_SYMBOL_GPL(btintel_configure_offload_usecases);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d184064a5e7c..45ca5c4ccf37 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -132,6 +132,11 @@ struct intel_debug_features {
 	__u8    page1[16];
 } __packed;
 
+struct intel_offload_usecases {
+	__u8	status;
+	__u8	preset[8];
+} __packed;
+
 #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
 #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
@@ -175,6 +180,7 @@ int btintel_read_debug_features(struct hci_dev *hdev,
 				struct intel_debug_features *features);
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features);
+int btintel_configure_offload_usecases(struct hci_dev *hdev);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -307,4 +313,8 @@ static inline int btintel_set_debug_features(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static int btintel_configure_offload_usecases(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1876a960b3dc..0ff8d1288929 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3023,6 +3023,9 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 		btintel_set_debug_features(hdev, &features);
 	}
 
+	/* Read supported usecases and set callbacks to fetch datapath id */
+	btintel_configure_offload_usecases(hdev);
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &version);
 	if (err)
-- 
2.17.1

