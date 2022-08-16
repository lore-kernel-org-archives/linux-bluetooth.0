Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B1EC25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 16:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiHPQlb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbiHPQl3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 12:41:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A05580B62
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660668088; x=1692204088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t6zd7n7yQM/V1IMZ1iCrom2nG863rKcjK8rgyA4QcH4=;
  b=TpmXlfEI01q9KAOc+9mouWfRtyaykjBxNwHMaU8te8p1gFImiTaS0ij9
   I5qiqdVuiwACBqx6ZID6RqaKaaYVrOh8dJnkEgX3jE+vTVWyMjFoZXI4F
   KjeNMlx/S1JE2g+faxSBntL3k4DiWEVf7kpsP1eePU0t9AuxwzV/dKTaA
   nr5I8JsOV1fLoF6GS/GIUiZ2hqQ1OdwvC5e6yS3SSIX6NyktHOIjqyIE4
   hZKnleCDVfBSvhkoqGjilelDAcU7NoG5Xueq6f7mFbA1vcp6BITGJOdRE
   p20L8Q64eoeHNTKJJWlpv4JcqFiVZdopKu/0z0CWcFhgyUi3BKjFHHn6s
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="354015134"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="354015134"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 09:41:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="733358663"
Received: from frperuch-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.23.122])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 09:41:27 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v3] Bluetooth: Move hci_abort_conn to hci_conn.c
Date:   Tue, 16 Aug 2022 09:41:20 -0700
Message-Id: <20220816164120.1002822-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hci_abort_conn() is a wrapper around a number of DISCONNECT and
CREATE_CONN_CANCEL commands that was being invoked from hci_request
request queues, which are now deprecated. There are two versions:
hci_abort_conn() which can be invoked from the hci_event thread, and
hci_abort_conn_sync() which can be invoked within a hci_sync cmd chain.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 76 ++++++++++++++++++++++++++
 net/bluetooth/hci_request.c      | 93 --------------------------------
 net/bluetooth/hci_request.h      |  1 -
 net/bluetooth/mgmt.c             | 16 +++++-
 5 files changed, 92 insertions(+), 95 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e7862903187d..932153e68864 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2075,6 +2075,7 @@ int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip);
 void mgmt_adv_monitor_device_lost(struct hci_dev *hdev, u16 handle,
 				  bdaddr_t *bdaddr, u8 addr_type);
 
+int hci_abort_conn(struct hci_conn *conn, u8 reason);
 u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 337e74d0f8b1..7a59c4487050 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2760,3 +2760,79 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 
 	return phys;
 }
+
+int hci_abort_conn(struct hci_conn *conn, u8 reason)
+{
+	int r = 0;
+
+	switch (conn->state) {
+	case BT_CONNECTED:
+	case BT_CONFIG:
+		if (conn->type == AMP_LINK) {
+			struct hci_cp_disconn_phy_link cp;
+
+			cp.phy_handle = HCI_PHY_HANDLE(conn->handle);
+			cp.reason = reason;
+			r = hci_send_cmd(conn->hdev, HCI_OP_DISCONN_PHY_LINK,
+					 sizeof(cp), &cp);
+		} else {
+			struct hci_cp_disconnect dc;
+
+			dc.handle = cpu_to_le16(conn->handle);
+			dc.reason = reason;
+			r = hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT,
+					 sizeof(dc), &dc);
+		}
+
+		conn->state = BT_DISCONN;
+
+		break;
+	case BT_CONNECT:
+		if (conn->type == LE_LINK) {
+			if (test_bit(HCI_CONN_SCANNING, &conn->flags))
+				break;
+			r = hci_send_cmd(conn->hdev,
+					 HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
+		} else if (conn->type == ACL_LINK) {
+			if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
+				break;
+			r = hci_send_cmd(conn->hdev,
+					 HCI_OP_CREATE_CONN_CANCEL,
+					 6, &conn->dst);
+		}
+		break;
+	case BT_CONNECT2:
+		if (conn->type == ACL_LINK) {
+			struct hci_cp_reject_conn_req rej;
+
+			bacpy(&rej.bdaddr, &conn->dst);
+			rej.reason = reason;
+
+			r = hci_send_cmd(conn->hdev,
+					 HCI_OP_REJECT_CONN_REQ,
+					 sizeof(rej), &rej);
+		} else if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
+			struct hci_cp_reject_sync_conn_req rej;
+
+			bacpy(&rej.bdaddr, &conn->dst);
+
+			/* SCO rejection has its own limited set of
+			 * allowed error values (0x0D-0x0F) which isn't
+			 * compatible with most values passed to this
+			 * function. To be safe hard-code one of the
+			 * values that's suitable for SCO.
+			 */
+			rej.reason = HCI_ERROR_REJ_LIMITED_RESOURCES;
+
+			r = hci_send_cmd(conn->hdev,
+					 HCI_OP_REJECT_SYNC_CONN_REQ,
+					 sizeof(rej), &rej);
+		}
+		break;
+	default:
+		conn->state = BT_CLOSED;
+		break;
+	}
+
+	return r;
+}
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 2e19a271d7a1..5a0296a4352e 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -909,99 +909,6 @@ static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 	hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, rpa);
 }
 
