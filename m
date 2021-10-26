Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB436C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B973D610A6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbhJZXGC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240177AbhJZXF7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:05:59 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB44C061767
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f5so970031pgc.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3Qe7MEkWF3UTQoJXFglGsHmhQjk1XTTmdIUqSlTYk34=;
        b=euvgybjTaJ2m2OiZf7Bn45H5CdIrGyivV6K2BEm47DOiz2uSgcZ2mD7aCAcgD5G1fC
         rjTJxIdExAjzkcKL+wUDal27cmzlQbLf9CLuKY/CliBHYmOLVDohXk25suHDOsEWGxSf
         vtz5A31cGUd8aJwoKdkcFS+WsOcZW82stmd40hpETZppuXOciyH7gKeStUdbcBVhQ2ml
         f0XO96Cv0SVpkmENlHjl18Nyr2Ijcls45SpmVRWxK8ilQB18oDk5Ae4UPE7a7tfmVhol
         apvsHNi1xRc9jBu3XPzufhwNK+Xr1txrw0Lma2Mdtr3PtjBqnqzlhqq8a3it0Wky+JEH
         kHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Qe7MEkWF3UTQoJXFglGsHmhQjk1XTTmdIUqSlTYk34=;
        b=6th7T1RyErvdPGGslEgLF7m5U5XDFMyGGSJ9dG2Pd4GzpZMtr84xI35oR9tUN/sAmt
         4Jbbym+QgNkxkbnknivpdForuleITd1XspFVXxRBbJl3zVY551Bl2cfEw95kDR+9THKi
         R/rLSPbiQcw2aMDZ0TBv6l8Gj6wOsPJm0grlApP/XIzU/BYmbAreCLwqepo076nmBOu+
         r8upnigRB+hxdSX9GiVILVsnq1csP2S4Ev6FEXq74yD/ViDFNOrIUHmrg9Uo++wZxE2c
         MUwWY786dcLI5mSyNJ+SxO6XMuJ2mO9a0a730aKdz3S/ZfSRTG2ZKn+JOlbm585VJT8e
         7HWg==
X-Gm-Message-State: AOAM533Qs8adqdDztFVFjulBnqExupznN3vCHHh4233sn9ZezOn5VjYz
        Hm1p/+ySu5134xyffyT9V52PXUaniF4=
X-Google-Smtp-Source: ABdhPJwYOenh48eQP14KLGM/ZThP1bDXxvkvR/eJixPoCP1KVIrSuMe0W8/W5cd0yVNApcgsjP56XQ==
X-Received: by 2002:a63:b958:: with SMTP id v24mr13359325pgo.114.1635289414310;
        Tue, 26 Oct 2021 16:03:34 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 11/23] Bluetooth: hci_sync: Convert MGMT_OP_GET_CONN_INFO
Date:   Tue, 26 Oct 2021 16:03:12 -0700
Message-Id: <20211026230324.1533907-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

Synchronous version of MGMT_OP_GET_CONN_INFO

Implements:
	hci_read_rssi_sync
	hci_read_tx_power_sync

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |   2 +
 net/bluetooth/hci_sync.c         |  19 ++++
 net/bluetooth/mgmt.c             | 148 ++++++++++++-------------------
 3 files changed, 79 insertions(+), 90 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 03ffe95415fc..156cb5faf64f 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -67,6 +67,8 @@ int hci_disable_advertising_sync(struct hci_dev *hdev);
 
 int hci_update_passive_scan_sync(struct hci_dev *hdev);
 int hci_update_passive_scan(struct hci_dev *hdev);
+int hci_read_rssi_sync(struct hci_dev *hdev, __le16 handle);
+int hci_read_tx_power_sync(struct hci_dev *hdev, __le16 handle, u8 type);
 
 int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable);
 int hci_update_scan_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1fccab8bf01b..4e4bb1b4c71c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1309,6 +1309,25 @@ int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 	return 0;
 }
 
