Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327D22127B
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Nov 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434469; cv=pass; b=qmfB8QhgWCOK4fWgS8znGZ7fOG9v4OHiG4EAulj8pxfM9pkETTq1eOFsq+uAnETff0+g2sMV7rnnxTkhXhH/q/jUTYMbCyRuHqHxOmJ+Bnx1gfam9xyuP2ARllJWPcmI05qWHkdq1doMTM9PKEp32SIeoNWfdcX8DC7a2WHvgnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434469; c=relaxed/simple;
	bh=zLHdOwdkTV6tR+AjCvADZcQhBWWoJOTBLexO093VWtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZ/WHDZHbRukeI531QaIfJASkRbdlD9aQxFltpItSqZ/pLJQ6lg6f5+xsQggzNmy4RgRsZn9dmhJA5xNaSlyhQikUVdGzQVTr2YdVjJFSUKogMB+19RqtGyhn9PxVT2Nwk1Y3BwFCO8LmfCf1eWGwrb4BnuXp0hkmzTsMuJz0Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BnF9Okgj; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BnF9Okgj"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dJbX120GLzyVm;
	Sat, 29 Nov 2025 18:41:05 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764434465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Foum1bg6KqU/d9NBj3qbf1+sp6lUhGX6KAT/FXjyrSg=;
	b=BnF9Okgjn8YV576jCBGv+BRpmSxOtneIqllxPlvw12KFYxTDTLoqRwfU5bmgXOGLbNnjtQ
	+clv2juEGwQaQ/Kt13bDVZJKgz05Qkevb8AKL0ZIWWpp5I+dClsm4G65A9Ug50ieJvihMu
	TjbYpCMmveYjRfpoPUzDTrzIv6AfzTc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764434465;
	b=e+cWeQNz3m2yzKLbXIJ73lKHnPhfqUM3TeYW71JuS1ADLVCJrK5AC6U08pcBVbcYSJPQqj
	ulxMrdwERycsSfRvV8TYsF8VsoangvKnlWTDGALmJKQkWRCFUwzHQvGEg8rjZzuVPp0Teo
	FJABfGjMbG7VQcEzd76sayeYIKJyoxQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764434465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Foum1bg6KqU/d9NBj3qbf1+sp6lUhGX6KAT/FXjyrSg=;
	b=YDrNnv1FhtLabOWKQ73+zuP0RxcYERWqhSsH9NWbvky3HOZFVh0M7TLkdILFCEp4Dt/dBx
	qBaZdAYwLBBamHGj5ZptIuaB7vQq3bYsQvTuyggNXGv6t0lBHVDTVmiDdT3ZQ/yJH3UEYs
	ZJ4kuzRWEkQ1Xm//uwcWWKF7IB1vk4E=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/4] btdev: implement Sync Conn Accept/Reject flow
Date: Sat, 29 Nov 2025 18:41:00 +0200
Message-ID: <718fe8feb762c83ed5c8fc18aaeec90346c456f0.1764434454.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <ab1a4fceca2948a2844dbac64fbca08ee7514f3e.1764434454.git.pav@iki.fi>
References: <ab1a4fceca2948a2844dbac64fbca08ee7514f3e.1764434454.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Send HCI Connection Request properly for Setup Synchronous Connection,
instead of proceeding to Connection Complete immediately.

See Core v6.1 Vol 2 Part F Sec 5
---
 emulator/btdev.c | 294 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 230 insertions(+), 64 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7019037c7..c84bcf783 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -59,6 +59,10 @@
 #define SYNC_HANDLE 1
 #define INV_HANDLE 0xffff
 