-static void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
-			     u8 reason)
-{
-	switch (conn->state) {
-	case BT_CONNECTED:
-	case BT_CONFIG:
-		if (conn->type == AMP_LINK) {
-			struct hci_cp_disconn_phy_link cp;
-
-			cp.phy_handle = HCI_PHY_HANDLE(conn->handle);
-			cp.reason = reason;
-			hci_req_add(req, HCI_OP_DISCONN_PHY_LINK, sizeof(cp),
-				    &cp);
-		} else {
-			struct hci_cp_disconnect dc;
-
-			dc.handle = cpu_to_le16(conn->handle);
-			dc.reason = reason;
-			hci_req_add(req, HCI_OP_DISCONNECT, sizeof(dc), &dc);
-		}
-
-		conn->state = BT_DISCONN;
-
-		break;
-	case BT_CONNECT:
-		if (conn->type == LE_LINK) {
-			if (test_bit(HCI_CONN_SCANNING, &conn->flags))
-				break;
-			hci_req_add(req, HCI_OP_LE_CREATE_CONN_CANCEL,
-				    0, NULL);
-		} else if (conn->type == ACL_LINK) {
-			if (req->hdev->hci_ver < BLUETOOTH_VER_1_2)
-				break;
-			hci_req_add(req, HCI_OP_CREATE_CONN_CANCEL,
-				    6, &conn->dst);
-		}
-		break;
-	case BT_CONNECT2:
-		if (conn->type == ACL_LINK) {
-			struct hci_cp_reject_conn_req rej;
-
-			bacpy(&rej.bdaddr, &conn->dst);
-			rej.reason = reason;
-
-			hci_req_add(req, HCI_OP_REJECT_CONN_REQ,
-				    sizeof(rej), &rej);
-		} else if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
-			struct hci_cp_reject_sync_conn_req rej;
-
-			bacpy(&rej.bdaddr, &conn->dst);
-
-			/* SCO rejection has its own limited set of
-			 * allowed error values (0x0D-0x0F) which isn't
-			 * compatible with most values passed to this
-			 * function. To be safe hard-code one of the
-			 * values that's suitable for SCO.
-			 */
-			rej.reason = HCI_ERROR_REJ_LIMITED_RESOURCES;
-
-			hci_req_add(req, HCI_OP_REJECT_SYNC_CONN_REQ,
-				    sizeof(rej), &rej);
-		}
-		break;
-	default:
-		conn->state = BT_CLOSED;
-		break;
-	}
-}
-
-static void abort_conn_complete(struct hci_dev *hdev, u8 status, u16 opcode)
-{
-	if (status)
-		bt_dev_dbg(hdev, "Failed to abort connection: status 0x%2.2x", status);
-}
-
-int hci_abort_conn(struct hci_conn *conn, u8 reason)
-{
-	struct hci_request req;
-	int err;
-
-	hci_req_init(&req, conn->hdev);
-
-	__hci_abort_conn(&req, conn, reason);
-
-	err = hci_req_run(&req, abort_conn_complete);
-	if (err && err != -ENODATA) {
-		bt_dev_err(conn->hdev, "failed to run HCI request: err %d", err);
-		return err;
-	}
-
-	return 0;
-}
-
 void hci_request_setup(struct hci_dev *hdev)
 {
 	INIT_DELAYED_WORK(&hdev->interleave_scan, interleave_scan_work);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 7e1de871fca4..b9c5a9823837 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -73,6 +73,5 @@ void hci_req_add_le_passive_scan(struct hci_request *req);
 
 void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next);
 
-int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void hci_request_setup(struct hci_dev *hdev);
 void hci_request_cancel_all(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index df20e15a05da..407d7abd43d7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3185,6 +3185,19 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static int abort_conn_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_conn *conn;
+	u16 handle = (u16) PTR_ERR(data);
+
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+
+	if (!conn)
+		return 0;
+
+	return hci_abort_conn_sync(hdev, conn, HCI_ERROR_REMOTE_USER_TERM);
+}
+
 static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 			      u16 len)
 {
@@ -3235,7 +3248,8 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 					      le_addr_type(addr->type));
 
 	if (conn->conn_reason == CONN_REASON_PAIR_DEVICE)
-		hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+		hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
+				   NULL);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.37.1

