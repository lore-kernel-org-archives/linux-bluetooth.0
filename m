Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2392C3E44F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104049; cv=none; b=n2DOLui11admmOgeZBhkT1oNlozG0ZcoULkHxk2TkIDQR525/WX+BWLdB4MwD480NJKlq4kfEEfJ/0b52WLxaSbVTRBul1uB+SpKW+3PYLsPGXoUz+KjH33DtchuxkUwxvLrAqvTDkfL2Sm6F+bRBr3/jDkeOFDhGfMRduMrz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104049; c=relaxed/simple;
	bh=QV6nBCKrnG1bM785f8sa5gbBXoX71ah4FbR9J0K5P1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=He4J7sY/uJ7phAIIqy796jr7tCPPzddPI29xnYS+wVd73WRUcm+vCHHDkV+HsY5lW00AC4dCCOqI4wrhR/0UAEI4C1MaO4e2KC5PIPPCf2T4IY1TFV5wgZG8dbs2yed2qugZh7w55lzG8tLY77Bz0jK/ZpbGk78Se9ziKnE2A88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=dFmIEYwT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e7ZJ5oeN; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="dFmIEYwT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e7ZJ5oeN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F8CE7A015F;
	Wed, 10 Jun 2026 11:07:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Jun 2026 11:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1781104047; x=1781190447; bh=CXYcw7e0FrtJBiwgWjNlJ
	/58IUW4meUSEkwAfcSoVjI=; b=dFmIEYwT91sC2UsX83tiVeekgeP4BZlqbfw5P
	bMCxZ/fq+UMdR91GTkZaoNhlhp4UiT2h1SzHIr63s/c/xaVt1FKKzAg5EevPMDgq
	7TCxLGl6vR88s+tddVKPHD5OI7rWM9n6H74XPqWCe415r5HVTaEEsq/Mv/e08tKa
	TLuAjBWosxzPdpCZB/Eb0AYA6lGJAAXITkiQL9PHxMenzjOWkWgM/Drgek8iqMdx
	KtKh7WYIw48ZO2vMiPnL6xuX8ocqgfzoOrAVKSgQN7zNUUEzekynvTOmqEjVTeYn
	tSi+kueqjPcOgWWf8XC4P5pbv0OTOdGExh1jyePNTYFx5hSaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781104047; x=1781190447; bh=CXYcw7e0FrtJBiwgWjNlJ/58IUW4meUSEkw
	AfcSoVjI=; b=e7ZJ5oeNOYwcqGk9YMkIU4qjR7lPaQ0cRezRlWU4el7iqMCFEVt
	8j51x6eZhOAuBlg+V1R9b9Luhs9sgnZEIkbKVf9B8vPNb+db3Iyj+/oABfUr/feN
	D5vjEL0eTcJB68s/0UrmZB22DYJ0mseT2HCFrVrW2iu9us4E8QZ5F5Pc9pomIHx6
	ju3t0sO0ITRayHk1UShKW6nlOBxjV/ayhbrMGKsLhrMFs3FlLQsA0IDQA8Ygyu1u
	76E1Ll+BgMwjEgdzyvPE8H0gaEaDKiqSks2fXBLlqyh2rBm00QPmjof165u5yja2
	CBAe7Nf5TICUf/7847B69yh1k7mzu5krFoQ==
X-ME-Sender: <xms:rn0paqRvaCczDXD0q743BXIyeA6hPDKDwGF9dh-yeh7UmM0wi5rT9A>
    <xme:rn0panPYxnBBkx1CmERXaSI1yCEiEpOfq2o2Ndq3VPb3LrF229WospWhLdYtBhAO5
    oua5zU533GhYvtxunof5WamPbfabmFC31qhC2snQ0RJwF1_YY28D9o>
