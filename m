Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049E03EEADD
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529123; cv=none; b=daJpy181aoKPzCP2hDmMRVjwNH6aM1flJi5LvMHmx5gEwUOikEFrLkspvSSakUEuL2xhVNKeXuRD+pfnNIFS0nh8UkwXfWjL+riJEL8u/YgbPkuvzMuNenwXo7RhAphzbskZf3Mwi3kHdNjYgVQEFBHbbZ99XpayZBc/cZtNV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529123; c=relaxed/simple;
	bh=YgvGbML8fR3OchKeR2Agqkk44RUwLh2uZIQkqtCvzeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ynh7/EpgL2yAeyuYKnWpF9LpNRijgoTsILdDl22Rw12DExhb1UUTAT7Phihlzg9nEWm9oFzo+/7kY/L4A7r2mBlWZbGrtQJI7BnysAkL4P8OASwZR4CLuZaEQNLWGWSUP4fTHj2pBj9ZCm3N8rnge2IdfJhD4GeL28c4tvBJYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=HyW3dRHV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QYGGqDEN; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="HyW3dRHV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYGGqDEN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 03E051D00091;
	Mon, 15 Jun 2026 09:12:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 09:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1781529120; x=1781615520; bh=iAqcBjdlLyy4X/MO/Qfuf
	hFjGz/W+H787UJjIxg2c/8=; b=HyW3dRHVsk3388F5DTSsbahnMe88whG9WoGyS
	m1rBEiJf3SlmCVSLi3H5dbOMeNuaybwh09uxtp+zEtaRjik9H7ygTga+BkYNKqiH
	6RuGbvlJPu2JHmoH3FHvnWAsOSSGwgXO0oOQq0F1yk5cPCtXUkAHw2zXFOr8eTQF
	vcDmmpXS4x2tiuayu1dV7qrmicDwgvhXUP9GRqwC38RoTMeLjXnu6IGw2lZY1CZ4
	DhZoLZInBaH2N9Gzsto7Gvh7csKPdw6PaeKDHVhjfRjwj8zKQr8avpMLP0+OSqOU
	TzwRea6gY5AwBG1/bpoFjonCH38p+AClsGvMX/OjD590nx2zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781529120; x=1781615520; bh=iAqcBjdlLyy4X/MO/QfufhFjGz/W+H787UJ
	jIxg2c/8=; b=QYGGqDENOJgjQm5QTpkr6y1AeTahFV71d3o1bagQfq/PsXFgqw4
	dj1QdNhKhvDDWfluGthjsSyEA0//5klXvu9fG+6UWtjXcd88WDueQqld+rFOg4UT
	nFM+RfLVECt6HjFMUsuo35uXvE1ip8qQclK2s2fnGNK+PSWkIn13E9N4256Uokj6
	DRqnQvHdgUxDP/qcf+ZGk41EI6t04n85YcyFX7VRutrLlZHpGUt2/sIZeXt+XasN
	sg1a3Y5eD+5AA+yKfpzcGZ5h71v6WmLGkDJiorTriwXsMUp6V3f7WQHtYTY+x17e
	c7Wp5WXU0fTlgP9vBtKFZmqSqEXLcyrGDlA==
X-ME-Sender: <xms:IPovapgsEWjAaKZKWsQBV3JOi8_rAYVfbjhV_VJb1eKCWQUPeCYi_A>
    <xme:IPovak5zrcRlIDhkLZ4Lh6BwrS9XTqz94VsTNNCxtNYwNEiAZzzzRDIqoLSXSaxhA
    27NKdsBltaydb0hy99NyemlXvERpBHqk7egaaI3TTrYUEnx7l_EERE>
