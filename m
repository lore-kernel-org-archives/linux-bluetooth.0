Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17D3FBA7
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190424; cv=none; b=teI9W2JkwiWMHbEdWIzTMRlEMv4Uil6nual/XA5qepS6meeAE8UyO43k7Ooul6I8Ud4C8OCFfRi8SIuXjs+9vvpvbirBYRVMCkZAzHdWV4BUjjZUv0HWylHbn6Lla5rPPc1SNsc3XsLzmP6o5mzzNSzbHUikELSgVDWt1ay3uqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190424; c=relaxed/simple;
	bh=QV6nBCKrnG1bM785f8sa5gbBXoX71ah4FbR9J0K5P1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XaZNU6xrm5vNsC9R/Hc2ShKFGkjNaaRGTuUM0jhz9PR+ZDNvfkU42JZyDxzRFHTLlG8gSWGFOUYYpRElz60jMpR85Kqw+x4685uC2g+Z9Vz1fR8Cwr49tiRz0KnOuTswVp7D7d00kPENiWaGRwhDm0LcNhlLbUJi3pKPbFJeCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=DWJ9uSPC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pvj7Qf6+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="DWJ9uSPC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pvj7Qf6+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BC14DEC01B5;
	Thu, 11 Jun 2026 11:07:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 11 Jun 2026 11:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1781190421; x=1781276821; bh=CXYcw7e0FrtJBiwgWjNlJ
	/58IUW4meUSEkwAfcSoVjI=; b=DWJ9uSPC3RRPLVxk5wquUwCS2UesXsyeLjlvU
	u/RXXbBYW79Tr9CzIZdvtxZ3GR68aqQSq+ntmDYZXeRR5mWilBhcz3uGVzSTzUsr
	xQzkBjPmqm6zCeZQ1rXkQvybGrAUpwUyEvGqWFq2hae5B9RTvkT+KWMbF9uSUKmP
	iLkPWT5tq5y2rROJ82+/6WIqQTnT2k1GW/ySB77sxt7ohjnBgugLflqmuenVPpMB
	t1feS7HPP1dzTFGs0J/mCTUkNxmdGTp3sABgNMRbIltQta9QOMCB6xeNg+Z4pY39
	ybFeyOov2reD0qerOcz6G5D4Wd/mvjOxPEJjbedahyfXhZbmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781190421; x=1781276821; bh=CXYcw7e0FrtJBiwgWjNlJ/58IUW4meUSEkw
	AfcSoVjI=; b=Pvj7Qf6+cs9KUyWwE27Bw9pvBn5XRXWqaRX9DXLP4uDOor0gfcU
	miBvF0UiRKz8z/nCWAyeEY5N6EBFwUGXJLe+FDspi7M9TlrbbBn6v7LzPHpth1/8
	6JI7hdPQBLhOrjapE/YFvBacqOVMDTzPPlKD0X3qnfRxuRfViYTjv9LaihYya4B2
	OPU+xyFMIrPsyFxMIUgXnuXud/HQaGdqTCBa7pp0bSWZwUHhPJ0IZuhcyTFQHEXd
	hgwMFjUPq3m6QrL3nFg8YwdI88e/U8dZVRzjboL6zIBPDcqyt/Ml1AULYdTdZgeL
	/Y70u6/yBAsqPkgT79QjFX+yiprTkOhNa0w==
X-ME-Sender: <xms:Fc8qamWZ70I3nnxk4IP39zHtVumULacpva94jqa5KN9Jt1zalsKSPw>
    <xme:Fc8qaqAFw3STaXeDgzcHy86dIsdLR15oN3kkn8T_JXxxuRMKJ1P465uB8MEOm_zHX
    wDaujSUIWl43jsLG6wp1cDh_1dFfVU5gLRKn1qdXv3zhyazZTaGxXM>
X-ME-Received: <xmr:Fc8qanwtFRIvTnIUrieo8L6ckAHcYtazvD87cniYOiO1FbMQWUoc5OiP4jvE5W8ouesb6jI>
X-ME-Proxy-Cause: dmFkZTFn0yVpRNZ/d/oq9iEJttSUUDtCeyQLolyHeAgrKNHUjdpoAf8IpKNaJ/TA5wA286
    2lUH91DOhjX61DLeXGtQyG5NTGJwozv4639AFXqdYD1rKpoWPa+YKymBko6nWAhopdLszy
    pKpGXeXpmJXEGyNBfwuLUuVvNs/azWWsbANl+OIqy9m+ZmzrGNUCnc+jvoPrhITiTRJGQq
    BhWrKHKiRWIQ11FNbMLJabuTZln4GHbGSid3jC1G+Q64PYCHa1n5cHS/wZI1X3IW2YNWpO
    hJu/VQBjKmCjxmtFPtTwzFilgDZt02fi5xML7I3x0JqosGNUHgRKGfquYLX6FpsHw4XUNR
    h8m+beTTYa9529WnkkpiVSFQaAq+uv/Eeymd2dZoM3VwjjXMqWx792I/zZDQhSNFZH+1Kc
    D8xTgnoarxJAqIz5FusOWe9TUWybp5ZKK9Jm1EIx4ZJ1tdfFh1zyHepDb2hxVssA21S28H
    yGiwYkyjmL/HzjUssdTg5dB9Lg/8jlld4hSlpEzNfbwMhauXqXS8ZfpSOx/AxIBlL4y6GU
    b1kiICOkX0IZEaBeYjaTav/+fMYJnoJkG/Ig3jRjur/6+TazWs0mMcpBuwGqvori45oNH/
    UuLZPs8wu5xd8oHxYneA3Ovh5z13OEK6sQC/as8MZLsy3v5CoxT2rFnOjU0A
X-ME-Proxy: <xmx:Fc8qanBJ_Bi1MbqenTQAJITdx9c-QLfAs9SvG_BzihiRNLsyzyd-VA>
    <xmx:Fc8qakZgB4s309nFRyhCA5CMwl7GPIRb6R0fnGHbXsbaxfNmqA5P5Q>
    <xmx:Fc8qavhivFEhYnEbIfJdzQGs1JHUBJIMbPfkTAmX1VwWbajCutlcmA>
    <xmx:Fc8qam79k8iNHdrgWp6MDuefu51XsuRyGq9e3p-SneW_VJt3mNENPA>
    <xmx:Fc8qauD3M-3l33M2tzuvkK7Xa1FGDe10snTNpu9K-6GrGYsV_IG2i7o8>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 11:07:01 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Date: Thu, 11 Jun 2026 11:06:23 -0400
Message-ID: <20260611150628.2164737-1-oss@fourdim.xyz>
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

