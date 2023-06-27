Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4922EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 22:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjF0W7W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 18:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjF0W7U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 18:59:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4273B2947
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 15:59:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b80512a7f2so19153255ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 15:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687906757; x=1690498757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CsY2ZNtyO5jvicCTrUb3iO/cDNiJUugZM0W2hZTnmpc=;
        b=eBVZe7vWV37XYTPFF23iIohs+uHfbDOfYGBuS/R5Ni0Bts4Qq9YzL8JKju/6tF6HPa
         NWyQwHc5IhsHBXn8ckCigx35OHj8bNrutyVb5Z9QdPASoH7rpnDm8UGriOVMNUdMDaWc
         UQ4DCtM0JANO8BTSqUiB8mvhUeslzC5x/WtMSmOmI7pXl/Lmjl2FRKBL56ZbqoGigw4r
         7R+FqfU5xpxCDviDMKg8ip5IuNb+kJRV6xU9kqK2O8BuJFuG/Ctp8/9Nj3V5w9/fQ4px
         pLL9WEMcodhZNYIePv3bJdnaSntT4L5feYUXFzaXC0Mx2dXfmjZmQ+ZXGIiFRKa3M5+3
         7Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687906757; x=1690498757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CsY2ZNtyO5jvicCTrUb3iO/cDNiJUugZM0W2hZTnmpc=;
        b=EQ6D+fMZkQftaCIBFKuz1kLs8R3EdIAUbSgacy185g+/OCUWklTx4yAqUt4kCSNvt+
         nmaxsfkMQeCYgbIdtWkRfa3DgxTDsehcwxuNsLCz7hLlhrFZwV8LY58IukiIV67UD1FA
         kfVOI7Qc4Ns0IVgAPvrLPtSNdIXPjgwE64zxQejRzK0CHIEETZpq1aS0SI72IsLJmMJ6
         See3N0FJLkDZNmZFcVUEr0uddSk25rkGjCjzmyM2yyJMa8JQk47/U63AWQVXFgT2TgoW
         LT6Da4rAYpqwS9wYFdm76THXH9IIk+n058/oIeXZrwTohOraXQPbdFYhLewLm93JBdRE
         LZxQ==
X-Gm-Message-State: AC+VfDxol8Gri+DU+VFxzRpbx2J/l5oFvj+iA8PJdunLcZf57iTsCES2
        8761a8eCFsJZj8oPzvnCnUxEntmsfL9m/Q==
X-Google-Smtp-Source: ACHHUZ5vbtDaRZhaFhCWyvSSm1By/dD3oUubvVFfKZ6s/vPuKe1vkeSpZ1nuhXgm6P53TxWq6+RbHA==
X-Received: by 2002:a17:903:11ce:b0:1a6:74f6:fa92 with SMTP id q14-20020a17090311ce00b001a674f6fa92mr9877672plh.19.1687906757317;
        Tue, 27 Jun 2023 15:59:17 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001b1a2bf5277sm259290plb.39.2023.06.27.15.59.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 15:59:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_conn: Consolidate code for aborting connections
