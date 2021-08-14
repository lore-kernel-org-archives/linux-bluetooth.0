Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3634AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 07:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFAE61028
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 07:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhHNHWx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 03:22:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:42835 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237258AbhHNHWt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 03:22:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="213817677"
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="213817677"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2021 00:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="640022061"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 14 Aug 2021 00:22:20 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v12 10/10] Bluetooth: Add offload feature under experimental flag
Date:   Sat, 14 Aug 2021 12:56:29 +0530
Message-Id: <20210814072629.11748-10-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210814072629.11748-1-kiran.k@intel.com>
References: <20210814072629.11748-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Allow user level process to enable / disable codec offload
feature through mgmt interface. By default offload codec feature
is disabled.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
changes in v12:
- Move definiton of mgmt flag to control hfp offload to patch 04/10

changes in v11:
- Remove Kconfig

 net/bluetooth/mgmt.c | 98 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1e21e014efd2..083365d89946 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3791,6 +3791,12 @@ static const u8 debug_uuid[16] = {
 };
 #endif
 
+/* a6695ace-ee7f-4fb9-881a-5fac66c629af */
+static const u8 offload_codecs_uuid[16] = {
+	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f, 0x1a, 0x88,
+	0xb9, 0x4f, 0x7f, 0xee, 0xce, 0x5a, 0x69, 0xa6,
+};
+
 /* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
 static const u8 simult_central_periph_uuid[16] = {
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
@@ -3806,7 +3812,7 @@ static const u8 rpa_resolution_uuid[16] = {
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[62];	/* Enough space for 3 features */
+	char buf[82];   /* Enough space for 4 features: 2 + 20 * 4 */
 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
 	u16 idx = 0;
 	u32 flags;
@@ -3850,6 +3856,26 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
+	if (hdev) {
+		if (hdev->get_data_path_id) {
+			/* BIT(0): indicating if offload codecs are
+			 * supported by controller.
+			 */
+			flags = BIT(0);
+
+			/* BIT(1): indicating if codec offload feature
+			 * is enabled.
+			 */
+			if (hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED))
+				flags |= BIT(1);
+		} else {
+			flags = 0;
+		}
+		memcpy(rp->features[idx].uuid, offload_codecs_uuid, 16);
+		rp->features[idx].flags = cpu_to_le32(flags);
+		idx++;
+	}
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
@@ -3892,6 +3918,21 @@ static int exp_debug_feature_changed(bool enabled, struct sock *skip)
 }
 #endif
 
+static int exp_offload_codec_feature_changed(bool enabled, struct sock *skip)
+{
+	struct mgmt_ev_exp_feature_changed ev;
+
+	BT_INFO("enabled %d", enabled);
+
+	memset(&ev, 0, sizeof(ev));
+	memcpy(ev.uuid, offload_codecs_uuid, 16);
+	ev.flags = cpu_to_le32(enabled ? BIT(0) : 0);
+
+	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, NULL,
+				  &ev, sizeof(ev),
+				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
+}
+
 static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 data_len)
 {
@@ -4038,6 +4079,61 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 		return err;
 	}
 
+	if (!memcmp(cp->uuid, offload_codecs_uuid, 16)) {
+		bool val, changed;
+		int err;
+
+		/* Command requires to use a valid controller index */
+		if (!hdev)
+			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_INDEX);
+
+		/* Parameters are limited to a single octet */
+		if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		/* Only boolean on/off is supported */
+		if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		val = !!cp->param[0];
+		changed = (val != hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED));
+
+		if (!hdev->get_data_path_id) {
+			bt_dev_info(hdev, "offload codecs not supported");
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_NOT_SUPPORTED);
+		}
+
+		if (changed) {
+			if (val)
+				hci_dev_set_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED);
+			else
+				hci_dev_clear_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED);
+		}
+
+		bt_dev_info(hdev, "offload codecs enable %d changed %d",
+			    val, changed);
+
+		memcpy(rp.uuid, offload_codecs_uuid, 16);
+		rp.flags = cpu_to_le32(val ? BIT(0) : 0);
+		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_SET_EXP_FEATURE, 0,
+					&rp, sizeof(rp));
+
+		if (changed)
+			exp_offload_codec_feature_changed(val, sk);
+
+		return err;
+	}
+
 	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 			       MGMT_OP_SET_EXP_FEATURE,
 			       MGMT_STATUS_NOT_SUPPORTED);
-- 
2.17.1

