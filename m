Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9491C2BBCA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 00:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DC822D02
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 00:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgLPABc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:01:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:56286 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgLOXij (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 18:38:39 -0500
IronPort-SDR: wTka22TL5xF9a19rj/96LbxqVrUIxggEjuc5pgpnGXh+ao2A3Vd8IyYyl7eM6Nr9Un9sUdLNjJ
 GM+krTuZyFiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="193351496"
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="193351496"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 15:37:58 -0800
IronPort-SDR: 49qS0KPb+DwWKC4HnI3oUImAWXG/hroQO1wAYvjgtiEafbeoR2XqS8ja49Haus8u1h+jO/JZ22
 jj26aqhQlx3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="341810954"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2020 15:37:57 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Revert "Bluetooth: btintel: Fix endianness issue for TLV version information"
Date:   Wed, 16 Dec 2020 05:10:38 +0530
Message-Id: <20201215234038.31975-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reverts commit a63f23c9d139377833a139b179793fea79ee198f.

get_unaligned_{le16|le32|le64}(p) is meant to replace code of the form
le16_to_cpu(get_unaligned((__le16 *)p)). There is no need to explicitly
do leXX_to_cpu() if get_unaligned_leXX() is used.

https://lwn.net/Articles/277779/

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 41ff2071d7ef..88ce5f0ffc4b 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -437,38 +437,31 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 		tlv = (struct intel_tlv *)skb->data;
 		switch (tlv->type) {
 		case INTEL_TLV_CNVI_TOP:
-			version->cnvi_top =
-				__le32_to_cpu(get_unaligned_le32(tlv->val));
+			version->cnvi_top = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_CNVR_TOP:
-			version->cnvr_top =
-				__le32_to_cpu(get_unaligned_le32(tlv->val));
+			version->cnvr_top = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_CNVI_BT:
-			version->cnvi_bt =
-				__le32_to_cpu(get_unaligned_le32(tlv->val));
+			version->cnvi_bt = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_CNVR_BT:
-			version->cnvr_bt =
-				__le32_to_cpu(get_unaligned_le32(tlv->val));
+			version->cnvr_bt = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_DEV_REV_ID:
-			version->dev_rev_id =
-				__le16_to_cpu(get_unaligned_le16(tlv->val));
+			version->dev_rev_id = get_unaligned_le16(tlv->val);
 			break;
 		case INTEL_TLV_IMAGE_TYPE:
 			version->img_type = tlv->val[0];
 			break;
 		case INTEL_TLV_TIME_STAMP:
-			version->timestamp =
-				__le16_to_cpu(get_unaligned_le16(tlv->val));
+			version->timestamp = get_unaligned_le16(tlv->val);
 			break;
 		case INTEL_TLV_BUILD_TYPE:
 			version->build_type = tlv->val[0];
 			break;
 		case INTEL_TLV_BUILD_NUM:
-			version->build_num =
-				__le32_to_cpu(get_unaligned_le32(tlv->val));
+			version->build_num = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_SECURE_BOOT:
 			version->secure_boot = tlv->val[0];
-- 
2.17.1