Date:   Tue, 27 Jun 2023 15:59:14 -0700
Message-Id: <20230627225915.2674812-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This consolidates code for aborting connections using
hci_cmd_sync_queue so it is synchronized with other threads, but
because of the fact that some commands may block the cmd_sync_queue
while waiting specific events this attempt to cancel those requests by
using hci_cmd_sync_cancel.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |   2 +-
 net/bluetooth/hci_conn.c         | 160 +++++++------------------------
 net/bluetooth/hci_sync.c         |  20 ++--
 net/bluetooth/mgmt.c             |  15 +--
 4 files changed, 48 insertions(+), 149 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 05a9b3ab3f56..094ca3aca15e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -741,6 +741,7 @@ struct hci_conn {
 	unsigned long	flags;
 
 	enum conn_reasons conn_reason;
+	__u8		abort_reason;
 
 	__u32		clock;
 	__u16		clock_accuracy;
@@ -760,7 +761,6 @@ struct hci_conn {
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
 	struct delayed_work le_conn_timeout;
-	struct work_struct  le_scan_cleanup;
 
 	struct device	dev;
 	struct dentry	*debugfs;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 47e7aa4d63a9..88f18f375684 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -178,57 +178,6 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 	hci_conn_put(conn);
 }
 
-static void le_scan_cleanup(struct work_struct *work)
-{
-	struct hci_conn *conn = container_of(work, struct hci_conn,
-					     le_scan_cleanup);
-	struct hci_dev *hdev = conn->hdev;
-	struct hci_conn *c = NULL;
-
-	BT_DBG("%s hcon %p", hdev->name, conn);
-
-	hci_dev_lock(hdev);
-
-	/* Check that the hci_conn is still around */
-	rcu_read_lock();
-	list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
-		if (c == conn)
-			break;
-	}
-	rcu_read_unlock();
-
-	if (c == conn) {
-		hci_connect_le_scan_cleanup(conn, 0x00);
-		hci_conn_cleanup(conn);
-	}
-
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-	hci_conn_put(conn);
-}
-
-static void hci_connect_le_scan_remove(struct hci_conn *conn)
-{
-	BT_DBG("%s hcon %p", conn->hdev->name, conn);
-
-	/* We can't call hci_conn_del/hci_conn_cleanup here since that
-	 * could deadlock with another hci_conn_del() call that's holding
-	 * hci_dev_lock and doing cancel_delayed_work_sync(&conn->disc_work).
-	 * Instead, grab temporary extra references to the hci_dev and
-	 * hci_conn and perform the necessary cleanup in a separate work
-	 * callback.
-	 */
-
-	hci_dev_hold(conn->hdev);
-	hci_conn_get(conn);
-
-	/* Even though we hold a reference to the hdev, many other
-	 * things might get cleaned up meanwhile, including the hdev's
-	 * own workqueue, so we can't use that for scheduling.
-	 */
-	schedule_work(&conn->le_scan_cleanup);
-}
-
 static void hci_acl_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -679,13 +628,6 @@ static void hci_conn_timeout(struct work_struct *work)
 	if (refcnt > 0)
 		return;
 
-	/* LE connections in scanning state need special handling */
-	if (conn->state == BT_CONNECT && conn->type == LE_LINK &&
-	    test_bit(HCI_CONN_SCANNING, &conn->flags)) {
-		hci_connect_le_scan_remove(conn);
-		return;
-	}
-
 	hci_abort_conn(conn, hci_proto_disconn_ind(conn));
 }
 
@@ -1066,7 +1008,6 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
 	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
-	INIT_WORK(&conn->le_scan_cleanup, le_scan_cleanup);
 
 	atomic_set(&conn->refcnt, 0);
 
@@ -2888,81 +2829,46 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 	return phys;
 }
 
-int hci_abort_conn(struct hci_conn *conn, u8 reason)
+static int abort_conn_sync(struct hci_dev *hdev, void *data)
 {
-	int r = 0;
+	struct hci_conn *conn;
+	u16 handle = PTR_ERR(data);
 
-	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn)
 		return 0;
 