+#define SCO_AIRMODE_MASK       0x0003
+#define SCO_AIRMODE_CVSD       0x0000
+#define SCO_AIRMODE_TRANSP     0x0003
+
 struct hook {
 	btdev_hook_func handler;
 	void *user_data;
@@ -136,6 +140,11 @@ struct le_cig {
 	bool activated;
 } __attribute__ ((packed));
 
+struct pending_conn {
+	struct btdev *dev;
+	uint8_t link_type;
+};
+
 struct btdev {
 	enum btdev_type type;
 	uint16_t id;
@@ -251,7 +260,7 @@ struct btdev {
 	uint8_t  le_rl_enable;
 	uint16_t le_rl_timeout;
 
-	struct btdev *pending_conn[MAX_PENDING_CONN];
+	struct pending_conn pending_conn[MAX_PENDING_CONN];
 
 	uint8_t le_local_sk256[32];
 
@@ -1283,29 +1292,49 @@ static struct btdev_conn *conn_link_bis(struct btdev *dev, struct btdev *remote,
 	return conn;
 }
 
-static void pending_conn_add(struct btdev *btdev, struct btdev *remote)
+static void pending_conn_add(struct btdev *btdev, struct btdev *remote,
+							uint8_t link_type)
 {
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
-		if (!btdev->pending_conn[i]) {
-			btdev->pending_conn[i] = remote;
+		if (!btdev->pending_conn[i].dev) {
+			btdev->pending_conn[i].dev = remote;
+			btdev->pending_conn[i].link_type = link_type;
 			return;
 		}
 	}
 }
 
-static bool pending_conn_del(struct btdev *btdev, struct btdev *remote)
+static int pending_conn_del(struct btdev *btdev, struct btdev *remote)
 {
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
-		if (btdev->pending_conn[i] == remote) {
-			btdev->pending_conn[i] = NULL;
-			return true;
+		if (btdev->pending_conn[i].dev == remote) {
+			btdev->pending_conn[i].dev = NULL;
+			return btdev->pending_conn[i].link_type;
 		}
 	}
-	return false;
+	return -ENOENT;
+}
+
+static void sync_conn_init_complete(struct btdev_conn *conn,
+		uint8_t link_type, struct bt_hci_evt_sync_conn_complete *cc)
+{
+	struct bt_hci_cmd_enhanced_setup_sync_conn *cmd = conn->data;
+
+	memset(cc, 0, sizeof(*cc));
+
+	cc->status = 0x00;
+	memcpy(cc->bdaddr, conn->link->dev->bdaddr, 6);
+	cc->link_type = link_type;
+	cc->tx_interval = 0x0c;
+	cc->retrans_window = 0x06;
+	cc->rx_pkt_len = cpu_to_le16(60);
+	cc->tx_pkt_len = cpu_to_le16(60);
+	cc->air_mode = cmd->tx_coding_format[0];
+	cc->handle = cpu_to_le16(conn->handle);
 }
 
 static void conn_complete(struct btdev *btdev,
@@ -1313,16 +1342,39 @@ static void conn_complete(struct btdev *btdev,
 {
 	struct bt_hci_evt_conn_complete cc;
 	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
+	int link_type;
 
 	if (!remote)
 		return;
 
+	link_type = pending_conn_del(btdev, remote);
+	switch (link_type) {
+	case 0x00:
+	case 0x01:
+		break;
+	default:
+		if (!status)
+			status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		link_type = 0x01;
+		break;
+	}
+
+	cc.link_type = link_type;
+
 	if (!status) {
+		struct bt_hci_evt_sync_conn_complete scc;
 		struct btdev_conn *conn;
 
-		conn = conn_add_acl(btdev, bdaddr, BDADDR_BREDR);
-		if (!conn)
-			return;
+		if (link_type == 0x01) {
+			conn = conn_add_acl(btdev, bdaddr, BDADDR_BREDR);
+			if (!conn)
+				return;
+		} else {
+			conn = queue_find(btdev->conns, match_handle,
+						UINT_TO_PTR(SCO_HANDLE));
+			if (!conn)
+				return;
+		}
 
 		pending_conn_del(conn->link->dev, btdev);
 
@@ -1331,20 +1383,23 @@ static void conn_complete(struct btdev *btdev,
 		cc.encr_mode = 0x00;
 
 		cc.handle = cpu_to_le16(conn->link->handle);
-		cc.link_type = 0x01;
 
 		send_event(conn->link->dev, BT_HCI_EVT_CONN_COMPLETE, &cc,
 						sizeof(cc));
 
+		if (link_type != 0x01) {
+			/* Initiating controller gets Sync Conn Complete */
+			sync_conn_init_complete(conn, link_type, &scc);
+			send_event(btdev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &scc,
+						sizeof(scc));
+			return;
+		}
+
 		cc.handle = cpu_to_le16(conn->handle);
-		cc.link_type = 0x01;
 	} else {
 		cc.handle = cpu_to_le16(0x0000);
-		cc.link_type = 0x01;
 	}
 
-	pending_conn_del(btdev, remote);
-
 	cc.status = status;
 	memcpy(cc.bdaddr, bdaddr, 6);
 	cc.encr_mode = 0x00;
@@ -1352,6 +1407,57 @@ static void conn_complete(struct btdev *btdev,
 	send_event(btdev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
 }
 
+static void sync_conn_complete(struct btdev *btdev,
+					const uint8_t *bdaddr, uint8_t status)
+{
+	struct bt_hci_evt_sync_conn_complete cc;
+	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
+	struct btdev_conn *conn;
+	int link_type;
+
+	if (!remote)
+		return;
+
+	link_type = pending_conn_del(btdev, remote);
+
+	switch (link_type) {
+	case 0x00: /* SCO */
+	case 0x02: /* eSCO */
+		break;
+	default:
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
+
+	conn = queue_find(btdev->conns, match_handle, UINT_TO_PTR(SCO_HANDLE));
+	if (!conn) {
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
+
+	if (!status) {
+		pending_conn_del(conn->link->dev, btdev);
+
+		sync_conn_init_complete(conn->link, link_type, &cc);
+		send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMPLETE,
+							&cc, sizeof(cc));
+
+		sync_conn_init_complete(conn, link_type, &cc);
+	} else {
+		conn_remove(conn);
+
+		memset(&cc, 0, sizeof(cc));
+		cc.handle = cpu_to_le16(0x0000);
+		cc.link_type = 0x02;
+	}
+
+done:
+	cc.status = status;
+	memcpy(cc.bdaddr, bdaddr, 6);
+
+	send_event(btdev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
+}
+
 struct page_timeout_data {
 	struct btdev *btdev;
 	uint8_t bdaddr[6];
@@ -1387,7 +1493,7 @@ static int cmd_create_conn_complete(struct btdev *dev, const void *data,
 		memcpy(cr.dev_class, dev->dev_class, 3);
 		cr.link_type = 0x01;
 
-		pending_conn_add(dev, remote);
+		pending_conn_add(dev, remote, cr.link_type);
 
 		send_event(remote, BT_HCI_EVT_CONN_REQUEST, &cr, sizeof(cr));
 	} else {
@@ -1413,6 +1519,7 @@ static int cmd_add_sco_conn(struct btdev *dev, const void *data, uint8_t len)
 	const struct bt_hci_cmd_add_sco_conn *cmd = data;
 	struct bt_hci_evt_conn_complete cc;
 	struct btdev_conn *conn;
+	struct bt_hci_cmd_enhanced_setup_sync_conn enh = { 0 };
 
 	memset(&cc, 0, sizeof(cc));
 
@@ -1429,6 +1536,8 @@ static int cmd_add_sco_conn(struct btdev *dev, const void *data, uint8_t len)
 		goto done;
 	}
 
+	conn->data = util_memdup(&enh, sizeof(enh));
+
 	cc.status = BT_HCI_ERR_SUCCESS;
 	memcpy(cc.bdaddr, conn->link->dev->bdaddr, 6);
 	cc.handle = cpu_to_le16(conn->handle);
@@ -1478,7 +1587,7 @@ static int cmd_create_conn_cancel_complete(struct btdev *dev, const void *data,
 	 * Controller shall return an HCI_Command_Complete event with the error
 	 * code Unknown Connection Identifier (0x02).
 	 */
-	if (pending_conn_del(dev, remote)) {
+	if (pending_conn_del(dev, remote) >= 0) {
 		rp.status = BT_HCI_ERR_SUCCESS;
 	} else {
 		conn = queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
@@ -1517,7 +1626,7 @@ static int cmd_accept_conn_complete(struct btdev *dev, const void *data,
 	if (dev->auth_enable || remote->auth_enable)
 		send_event(remote, BT_HCI_EVT_LINK_KEY_REQUEST, dev->bdaddr, 6);
 	else
-		conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_SUCCESS);
+		conn_complete(remote, dev->bdaddr, BT_HCI_ERR_SUCCESS);
 
 	return 0;
 }
@@ -1533,8 +1642,12 @@ static int cmd_reject_conn_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_reject_conn_request *cmd = data;
+	struct btdev *remote = find_btdev_by_bdaddr(cmd->bdaddr);
 
-	conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
+	if (!remote)
+		return 0;
+
+	conn_complete(remote, dev->bdaddr, cmd->reason);
 
 	return 0;
 }
@@ -2821,43 +2934,38 @@ static int cmd_enhanced_setup_sync_conn_complete(struct btdev *dev,
 {
 	const struct bt_hci_cmd_enhanced_setup_sync_conn *cmd = data;
 	struct bt_hci_evt_sync_conn_complete cc;
+	struct bt_hci_evt_conn_request cr;
 	struct btdev_conn *conn;
 
 	memset(&cc, 0, sizeof(cc));
 
 	conn = queue_find(dev->conns, match_handle,
 				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
-	if (!conn) {
+	if (!conn || conn->type != HCI_ACLDATA_PKT) {
 		cc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		goto done;
+		goto fail;
 	}
 
 	conn = conn_add_sco(conn);
 	if (!conn) {
 		cc.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
-		goto done;
+		goto fail;
 	}
 
-	/* TODO: HCI_Connection_Request connection flow */
+	conn->data = util_memdup(cmd, sizeof(*cmd));
+	conn->link->data = util_memdup(cmd, sizeof(*cmd));
 
-	cc.status = BT_HCI_ERR_SUCCESS;
-	memcpy(cc.bdaddr, conn->link->dev->bdaddr, 6);
+	memcpy(cr.bdaddr, dev->bdaddr, 6);
+	memcpy(cr.dev_class, dev->dev_class, 3);
+	cr.link_type = 0x02;
 
-	cc.handle = cpu_to_le16(conn->handle);
-	cc.link_type = 0x02;
-	cc.tx_interval = 0x000c;
-	cc.retrans_window = 0x06;
-	cc.rx_pkt_len = 60;
-	cc.tx_pkt_len = 60;
-	cc.air_mode = cmd->tx_coding_format[0];
+	pending_conn_add(dev, conn->link->dev, cr.link_type);
 
-done:
+	send_event(conn->link->dev, BT_HCI_EVT_CONN_REQUEST, &cr, sizeof(cr));
+	return 0;
+
+fail:
 	send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
-
-	if (conn)
-		send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMPLETE,
-							&cc, sizeof(cc));
-
 	return 0;
 }
 
@@ -2872,42 +2980,94 @@ static int cmd_setup_sync_conn_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_setup_sync_conn *cmd = data;
-	struct bt_hci_evt_sync_conn_complete cc;
+	struct bt_hci_cmd_enhanced_setup_sync_conn enh;
 	struct btdev_conn *conn;
 
-	memset(&cc, 0, sizeof(cc));
-
 	conn = queue_find(dev->conns, match_handle,
 				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
-	if (!conn) {
-		cc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		goto done;
+	if (conn && conn->type == HCI_SCODATA_PKT) {
+		struct bt_hci_evt_sync_conn_changed cc;
+
+		/* TODO: actually modify connection parameters */
+		memset(&cc, 0, sizeof(cc));
+		cc.status = BT_HCI_ERR_UNSUPPORTED_FEATURE;
+		send_event(dev, BT_HCI_EVT_SYNC_CONN_CHANGED, &cc, sizeof(cc));
+		return 0;
 	}
 
-	conn = conn_add_sco(conn);
-	if (!conn) {
-		cc.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
-		goto done;
+	memset(&enh, 0, sizeof(enh));
+
+	enh.handle = cmd->handle;
+
+	/* TODO: emulate also this properly? */
+	enh.tx_bandwidth = cmd->tx_bandwidth;
+	enh.rx_bandwidth = cmd->rx_bandwidth;
+	enh.max_latency = cmd->max_latency;
+	enh.retrans_effort = cmd->retrans_effort;
+	enh.pkt_type = cmd->pkt_type;
+
+	switch (le16_to_cpu(cmd->voice_setting) & SCO_AIRMODE_MASK) {
+	case SCO_AIRMODE_TRANSP:
+		enh.tx_coding_format[0] = 0x03;
+		break;
+	case SCO_AIRMODE_CVSD:
+	default:
+		enh.tx_coding_format[0] = 0x02;
+		break;
 	}
 
-	cc.status = BT_HCI_ERR_SUCCESS;
-	memcpy(cc.bdaddr, conn->link->dev->bdaddr, 6);
+	return cmd_enhanced_setup_sync_conn_complete(dev, &enh, sizeof(enh));
+}
 
-	cc.handle = cpu_to_le16(conn->handle);
-	cc.link_type = 0x02;
-	cc.tx_interval = 0x000c;
-	cc.retrans_window = 0x06;
-	cc.rx_pkt_len = 60;
-	cc.tx_pkt_len = 60;
-	cc.air_mode = (cmd->voice_setting == 0x0060) ? 0x02 : 0x03;
+static int cmd_accept_sync_conn_request(struct btdev *dev, const void *data,
+								uint8_t len)
+{
+	const struct bt_hci_cmd_accept_sync_conn_request *cmd = data;
 
-done:
-	send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
+	if (!find_btdev_by_bdaddr(cmd->bdaddr))
+		return -EPERM;
 
-	if (conn)
-		send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMPLETE,
-							&cc, sizeof(cc));
+	cmd_status(dev, BT_HCI_ERR_SUCCESS,
+					BT_HCI_CMD_ACCEPT_SYNC_CONN_REQUEST);
+	return 0;
+}
 
+static int cmd_accept_sync_conn_request_complete(struct btdev *dev,
+						const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_accept_sync_conn_request *cmd = data;
+	struct btdev *remote = find_btdev_by_bdaddr(cmd->bdaddr);
+
+	if (!remote)
+		return 0;
+
+	sync_conn_complete(remote, dev->bdaddr, BT_HCI_ERR_SUCCESS);
+	return 0;
+}
+
+static int cmd_reject_sync_conn_request(struct btdev *dev, const void *data,
+								uint8_t len)
+{
+	const struct bt_hci_cmd_accept_sync_conn_request *cmd = data;
+
+	if (!find_btdev_by_bdaddr(cmd->bdaddr))
+		return -EPERM;
+
+	cmd_status(dev, BT_HCI_ERR_SUCCESS,
+					BT_HCI_CMD_REJECT_SYNC_CONN_REQUEST);
+	return 0;
+}
+
+static int cmd_reject_sync_conn_request_complete(struct btdev *dev,
+						const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_reject_sync_conn_request *cmd = data;
+	struct btdev *remote = find_btdev_by_bdaddr(cmd->bdaddr);
+
+	if (!remote)
+		return 0;
+
+	sync_conn_complete(remote, dev->bdaddr, cmd->reason);
 	return 0;
 }
 
@@ -3235,6 +3395,10 @@ static int cmd_get_mws_transport_config(struct btdev *dev, const void *data,
 #define CMD_BREDR \
 	CMD(BT_HCI_CMD_SETUP_SYNC_CONN, cmd_setup_sync_conn, \
 					cmd_setup_sync_conn_complete), \
+	CMD(BT_HCI_CMD_ACCEPT_SYNC_CONN_REQUEST, cmd_accept_sync_conn_request, \
+				cmd_accept_sync_conn_request_complete), \
+	CMD(BT_HCI_CMD_REJECT_SYNC_CONN_REQUEST, cmd_reject_sync_conn_request, \
+				cmd_reject_sync_conn_request_complete), \
 	CMD(BT_HCI_CMD_READ_EXT_INQUIRY_RESPONSE, cmd_read_ext_inquiry, NULL), \
 	CMD(BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE, cmd_write_ext_inquiry, \
 					NULL), \
@@ -3379,6 +3543,8 @@ static void set_bredr_commands(struct btdev *btdev)
 	set_common_commands_bredr20(btdev);
 
 	btdev->commands[16] |= 0x08;	/* Setup Synchronous Connection */
+	btdev->commands[16] |= 0x10;	/* Accept Synchronous Connection Req */
+	btdev->commands[16] |= 0x20;	/* Reject Synchronous Connection Req */
 	btdev->commands[17] |= 0x01;	/* Read Extended Inquiry Response */
 	btdev->commands[17] |= 0x02;	/* Write Extended Inquiry Response */
 	btdev->commands[17] |= 0x20;	/* Read Simple Pairing Mode */
-- 
2.51.1

