Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6085BC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B41B61353
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbhERKkJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 06:40:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:23234 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242442AbhERKkI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 06:40:08 -0400
IronPort-SDR: 7U70z86KBX4+7a3xWU7GtSYBAxFWCK7W1ur0sUiEczk0+kFDocjNIVVzZzjGG4kYxaT4V8RInF
 4WhjkfQfYugw==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="187804809"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="187804809"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 03:38:50 -0700
IronPort-SDR: +5PYa+24R9falh64ojfoRN8dM00Yc/WKlqw+CN1IqKJiD8gqxeASS8GaFFcQXr2YqjHLFGfiMB
 1/HCyvMaBCjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="433017832"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2021 03:38:48 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v8 3/9] Bluetooth: btintel: Add a quirk for hfp offload usecase
Date:   Tue, 18 May 2021 16:12:26 +0530
Message-Id: <20210518104232.5431-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518104232.5431-1-kiran.k@intel.com>
References: <20210518104232.5431-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Define a quirk to identify if intel controllers supports offload for
HFP. In *setup* function, driver sends vendor specific command to
check if controller supports offload. If offload is supports then
quirk flag is set

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.c | 28 ++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  5 +++++
 drivers/bluetooth/btusb.c   |  2 ++
 include/net/bluetooth/hci.h |  7 +++++++
 4 files changed, 42 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..e3ad19244054 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -32,6 +32,11 @@ struct cmd_write_boot_params {
 	u8  fw_build_yy;
 } __packed;
 
+struct intel_offload_usecases {
+	__u8	status;
+	__u8	preset[8];
+} __packed;
+
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -1272,6 +1277,29 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
 
+int btintel_read_offload_usecases(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct intel_offload_usecases *usecases;
+
+	skb = __hci_cmd_sync(hdev, 0xfc86, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading offload usecases failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	usecases = (void *)skb->data;
+	if (usecases->status)
+		goto error;
+
+	if (usecases->preset[0] & 0x03)
+		set_bit(HCI_QUIRK_HFP_OFFLOAD_CODECS_SUPPORTED, &hdev->quirks);
+error:
+	kfree_skb(skb);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_read_offload_usecases);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d184064a5e7c..d561d4899b1b 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -175,6 +175,7 @@ int btintel_read_debug_features(struct hci_dev *hdev,
 				struct intel_debug_features *features);
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features);
+int btintel_read_offload_usecases(struct hci_dev *hdev);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -307,4 +308,8 @@ static inline int btintel_set_debug_features(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static int btintel_read_offload_usecases(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5245714dc6d0..ac245df5fa18 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2993,6 +2993,8 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	/* Set DDC mask for available debug features */
 	btintel_set_debug_features(hdev, &features);
 
+	btintel_read_offload_usecases(hdev);
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &version);
 	if (err)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 08508b3d13b4..731d48ca873a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -246,6 +246,13 @@ enum {
 	 * HCI after resume.
 	 */
 	HCI_QUIRK_NO_SUSPEND_NOTIFIER,
+
+	/* When this quirk is set, then controller supports offload codecs
+	 * for HFP.
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_HFP_OFFLOAD_CODECS_SUPPORTED,
 };
 
 /* HCI device flags */
-- 
2.17.1