-	switch (conn->state) {
-	case BT_CONNECTED:
-	case BT_CONFIG:
-		if (conn->type == AMP_LINK) {
-			struct hci_cp_disconn_phy_link cp;
+	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
+}
 
-			cp.phy_handle = HCI_PHY_HANDLE(conn->handle);
-			cp.reason = reason;
-			r = hci_send_cmd(conn->hdev, HCI_OP_DISCONN_PHY_LINK,
-					 sizeof(cp), &cp);
-		} else {
-			struct hci_cp_disconnect dc;
+int hci_abort_conn(struct hci_conn *conn, u8 reason)
+{
+	struct hci_dev *hdev = conn->hdev;
 
-			dc.handle = cpu_to_le16(conn->handle);
-			dc.reason = reason;
-			r = hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT,
-					 sizeof(dc), &dc);
+	/* If abort_reason has already been set it means the connection is
+	 * already being aborted so don't attempt to overwrite it.
+	 */
+	if (conn->abort_reason)
+		return 0;
+
+	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
+
+	conn->abort_reason = reason;
+
+	/* If the connection is pending check the command opcode since that
+	 * might be blocking on hci_cmd_sync_work while waiting its respective
+	 * event so we need to hci_cmd_sync_cancel to cancel it.
+	 */
+	if (conn->state == BT_CONNECT && hdev->req_status == HCI_REQ_PEND) {
+		switch (hci_skb_event(hdev->sent_cmd)) {
+		case HCI_EV_LE_CONN_COMPLETE:
+		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
+		case HCI_EVT_LE_CIS_ESTABLISHED:
+			hci_cmd_sync_cancel(hdev, -ECANCELED);
+			break;
 		}
-
-		conn->state = BT_DISCONN;
-
-		break;
-	case BT_CONNECT:
-		if (conn->type == LE_LINK) {
-			if (test_bit(HCI_CONN_SCANNING, &conn->flags))
-				break;
-			r = hci_send_cmd(conn->hdev,
-					 HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
-		} else if (conn->type == ACL_LINK) {
-			if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
-				break;
-			r = hci_send_cmd(conn->hdev,
-					 HCI_OP_CREATE_CONN_CANCEL,
-					 6, &conn->dst);
-		}
-		break;
-	case BT_CONNECT2:
-		if (conn->type == ACL_LINK) {
-			struct hci_cp_reject_conn_req rej;
-
-			bacpy(&rej.bdaddr, &conn->dst);
-			rej.reason = reason;
-
-			r = hci_send_cmd(conn->hdev,
-					 HCI_OP_REJECT_CONN_REQ,
-					 sizeof(rej), &rej);
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
-			r = hci_send_cmd(conn->hdev,
-					 HCI_OP_REJECT_SYNC_CONN_REQ,
-					 sizeof(rej), &rej);
-		}
-		break;
-	default:
-		conn->state = BT_CLOSED;
-		break;
 	}
 
-	return r;
+	return hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
+				  NULL);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index afb8e970e62c..ef8297d04a8c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5271,10 +5271,13 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 }
 
 static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
-				      struct hci_conn *conn)
+				      struct hci_conn *conn, u8 reason)
 {
+	/* Return reason if scanning since the connection shall probably be
+	 * cleanup directly.
+	 */
 	if (test_bit(HCI_CONN_SCANNING, &conn->flags))
-		return 0;
+		return reason;
 
 	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
 		return 0;
@@ -5283,10 +5286,11 @@ static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
 
-static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn)
+static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
+				   u8 reason)
 {
 	if (conn->type == LE_LINK)
-		return hci_le_connect_cancel_sync(hdev, conn);
+		return hci_le_connect_cancel_sync(hdev, conn, reason);
 
 	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return 0;
@@ -5339,9 +5343,11 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	case BT_CONFIG:
 		return hci_disconnect_sync(hdev, conn, reason);
 	case BT_CONNECT:
-		err = hci_connect_cancel_sync(hdev, conn);
+		err = hci_connect_cancel_sync(hdev, conn, reason);
 		/* Cleanup hci_conn object if it cannot be cancelled as it
-		 * likelly means the controller and host stack are out of sync.
+		 * likelly means the controller and host stack are out of sync
+		 * or in case of LE it was still scanning so it can be cleanup
+		 * safely.
 		 */
 		if (err) {
 			hci_dev_lock(hdev);
@@ -6255,7 +6261,7 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 
 done:
 	if (err == -ETIMEDOUT)
-		hci_le_connect_cancel_sync(hdev, conn);
+		hci_le_connect_cancel_sync(hdev, conn, 0x00);
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0f5ba618ceb1..3156bc27088e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3586,18 +3586,6 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
-static int abort_conn_sync(struct hci_dev *hdev, void *data)
-{
-	struct hci_conn *conn;
-	u16 handle = PTR_ERR(data);
-
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		return 0;
-
-	return hci_abort_conn_sync(hdev, conn, HCI_ERROR_REMOTE_USER_TERM);
-}
-
 static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 			      u16 len)
 {
@@ -3648,8 +3636,7 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 					      le_addr_type(addr->type));
 
 	if (conn->conn_reason == CONN_REASON_PAIR_DEVICE)
-		hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
-				   NULL);
+		hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.40.1

