Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE44218EB1
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281092; cv=none; b=FbGmNNKELLpLQAvKRRoY3Xx5yxSvUwiNmqzM/SYSuK0qpe8C8F35SB5xhiJ/hLmo8PWbZKUro/NvnCjpv7qHoNECY0HySkOWAbK0vJsRpPHOGfKNLgR/FEpa384aL6qbei+K6qcHZSsGry6uV05CAS44CXHb89Wa5PlC++1OGMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281092; c=relaxed/simple;
	bh=NAdr2E3j1zbw6T89YL42XgwcAYg3aEa5io3+QN1KbjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JxNdQtnz35EYzNe1gxQ6W8eIBhr1EklpfXIyZXTw4LXFflWg68o4P+waT1l+wEUVeXc3M0YG0XqTtSN04+n4JqOdGS4gxlGo4WWJzo2ET8F+yMfReXXVx9K2wA9QUBogKbhq0aBma5tC7NU5G5fz9YwcWZwbXF/Gqg1tv66inNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=ADjVyUje; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ayl25ttE; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="ADjVyUje";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ayl25ttE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE0A27A0078;
	Fri, 12 Jun 2026 12:18:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 12 Jun 2026 12:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1781281089; x=1781367489; bh=wJ39vyFgCW+wTTWAlPj1k
	vVMthp7TnCtK8GVvX0NcPE=; b=ADjVyUje2LW1/A9Vx9f8vdvaZrkHZ3RndGCHs
	nY/VMXMX6ioA2QARHsvNc8N3ol0nQD0kvJLxDopoiaCJmE8IBQzZv+DtHpr0FQrQ
	lAAwZwyNK9YguEmpjlq8o8WB/K1BHjOfOMQThKDIHmbp9GPWUJm0QwsgnTkTpqKk
	IFsE4Dl6Q5DkVOzGT2kXpCstpV+WNm4Dqgm05biygYTXR92p8OH20QJHGSkzL1tL
	WTVDe9/1nzQ+d+CfunhlVByUcdVuHgy0jMW+KRqgpISoafxVlHY6VOKPrqF7vwyx
	jGoDr9XfH4drMJIfxV78qwAerTip+N/bNKU1u077IPHiX2+9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781281089; x=1781367489; bh=wJ39vyFgCW+wTTWAlPj1kvVMthp7TnCtK8G
	VvX0NcPE=; b=ayl25ttEG3KdOYMoqcWUFbESmnnUTEGZbBVxZNnjsTyzUqCCag+
	7zhKWdrdiXXbeEjYfAIi7Enp4zBKWKVDnhPmPYlA0d1iGlm1jXKD4XQ0nc/VbLVn
	73T/E2zS9XFAlYhDJGIPmz8rUY3ne7f2QIafa/dfuMN/wZfYmrzz+P8Teb8h0dj7
	FpnvGEucToaa4fk2mk5T4lh5uRZhcjfSOWLiIhcjbNOd8HVm9pXHpuYTGk6wDIaY
	nDOoDfjsRxZPtWddKVEHS2dkNOBX7p/5hPmmR+gWWh2obwZ3u8rTd3VjiiIVvHpX
	ApkgPIW1Wxl/TcVPYwkDQSj7flCXNTxcOdQ==
X-ME-Sender: <xms:QTEsagKsWa0Bxk9TM6tWJaOnY4kuOKlg3Aqe2zDzRpdj_9M43uykVw>
    <xme:QTEsanLJvhAhyNFTLyXx0pmNUY6Q-2CsQqw585Y4vUJvf5S6a-tQqfyWCe-drBi9l
    4uiHmmTKY8puxoMb8TlccsKmQw8Puqy8OSlasrO0kYNtS2Dm6qLcCc>