+int hci_read_rssi_sync(struct hci_dev *hdev, __le16 handle)
+{
+	struct hci_cp_read_rssi cp;
+
+	cp.handle = handle;
+	return __hci_cmd_sync_status(hdev, HCI_OP_READ_RSSI,
+					sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+int hci_read_tx_power_sync(struct hci_dev *hdev, __le16 handle, u8 type)
+{
+	struct hci_cp_read_tx_power cp;
+
+	cp.handle = handle;
+	cp.type = type;
+	return __hci_cmd_sync_status(hdev, HCI_OP_READ_TX_POWER,
+					sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
 int hci_disable_advertising_sync(struct hci_dev *hdev)
 {
 	u8 enable = 0x00;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f49efa1a428e..39bf1a7dd0a5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5942,7 +5942,6 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 		mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				MGMT_STATUS_FAILED);
 
-
 		if (cmd)
 			mgmt_pending_free(cmd);
 	}
@@ -6534,14 +6533,19 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static int conn_info_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
+static void get_conn_info_complete(struct hci_dev *hdev, void *data, int err)
 {
+	struct mgmt_pending_cmd *cmd = data;
 	struct hci_conn *conn = cmd->user_data;
+	struct mgmt_cp_get_conn_info *cp = cmd->param;
 	struct mgmt_rp_get_conn_info rp;
-	int err;
+	u8 status;
 
-	memcpy(&rp.addr, cmd->param, sizeof(rp.addr));
+	bt_dev_dbg(hdev, "err %d", err);
 
+	memcpy(&rp.addr, &cp->addr.bdaddr, sizeof(rp.addr));
+
+	status = mgmt_status(err);
 	if (status == MGMT_STATUS_SUCCESS) {
 		rp.rssi = conn->rssi;
 		rp.tx_power = conn->tx_power;
@@ -6552,67 +6556,58 @@ static int conn_info_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
 		rp.max_tx_power = HCI_TX_POWER_INVALID;
 	}
 
-	err = mgmt_cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO,
-				status, &rp, sizeof(rp));
+	mgmt_cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO, status,
+			  &rp, sizeof(rp));
 
-	hci_conn_drop(conn);
-	hci_conn_put(conn);
+	if (conn) {
+		hci_conn_drop(conn);
+		hci_conn_put(conn);
+	}
 
-	return err;
+	mgmt_pending_free(cmd);
 }
 
-static void conn_info_refresh_complete(struct hci_dev *hdev, u8 hci_status,
-				       u16 opcode)
+static int get_conn_info_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_cp_read_rssi *cp;
-	struct mgmt_pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_get_conn_info *cp = cmd->param;
 	struct hci_conn *conn;
-	u16 handle;
-	u8 status;
-
-	bt_dev_dbg(hdev, "status 0x%02x", hci_status);
+	int err;
+	__le16   handle;
 
-	hci_dev_lock(hdev);
+	/* Make sure we are still connected */
+	if (cp->addr.type == BDADDR_BREDR)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+					       &cp->addr.bdaddr);
+	else
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
 
-	/* Commands sent in request are either Read RSSI or Read Transmit Power
-	 * Level so we check which one was last sent to retrieve connection
-	 * handle.  Both commands have handle as first parameter so it's safe to
-	 * cast data on the same command struct.
-	 *
-	 * First command sent is always Read RSSI and we fail only if it fails.
-	 * In other case we simply override error to indicate success as we
-	 * already remembered if TX power value is actually valid.
-	 */
-	cp = hci_sent_cmd_data(hdev, HCI_OP_READ_RSSI);
-	if (!cp) {
-		cp = hci_sent_cmd_data(hdev, HCI_OP_READ_TX_POWER);
-		status = MGMT_STATUS_SUCCESS;
-	} else {
-		status = mgmt_status(hci_status);
+	if (!conn || conn != cmd->user_data || conn->state != BT_CONNECTED) {
+		if (cmd->user_data) {
+			hci_conn_drop(cmd->user_data);
+			hci_conn_put(cmd->user_data);
+			cmd->user_data = NULL;
+		}
+		return MGMT_STATUS_NOT_CONNECTED;
 	}
 
-	if (!cp) {
-		bt_dev_err(hdev, "invalid sent_cmd in conn_info response");
-		goto unlock;
-	}
+	handle = cpu_to_le16(conn->handle);
 
-	handle = __le16_to_cpu(cp->handle);
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn) {
-		bt_dev_err(hdev, "unknown handle (%u) in conn_info response",
-			   handle);
-		goto unlock;
-	}
+	/* Refresh RSSI each time */
+	err = hci_read_rssi_sync(hdev, handle);
 
