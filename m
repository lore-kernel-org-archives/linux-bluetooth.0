Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8046CC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 11:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FC4246EE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 11:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgKSLhv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 06:37:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:21909 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgKSLhv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 06:37:51 -0500
IronPort-SDR: 21MoNy75/IB/mRSuM/DibWCl9E11Ye3tTjLBMsRG26LDut06NdsLb8dIaTxizmrrKZN/nsaxtk
 yPRyC+we3Saw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="167763745"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="167763745"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:37:50 -0800
IronPort-SDR: aa67KEz22ElSRD/NbX/k9ioxX18IP715rzll4ntweAe075ZNf5TnUmjw0rKWFY+a5lwazN72Iv
 wKhHbFeBdvmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="325950027"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga003.jf.intel.com with ESMTP; 19 Nov 2020 03:37:48 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        sathish.narasimman@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v8 1/5] Bluetooth: btintel: Fix endianness issue for TLV version information
Date:   Thu, 19 Nov 2020 17:09:39 +0530
Message-Id: <20201119113943.13839-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

do __le32_to_cpu to tlv data fields to make sure driver runs
correctly when running on big endian system.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 88ce5f0ffc4b..41ff2071d7ef 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -437,31 +437,38 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 		tlv = (struct intel_tlv *)skb->data;
 		switch (tlv->type) {
 		case INTEL_TLV_CNVI_TOP:
-			version->cnvi_top = get_unaligned_le32(tlv->val);
+			version->cnvi_top =
+				__le32_to_cpu(get_unaligned_le32(tlv->val));
 			break;
 		case INTEL_TLV_CNVR_TOP:
-			version->cnvr_top = get_unaligned_le32(tlv->val);
+			version->cnvr_top =
+				__le32_to_cpu(get_unaligned_le32(tlv->val));
 			break;
 		case INTEL_TLV_CNVI_BT:
-			version->cnvi_bt = get_unaligned_le32(tlv->val);
+			version->cnvi_bt =
+				__le32_to_cpu(get_unaligned_le32(tlv->val));
 			break;
 		case INTEL_TLV_CNVR_BT:
-			version->cnvr_bt = get_unaligned_le32(tlv->val);
+			version->cnvr_bt =
+				__le32_to_cpu(get_unaligned_le32(tlv->val));
 			break;
 		case INTEL_TLV_DEV_REV_ID:
-			version->dev_rev_id = get_unaligned_le16(tlv->val);
+			version->dev_rev_id =
+				__le16_to_cpu(get_unaligned_le16(tlv->val));
 			break;
 		case INTEL_TLV_IMAGE_TYPE:
 			version->img_type = tlv->val[0];
 			break;
 		case INTEL_TLV_TIME_STAMP:
-			version->timestamp = get_unaligned_le16(tlv->val);
+			version->timestamp =
+				__le16_to_cpu(get_unaligned_le16(tlv->val));
 			break;
 		case INTEL_TLV_BUILD_TYPE:
 			version->build_type = tlv->val[0];
 			break;
 		case INTEL_TLV_BUILD_NUM:
-			version->build_num = get_unaligned_le32(tlv->val);
+			version->build_num =
+				__le32_to_cpu(get_unaligned_le32(tlv->val));
 			break;
 		case INTEL_TLV_SECURE_BOOT:
 			version->secure_boot = tlv->val[0];
-- 
2.17.1