X-ME-Received: <xmr:QTEsals_OonUjM6QaXKnjme6gzt8OdGGsG7UCsmu4Q_b0yVsrZARockGUI0lnbnS0f8m_68>
X-ME-Proxy-Cause: dmFkZTE4IsRnZTk9lXC7dDcowvXRZpvyG7iaUdx0QUqup5+Qzafhz8uOW/bTQIUiMTAV25
    jbdmu/k6zrtBgEs+eYAcep42tmKTZ6+K6wxgJqMOlHkJYbzeTcV6XYLWCXCZPQ1eNiYWu7
    tPXHEoT2r2uhzDGu94dzO1/DnNOUBu0VbXNAOiaBNjJuAWwiQ2y/FAeY7Lrq8qEL6tnECD
    0ySpGeN+SNBHGokOWpnfdDXRI6cbVglPNXJQoU2utHoAuuZxDXi3fWTyrZScJEGfI88oxZ
    Noe8UyrQ5MJX/WIi1qsR7WVv+HoVo7wrs0SXsirl3pzvr4Ii9hmgXYYZXI3pQXt1xH1tZB
    rOV04Suiq/3qeOLSdsKoRdWIX49PRNJxFhPiidwQ/R601pyxE6w3oRVEJ0RBdGTqc8RHde
    tCsXdGPTS3uMmEKgodCb6gWg1XuMtgW1pgWnNn07wegSCXLihc7r2T2Qzt9OEKyUmEmarN
    BOuwRahLwtA2nEYIZAZN9m4xUmNbNC0mvsTpvjb2zi7VMwOsbLnVeVgPgr/AC+vP/h/eFz
    DxV2CdDFwOif5wppcvG33VDDxsO62BIkW714vIKvLP4oWkMLn+2rISeRWbrXEc/ovXUNuV
    oerqZb77iVNXiTXT9A/yGdGu14SymWaSFeHlGynXrq5vEpRlki4aJRywk/vw
X-ME-Proxy: <xmx:QTEsasTJvO2_crg8L1bTDP38y-oL_5_9XOyXGwtF4KPcmM7OzIpZAA>
    <xmx:QTEsajM2mXxPYogpzi5qN0BUAaVkKlsSKwgRtoNV8GJ9zPeiKqcgbQ>
    <xmx:QTEsapYziDNVdULnfGYTXyvTEtodf0Ae1GeSJtqc9ZHxy4g7jHtupw>
    <xmx:QTEsalzOiXn2cBkdi69YkaMrnE1RlXx2eMkDdezGyPWb1gGyidDWIA>
    <xmx:QTEsagmK_3wNT6OoAX3yZ6Ku_eRLoXf9m_9f9f_uuo8eTGB0zNAa5OyH>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 12:18:09 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v4 1/2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Date: Fri, 12 Jun 2026 12:16:09 -0400
Message-ID: <20260612161753.3140707-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connection
was pending, but hdev->sent_cmd can be NULL while req_status is still
HCI_REQ_PEND, leading to a NULL pointer dereference and a general
protection fault from the hci_rx_work() receive path.