X-ME-Received: <xmr:rn0palODoyOTpjzd7Z4DjfHF9MeaOxEPpJ-QPv1Lq6XtwaWm3T_1w52tBsRuE1TAbQASv2g>
X-ME-Proxy-Cause: dmFkZTEdRbhZspr0hrqoxjn5XxFEFCNTZElXjn0dVUFUl5B7xymQ6l3/+03rTINr+GmRPU
    yA1e+P+/mlhbwYG/MFzf8WXZ8j27n1DIXS3S7RBGMs+8/mfgrvKpPx84kxbDlnGnDXh3E5
    5/zG+eLLmj/dLWi5YvjB3V9drM5bcC7hxnPKvq5bzz3wvyH8tCrGcLK+VIa29xqGh0dRha
    Oncy4mWXtNaqBlft3iSc9rvQwMbRDeTX0IIV7ZTr+aW8OiO9W0jSAzqW7+Dr4zcoODLkSA
    iN+gTayS+2AQ6KxsjnfJjbV4SHKZLvy0fd06DYwld0raL/4svnBbFKsnDuZXj/bwYi9SiD
    t07fZ22UOGoKqrgnnjBe7ZrPO6LRQDUYFoZdxc0wLCxWPuAIlN1GPzm/42YKLEr+6hy1vz
    3XrK2qzkGcW6DpEXzLgUPYrZCJiI+TQZdA3lVAVrkJRrO4+KWoURj6SDPwIK7Sy4UPOA1q
    TcsM7yEuX7iNsXdbNk3m4KzguCO5CBxSQ/w5HLoWE5o6AC+q0MVmkoH6z9VFJxaaxBwxhq
    TawUVn4hs8baQrxj6Sm2s5deVOWfUMPAkNpDdq4dbhDgfbEoCiFbuLgB2nRxSjPYefYVZw
    36PphvVicMpCLyodsKje+lDNBtquytP4rW5T+8u+pfZ3V16bfNxYD2zWbFIg
X-ME-Proxy: <xmx:rn0pavv_6QenTYtuc5y5VJ6kWbIReJP31d1TytOnYYzOsQPF0PO3GQ>
    <xmx:rn0panX7Yqr1sGXV_C3201expJ_5MGJZoetHav7MDZCm1Q-MNxe_Jw>
    <xmx:rn0pavuvfcqjvFLq8qsPZyLBn9f70qrm9FdelL0IIbChtSnz1m2_JQ>
    <xmx:rn0parV51nbAnI1osoFeRDiD3Cc9x71chvFsXYa2VuaFo1wey1qQtw>
    <xmx:r30panNweUiNTxIWI_PBU-L2MQaKpFVIVIJUMSWzQct63GtskL6DbA2I>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 11:07:26 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Date: Wed, 10 Jun 2026 11:06:21 -0400
Message-ID: <20260610150704.1234558-1-oss@fourdim.xyz>
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
connection command with a new per-connection HCI_CONN_CREATE_CONN flag
and route all cancellation through hci_cancel_connect_sync(), which
dequeues the command if still queued, or cancels the pending request if
this connection owns the in-flight create command. CIS uses the same
path via the existing HCI_CONN_CREATE_CIS flag.

Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 21 ++----------
 net/bluetooth/hci_sync.c         | 58 +++++++++++++++++++++++++-------
 3 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aa600fbf9a53..c90ca6173680 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -988,6 +988,7 @@ enum {
 	HCI_CONN_AUTH_FAILURE,
 	HCI_CONN_PER_ADV,
 	HCI_CONN_BIG_CREATED,
+	HCI_CONN_CREATE_CONN,
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
index df23245d6ccd..08917b8167de 100644
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
+	set_bit(HCI_CONN_CREATE_CONN, &conn->flags);
+
 	/* Send command LE Extended Create Connection if supported */
 	if (use_ext_conn(hdev)) {
 		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
@@ -6703,6 +6709,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 				       conn->conn_timeout, NULL);
 
 done:
+	clear_bit(HCI_CONN_CREATE_CONN, &conn->flags);
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
+	set_bit(HCI_CONN_CREATE_CONN, &conn->flags);
+
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
+				       sizeof(cp), &cp,
+				       HCI_EV_CONN_COMPLETE,
+				       conn->conn_timeout, NULL);
+
+	clear_bit(HCI_CONN_CREATE_CONN, &conn->flags);
+
+	return err;
 }
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -7039,20 +7056,37 @@ int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 
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
+		create_flag = HCI_CONN_CREATE_CONN;
+		break;
 	case LE_LINK:
-		return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_conn_sync,
-						  conn, create_le_conn_complete);
+		func = hci_le_create_conn_sync;
+		destroy = create_le_conn_complete;
+		create_flag = HCI_CONN_CREATE_CONN;
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

