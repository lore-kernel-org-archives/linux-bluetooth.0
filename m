Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF70C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 10:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C2B2074B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 10:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFCKOX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:14:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:48549 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCKOX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 06:14:23 -0400
IronPort-SDR: PJA4YqrgQ8/uQ913w8JvAJAWTQpmzSUHXmpXxzImIBYYLY5zc9Sw+5Z7/E5oTSEeNjAcyrNG7/
 g2O9a8AN6avg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 03:14:21 -0700
IronPort-SDR: Fzn0DxAlo3eZsHhvbttv7hSpc+Hz5h/8BK5+JoDZWGkrVGe2/mBUaJgE/nANyzfgp92ZhSspzx
 sZiCGTYnnWHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="471084215"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2020 03:14:19 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Ps@vger.kernel.org, AyappadasX <AyappadasX.Ps@intel.com>,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 1/2] Bluetooth: Add support to Intel read supported feature
Date:   Wed,  3 Jun 2020 15:45:22 +0530
Message-Id: <20200603101523.12547-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

The command shall read the Intel controller supported
feature. Based on the supported features addtional debug
configuration shall be enabled.

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Ps, AyappadasX <AyappadasX.Ps@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h | 14 ++++++++++++++
 drivers/bluetooth/btusb.c   |  8 +++++++-
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 6a0e2c5a8beb..09e697b92426 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -754,6 +754,40 @@ void btintel_reset_to_bootloader(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btintel_reset_to_bootloader);
 
+int btintel_read_supported_features(struct hci_dev *hdev,
+	struct intel_supported_features *supported_features)
+{
+	struct sk_buff *skb;
+	u8 page_no = 1;
+
+	/* Intel controller supports two pages, each page is of 128-bit
+	 * feature bit mask. And each bit defines specific feature support
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfca6, sizeof(page_no), &page_no,
+		HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("Reading supported features(page1) failed (%ld)",
+			PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != (sizeof(supported_features->page1) + 3)) {
+		bt_dev_err(hdev,
+			"Supported feature(page1) event size mismatch");
+		kfree_skb(skb);
+		return -EILSEQ;
+	}
+
+	memcpy(supported_features->page1, skb->data + 3,
+		sizeof(supported_features->page1));
+
+	/* Read the supported features page2 if required in future.
+	 */
+	kfree_skb(skb);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_read_supported_features);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index a69ea8a87b9b..f3892c0233f4 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -62,6 +62,11 @@ struct intel_reset {
 	__le32   boot_param;
 } __packed;
 
+
+struct intel_supported_features {
+	__u8    page1[16];
+} __packed;
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
@@ -88,6 +93,9 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
 			      u32 *boot_param);
 void btintel_reset_to_bootloader(struct hci_dev *hdev);
+int btintel_read_supported_features(struct hci_dev *hdev,
+			struct intel_supported_features *supported_features);
+
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -186,4 +194,10 @@ static inline int btintel_download_firmware(struct hci_dev *dev,
 static inline void btintel_reset_to_bootloader(struct hci_dev *hdev)
 {
 }
+static int btintel_read_supported_features(struct hci_dev *hdev,
+		struct intel_supported_features *supported_features)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5f022e9cf667..a5a971e7025b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -5,7 +5,6 @@
  *
  *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
  */
-
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/usb.h>
@@ -2273,6 +2272,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	ktime_t calltime, delta, rettime;
 	unsigned long long duration;
 	int err;
+	struct intel_supported_features supported_features;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2542,6 +2542,12 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 */
 	btintel_load_ddc_config(hdev, fwname);
 
+	/* Read the Intel supported features and if new exception formats
+	 * supported, need to load the additional DDC config to enable.
+	 */
+	btintel_read_supported_features(hdev, &supported_features);
+
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &ver);
 	if (err)
-- 
2.17.1

