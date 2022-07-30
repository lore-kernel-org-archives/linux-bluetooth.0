Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B18EC25B06
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jul 2022 00:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbiG3Au7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 20:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiG3Auz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 20:50:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923A77392A
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 17:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659142254; x=1690678254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4YptWyqVFSTPwIPEGSBEq9FlJSIeISKSP8lD74P7k50=;
  b=ROB6T/k9BdfatHl/VuJDEHmwolXVGif1hxdfSzs0yQgidKUgunXv5jdw
   wJB9ycpT/urZdSVVwCqku/cSwIUJFdU3cLH1SIqZOBiZ2sBttlC1XFX+K
   TRIFiXm6vASS9qFF3DwknQSCAodtJxI69ia2dLFpG7dTY6kSMly7SXVvB
   8js06HZtIdr7W1OlG8D67xVE36GN7MO9jNYHW8op/AHGViwCjwW2wo56Z
   TtVQt0O14jJToN54MulCb1T+mL9hkE++DtopsD5XnVcofP8lvQhgVGHKW
   sLAvicEpxgORbliW57NoIZ5zSVCS3Sc+mTb6j4MwpkZ/iPkvGYzzf2udI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268644799"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="268644799"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="660458139"
Received: from agcodina-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.26.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:51 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v5 10/10] Bluetooth: Convert hci_abort_conn to hci_sync
Date:   Fri, 29 Jul 2022 17:50:38 -0700
Message-Id: <20220730005038.894650-11-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220730005038.894650-1-brian.gix@intel.com>
References: <20220730005038.894650-1-brian.gix@intel.com>
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
 net/bluetooth/hci_request.c      |  93 ----------------------
 net/bluetooth/hci_request.h      |   2 -
 net/bluetooth/hci_sync.c         | 127 +++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 95 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 17f5a4c32f36..1f5784da98e6 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -129,3 +129,4 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason);
 int hci_le_big_terminate_sync(struct hci_dev *hdev, u8 handle);
 
 int hci_le_pa_terminate_sync(struct hci_dev *hdev, u16 handle);
+int hci_abort_conn(struct hci_conn *conn, u8 reason);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index c6bfb2e75e52..064026bb6162 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -272,96 +272,3 @@ void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
 	bt_dev_dbg(req->hdev, "HCI_REQ-0x%4.4x", opcode);
 	hci_req_add_ev(req, opcode, plen, param, 0);
 }
-
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
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index e5ecd4e4b686..763a9e6db976 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -67,5 +67,3 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param);
-
-int hci_abort_conn(struct hci_conn *conn, u8 reason);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 280f0fcfdedc..39adeddbb39f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6140,3 +6140,130 @@ int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
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
+int hci_abort_conn(struct hci_conn *conn, u8 reason)
+{
+	struct conn_reason *conn_reason = kmalloc(sizeof(struct conn_reason),
+						  GFP_KERNEL);
+	int err;
+
+
+	if ( !conn_reason)
+		return -ENOMEM;
+
+	conn_reason->conn = conn;
+	conn_reason->reason = reason;
+
+	err = hci_cmd_sync_queue(conn->hdev, _abort_conn_sync, conn_reason,
+				 abort_conn_complete);
+
+	if (err)
+		kfree(conn_reason);
+
+	if (err && err != -ENODATA) {
+		bt_dev_err(conn->hdev, "failed to run HCI req: err %d", err);
+		return err;
+	}
+
+	return 0;
+}
-- 
2.37.1

