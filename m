Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6CBC11F68
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 08:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB22961D05
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 08:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhF3IGg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jun 2021 04:06:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:5410 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233230AbhF3IGf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jun 2021 04:06:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="272164669"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="272164669"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 01:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="643997998"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2021 01:04:05 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v10 10/10] Bluetooth: Add offload feature under experimental flag
Date:   Wed, 30 Jun 2021 13:38:07 +0530
Message-Id: <20210630080807.12600-10-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210630080807.12600-1-kiran.k@intel.com>
References: <20210630080807.12600-1-kiran.k@intel.com>
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
* changes in v10:
  - new patch added to place offload codec feature under experimental flag

 include/net/bluetooth/hci.h |   4 ++
 net/bluetooth/mgmt.c        | 106 +++++++++++++++++++++++++++++++++++-
 net/bluetooth/sco.c         |  10 ++++
 3 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e20318854900..5ca98d9f64dd 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -331,6 +331,10 @@ enum {
 	HCI_CMD_PENDING,
 	HCI_FORCE_NO_MITM,
 
+#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
+	HCI_OFFLOAD_CODECS_ENABLED,
+#endif
+
 	__HCI_NUM_FLAGS,
 };
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3663f880df11..d7be85eb52e7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3791,6 +3791,14 @@ static const u8 debug_uuid[16] = {
 };
 #endif
 
+#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
+/* a6695ace-ee7f-4fb9-881a-5fac66c629af */
+static const u8 offload_codecs_uuid[16] = {
+	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f, 0x1a, 0x88,
+	0xb9, 0x4f, 0x7f, 0xee, 0xce, 0x5a, 0x69, 0xa6,
+};
+#endif
+
 /* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
 static const u8 simult_central_periph_uuid[16] = {
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
@@ -3806,7 +3814,7 @@ static const u8 rpa_resolution_uuid[16] = {
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[62];	/* Enough space for 3 features */
+	char buf[82];   /* Enough space for 4 features: 2 + 20 * 4 */
 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
 	u16 idx = 0;
 	u32 flags;
@@ -3850,6 +3858,28 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
+#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
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
+#endif
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
@@ -3892,6 +3922,23 @@ static int exp_debug_feature_changed(bool enabled, struct sock *skip)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
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
+#endif
+
 static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 data_len)
 {
@@ -4038,6 +4085,63 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 		return err;
 	}
 
+#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
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
+#endif
+
 	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 			       MGMT_OP_SET_EXP_FEATURE,
 			       MGMT_STATUS_NOT_SUPPORTED);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b44d56eb936a..bc033464af43 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -964,6 +964,11 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
+		if (!hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED)) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
 		if (!hdev->get_codec_config_data) {
 			err = -EOPNOTSUPP;
 			break;
@@ -1163,6 +1168,11 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
+		if (!hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED)) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
 		if (!hdev->get_data_path_id) {
 			err = -EOPNOTSUPP;
 			break;
-- 
2.17.1

