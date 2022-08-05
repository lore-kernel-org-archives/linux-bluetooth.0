Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9498C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 23:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbiHEXm7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 19:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241720AbiHEXmx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 19:42:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86E7B1DF
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659742972; x=1691278972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NUZFBt74j2z4Quw/YCg9EnmKuKWra+kv898DJpYT0Uc=;
  b=RVM9qMJZ0ujnVjv099y6zN3dlDCl20+8QTLEMHkHtS2cWGtvA+MNxFd2
   x5IB3Quho30tgSD7Nrqc8xUkDh8Eaj3F7ejXrrBkVf9g1br23B3kJEqGN
   B5J7qhT7LPdmZw9F/uL92t+hCqbAfR1rOZunVbiJcsYh0NSsMDnee1hXI
   nhj4EM6NzOy1ho0Yp+tFkC4y27mZzmPN02sOzSCOnXilMW29t8nt2Tuot
   Z8suQ+TlsM/u77vaTQuIY4jVP2++eHIezEJjzOcIuoN0OZTephl/NcF5c
   pUcJCER8szS7AUozhohuXbR4lT0SljnL/cK0laAJNcx/pbkWUsMRdvxLM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="273362757"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="273362757"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636661832"
Received: from bkkx-mobl.gar.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.189.232])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v7 9/9] Bluetooth: Convert hci_abort_conn to hci_sync
Date:   Fri,  5 Aug 2022 16:42:36 -0700
Message-Id: <20220805234236.704986-10-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805234236.704986-1-brian.gix@intel.com>
References: <20220805234236.704986-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The prior hci_abort_conn() used the deprecated hci_request mechanism.
This version has been rewritten to use hci_sync.c

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |   1 +
 net/bluetooth/hci_conn.c         |   6 +-
 net/bluetooth/hci_request.c      |  93 ----------------------
 net/bluetooth/hci_request.h      |   1 -
 net/bluetooth/hci_sync.c         | 130 +++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |   2 +-
 6 files changed, 135 insertions(+), 98 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 17f5a4c32f36..1816222c8fbc 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -129,3 +129,4 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason);
 int hci_le_big_terminate_sync(struct hci_dev *hdev, u8 handle);
 
 int hci_le_pa_terminate_sync(struct hci_dev *hdev, u16 handle);
+int hci_abort_conn(struct hci_conn *conn, u8 reason, bool async);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 337e74d0f8b1..e61cb5aa3eb1 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -286,7 +286,7 @@ int hci_disconnect(struct hci_conn *conn, __u8 reason)
 			     &clkoff_cp);
 	}
 
-	return hci_abort_conn(conn, reason);
+	return hci_abort_conn(conn, reason, true);
 }
 
 static void hci_add_sco(struct hci_conn *conn, __u16 handle)
@@ -662,7 +662,7 @@ static void hci_conn_timeout(struct work_struct *work)
 		return;
 	}
 
-	hci_abort_conn(conn, hci_proto_disconn_ind(conn));
+	hci_abort_conn(conn, hci_proto_disconn_ind(conn), false);
 }
 
 /* Enter sniff mode */
@@ -748,7 +748,7 @@ static void le_conn_timeout(struct work_struct *work)
 		return;
 	}
 
-	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM, false);
 }
 
 struct iso_list_data {
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
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6de2ad730995..0523e60a379b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6085,3 +6085,133 @@ int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
 	*inst_ptr = instance;
 	return hci_cmd_sync_queue(hdev, _update_adv_data_sync, inst_ptr, NULL);
 }
+
+struct conn_reason {
+	struct hci_conn *conn;
+	u8 reason;
+};
+
+static int _abort_conn_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_conn *conn = ((struct conn_reason *)data)->conn;
+	u8 reason = ((struct conn_reason *)data)->reason;
+	int err = 0;
+
+	kfree(data);
+
+	switch (conn->state) {
+	case BT_CONNECTED:
+	case BT_CONFIG:
+		if (conn->type == AMP_LINK) {
+			struct hci_cp_disconn_phy_link cp;
+
+			cp.phy_handle = HCI_PHY_HANDLE(conn->handle);
+			cp.reason = reason;
+			err = __hci_cmd_sync_status(hdev,
+						    HCI_OP_DISCONN_PHY_LINK,
+						    sizeof(cp), &cp,
+						    HCI_CMD_TIMEOUT);
+		} else {
+			struct hci_cp_disconnect dc;
+
+			dc.handle = cpu_to_le16(conn->handle);
+			dc.reason = reason;
+			err = __hci_cmd_sync_status(hdev,
+						    HCI_OP_DISCONNECT,
+						    sizeof(dc), &dc,
+						    HCI_CMD_TIMEOUT);
+		}
+		conn->state = BT_DISCONN;
+		break;
+	case BT_CONNECT:
+		if (conn->type == LE_LINK) {
+			if (test_bit(HCI_CONN_SCANNING, &conn->flags))
+				break;
+
+			err = __hci_cmd_sync_status(hdev,
+						    HCI_OP_LE_CREATE_CONN_CANCEL,
+						    0, NULL, HCI_CMD_TIMEOUT);
+		} else if (conn->type == ACL_LINK) {
+			if (hdev->hci_ver < BLUETOOTH_VER_1_2)
+				break;
+
+			err = __hci_cmd_sync_status(hdev,
+						    HCI_OP_CREATE_CONN_CANCEL,
+						    6, &conn->dst,
+						    HCI_CMD_TIMEOUT);
+		}
+		break;
+	case BT_CONNECT2:
+		if (conn->type == ACL_LINK) {
+			struct hci_cp_reject_conn_req rej;
+
+			bacpy(&rej.bdaddr, &conn->dst);
+			rej.reason = reason;
+
+			err = __hci_cmd_sync_status(hdev,
+						    HCI_OP_REJECT_CONN_REQ,
+						    sizeof(rej), &rej,
+						    HCI_CMD_TIMEOUT);
+
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
+			err = __hci_cmd_sync_status(hdev,
+						    HCI_OP_REJECT_SYNC_CONN_REQ,
+						    sizeof(rej), &rej,
+						    HCI_CMD_TIMEOUT);
+		}
+		break;
+	default:
+		conn->state = BT_CLOSED;
+		break;
+	}
+
+	return err;
+}
+
+static void abort_conn_complete(struct hci_dev *hdev, void *data, int err)
+{
+	if (err)
+		bt_dev_dbg(hdev, "Failed to abort connection: err %d", err);
+}
+
+int hci_abort_conn(struct hci_conn *conn, u8 reason, bool async)
+{
+	struct conn_reason *conn_reason = kmalloc(sizeof(*conn_reason),
+						  GFP_KERNEL);
+	int err;
+
+	if (!conn_reason)
+		return -ENOMEM;
+
+	conn_reason->conn = conn;
+	conn_reason->reason = reason;
+
+	if (async) {
+		err = hci_cmd_sync_queue(conn->hdev, _abort_conn_sync,
+					 conn_reason, abort_conn_complete);
+
+		if (err)
+			kfree(conn_reason);
+	} else {
+		err = _abort_conn_sync(conn->hdev, conn_reason);
+	}
+
+	if (err && err != -ENODATA) {
+		bt_dev_err(conn->hdev, "failed to run HCI req: err %d", err);
+		return err;
+	}
+
+	return 0;
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 11eb6e538518..a63c778d18f1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3235,7 +3235,7 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 					      le_addr_type(addr->type));
 
 	if (conn->conn_reason == CONN_REASON_PAIR_DEVICE)
-		hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+		hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM, true);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.37.1

