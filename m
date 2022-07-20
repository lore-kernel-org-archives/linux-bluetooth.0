Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552C5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 19:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGTTp1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 15:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiGTTp0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 15:45:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C80186E7
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658346325; x=1689882325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gg14aMIjmxmNpj1lgEraTmDO5ZGYg92ogIQO7vfBAUA=;
  b=CP9BIscGhJX8owT/qiSB06062Cq4l3ukZnkjfuSPaeXPj2Do4ThwXRR3
   v2pjFYw1XEmP8pN86c0dU1XWaKTe1DGRHw/WVn7AsmsgCCcwJZQnpmFkS
   USpsVeLoaCUVD5qa95tJZiMkwc/C+6lfMMZqttXei5oO5JuvwJEoDTWHZ
   l6Oj4C27+UEKIrx4q0mBMCtGsDf3sh59HCmxErLCrkoEPLaJJqdsS3i0m
   WMph50EXMyaGhEHeg+KmHmz3XvSMcEGTFavz4LGWDAdpxR+kxr+etMXp4
   YH3/JOPef0pCNJdfKq+loPhJCgRxeG7YQp7a0h4ukQBKjz8mTSE2dsamc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="287615650"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="287615650"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 12:45:23 -0700
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="740410349"
Received: from kjmoraji-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.165.4])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 12:45:22 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v5 2/2] Bluetooth: Add experimental wrapper for MGMT based mesh
Date:   Wed, 20 Jul 2022 12:45:11 -0700
Message-Id: <20220720194511.320773-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720194511.320773-1-brian.gix@intel.com>
References: <20220720194511.320773-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This introduces a "Mesh UUID" and an Experimental Feature bit to the
hdev mask, and depending all underlying Mesh functionality on it.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci.h |   1 +
 net/bluetooth/mgmt.c        | 113 +++++++++++++++++++++++++++++++++---
 2 files changed, 106 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c9db71d267e7..e7d1ba828c6c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -363,6 +363,7 @@ enum {
 	HCI_LE_SIMULTANEOUS_ROLES,
 	HCI_CMD_DRAIN_WORKQUEUE,
 
+	HCI_MESH_EXPERIMENTAL,
 	HCI_MESH,
 	HCI_MESH_SENDING,
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b56612b091d7..3b5e80bfd4ad 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2175,7 +2175,8 @@ static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
-	if (!lmp_le_capable(hdev))
+	if (!lmp_le_capable(hdev) ||
+	    !hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
@@ -2292,7 +2293,8 @@ static int mesh_features(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_rp_mesh_read_features rp;
 
-	if (!lmp_le_capable(hdev))
+	if (!lmp_le_capable(hdev) ||
+	    !hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_READ_FEATURES,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
@@ -2346,6 +2348,11 @@ static int mesh_send_cancel(struct sock *sk, struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd;
 	int err;
 
+	if (!lmp_le_capable(hdev) ||
+	    !hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
 				       MGMT_STATUS_REJECTED);
@@ -2377,6 +2384,11 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	bool sending;
 	int err = 0;
 
+	if (!lmp_le_capable(hdev) ||
+	    !hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
 	    len <= MGMT_MESH_SEND_SIZE ||
 	    len > (MGMT_MESH_SEND_SIZE + 31))
@@ -4287,17 +4299,30 @@ static const u8 rpa_resolution_uuid[16] = {
 	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
 };
 
+/* 2ce463d7-7a03-4d8d-bf05-5f24e8f36e76 */
+static const u8 mgmt_mesh_uuid[16] = {
+	0x76, 0x6e, 0xf3, 0xe8, 0x24, 0x5f, 0x05, 0xbf,
+	0x8d, 0x4d, 0x03, 0x7a, 0xd7, 0x63, 0xe4, 0x2c,
+};
+
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[102];   /* Enough space for 5 features: 2 + 20 * 5 */
-	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
+	struct mgmt_rp_read_exp_features_info *rp;
+	size_t len;
 	u16 idx = 0;
 	u32 flags;
+	int status;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
-	memset(&buf, 0, sizeof(buf));
+	/* Enough space for 6 features */
+	len = sizeof(*rp) + (sizeof(rp->features[0]) * 6);
+	rp = kmalloc(len, GFP_KERNEL);
+	if (!rp)
+		return -ENOMEM;
+
+	memset(rp, 0, len);
 
 #ifdef CONFIG_BT_FEATURE_DEBUG
 	if (!hdev) {
@@ -4354,6 +4379,17 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
+	if (hdev && lmp_le_capable(hdev)) {
+		if (hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
+			flags = BIT(0);
+		else
+			flags = 0;
+
+		memcpy(rp->features[idx].uuid, mgmt_mesh_uuid, 16);
+		rp->features[idx].flags = cpu_to_le32(flags);
+		idx++;
+	}
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
@@ -4361,9 +4397,12 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	 */
 	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
 
-	return mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
-				 MGMT_OP_READ_EXP_FEATURES_INFO,
-				 0, rp, sizeof(*rp) + (20 * idx));
+	status = mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
+				   MGMT_OP_READ_EXP_FEATURES_INFO,
+				   0, rp, sizeof(*rp) + (20 * idx));
+
+	kfree(rp);
+	return status;
 }
 
 static int exp_ll_privacy_feature_changed(bool enabled, struct hci_dev *hdev,
@@ -4490,6 +4529,63 @@ static int set_debug_func(struct sock *sk, struct hci_dev *hdev,
 }
 #endif
 
+static int set_mgmt_mesh_func(struct sock *sk, struct hci_dev *hdev,
+			      struct mgmt_cp_set_exp_feature *cp, u16 data_len)
+{
+	struct mgmt_rp_set_exp_feature rp;
+	bool val, changed;
+	int err;
+
+	/* Command requires to use the controller index */
+	if (!hdev)
+		return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_INDEX);
+
+	/* Changes can only be made when controller is powered down */
+	if (hdev_is_powered(hdev))
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_REJECTED);
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
+
+	if (val)
+		changed = !hci_dev_test_and_set_flag(hdev,
+						     HCI_MESH_EXPERIMENTAL);
+	else {
+		hci_dev_clear_flag(hdev, HCI_MESH);
+		changed = hci_dev_test_and_clear_flag(hdev,
+						      HCI_MESH_EXPERIMENTAL);
+	}
+
+	memcpy(rp.uuid, mgmt_mesh_uuid, 16);
+	rp.flags = cpu_to_le32(val ? BIT(0) : 0);
+
+	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+
+	err = mgmt_cmd_complete(sk, hdev->id,
+				MGMT_OP_SET_EXP_FEATURE, 0,
+				&rp, sizeof(rp));
+
+	if (changed)
+		exp_feature_changed(hdev, mgmt_mesh_uuid, val, sk);
+
+	return err;
+}
+
 static int set_rpa_resolution_func(struct sock *sk, struct hci_dev *hdev,
 				   struct mgmt_cp_set_exp_feature *cp,
 				   u16 data_len)
@@ -4754,6 +4850,7 @@ static const struct mgmt_exp_feature {
 #ifdef CONFIG_BT_FEATURE_DEBUG
 	EXP_FEAT(debug_uuid, set_debug_func),
 #endif
+	EXP_FEAT(mgmt_mesh_uuid, set_mgmt_mesh_func),
 	EXP_FEAT(rpa_resolution_uuid, set_rpa_resolution_func),
 	EXP_FEAT(quality_report_uuid, set_quality_report_func),
 	EXP_FEAT(offload_codecs_uuid, set_offload_codec_func),
-- 
2.36.1

