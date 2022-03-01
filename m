Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6055C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 22:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbiCAWfq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 17:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiCAWfp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 17:35:45 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853523C726
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 14:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646174103; x=1677710103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DkZsGKg0L8gJ0Z4of+roRRkp4akdk6kgr1OnxCZW908=;
  b=UZK9+2TvT+58LYqxOTfxr728ZFWFZN2YQiEw2K7+uMnlEfPU0xLYFzrr
   tP6VZy2iQfAFTjSPTyRvuRSDsK9s0DbkhJyagpJnpMlUbJ8Qbi92Gvdj7
   AEw2leqxFSvx+yuwmoApWssQxS8d0AJU2wvPJJHDfDOLKXQ3SdQbjpWrh
   +HdTP3RAgp7tqBgFQp6qyAbiS32x1cIpapaYsBxlFWZT1yvHh71HLR09P
   KPV9DRWnLpz4sgDNqv/RwMj9SRsSCn008fQ2vM/f1Vcv/sfUFVLcEIVpz
   HIXDSVU5E17HzVzpnjqrND9WiFvxFHk7P5EPdu5+YK4wgtLMZQDp99Jlh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252089786"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252089786"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 14:35:03 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="545267702"
Received: from rlucey-mobl.ger.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.91.119])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 14:35:03 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, marcel@holtmann.org, brian.gix@intel.com,
        tedd.an@intel.com
Subject: [PATCH v6] Bluetooth: Scrub MGMT cmd pending queue for consistency
Date:   Tue,  1 Mar 2022 14:34:57 -0800
Message-Id: <20220301223457.784338-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A number of places in the MGMT handlers we examine the command queue for
other commands (in progress but not yet complete) that will interact
with the process being performed. However, not all commands go into the
queue if one of:

1. There is no negative side effect of consecutive or redundent commands
2. The command is entirely perform "inline".

This change examines each "pending command" check, and if it is not
needed, deletes the check. Of the remaining pending command checks, we
make sure that the command is in the pending queue by using the
mgmt_pending_add/mgmt_pending_remove pair rather than the
mgmt_pending_new/mgmt_pending_free pair.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/mgmt.c | 99 ++++++++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 36 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4b15b95e61e6..5913fc4a17ea 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1220,7 +1220,13 @@ static int new_settings(struct hci_dev *hdev, struct sock *skip)
 static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_mode *cp = cmd->param;
+	struct mgmt_mode *cp;
+
+	/* Make sure cmd still outstanding. */
+	if (cmd != pending_find(MGMT_OP_SET_POWERED, hdev))
+		return;
+
+	cp = cmd->param;
 
 	bt_dev_dbg(hdev, "err %d", err);
 
@@ -1244,7 +1250,7 @@ static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
 				mgmt_status(err));
 	}
 
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 }
 
 static int set_powered_sync(struct hci_dev *hdev, void *data)
