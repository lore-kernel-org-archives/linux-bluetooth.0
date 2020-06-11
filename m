Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3616AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 11:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5C12072F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 11:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgFKLo7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:44:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:26678 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgFKLo7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jun 2020 07:44:59 -0400
IronPort-SDR: kCXgdUS7MlZ31um2Drs0a4bd5qAZLt6IdxwCMUxD+OE3SmaoyrnG9CSVd11OuatcJwSh0nASt7
 ymqQYVJP5KLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 04:44:58 -0700
IronPort-SDR: nGGZhFtFEh52jmxDbEMUbcCAI/iobC4NwAOOyPdHSqdJWay/poenp/il03Q70cbL60deCMgY4Z
 /MSrsYjnemtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="296562876"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2020 04:44:56 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH 4/4] Bluetooth: btintel: Add helper function to help controller type
Date:   Thu, 11 Jun 2020 17:15:26 +0530
Message-Id: <20200611114526.13594-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611114526.13594-1-kiran.k@intel.com>
References: <20200611114526.13594-1-kiran.k@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Raghuram Hegde <raghuram.hegde@intel.com>

As the firmware download flow for new generation controller changes
from legacy controller, this function helps in deciding the download
flow to be used

Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btintel.c | 51 +++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  3 +++
 2 files changed, 54 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index ae60527e1abd..93a0e5a2e927 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -482,6 +482,57 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 }
 EXPORT_SYMBOL_GPL(btintel_read_version);
 
+int btintel_read_version_tlv(struct hci_dev *hdev, bool *is_tlv_format,
+			     struct sk_buff **skb_out)
+{
+	u8 param;
+	u8 status;
+	u8 tlv_check_octet;
+	u8 *data;
+	struct sk_buff *skb;
+
+	param = 0xFF;
+	skb_out = NULL;
+
+	skb = __hci_cmd_sync(hdev,  0xfc05, 1, &param, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Intel read version command failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	/* Check status */
+	data = skb->data;
+	status = *data;
+	if (status) {
+		bt_dev_err(hdev, "Intel Read Version failed (%02x)",
+			   status);
+		kfree_skb(skb);
+		return -bt_to_errno(status);
+	}
+
+	/* There are two variants of HCI_Intel_Read_Version_Command_Complete
+	 * depending on SKU type (legacy and TLV format).If the skb->len
+	 * parameter is equal to INTEL_VERSION_LEN  and the first octet
+	 * after the status parameter is 0x37 then it's the legacy format,
+	 * otherwise it's TLV format
+	 */
+
+	/* Fetch the octet after status */
+	tlv_check_octet = *(data + 1);
+
+	if (skb->len == INTEL_VERSION_LEN && tlv_check_octet == 0x37) {
+		bt_dev_dbg(hdev, "Using Legacy Intel Version command");
+		*is_tlv_format = false;
+	} else {
+		bt_dev_dbg(hdev, "Using TLV format Version command");
+		*is_tlv_format = true;
+	}
+	*skb_out = skb;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_read_version_tlv);
+
 /* ------- REGMAP IBT SUPPORT ------- */
 
 #define IBT_REG_MODE_8BIT  0x00
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index fa4b1b801b13..de2d104cb86d 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -6,6 +6,9 @@
  *  Copyright (C) 2015  Intel Corporation
  */
 
+/* Length of intel_version structure*/
+#define INTEL_VERSION_LEN	10
+
 struct intel_version {
 	u8 status;
 	u8 hw_platform;
-- 
2.17.1