-	cmd = pending_find_data(MGMT_OP_GET_CONN_INFO, hdev, conn);
-	if (!cmd)
-		goto unlock;
+	/* For LE links TX power does not change thus we don't need to
+	 * query for it once value is known.
+	 */
+	if (!err && (!bdaddr_type_is_le(cp->addr.type) ||
+				conn->tx_power == HCI_TX_POWER_INVALID))
+		err = hci_read_tx_power_sync(hdev, handle, 0x00);
 
-	cmd->cmd_complete(cmd, status);
-	mgmt_pending_remove(cmd);
+	/* Max TX power needs to be read only once per connection */
+	if (!err && conn->max_tx_power == HCI_TX_POWER_INVALID)
+		err = hci_read_tx_power_sync(hdev, handle, 0x01);
 
-unlock:
-	hci_dev_unlock(hdev);
+	return err;
 }
 
 static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -6657,12 +6652,6 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (pending_find_data(MGMT_OP_GET_CONN_INFO, hdev, conn)) {
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
-					MGMT_STATUS_BUSY, &rp, sizeof(rp));
-		goto unlock;
-	}
-
 	/* To avoid client trying to guess when to poll again for information we
 	 * calculate conn info age as random value between min/max set in hdev.
 	 */
@@ -6676,49 +6665,28 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (time_after(jiffies, conn->conn_info_timestamp +
 		       msecs_to_jiffies(conn_info_age)) ||
 	    !conn->conn_info_timestamp) {
-		struct hci_request req;
-		struct hci_cp_read_tx_power req_txp_cp;
-		struct hci_cp_read_rssi req_rssi_cp;
 		struct mgmt_pending_cmd *cmd;
 
-		hci_req_init(&req, hdev);
-		req_rssi_cp.handle = cpu_to_le16(conn->handle);
-		hci_req_add(&req, HCI_OP_READ_RSSI, sizeof(req_rssi_cp),
-			    &req_rssi_cp);
-
-		/* For LE links TX power does not change thus we don't need to
-		 * query for it once value is known.
-		 */
-		if (!bdaddr_type_is_le(cp->addr.type) ||
-		    conn->tx_power == HCI_TX_POWER_INVALID) {
-			req_txp_cp.handle = cpu_to_le16(conn->handle);
-			req_txp_cp.type = 0x00;
-			hci_req_add(&req, HCI_OP_READ_TX_POWER,
-				    sizeof(req_txp_cp), &req_txp_cp);
-		}
+		cmd = mgmt_pending_new(sk, MGMT_OP_GET_CONN_INFO, hdev, data,
+				       len);
+		if (!cmd)
+			err = -ENOMEM;
+		else
+			err = hci_cmd_sync_queue(hdev, get_conn_info_sync,
+						 cmd, get_conn_info_complete);
 
-		/* Max TX power needs to be read only once per connection */
-		if (conn->max_tx_power == HCI_TX_POWER_INVALID) {
-			req_txp_cp.handle = cpu_to_le16(conn->handle);
-			req_txp_cp.type = 0x01;
-			hci_req_add(&req, HCI_OP_READ_TX_POWER,
-				    sizeof(req_txp_cp), &req_txp_cp);
-		}
+		if (err < 0) {
+			mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
+					  MGMT_STATUS_FAILED, &rp, sizeof(rp));
 
-		err = hci_req_run(&req, conn_info_refresh_complete);
-		if (err < 0)
-			goto unlock;
+			if (cmd)
+				mgmt_pending_free(cmd);
 
-		cmd = mgmt_pending_add(sk, MGMT_OP_GET_CONN_INFO, hdev,
-				       data, len);
-		if (!cmd) {
-			err = -ENOMEM;
 			goto unlock;
 		}
 
 		hci_conn_hold(conn);
 		cmd->user_data = hci_conn_get(conn);
-		cmd->cmd_complete = conn_info_cmd_complete;
 
 		conn->conn_info_timestamp = jiffies;
 	} else {
-- 
2.31.1

