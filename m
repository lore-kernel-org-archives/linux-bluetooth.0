Return-Path: <SRS0=y60a=7P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA712C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jun 2020 05:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38E320772
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jun 2020 05:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgFBFGw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:06:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:61114 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgFBFGw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jun 2020 01:06:52 -0400
IronPort-SDR: VBBPV1FZGnnBEdncN2nkdyohwrG2wUBzpANJ12OzOBCSaZdTfYOwAm2GPpKsLADV03Dv/QjJr6
 lxsl0i/xtMBA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 22:06:51 -0700
IronPort-SDR: fzwNGEOvJSvS7i1/54jYWyuIX2Z29yci0qHBgaEx09KLQfiWH7+Z5B/6s3XftYNZBwZnthgwbf
 mdsX3D5Kdcnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="258162636"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jun 2020 22:06:49 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Ps@vger.kernel.org, AyappadasX <AyappadasX.Ps@intel.com>,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH 2/2] Bluetooth : Load debug config based on the debug support
Date:   Tue,  2 Jun 2020 10:37:52 +0530
Message-Id: <20200602050752.7470-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602050752.7470-1-kiran.k@intel.com>
References: <20200602050752.7470-1-kiran.k@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

This patch shall enables the Intel telemetry exception format
based on the supported features

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Ps, AyappadasX <AyappadasX.Ps@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 28 ++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  9 ++++++++-
 drivers/bluetooth/btusb.c   |  3 +++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 09e697b92426..5ef83e9ad19c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -788,6 +788,34 @@ int btintel_read_supported_features(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_read_supported_features);
 
+int btintel_load_debug_config_based_on_supported_features(struct hci_dev *hdev,
+	const struct intel_supported_features *supported_features)
+{
+	struct sk_buff *skb;
+	u8 mask_ddc[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00 };
+
+	if (!supported_features)
+		return -EINVAL;
+
+	if (!(supported_features->page1[0] & 0x3f)) {
+		bt_dev_info(hdev, "Telemety exception format not supported");
+		return 0;
+	}
+
+	skb = __hci_cmd_sync(hdev, 0xfc8b, 11, mask_ddc, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Setting Intel telemetry ddc write event mask failed (%ld)",
+		PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_load_debug_config_based_on_supported_features);
+
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index f3892c0233f4..043d76c0e7cd 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -95,7 +95,8 @@ int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
 void btintel_reset_to_bootloader(struct hci_dev *hdev);
 int btintel_read_supported_features(struct hci_dev *hdev,
 			struct intel_supported_features *supported_features);
-
+int btintel_load_debug_config_based_on_supported_features(struct hci_dev *hdev,
+	const struct intel_supported_features *supported_features);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -199,5 +200,11 @@ static int btintel_read_supported_features(struct hci_dev *hdev,
 {
 	return -EOPNOTSUPP;
 }
+static int btintel_load_debug_config_based_on_supported_features(
+	struct hci_dev *hdev,
+	const struct intel_supported_features *supported_features);
+{
+	return -EOPNOTSUPP;
+}
 
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a5a971e7025b..510e3c1c23dc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2547,6 +2547,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 */
 	btintel_read_supported_features(hdev, &supported_features);
 
+	btintel_load_debug_config_based_on_supported_features(hdev,
+		&supported_features);
+
 
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &ver);
-- 
2.17.1

