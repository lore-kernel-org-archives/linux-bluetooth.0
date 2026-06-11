Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4E3DB309
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191261; cv=none; b=J2nVmzqPYuapM1UsyfDh3ofbLw3JnXidT0Y4pJt3dLzFZ3U//5gMo19T601yih5AGqEz3kJvVZDrLpasqyWcag8xZgkwnZozDXG8H+/RpdiF8ScQRa/fUaZ30pg8uZwxUTv+++vuO0Fghk+X2sMlhlmUUwzcLlYvZQEFYTo8a4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191261; c=relaxed/simple;
	bh=WRS8O3TIROBJ141L2c5QSA2tcAFSdLoliuyn9SFKa3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CFL8bHvpINahq7Iq6Ne0GSkRXaPG9FL9gonj2HsCaT4swdYbDuxn0jRWTGxr/Wnzxd628Mvena8TUo3Ci2Evem4NOMjYts7lZeEwPEaK+7Be8kAH5IfQ4OXOotrMVY1VhiPfOLy2TvRRyiVxxAvXUbfOn5HsF28Wzl36DceapSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=MltY7yN2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=au7wzE9W; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="MltY7yN2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="au7wzE9W"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B43C14000F9;
	Thu, 11 Jun 2026 11:20:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 11:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1781191259; x=1781277659; bh=tKMANmpoF3pbtplO5VGja
	geBrreMiwT/OBf4CIqlK98=; b=MltY7yN298hLWmpwFibA+qTzVeLlyO+p+ES6k
	TP3QVV2QxS21Y8fY6tWXlQLfXS4gIahVw22dbsR+95RirWFGdGhDS4BaS+Qdk3CW
	6HfjWokq8rcjR37SIXbHh9ZtMi4QmNFIEz58hnyc9BMo0VdFgZiZRJ0FGNgwuBQP
	SD9H3iuODuk9zPyhuf9WM4EUd2J0kLp1CnCTfXi3I+hAZoHLgVhUp3UHXfMSGuHJ
	AWBOUY/D911EnA1yqe3HQOVETdpqRQE5xe7wV61rEiQdPGk7DBWuL5B6m4NKJURK
	L0ibKdvMCtApHlxcMtWLJIy/r9TzRL4cK3f0IKE7mJ+RrDq4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781191259; x=1781277659; bh=tKMANmpoF3pbtplO5VGjageBrreMiwT/OBf
	4CIqlK98=; b=au7wzE9WGbM7ATHscd+MU2jfii5mWPdwxG1IHbsUeKbxbGwZe4q
	hrDLdimyh3+Lncg0aK4tAbwvlxgUX51bwWPPvk3w+Y4PoAc5VyMb5VhFw2sbxETh
	uY14G7XckppgANy1NSqeAR2VbV6jSvoCk5/z/50omEc5y0Fl8dKvukq9SfT+Dnz3
	7Ukk/B12q9QJppJJDXkLD2v/p7qKC8xaMCwLjXwzOxew2zNkn7yxOo8FxWoXzWo0
	4MVFgTV2VVybqTu6By8x8Hc+Sd+IXx06/ib+dIOc8GLFB3KPvC+qpZ7yMxyfr/Ws
	9KKEZGdZgP6TzhciSO8lYBjqN3JYuNHwmIQ==
X-ME-Sender: <xms:W9IqagP6jyCvXebnQk7_Zeb_bOPjrPaizYILCNDkYB6deWKvmBxzoA>
    <xme:W9IqauYcgv5JJNGiG0JS0KmfIP9XwbvDxmhPH9dTFmCB5Nf9KhrInJI-RVEyNAhqb
    iYRpE_yqlL0OIBN4UaeK_Q5bK3Rhngy68BBiD6r3CxuaehwnGP1Y6sC>
