Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DC6ECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 19:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiIATTd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiIATTb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 15:19:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2A79610
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662059969; x=1693595969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCKtovdYURhI8yhebysw4HI5CByeGIlssBcKwN4pS2U=;
  b=FPc5POaYCZISNHrH4N9Ja02FaYjxs8BvbTS4V7TfxAnHSUlbbfdXhNA7
   LXUuxziUKnV+5cZgOA++EIpuI/Q3E18WD82BtdIMaVDeEnszdYuhKMs8Q
   jIONyVhe5q7itcB8P8Z1w0e3vaQQbaqo39tivEvypFVAHz+a8ZUsN4OkG
   FpCalVzpHevcAYgzdQtVhwJZo4k1O+eVmEdVxPQOvFn7RYfOo6tu6ZBNY
   hZC0SemQDUdmztlKd5E8zl56hxKKSc4D7tpxSBPVTv5pz7YE+lZ5EFixs
   E9lQJ/wgiZ9cBGt0DnJwtJ9aNaEcL6wUlfc16yfyC1lhnmGlq4eYQJncE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296590699"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="296590699"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:19:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="674007698"
Received: from ghonawax-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.58.197])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:19:28 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v7 2/2] Bluetooth: Add experimental wrapper for MGMT based mesh
Date:   Thu,  1 Sep 2022 12:19:14 -0700
Message-Id: <20220901191914.22706-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901191914.22706-1-brian.gix@intel.com>
References: <20220901191914.22706-1-brian.gix@intel.com>
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
 net/bluetooth/mgmt.c        | 112 +++++++++++++++++++++++++++++++++---
 2 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b3ade687531f..e004ba04a9ae 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -354,6 +354,7 @@ enum {
 	HCI_LE_SIMULTANEOUS_ROLES,
 	HCI_CMD_DRAIN_WORKQUEUE,
 
+	HCI_MESH_EXPERIMENTAL,
 	HCI_MESH,
 	HCI_MESH_SENDING,
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b7ca59e1e10c..063682ec4014 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2203,7 +2203,8 @@ static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
-	if (!lmp_le_capable(hdev))
+	if (!lmp_le_capable(hdev) ||
+	    !hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
@@ -2322,7 +2323,8 @@ static int mesh_features(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_rp_mesh_read_features rp;
 
-	if (!lmp_le_capable(hdev))
+	if (!lmp_le_capable(hdev) ||
+	    !hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_READ_FEATURES,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
@@ -2376,6 +2378,11 @@ static int mesh_send_cancel(struct sock *sk, struct hci_dev *hdev,
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
@@ -2407,6 +2414,10 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	bool sending;
 	int err = 0;
 
+	if (!lmp_le_capable(hdev) ||
+	    !hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+				       MGMT_STATUS_NOT_SUPPORTED);
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
 	    len <= MGMT_MESH_SEND_SIZE ||
 	    len > (MGMT_MESH_SEND_SIZE + 31))
@@ -4352,17 +4363,30 @@ static const u8 iso_socket_uuid[16] = {
 	0x6a, 0x49, 0xe0, 0x05, 0x88, 0xf1, 0xba, 0x6f,
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
-	char buf[122];   /* Enough space for 6 features: 2 + 20 * 6 */
-	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
+	struct mgmt_rp_read_exp_features_info *rp;
+	size_t len;
 	u16 idx = 0;
 	u32 flags;
+	int status;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
-	memset(&buf, 0, sizeof(buf));
+	/* Enough space for 7 features */
+	len = sizeof(*rp) + (sizeof(rp->features[0]) * 7);
+	rp = kmalloc(len, GFP_KERNEL);
+	if (!rp)
+		return -ENOMEM;
+
+	memset(rp, 0, len);
 
 #ifdef CONFIG_BT_FEATURE_DEBUG
 	if (!hdev) {
@@ -4426,6 +4450,17 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
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
@@ -4433,9 +4468,12 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
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
@@ -4563,6 +4601,63 @@ static int set_debug_func(struct sock *sk, struct hci_dev *hdev,
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
+	if (val) {
+		changed = !hci_dev_test_and_set_flag(hdev,
+						     HCI_MESH_EXPERIMENTAL);
+	} else {
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
@@ -4878,6 +4973,7 @@ static const struct mgmt_exp_feature {
 #ifdef CONFIG_BT_FEATURE_DEBUG
 	EXP_FEAT(debug_uuid, set_debug_func),
 #endif
+	EXP_FEAT(mgmt_mesh_uuid, set_mgmt_mesh_func),
 	EXP_FEAT(rpa_resolution_uuid, set_rpa_resolution_func),
 	EXP_FEAT(quality_report_uuid, set_quality_report_func),
 	EXP_FEAT(offload_codecs_uuid, set_offload_codec_func),
-- 
2.37.2

