Return-Path: <SRS0=ITyu=7V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09649C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 12:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB582074B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 12:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgFHM1E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:27:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:42400 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729741AbgFHM1E (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 08:27:04 -0400
IronPort-SDR: ptxMuvMXS6KjsowJ4LW6k7gk7DY2p1z5cqg9LBcyD//PWVQl6G/6QVmCkVOZbpd9r+rvf/rlKM
 pY7JK8dd0DDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 05:27:03 -0700
IronPort-SDR: 5bj2ltmlxAmLZKQ7OHj8T2nlpPXOpGfVCE669MxQgDGqYA4NRC2T6nliB6ptofLqbASEhfBxMU
 24ZInZKLMNiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="313863089"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2020 05:27:01 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Ps AyappadasX <AyappadasX.Ps@intel.com>,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 2/2] Bluetooth : Config debug feature based on available support
Date:   Mon,  8 Jun 2020 17:57:47 +0530
Message-Id: <20200608122747.10714-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608122747.10714-1-kiran.k@intel.com>
References: <20200608122747.10714-1-kiran.k@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

This patch shall enable the Intel telemetry exception format
based on the supported features

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Ps AyappadasX <AyappadasX.Ps@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 27 +++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  9 +++++++--
 drivers/bluetooth/btusb.c   |  2 ++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index cb7d62883b18..f9463f0c3ee2 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -787,6 +787,33 @@ int btintel_read_debug_features(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_read_debug_features);
 
+int btintel_config_debug_features(struct hci_dev *hdev,
+				  const struct intel_debug_features *features)
+{
+	struct sk_buff *skb;
+	u8 mask_ddc[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00 };
+
+	if (!features)
+		return -EINVAL;
+
+	if (!(features->page1[0] & 0x3f)) {
+		bt_dev_info(hdev, "Telemety exception format not supported");
+		return 0;
+	}
+
+	skb = __hci_cmd_sync(hdev, 0xfc8b, 11, mask_ddc, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Setting Intel telemetry ddc write event mask failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_config_debug_features);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 7cd813fc5db4..63743b89dad9 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -92,10 +92,10 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
 			      u32 *boot_param);
 void btintel_reset_to_bootloader(struct hci_dev *hdev);
-
 int btintel_read_debug_features(struct hci_dev *hdev,
 				struct intel_debug_features *features);
-
+int btintel_config_debug_features(struct hci_dev *hdev,
+				  const struct intel_debug_features *features);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -201,4 +201,9 @@ static inline int btintel_read_debug_features(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_config_debug_features(struct hci_dev *hdev,
+						const struct intel_debug_features *features)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1d36141ebe65..b1573004ffac 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2547,6 +2547,8 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 */
 	btintel_read_debug_features(hdev, &debug_features);
 
+	btintel_config_debug_features(hdev, &debug_features);
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &ver);
 	if (err)
-- 
2.17.1

