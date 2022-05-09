Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CDFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 May 2022 22:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiEIWJY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 18:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiEIWJU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 18:09:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B752A83F1
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 15:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652133924; x=1683669924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2qxpi8P1WM6syq5Kx1SRdO4LNoaxlPFbJYft4PcpsBM=;
  b=bDSBOFNRFu3roKPDllr+6mGgDqzAxIN/qG+pLMEXCbQ/vyazBrJ8tt/2
   2DyfSeteHrQbRDAqBRTVfOsGvQUgrIC3YnwikCPaaGumYWBYcl2gLginT
   Xc7zbywxDFk3avi1ehxir4ZLDXdc2FUloJiuYLy5WWEB4LicYgI7+1zTv
   rG0SUj07Uch48bY7gaLb/d3EOE2IMGGKQAZ7Em0e3b79tC3vXg88H5lNJ
   nuA42UnpExh5wTM/vI5vezb9BW6hkVy0O/ziEc0KKr1VMBPRdMGeG4Jcs
   pE4vQ4h8r8ZcBuSufbxRvj5lUUEPsZaWHb7N9QBCKVp4khrwy+4sbNlKn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="329776690"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="329776690"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 15:05:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="657329495"
Received: from sameeram-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.88.33])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 15:05:22 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v2 2/2] Bluetooth: Add experimental wrapper for MGMT based mesh
Date:   Mon,  9 May 2022 15:05:12 -0700
Message-Id: <20220509220512.482695-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509220512.482695-1-brian.gix@intel.com>
References: <20220509220512.482695-1-brian.gix@intel.com>
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
 net/bluetooth/mgmt.c        | 120 +++++++++++++++++++++++++++++++-----
 2 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5d70beb54cab..e18c8d104f79 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -362,6 +362,7 @@ enum {
 	HCI_OFFLOAD_CODECS_ENABLED,
 	HCI_LE_SIMULTANEOUS_ROLES,
 
+	HCI_MESH_EXPERIMENTAL,
 	HCI_MESH,
 	HCI_MESH_SENDING,
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index aebd579fddba..1467b33be63a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2134,7 +2134,6 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
 	struct mgmt_pending_cmd *cmd = data;
 	u8 status = mgmt_status(err);
 	struct sock *sk = cmd->sk;
-	u8 slots;
 
 	if (status) {
 		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev,
@@ -2142,14 +2141,8 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
 		return;
 	}
 
-	if (hci_dev_test_flag(hdev, HCI_MESH))
-		slots = 1;
-	else
-		slots = 0;
-
 	mgmt_pending_remove(cmd);
-	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER, 0,
-								&slots, 1);
+	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER, 0, 0, 0);
 }
 
 static int set_mesh_sync(struct hci_dev *hdev, void *data)
@@ -2183,7 +2176,8 @@ static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
-	if (!lmp_le_capable(hdev))
+	if (!lmp_le_capable(hdev) ||
+			!hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
@@ -2262,7 +2256,8 @@ static int mesh_features(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_rp_mesh_read_features rp;
 
-	if (!lmp_le_capable(hdev))
+	if (!lmp_le_capable(hdev) ||
+			!hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_READ_FEATURES,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
@@ -2316,6 +2311,11 @@ static int mesh_send_cancel(struct sock *sk, struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd;
 	int err;
 
+	if (!lmp_le_capable(hdev) ||
+			!hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
 				       MGMT_STATUS_REJECTED);
@@ -2347,6 +2347,11 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	bool sending;
 	int err = 0;
 
+	if (!lmp_le_capable(hdev) ||
+			!hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
 					len <= MGMT_MESH_SEND_SIZE ||
 					len > (MGMT_MESH_SEND_SIZE + 29))
@@ -4265,17 +4270,30 @@ static const u8 rpa_resolution_uuid[16] = {
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
@@ -4332,6 +4350,17 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
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
@@ -4339,9 +4368,12 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	 */
 	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
 
-	return mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
+	status = mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 				 MGMT_OP_READ_EXP_FEATURES_INFO,
 				 0, rp, sizeof(*rp) + (20 * idx));
+
+	kfree(rp);
+	return status;
 }
 
 static int exp_ll_privacy_feature_changed(bool enabled, struct hci_dev *hdev,
@@ -4468,6 +4500,65 @@ static int set_debug_func(struct sock *sk, struct hci_dev *hdev,
 }
 #endif
 
+static int set_mgmt_mesh_func(struct sock *sk, struct hci_dev *hdev,
+				   struct mgmt_cp_set_exp_feature *cp,
+				   u16 data_len)
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
@@ -4732,6 +4823,7 @@ static const struct mgmt_exp_feature {
 #ifdef CONFIG_BT_FEATURE_DEBUG
 	EXP_FEAT(debug_uuid, set_debug_func),
 #endif
+	EXP_FEAT(mgmt_mesh_uuid, set_mgmt_mesh_func),
 	EXP_FEAT(rpa_resolution_uuid, set_rpa_resolution_func),
 	EXP_FEAT(quality_report_uuid, set_quality_report_func),
 	EXP_FEAT(offload_codecs_uuid, set_offload_codec_func),
-- 
2.35.1

