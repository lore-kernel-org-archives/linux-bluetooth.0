Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C9C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 11:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F7B2072F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 11:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgFKLoy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:44:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:26678 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgFKLov (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jun 2020 07:44:51 -0400
IronPort-SDR: rRbYXi5yY7z1B47Wl6I7Mhbu3g+o441Fi3zek/asFWsDrCqkej7O+Nn5LUa6g6rx9ZpwNOUNKj
 fp6f88EZWi1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 04:44:51 -0700
IronPort-SDR: BP6I2jTa8+WKFIsRnESi1sBxg1uhsKBn4OV7qsf7dzTwiye7xxz3Q+Qyeedpz3q2TeaHdImIg2
 IzBlYrkU7eHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="296562838"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2020 04:44:49 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH 1/4] Bluetooth: btintel: Define tlv structure to enable firmware download
Date:   Thu, 11 Jun 2020 17:15:23 +0530
Message-Id: <20200611114526.13594-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611114526.13594-1-kiran.k@intel.com>
References: <20200611114526.13594-1-kiran.k@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Raghuram Hegde <raghuram.hegde@intel.com>

Define tlv structure to enable FW download for new generation Intel
controllers

Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btintel.h | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 08e20606fb58..32b2cd887bdd 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -19,6 +19,46 @@ struct intel_version {
 	u8 fw_patch_num;
 } __packed;
 
+struct intel_version_tlv {
+	u8	 status;
+	u32	 cnvi_top;
+	u32	 cnvr_top;
+	u32	 cnvi_bt;
+	u32	 cnvr_bt;
+	u16	 cnvi_otp;
+	u16	 cnvr_otp;
+	u16	 dev_rev_id;
+	u16	 usb_vid;
+	u16	 usb_pid;
+	u16	 pcie_vendor_id;
+	u16	 pcie_dev_id;
+	u16	 pcie_subsys_id;
+	u8	 img_type;
+	u16	 timestamp;
+	u8	 build_type;
+	u32	 build_num;
+	u8	 fw_build_prod;
+	u8	 fw_build_hw;
+	u8	 fw_build_step;
+	u8	 bt_spec_ver;
+	u16	 mfg_name;
+	u16	 hci_rev;
+	u16	 lmp_sub_ver;
+	u8	 otp_patch_ver;
+	u8	 secure_boot;
+	u8	 key_from_hdr;
+	u8	 otp_lock;
+	u8	 api_lock;
+	u8	 debug_lock;
+	u8	 min_fw_build_nn;
+	u8	 min_fw_build_cw;
+	u8	 min_fw_build_yy;
+	u8	 limited_cce;
+	u8	 sbe_type;
+	bdaddr_t otp_bd_addr;
+	u8	 unlocked_state;
+} __packed;
+
 struct intel_boot_params {
 	__u8     status;
 	__u8     otp_format;
-- 
2.17.1