X-ME-Received: <xmr:IPovaha_bCbJfewLpstZ-vdbCuwz3yMya3SyNOa4h5GgC4vTNxIdQT-a0oGppkpuKf_5-z4>
X-ME-Proxy-Cause: dmFkZTGOQQ1SYubukGKVbB21zz6Imx3GwbH2a0faj7htSqIUiBtsKJLNB7Tn3dIUtGHWAO
    t0nzFEzse92DrStgkprYj8SuRrtzoYWEGqzHvENXbOfwYhvpNZoY212HfCvTAmAv+SMdPD
    rJWdhXlVDMNhbjpQ910CvV4zE3nIkA2fgMxq+DvZ6LBi8adzyiuz3TLpo9iWm/E7MBTKWN
    +Dah04jP13nXEfAfxyCBpVyYiDWL/zlfRGUSJ7IcQsaOMly/IUVov3XtKwnevP9YsGZJX+
    Mkru5ADtpB/MyqqVlC1ejgDVH6QlYPVeurVWpQd7ImzsyhjoiN/71WOE/AYJQv24xdhmMK
    k1f0g48g9GvO7M/jiIPOvhur2x7FIZ3KBvKO1mMH7Eb+04E0nQBRauDiexIs8muTKk9KZA
    MKtQ2CquId0FKQ//oHrxzpRhLvCCEr2eLCptuZ/WlW99jUiHy1RbRoSBOncWHKXd9vssQf
    rri2Kb47c2uvRb9Ua6npkOFX96k0UZYzhQzELBYo1ekGAP5oBlPNfpsOfWslbVj7ay+DUY
    EQV1chuI/LQ/ecGnsHOSXe0jKayXlWNUi8aQDIzpyicpQuKuUGm/+/+fOPUao/u9tRjrpa
    P6wmjwFW8n+YBpeR2TL89ACJA1CCF0O11b0jBDz8EjCoqMNx881fcjhvk5YA
X-ME-Proxy: <xmx:IPovap5K5NHI5GFoWhucP2tox_PuIkX--f5CrgRZihKWeYGAEOo1_w>
    <xmx:IPovakB2-3uHJS8m1jfTqwZPS316laAqqSQZp-H6nh3_gBW-GoUPcA>
    <xmx:IPovavcySz1m9tFW2iYFbXBBUmRfeqSg4f6Dk0GjOnVlHgzxplZ5IA>
    <xmx:IPovajLluyyfOobYldZmJpkxDCqWDKxdfNi02YMgRp3lF6-D4pftRg>
    <xmx:IPovaoPFTLQEZ8tRmio0b-XCRQD1493V7Qz4dpMyLG55tGbOp-5eyV7h>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:11:59 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	XIAO WU <xiaowu.417@qq.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v5 1/2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Date: Mon, 15 Jun 2026 09:10:54 -0400
Message-ID: <20260615131131.1459372-1-oss@fourdim.xyz>
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

hci_acl_create_conn_sync() and hci_le_create_conn_sync() clear
HCI_CONN_CREATE after the create command completes, but the command
status handler can free conn via hci_conn_del() (for example when the
controller rejects the connection) while the worker is still blocked on
the connection complete event. Hold a reference on conn across the
create command so the flag can be cleared without a use-after-free.

Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Cc: stable@vger.kernel.org
Suggested-by: XIAO WU <xiaowu.417@qq.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 21 +------
 net/bluetooth/hci_sync.c         | 96 ++++++++++++++++++++++++++++----
 3 files changed, 88 insertions(+), 30 deletions(-)

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
index df23245d6ccd..06b87e9cd999 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6611,6 +6611,11 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	/* Hold a reference so conn stays valid for the HCI_CONN_CREATE
+	 * clear_bit() at done.
+	 */
+	hci_conn_get(conn);
+
 	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 	conn->state = BT_CONNECT;
 
@@ -6623,6 +6628,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		    hdev->le_scan_type == LE_SCAN_ACTIVE &&
 		    !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES)) {
 			hci_conn_del(conn);
+			hci_conn_put(conn);
 			return -EBUSY;
 		}
 
@@ -6668,6 +6674,12 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
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
@@ -6703,11 +6715,14 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 				       conn->conn_timeout, NULL);
 
 done:
+	clear_bit(HCI_CONN_CREATE, &conn->flags);
+
 	if (err == -ETIMEDOUT)
 		hci_le_connect_cancel_sync(hdev, conn, 0x00);
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
+	hci_conn_put(conn);
 	return err;
 }
 
@@ -6982,10 +6997,25 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	else
 		cp.role_switch = 0x00;
 
-	return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
-					sizeof(cp), &cp,
-					HCI_EV_CONN_COMPLETE,
-					conn->conn_timeout, NULL);
+	/* Hold a reference so conn stays valid for the HCI_CONN_CREATE
+	 * clear_bit() below.
+	 */
+	hci_conn_get(conn);
+
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
+	hci_conn_put(conn);
+
+	return err;
 }
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -7039,20 +7069,62 @@ int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 
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

