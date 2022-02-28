Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B64C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 17:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbiB1Rw3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239129AbiB1Rvn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 12:51:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D585A41A8
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 09:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069967; x=1677605967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1YTfqfCdSmGfo7xTCzeiLSb13KhNCHHQeXdE6zD9V/g=;
  b=oEr3n7uyWsWT5LAO2M9qov5VNiIgesevhrVUY5IqvGfZeITVEWJeR3zR
   7H8yQP06nK5zu1n8ayuAT1PrUGeZODGGoib6e5bmbKWDtDiF2z8E2Q6cu
   tHsIa/yGut5JRY+QWXQBgehV6jrjaoHyny3EPj2nMs5ujCsa4InFvSPC8
   mbPDqe+jtO777ZwuPH/vAJaeprMPrgaYY06BkXpBLLq99jZNvFxq13d4k
   JcOwa1GsskpWINLjSFbRrIBfreZs1pV2AYqDrXbXqK53GLBGOvXq4mSiF
   XoLprL+2d02RcyYBhAh7iOiiagnXa7xcrOJn27RzVQVUHiq4r+F2Xyhy/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233560955"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="233560955"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:39:26 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="575391603"
Received: from srhallym-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.239.74])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:39:26 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, marcel@holtmann.org, brian.gix@intel.com,
        tedd.an@intel.com
Subject: [PATCH v2] Bluetooth: Scrub MGMT cmd pending queue for consistency
Date:   Mon, 28 Feb 2022 09:39:18 -0800
Message-Id: <20220228173918.524733-1-brian.gix@intel.com>
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
 net/bluetooth/mgmt.c | 80 +++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4b15b95e61e6..a563ce90931a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1219,8 +1219,16 @@ static int new_settings(struct hci_dev *hdev, struct sock *skip)
 
 static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_mode *cp = cmd->param;
+	struct mgmt_pending_cmd *cmd;
+	struct mgmt_mode *cp;
+
+	/* Make sure cmd still outstanding. */
+	cmd = pending_find(MGMT_OP_SET_POWERED, hdev);
+
+	if (!cmd)
+		return;
+
+	cp = cmd->param;
 
 	bt_dev_dbg(hdev, "err %d", err);
 
@@ -1244,7 +1252,7 @@ static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
 				mgmt_status(err));
 	}
 
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 }
 
 static int set_powered_sync(struct hci_dev *hdev, void *data)
@@ -1283,7 +1291,7 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_new(sk, MGMT_OP_SET_POWERED, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1292,6 +1300,9 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 	err = hci_cmd_sync_queue(hdev, set_powered_sync, cmd,
 				 mgmt_set_powered_complete);
 
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
 failed:
 	hci_dev_unlock(hdev);
 	return err;
@@ -1404,7 +1415,7 @@ static void mgmt_set_discoverable_complete(struct hci_dev *hdev, void *data,
 	new_settings(hdev, cmd->sk);
 
 done:
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 	hci_dev_unlock(hdev);
 }
 
@@ -1513,7 +1524,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_new(sk, MGMT_OP_SET_DISCOVERABLE, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1540,6 +1551,9 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	err = hci_cmd_sync_queue(hdev, set_discoverable_sync, cmd,
 				 mgmt_set_discoverable_complete);
 
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
 failed:
 	hci_dev_unlock(hdev);
 	return err;
@@ -1548,12 +1562,16 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
 					  int err)
 {
-	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_pending_cmd *cmd;
 
 	bt_dev_dbg(hdev, "err %d", err);
 
 	hci_dev_lock(hdev);
 
+	cmd = pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
+	if (!cmd)
+		goto done;
+
 	if (err) {
 		u8 mgmt_err = mgmt_status(err);
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
@@ -1564,7 +1582,9 @@ static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
 	new_settings(hdev, cmd->sk);
 
 done:
-	mgmt_pending_free(cmd);
+	if (cmd)
+		mgmt_pending_remove(cmd);
+
 	hci_dev_unlock(hdev);
 }
 
@@ -1636,7 +1656,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_new(sk, MGMT_OP_SET_CONNECTABLE, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1656,6 +1676,9 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	err = hci_cmd_sync_queue(hdev, set_connectable_sync, cmd,
 				 mgmt_set_connectable_complete);
 
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
 failed:
 	hci_dev_unlock(hdev);
 	return err;
@@ -3763,13 +3786,6 @@ static int set_wideband_speech(struct sock *sk, struct hci_dev *hdev,
 
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
@@ -5040,12 +5056,6 @@ static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
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
@@ -5269,7 +5279,7 @@ static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
 
 	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(err),
 			  cmd->param, 1);
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 
 	hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED:
 				DISCOVERY_FINDING);
@@ -5331,7 +5341,7 @@ static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
 	else
 		hdev->discovery.limited = false;
 
-	cmd = mgmt_pending_new(sk, op, hdev, data, len);
+	cmd = mgmt_pending_add(sk, op, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -5340,7 +5350,7 @@ static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
 	err = hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
 				 start_discovery_complete);
 	if (err < 0) {
-		mgmt_pending_free(cmd);
+		mgmt_pending_remove(cmd);
 		goto failed;
 	}
 
@@ -5434,7 +5444,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_new(sk, MGMT_OP_START_SERVICE_DISCOVERY,
+	cmd = mgmt_pending_add(sk, MGMT_OP_START_SERVICE_DISCOVERY,
 			       hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
@@ -5467,7 +5477,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	err = hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
 				 start_discovery_complete);
 	if (err < 0) {
-		mgmt_pending_free(cmd);
+		mgmt_pending_remove(cmd);
 		goto failed;
 	}
 
@@ -5503,7 +5513,7 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 
 	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(err),
 			  cmd->param, 1);
-	mgmt_pending_free(cmd);
+	mgmt_pending_remove(cmd);
 
 	if (!err)
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
@@ -5539,7 +5549,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_new(sk, MGMT_OP_STOP_DISCOVERY, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
@@ -5548,7 +5558,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 	err = hci_cmd_sync_queue(hdev, stop_discovery_sync, cmd,
 				 stop_discovery_complete);
 	if (err < 0) {
-		mgmt_pending_free(cmd);
+		mgmt_pending_remove(cmd);
 		goto unlock;
 	}
 
@@ -7973,11 +7983,7 @@ static bool requested_adv_flags_are_valid(struct hci_dev *hdev, u32 adv_flags)
 
 static bool adv_busy(struct hci_dev *hdev)
 {
-	return (pending_find(MGMT_OP_ADD_ADVERTISING, hdev) ||
-		pending_find(MGMT_OP_REMOVE_ADVERTISING, hdev) ||
-		pending_find(MGMT_OP_SET_LE, hdev) ||
-		pending_find(MGMT_OP_ADD_EXT_ADV_PARAMS, hdev) ||
-		pending_find(MGMT_OP_ADD_EXT_ADV_DATA, hdev));
+	return (pending_find(MGMT_OP_SET_LE, hdev));
 }
 
 static void add_adv_complete(struct hci_dev *hdev, struct sock *sk, u8 instance,
@@ -8567,9 +8573,7 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
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