X-ME-Received: <xmr:W9Iqakr64o--UATz0Ie3T5VcJC6OGrbMuvcVmEyE0UauaHuL2tb2RqiQgiLfQZyyBkQjUvg>
X-ME-Proxy-Cause: dmFkZTGR+M3A9n0WovApy4nYX9oEEBnPbev5LuTN4Gnn/sy9SMnllzTJnek5opLIYJaYOT
    ToH7LNZFW2F6jAkDmYIbG6pfNpUweFgiFKBJLIDxcxvhtO23rdqfSM04UPmjs+FiyIzxF2
    0L+82G7L1FWhVecfe3qC/iXn9YfxgPgG2MI+ctzspTwXdBV9YMhdIjQ+ZyQw9QoRDLl89a
    Z3Q5TyPqq5wAE4R8TcMNVgQyUg9aqhV9kF4+HW5fwwvmHwbQpOodRdRulqqrPatMC1UwwP
    5yRwwe3d7Fznb+ahqPdj09U2Xi+4aBGbAcYJQvEqwkrJeYQTQ7tygStouhsnuQsA3EXrFV
    p9dzHkUrOR99QNhMy+rfFGqVd9+jrQYWJMxgWMVoSGd6IlLDVP3mnt8nOnT34JZbpc//6h
    qFNLUXv4XORIR0jLoDNvH4O9Ryfs17bgvjrEWfn+iMucRlpyxhwy9YvXXz4i0ozPDpxh7L
    zC5q+UX5Z+WpqZ7n9KvnRaWh+gDVLYNcAa6NM8qd4BQ5eXbmGywFYia5g6YuErAM55DJnv
    9gIRCkP50qHq/K4RVacIGUeIMZ4jDD0FfN0ufDnh8OxppFiOHCIsGxlTSf9chYx8/pp0Gh
    ns+Xsj1mqMNZN44CV3MnrUzZks3OUZIrleQnGle/PcYwvsXzTw439x7e9X7w
X-ME-Proxy: <xmx:W9IqaiaRhQEyOnif1QWVeTqV2n8y_-5AaBCWta7_TAxq1NJ2hF3X7w>
    <xmx:W9IqasRssNNxI_gNYcvD9jN5sE2tWuwQXzkGObS5KzdQhQjQNy3FLg>
    <xmx:W9Iqap7oF-tDusPNTndEinmYlR6wE8wuTFIDl3jBaSElrRsnZDcyzg>
    <xmx:W9IqahwJp3fMPOPdW8va_WXRqCGD74IJJQah2k3oWc8muVFuXbFClQ>
    <xmx:W9Iqaqai-ATOeCc8qBwYgSfeTekx59UG7cr86NcfrjNi4Qju-m3sSQKm>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 11:20:58 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v3] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Date: Thu, 11 Jun 2026 11:19:52 -0400
Message-ID: <20260611152039.2176565-1-oss@fourdim.xyz>
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
route all cancellation through hci_cancel_connect_sync(), which dequeues
the command if still queued, or cancels the pending request if this
connection owns the in-flight create command. CIS uses the same path
via the existing HCI_CONN_CREATE_CIS flag.

Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 21 ++--------
 net/bluetooth/hci_sync.c         | 66 ++++++++++++++++++++++++++------
 3 files changed, 58 insertions(+), 30 deletions(-)

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
index df23245d6ccd..1fe19ddbbc2c 100644
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
@@ -7039,20 +7056,45 @@ int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 
 int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	if (conn->state != BT_OPEN)
-		return -EINVAL;
+	hci_cmd_sync_work_func_t func = NULL;
+	hci_cmd_sync_work_destroy_t destroy = NULL;
+	int create_flag = -1;
 
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
+	/* The create command is in exactly one of two states: still queued, or
+	 * in flight. The create flag is only set once the worker has dequeued
+	 * the entry and started running it, so the two states are mutually
+	 * exclusive. Try to dequeue first: if it succeeds the command had not
+	 * started yet and we are done. Otherwise the worker already pulled it
+	 * off the queue (the dequeue is a no-op here), so if this connection
+	 * owns the in-flight create command, cancel the pending request.
+	 */
+	if (func && hci_cmd_sync_dequeue_once(hdev, func, conn, destroy))
+		return 0;
+
+	if (create_flag >= 0 && test_bit(create_flag, &conn->flags))
+		hci_cmd_sync_cancel(hdev, ECANCELED);
+
+	return -EBUSY;
 }
 
 int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
-- 
2.54.0

