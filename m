Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09826C6369E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 11:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B726E246CA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 11:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKSLhz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 06:37:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:21909 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgKSLhz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 06:37:55 -0500
IronPort-SDR: ACeUZZopOos+VuOby6FR2Ov6VimW/Zp25Fs9bMAAvkVpSUV8pXvETRPlbTysJBeITrGeQ4KFtT
 RDrbfGSh6f5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="167763757"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="167763757"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:37:55 -0800
IronPort-SDR: fdwCrqsU5wZ5f5L7ZNdvRFd0zNLMP+XfdXxj3yCRADYsfaLfdewZqo0rBol5WloscUAdN3Dec0
 07X96L/AZpyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="325950039"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga003.jf.intel.com with ESMTP; 19 Nov 2020 03:37:53 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        sathish.narasimman@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v8 3/5] Bluetooth: btusb: Define a function to construct firmware filename
Date:   Thu, 19 Nov 2020 17:09:41 +0530
Message-Id: <20201119113943.13839-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119113943.13839-1-kiran.k@intel.com>
References: <20201119113943.13839-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Define a new function to construct firmware/ddc filename for new
generation Intel controllers

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.h |  6 ++++++
 drivers/bluetooth/btusb.c   | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 78cc64b42b30..6511b091caf5 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -132,6 +132,12 @@ struct intel_debug_features {
 	__u8    page1[16];
 } __packed;
 
+#define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
+#define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
+#define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
+#define INTEL_CNVX_TOP_STEP(cnvx_top)	(((cnvx_top) & 0x0f000000) >> 24)
+#define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)(((t) << 4) | (s))))
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 111de9f25ef4..579dd1343057 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2383,6 +2383,21 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 	return true;
 }
 
+static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv *ver_tlv,
+						 char *fw_name, size_t len,
+						 const char *suffix)
+{
+	/* The firmware file name for new generation controllers will be
+	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
+	 */
+	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
+		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvi_top),
+					  INTEL_CNVX_TOP_STEP(ver_tlv->cnvi_top)),
+		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvr_top),
+					  INTEL_CNVX_TOP_STEP(ver_tlv->cnvr_top)),
+		 suffix);
+}
+
 static int btusb_intel_download_firmware(struct hci_dev *hdev,
 					 struct intel_version *ver,
 					 struct intel_boot_params *params,
@@ -2804,6 +2819,8 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
+	btusb_setup_intel_newgen_get_fw_name(&version, ddcname, sizeof(ddcname),
+					     "ddc");
 	/* Once the device is running in operational mode, it needs to
 	 * apply the device configuration (DDC) parameters.
 	 *
-- 
2.17.1

