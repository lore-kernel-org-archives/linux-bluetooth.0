Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DB3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFE560F21
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349200AbhICKy1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 06:54:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:42882 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349247AbhICKyX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 06:54:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="304953082"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="304953082"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 03:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="692090476"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2021 03:53:20 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, luiz.von.dentz@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v14 11/12] Bluetooth: Add offload feature under experimental flag
Date:   Fri,  3 Sep 2021 16:28:12 +0530
Message-Id: <20210903105813.2440-11-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210903105813.2440-1-kiran.k@intel.com>
References: <20210903105813.2440-1-kiran.k@intel.com>
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

Notes:
    changes in v14:
     - No changes
    
    changes in v13:
    - rebase on HEAD and resolve conflicts
    
    changes in v12:
    - Move definiton of mgmt flag to control hfp offload to patch 04/10
    
    changes in v11:

 net/bluetooth/mgmt.c | 103 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index af1e65c4e00e..8818ede3d788 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3797,6 +3797,12 @@ static const u8 quality_report_uuid[16] = {
 	0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33,
 };
 
+/* a6695ace-ee7f-4fb9-881a-5fac66c629af */
+static const u8 offload_codecs_uuid[16] = {
+	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f, 0x1a, 0x88,
+	0xb9, 0x4f, 0x7f, 0xee, 0xce, 0x5a, 0x69, 0xa6,
+};
+
 /* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
 static const u8 simult_central_periph_uuid[16] = {
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
@@ -3812,7 +3818,7 @@ static const u8 rpa_resolution_uuid[16] = {
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[82];   /* Enough space for 4 features: 2 + 20 * 4 */
+	char buf[102];   /* Enough space for 5 features: 2 + 20 * 5 */
 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
 	u16 idx = 0;
 	u32 flags;
@@ -3874,6 +3880,26 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
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
@@ -4152,6 +4178,80 @@ static int set_quality_report_func(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
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
+static int set_offload_codec_func(struct sock *sk, struct hci_dev *hdev,
+				  struct mgmt_cp_set_exp_feature *cp,
+				  u16 data_len)
+{
+	bool val, changed;
+	int err;
+	struct mgmt_rp_set_exp_feature rp;
+
+	/* Command requires to use a valid controller index */
+	if (!hdev)
+		return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_INDEX);
+
+	/* Parameters are limited to a single octet */
+	if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	/* Only boolean on/off is supported */
+	if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	val = !!cp->param[0];
+	changed = (val != hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED));
+
+	if (!hdev->get_data_path_id) {
+		bt_dev_info(hdev, "offload codecs not supported");
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_NOT_SUPPORTED);
+	}
+
+	if (changed) {
+		if (val)
+			hci_dev_set_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED);
+		else
+			hci_dev_clear_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED);
+	}
+
+	bt_dev_info(hdev, "offload codecs enable %d changed %d",
+		    val, changed);
+
+	memcpy(rp.uuid, offload_codecs_uuid, 16);
+	rp.flags = cpu_to_le32(val ? BIT(0) : 0);
+	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+	err = mgmt_cmd_complete(sk, hdev->id,
+				MGMT_OP_SET_EXP_FEATURE, 0,
+				&rp, sizeof(rp));
+
+	if (changed)
+		exp_offload_codec_feature_changed(val, sk);
+
+	return err;
+}
+
 static const struct mgmt_exp_feature {
 	const u8 *uuid;
 	int (*set_func)(struct sock *sk, struct hci_dev *hdev,
@@ -4163,6 +4263,7 @@ static const struct mgmt_exp_feature {
 #endif
 	EXP_FEAT(rpa_resolution_uuid, set_rpa_resolution_func),
 	EXP_FEAT(quality_report_uuid, set_quality_report_func),
+	EXP_FEAT(offload_codecs_uuid, set_offload_codec_func),
 
 	/* end with a null feature */
 	EXP_FEAT(NULL, NULL)
-- 
2.17.1