Instead of inspecting hdev->sent_cmd, track the in-flight create
connection command with a new per-connection HCI_CONN_CREATE flag and
route all cancellation through hci_cancel_connect_sync(). The create
command is in exactly one of two states: still queued, or in flight.
hci_cancel_connect_sync() holds cmd_sync_work_lock across the whole
decision: the worker takes this lock to dequeue every entry, so while it
is held a queued command cannot start running and an in-flight command
cannot complete and let the next command become pending. This keeps the
flag test and hci_cmd_sync_cancel() atomic with respect to the worker,
so a queued command is simply dequeued, and an in-flight command owned
by this connection is cancelled without the risk of cancelling an
unrelated command that became pending in the meantime. CIS uses the same
path via the existing HCI_CONN_CREATE_CIS flag.

Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 21 ++------
 net/bluetooth/hci_sync.c         | 83 +++++++++++++++++++++++++++-----
 3 files changed, 75 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aa600fbf9a53..aa554c34f9ec 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -988,6 +988,7 @@ enum {
 	HCI_CONN_AUTH_FAILURE,
 	HCI_CONN_PER_ADV,
 	HCI_CONN_BIG_CREATED,
+	HCI_CONN_CREATE,
 	HCI_CONN_CREATE_CIS,
 	HCI_CONN_CREATE_BIG_SYNC,
 	HCI_CONN_BIG_SYNC,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 54eabaa46960..eba4a548bef5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3181,26 +3181,11 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 
 	conn->abort_reason = reason;
 
-	/* If the connection is pending check the command opcode since that
-	 * might be blocking on hci_cmd_sync_work while waiting its respective
-	 * event so we need to hci_cmd_sync_cancel to cancel it.
-	 *
-	 * hci_connect_le serializes the connection attempts so only one
-	 * connection can be in BT_CONNECT at time.
+	/* Cancel the connect attempt. A return of 0 means the create command
+	 * was still queued and got dequeued, so there is nothing to disconnect.
 	 */
-	if (conn->state == BT_CONNECT && READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
-		switch (hci_skb_event(hdev->sent_cmd)) {
-		case HCI_EV_CONN_COMPLETE:
-		case HCI_EV_LE_CONN_COMPLETE:
-		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
-		case HCI_EVT_LE_CIS_ESTABLISHED:
-			hci_cmd_sync_cancel(hdev, ECANCELED);
-			break;
-		}
-	/* Cancel connect attempt if still queued/pending */
-	} else if (!hci_cancel_connect_sync(hdev, conn)) {
+	if (!hci_cancel_connect_sync(hdev, conn))
 		return 0;
-	}
 
 	/* Run immediately if on cmd_sync_work since this may be called
 	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index df23245d6ccd..5a6ffdb84c88 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6668,6 +6668,12 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 					     &own_addr_type);
 	if (err)
 		goto done;
+
+	/* Mark create connection in flight so hci_cancel_connect_sync() can
+	 * cancel it while blocking on the connection complete event.
+	 */
+	set_bit(HCI_CONN_CREATE, &conn->flags);
+
 	/* Send command LE Extended Create Connection if supported */
 	if (use_ext_conn(hdev)) {
 		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
@@ -6703,6 +6709,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 				       conn->conn_timeout, NULL);
 
 done:
+	clear_bit(HCI_CONN_CREATE, &conn->flags);
+
 	if (err == -ETIMEDOUT)
 		hci_le_connect_cancel_sync(hdev, conn, 0x00);
 
@@ -6982,10 +6990,19 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	else
 		cp.role_switch = 0x00;
 
-	return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
-					sizeof(cp), &cp,
-					HCI_EV_CONN_COMPLETE,
-					conn->conn_timeout, NULL);
+	/* Mark create connection in flight so hci_cancel_connect_sync() can
+	 * cancel it while blocking on the connection complete event.
+	 */
+	set_bit(HCI_CONN_CREATE, &conn->flags);
+
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
+				       sizeof(cp), &cp,
+				       HCI_EV_CONN_COMPLETE,
+				       conn->conn_timeout, NULL);
+
+	clear_bit(HCI_CONN_CREATE, &conn->flags);
+
+	return err;
 }
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -7039,20 +7056,62 @@ int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 
 int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	if (conn->state != BT_OPEN)
-		return -EINVAL;
+	struct hci_cmd_sync_work_entry *entry;
+	hci_cmd_sync_work_func_t func = NULL;
+	hci_cmd_sync_work_destroy_t destroy = NULL;
+	int create_flag = -1;
+	int err = -EBUSY;
 
 	switch (conn->type) {
 	case ACL_LINK:
-		return !hci_cmd_sync_dequeue_once(hdev,
-						  hci_acl_create_conn_sync,
-						  conn, NULL);
+		func = hci_acl_create_conn_sync;
+		create_flag = HCI_CONN_CREATE;
+		break;
 	case LE_LINK:
-		return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_conn_sync,
-						  conn, create_le_conn_complete);
+		func = hci_le_create_conn_sync;
+		destroy = create_le_conn_complete;
+		create_flag = HCI_CONN_CREATE;
+		break;
+	case CIS_LINK:
+		/* LE Create CIS is shared by the whole CIG and cannot be
+		 * dequeued per-connection; only cancel it in-flight below.
+		 */
+		create_flag = HCI_CONN_CREATE_CIS;
+		break;
+	default:
+		return -ENOENT;
 	}
 
-	return -ENOENT;
+	/* The create command is either still queued or in flight. Hold
+	 * cmd_sync_work_lock across the test and the cancel: the worker takes
+	 * this lock to dequeue every entry, so while it is held no other command
+	 * can become pending, which keeps hci_cmd_sync_cancel() from racing with
+	 * completion and cancelling an unrelated command.
+	 */
+	mutex_lock(&hdev->cmd_sync_work_lock);
+
+	/* The flag is set while the worker blocks on the connection complete
+	 * event, so if it is set this connection owns the pending request.
+	 */
+	if (create_flag >= 0 && test_bit(create_flag, &conn->flags)) {
+		hci_cmd_sync_cancel(hdev, ECANCELED);
+		goto unlock;
+	}
+
+	/* Otherwise it may still be queued; dequeue it. A successful dequeue
+	 * means it never started, so there is nothing to disconnect.
+	 */
+	if (func) {
+		entry = _hci_cmd_sync_lookup_entry(hdev, func, conn, destroy);
+		if (entry) {
+			_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+			err = 0;
+		}
+	}
+
+unlock:
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+	return err;
 }
 
 int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
-- 
2.54.0

