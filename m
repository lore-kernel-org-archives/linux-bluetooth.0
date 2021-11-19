Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FA6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E318603E7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhKSIS2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:18:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:1545 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234272AbhKSIS0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 03:18:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="233098448"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="233098448"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:15:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="473468865"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 00:15:23 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v4 14/14] Bluetooth: Add MSFT a2dp offload codec under experimental flag
Date:   Fri, 19 Nov 2021 13:50:27 +0530
Message-Id: <20211119082027.12809-14-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119082027.12809-1-kiran.k@intel.com>
References: <20211119082027.12809-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Keep MSFT a2dp offload codecs feature under experimental flag.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 net/bluetooth/mgmt.c | 94 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f8f74d344297..913e2c66cdf6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3887,10 +3887,16 @@ static const u8 rpa_resolution_uuid[16] = {
 	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
 };
 
+/* 0cc2131f-96f0-4cd1-b313-b97e7cbc8335 */
+static const u8 msft_a2dp_offload_codecs_uuid[16] = {
+	0x35, 0x83, 0xbc, 0x7c, 0x7e, 0xb9, 0x13, 0xb3,
+	0xd1, 0x4c, 0xf0, 0x96, 0x1f, 0x13, 0xc2, 0x0c,
+};
+
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[102];   /* Enough space for 5 features: 2 + 20 * 5 */
+	char buf[122];   /* Enough space for 6 features: 2 + 20 * 6 */
 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
 	u16 idx = 0;
 	u32 flags;
@@ -3957,6 +3963,17 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
+	if (hdev && hdev->get_data_path_id) {
+		if (hci_dev_test_flag(hdev, HCI_MSFT_A2DP_OFFLOAD_CODECS_ENABLED))
+			flags = BIT(0);
+		else
+			flags = 0;
+
+		memcpy(rp->features[idx].uuid, msft_a2dp_offload_codecs_uuid, 16);
+		rp->features[idx].flags = cpu_to_le32(flags);
+		idx++;
+	}
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
@@ -4256,6 +4273,20 @@ static int exp_offload_codec_feature_changed(bool enabled, struct hci_dev *hdev,
 				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
 }
 
+static int exp_msft_a2dp_offload_codec_feature_changed(bool enabled,
+						       struct sock *skip)
+{
+	struct mgmt_ev_exp_feature_changed ev;
+
+	memset(&ev, 0, sizeof(ev));
+	memcpy(ev.uuid, msft_a2dp_offload_codecs_uuid, 16);
+	ev.flags = cpu_to_le32(enabled ? BIT(0) : 0);
+
+	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, NULL,
+				  &ev, sizeof(ev),
+				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
+}
+
 static int set_offload_codec_func(struct sock *sk, struct hci_dev *hdev,
 				  struct mgmt_cp_set_exp_feature *cp,
 				  u16 data_len)
@@ -4314,6 +4345,66 @@ static int set_offload_codec_func(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int set_msft_a2dp_offload_codec_func(struct sock *sk, struct hci_dev *hdev,
+					    struct mgmt_cp_set_exp_feature *cp,
+					    u16 data_len)
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
+	changed = (val != hci_dev_test_flag(hdev,
+					    HCI_MSFT_A2DP_OFFLOAD_CODECS_ENABLED));
+
+	if (!hdev->get_data_path_id) {
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_NOT_SUPPORTED);
+	}
+
+	if (changed) {
+		if (val)
+			hci_dev_set_flag(hdev,
+					 HCI_MSFT_A2DP_OFFLOAD_CODECS_ENABLED);
+		else
+			hci_dev_clear_flag(hdev,
+					   HCI_MSFT_A2DP_OFFLOAD_CODECS_ENABLED);
+	}
+
+	bt_dev_info(hdev, "msft offload codecs enable %d changed %d",
+		    val, changed);
+
+	memcpy(rp.uuid, msft_a2dp_offload_codecs_uuid, 16);
+	rp.flags = cpu_to_le32(val ? BIT(0) : 0);
+	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+	err = mgmt_cmd_complete(sk, hdev->id,
+				MGMT_OP_SET_EXP_FEATURE, 0,
+				&rp, sizeof(rp));
+
+	if (changed)
+		exp_msft_a2dp_offload_codec_feature_changed(val, sk);
+
+	return err;
+}
 static const struct mgmt_exp_feature {
 	const u8 *uuid;
 	int (*set_func)(struct sock *sk, struct hci_dev *hdev,
@@ -4326,6 +4417,7 @@ static const struct mgmt_exp_feature {
 	EXP_FEAT(rpa_resolution_uuid, set_rpa_resolution_func),
 	EXP_FEAT(quality_report_uuid, set_quality_report_func),
 	EXP_FEAT(offload_codecs_uuid, set_offload_codec_func),
+	EXP_FEAT(msft_a2dp_offload_codecs_uuid, set_msft_a2dp_offload_codec_func),
 
 	/* end with a null feature */
 	EXP_FEAT(NULL, NULL)
-- 
2.17.1

