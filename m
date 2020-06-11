Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE7BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 11:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CDD2072F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 11:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgFKLo5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:44:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:26678 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgFKLo4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jun 2020 07:44:56 -0400
IronPort-SDR: kMpVEdw7/H/bqDiQPo75ILr2JlxYbpCjuDwoT6N6Pc7uyvu3x2dZRcqnEDfPAswf9JJF4lUuPt
 RCkKsWzkOVKQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 04:44:56 -0700
IronPort-SDR: vNQxPm7lbQ7Kbi4e+2MDNp3mpPpGOmuAsHWap/LXfnhD2d52DEkpMs/TDuQANipV+Pqb0b5eML
 MLolZX07r1aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="296562858"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2020 04:44:54 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH 3/4] Bluetooth: btintel: Add helper functions to parse firmware name
Date:   Thu, 11 Jun 2020 17:15:25 +0530
Message-Id: <20200611114526.13594-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611114526.13594-1-kiran.k@intel.com>
References: <20200611114526.13594-1-kiran.k@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Raghuram Hegde <raghuram.hegde@intel.com>

Define helper functions to construct firmware file name as the format of
legacy differs from new generation Intel controllers

Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btintel.c | 75 +++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  6 +++
 2 files changed, 81 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0139857f6a2c..ae60527e1abd 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -382,6 +382,81 @@ int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
 }
 EXPORT_SYMBOL_GPL(btintel_set_event_mask_mfg);
 
+bool btintel_get_fw_name(struct intel_version *ver,
+			 struct intel_boot_params *params,
+			 char *fw_name, size_t len,
+			 const char *suffix)
+{
+	/* This is for legacy HCI_Intel_Read_Version command.
+	 *
+	 * With this Intel bootloader only the hardware variant and device
+	 * revision information are used to select the right firmware for SfP
+	 * and WsP.
+	 *
+	 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
+	 *
+	 * Currently the supported hardware variants are:
+	 *   11 (0x0b) for iBT3.0 (LnP/SfP)
+	 *   12 (0x0c) for iBT3.5 (WsP)
+	 *
+	 * For ThP/JfP and for future SKU's, the FW name varies based on HW
+	 * variant, HW revision and FW revision, as these are dependent on CNVi
+	 * and RF Combination.
+	 *
+	 *   17 (0x11) for iBT3.5 (JfP)
+	 *   18 (0x12) for iBT3.5 (ThP)
+	 *
+	 * The firmware file name for these will be
+	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
+	 *
+	 */
+
+	switch (ver->hw_variant) {
+	case 0x0b:	/* SfP */
+	case 0x0c:	/* WsP */
+		snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
+			 le16_to_cpu(ver->hw_variant),
+			 le16_to_cpu(params->dev_revid),
+			 suffix);
+		break;
+	case 0x11:	/* JfP */
+	case 0x12:	/* ThP */
+	case 0x13:	/* HrP */
+	case 0x14:	/* CcP */
+		snprintf(fw_name, len, "intel/ibt-%u-%u-%u.%s",
+			 le16_to_cpu(ver->hw_variant),
+			 le16_to_cpu(ver->hw_revision),
+			 le16_to_cpu(ver->fw_revision),
+			 suffix);
+		break;
+	default:
+		return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(btintel_get_fw_name);
+
+void btintel_get_fw_name_tlv(struct intel_version_tlv *ver,
+			     char *fw_name, size_t len,
+			     const char *suffix)
+{
+	/* This is for legacy HCI_Intel_Read_Version command.
+	 * The firmware file name for these will be
+	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
+	 *
+	 * Currently the supported hardware variants are:
+	 * iBT4.2 23 (0x17) for TyP
+	 * iBT4.2 24 (0x18) for Solar
+	 */
+	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
+		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvi_top),
+		 INTEL_CNVX_TOP_STEP(ver->cnvi_top)),
+		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvr_top),
+		 INTEL_CNVX_TOP_STEP(ver->cnvr_top)),
+		 suffix);
+}
+EXPORT_SYMBOL_GPL(btintel_get_fw_name_tlv);
+
 int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 {
 	struct sk_buff *skb;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 32b2cd887bdd..fa4b1b801b13 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -106,6 +106,12 @@ struct intel_debug_features {
 	__u8    page1[16];
 } __packed;
 
+#define INTEL_CNVX_TOP_TYPE_MASK	0x00000fff
+#define INTEL_CNVX_TOP_STEP_MASK	0x0f000000
+#define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & INTEL_CNVX_TOP_TYPE_MASK)
+#define INTEL_CNVX_TOP_STEP(cnvx_top)	(((cnvx_top) & INTEL_CNVX_TOP_STEP_MASK) >> 24)
+#define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)(((t) << 4) | (s))))
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
-- 
2.17.1