@@ -1283,7 +1289,7 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_new(sk, MGMT_OP_SET_POWERED, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1292,6 +1298,9 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 	err = hci_cmd_sync_queue(hdev, set_powered_sync, cmd,
 				 mgmt_set_powered_complete);
 
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
 failed:
 	hci_dev_unlock(hdev);
 	return err;
@@ -1385,6 +1394,10 @@ static void mgmt_set_discoverable_complete(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "err %d", err);
 
+	/* Make sure cmd still outstanding. */
+	if (cmd != pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
+		return;
+
 	hci_dev_lock(hdev);
 
 	if (err) {
@@ -1404,7 +1417,7 @@ static void mgmt_set_discoverable_complete(struct hci_dev *hdev, void *data,
 	new_settings(hdev, cmd->sk);
 
 done:
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 	hci_dev_unlock(hdev);
 }
 
@@ -1513,7 +1526,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_new(sk, MGMT_OP_SET_DISCOVERABLE, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1540,6 +1553,9 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	err = hci_cmd_sync_queue(hdev, set_discoverable_sync, cmd,
 				 mgmt_set_discoverable_complete);
 
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
 failed:
 	hci_dev_unlock(hdev);
 	return err;
@@ -1552,6 +1568,10 @@ static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "err %d", err);
 
+	/* Make sure cmd still outstanding. */
+	if (cmd != pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
+		return;
+
 	hci_dev_lock(hdev);
 
 	if (err) {
@@ -1564,7 +1584,9 @@ static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
 	new_settings(hdev, cmd->sk);
 
 done:
-	mgmt_pending_free(cmd);
+	if (cmd)
+		mgmt_pending_remove(cmd);
+
 	hci_dev_unlock(hdev);
 }
 
@@ -1636,7 +1658,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_new(sk, MGMT_OP_SET_CONNECTABLE, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1656,6 +1678,9 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	err = hci_cmd_sync_queue(hdev, set_connectable_sync, cmd,
 				 mgmt_set_connectable_complete);
 
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
 failed:
 	hci_dev_unlock(hdev);
 	return err;
@@ -1776,6 +1801,10 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 	u8 enable = cp->val;
 	bool changed;
 
+	/* Make sure cmd still outstanding. */
+	if (cmd != pending_find(MGMT_OP_SET_SSP, hdev))
+		return;
+
 	if (err) {
 		u8 mgmt_err = mgmt_status(err);
 
@@ -3325,6 +3354,9 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
+	if (cmd != pending_find(MGMT_OP_SET_LOCAL_NAME, hdev))
+		return;
+
 	if (status) {
 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
 				status);
@@ -3497,6 +3529,9 @@ static void set_default_phy_complete(struct hci_dev *hdev, void *data, int err)
 	struct sk_buff *skb = cmd->skb;
 	u8 status = mgmt_status(err);
 
+	if (cmd != pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev))
+		return;
+
 	if (!status) {
 		if (!skb)
 			status = MGMT_STATUS_FAILED;
@@ -3763,13 +3798,6 @@ static int set_wideband_speech(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (pending_find(MGMT_OP_SET_WIDEBAND_SPEECH, hdev)) {
-		err = mgmt_cmd_status(sk, hdev->id,
-				      MGMT_OP_SET_WIDEBAND_SPEECH,
-				      MGMT_STATUS_BUSY);
-		goto unlock;
-	}
-
 	if (hdev_is_powered(hdev) &&
 	    !!cp->val != hci_dev_test_flag(hdev,
 					   HCI_WIDEBAND_SPEECH_ENABLED)) {
@@ -5040,12 +5068,6 @@ static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev)) {
-		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
-				      MGMT_STATUS_BUSY);
-		goto unlock;
-	}
-
 	cmd = mgmt_pending_new(sk, MGMT_OP_READ_LOCAL_OOB_DATA, hdev, NULL, 0);
 	if (!cmd)
 		err = -ENOMEM;
@@ -5265,11 +5287,16 @@ static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
 
+	if (cmd != pending_find(MGMT_OP_START_DISCOVERY, hdev) &&
+		cmd != pending_find(MGMT_OP_START_LIMITED_DISCOVERY, hdev) &&
+		cmd != pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev))
+		return;
+
 	bt_dev_dbg(hdev, "err %d", err);
 
 	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(err),
 			  cmd->param, 1);
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 
 	hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED:
 				DISCOVERY_FINDING);
@@ -5331,7 +5358,7 @@ static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
 	else
 		hdev->discovery.limited = false;
 
-	cmd = mgmt_pending_new(sk, op, hdev, data, len);
+	cmd = mgmt_pending_add(sk, op, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -5340,7 +5367,7 @@ static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
 	err = hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
 				 start_discovery_complete);
 	if (err < 0) {
-		mgmt_pending_free(cmd);
+		mgmt_pending_remove(cmd);
 		goto failed;
 	}
 
@@ -5434,7 +5461,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_new(sk, MGMT_OP_START_SERVICE_DISCOVERY,
+	cmd = mgmt_pending_add(sk, MGMT_OP_START_SERVICE_DISCOVERY,
 			       hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
@@ -5467,7 +5494,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	err = hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
 				 start_discovery_complete);
 	if (err < 0) {
-		mgmt_pending_free(cmd);
+		mgmt_pending_remove(cmd);
 		goto failed;
 	}
 
@@ -5499,11 +5526,14 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
 
+	if (cmd != pending_find(MGMT_OP_STOP_DISCOVERY, hdev))
+		return;
+
 	bt_dev_dbg(hdev, "err %d", err);
 
 	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(err),
 			  cmd->param, 1);
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 
 	if (!err)
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
@@ -5539,7 +5569,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_new(sk, MGMT_OP_STOP_DISCOVERY, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
@@ -5548,7 +5578,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 	err = hci_cmd_sync_queue(hdev, stop_discovery_sync, cmd,
 				 stop_discovery_complete);
 	if (err < 0) {
-		mgmt_pending_free(cmd);
+		mgmt_pending_remove(cmd);
 		goto unlock;
 	}
 
@@ -7478,6 +7508,9 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
 	u8 status = mgmt_status(err);
 	u16 eir_len;
 
+	if (cmd != pending_find(MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev))
+		return;
+
 	if (!status) {
 		if (!skb)
 			status = MGMT_STATUS_FAILED;
@@ -7973,11 +8006,7 @@ static bool requested_adv_flags_are_valid(struct hci_dev *hdev, u32 adv_flags)
 
 static bool adv_busy(struct hci_dev *hdev)
 {
-	return (pending_find(MGMT_OP_ADD_ADVERTISING, hdev) ||
-		pending_find(MGMT_OP_REMOVE_ADVERTISING, hdev) ||
-		pending_find(MGMT_OP_SET_LE, hdev) ||
-		pending_find(MGMT_OP_ADD_EXT_ADV_PARAMS, hdev) ||
-		pending_find(MGMT_OP_ADD_EXT_ADV_DATA, hdev));
+	return pending_find(MGMT_OP_SET_LE, hdev);
 }
 
 static void add_adv_complete(struct hci_dev *hdev, struct sock *sk, u8 instance,
@@ -8567,9 +8596,7 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (pending_find(MGMT_OP_ADD_ADVERTISING, hdev) ||
-	    pending_find(MGMT_OP_REMOVE_ADVERTISING, hdev) ||
-	    pending_find(MGMT_OP_SET_LE, hdev)) {
+	if (pending_find(MGMT_OP_SET_LE, hdev)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
 				      MGMT_STATUS_BUSY);
 		goto unlock;
-- 
2.35.1

