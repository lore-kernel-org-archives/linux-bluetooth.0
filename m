Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517BD762DE
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440501; cv=pass; b=dSjtjGNS1r+NSakPM0UMEOrLCkxLjDD5O00xVkylJyKFAAU+u4yPAyYBS3lDlWBDMNeGxj7mAR0qSoIG4Rt2EcuNbMVQpy3VgwUFP5J47c7wlWiPbxNgY7HKUs6ihlFCXfmdkUdQY1dEeRtxDv7s5aOgKa4KVJVqQ5iMZXG3UUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440501; c=relaxed/simple;
	bh=R1O/ht1ocoXEyVTEdAgk2S2D/NajFcKMc1FubLogsP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aw08yVvKd8lBuGBwxhmFRlghSRgFGow6KxTxxY8esOhyS4oQYGuCMHvC8TtplVIrB91xxwccffgKYa0EJIi/RXnoIMIvn5336jnurM4A4xSVp89nm6ejxfQ0wKcNSTXHRuL/Iw6Y40xpQkN1iqzP+WBdOU8Cu0RCFRnwupKBh/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=s5mmzCgN; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="s5mmzCgN"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TwbLN6lHPz49Ptk;
	Thu, 14 Mar 2024 20:21:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710440493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JzT69tOdpsUYsIOroGvf9htTZN0rV5ZdKs7wA0E/5Y=;
	b=s5mmzCgNiUQMYOKly2S0NkzZHF0Ps4hRpa1/GwhloXXxFE0HzxQkkkGfa8kmIVFRA4D0u3
	IqhkZGE6orZpe9KR2acXI6x6FV3rWKcitpxp87H62Z6O+K8UTOjljE9cmFKjx2NicECQXC
	pTNyD65z91f8DlYdW87tCCuUOFdjPFmv3QFgSXUXSUwt3c5wDc+URjWTW4eWdM95pvAbZP
	3etpwzR/dX9Cdux3nYKZMGSCb32ZdMsV/LQqlMPZfrdP5fNwadGqThutkAhtk439bIVag6
	n2v+QRR/u9QUETsKsOgZOhf6X6m8ZIwdadNPbY1rKuByKo+xm/b0ynViW0RTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710440493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JzT69tOdpsUYsIOroGvf9htTZN0rV5ZdKs7wA0E/5Y=;
	b=v6MVcW0VxLH9Il6HVX6Gh3q1w+bBqjgEgeLwIcqe5lRAdmgaDOc/LDzJeaiTeMYuP0h+p1
	bjU77XdLQr3L1Sk4poPBSYZ5Z3O1meDdQOpSXiqho8rhBL3HKHTr86h+7MqtJjcBiyU5bf
	EBx51/d+a3z1hOfX47vZTrqvoANY5BBNqooj7MeqSfW4FBOBeRlrBxG9vxi01dR5xjRnoM
	d1akTBF+/Am+IdL1+Cs2dqpH4g7Mt35f2z7b76yGuHlRPfubU+C8Kl+zq4eW8V0oRAbJGE
	iXittkH/0H73++XP94iuxaQBYoJEraIfZ/7m9XqzAYQSAwO2MWSuVrBOt+Joew==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710440493; a=rsa-sha256;
	cv=none;
	b=RsTbGYSttFX9rW6s6mUlGbvRW2ck0uKAvEcJJJX/6PQSImas0MJOMCMMsZaOMz3FtamQM+
	csAmzbZ26of6rFMx2aQfR1dMIAYhGnwRm1jMLTo8/VftUCn/4LR88GyadlO9//hnnA4Lgf
	MqedoRyVw3zFfZfqguDiBMiRT98g7jVl3PXwPp94gxmF5SjqhRrseqei7poKw84AqUOQ3K
	ALuk0//2bJfrfRu33ceBRbhIxqZzP4k3U34XyH9kd76HoXNTrMGdds0QCbPGyq9mcCijca
	9llI2L3iO/yqTmrRftuzKQg4wZGw173NNaYW5L1YtzJsZuRLl4CcmyTSuw4XHw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 7/9] bthost: handle client L2CAP conn in LE credit based mode
Date: Thu, 14 Mar 2024 20:21:16 +0200
Message-ID: <256516aa4a422430d28c4ac32666caa25f809430.1710440408.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710440408.git.pav@iki.fi>
References: <cover.1710440408.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow bthost hooks to receive data from L2CAP LE credit based
connections. Handle LE credit header when receiving, and reassemble
received SDU.

Handle L2CAP LE credit header also in bthost_send_cid.
---
 emulator/bthost.c | 205 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 180 insertions(+), 25 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 8c40fce90..8616bf715 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -162,11 +162,21 @@ struct btconn {
 	void *recv_data;
 };
 
+enum l2cap_mode {
+	L2CAP_MODE_OTHER,
+	L2CAP_MODE_LE_CRED,
+	L2CAP_MODE_LE_ENH_CRED,
+};
+
 struct l2conn {
+	struct l2conn *next;
 	uint16_t scid;
 	uint16_t dcid;
 	uint16_t psm;
-	struct l2conn *next;
+	enum l2cap_mode mode;
+	uint16_t data_len;
+	uint16_t recv_len;
+	void *recv_data;
 };
 
 struct rcconn {
@@ -275,6 +285,7 @@ struct bthost *bthost_create(void)
 
 static void l2conn_free(struct l2conn *conn)
 {
+	free(conn->recv_data);
 	free(conn);
 }
 
@@ -360,6 +371,7 @@ static struct l2conn *bthost_add_l2cap_conn(struct bthost *bthost,
 	l2conn->psm = psm;
 	l2conn->scid = scid;
 	l2conn->dcid = dcid;
+	l2conn->mode = L2CAP_MODE_OTHER;
 
 	l2conn->next = conn->l2conns;
 	conn->l2conns = l2conn;
@@ -415,6 +427,19 @@ static struct l2conn *btconn_find_l2cap_conn_by_scid(struct btconn *conn,
 	return NULL;
 }
 
+static struct l2conn *btconn_find_l2cap_conn_by_dcid(struct btconn *conn,
+								uint16_t dcid)
+{
+	struct l2conn *l2conn;
+
+	for (l2conn = conn->l2conns; l2conn != NULL; l2conn = l2conn->next) {
+		if (l2conn->dcid == dcid)
+			return l2conn;
+	}
+
+	return NULL;
+}
+
 static struct l2cap_conn_cb_data *bthost_find_l2cap_cb_by_psm(
 					struct bthost *bthost, uint16_t psm)
 {
@@ -609,14 +634,24 @@ static void send_iov(struct bthost *bthost, uint16_t handle, uint16_t cid,
 }
 
 static void send_acl(struct bthost *bthost, uint16_t handle, uint16_t cid,
-						const void *data, uint16_t len)
+				bool sdu_hdr, const void *data, uint16_t len)
 {
-	struct iovec iov;
+	struct iovec iov[2];
+	uint16_t sdu;
+	int num = 0;
+
+	if (sdu_hdr) {
+		sdu = cpu_to_le16(len);
+		iov[num].iov_base = &sdu;
+		iov[num].iov_len = sizeof(sdu);
+		num++;
+	}
 
-	iov.iov_base = (void *) data;
-	iov.iov_len = len;
+	iov[num].iov_base = (void *) data;
+	iov[num].iov_len = len;
+	num++;
 
-	send_iov(bthost, handle, cid, &iov, 1);
+	send_iov(bthost, handle, cid, iov, num);
 }
 
 static uint8_t l2cap_sig_send(struct bthost *bthost, struct btconn *conn,
@@ -711,12 +746,19 @@ void bthost_send_cid(struct bthost *bthost, uint16_t handle, uint16_t cid,
 					const void *data, uint16_t len)
 {
 	struct btconn *conn;
+	struct l2conn *l2conn;
+	bool sdu_hdr = false;
 
 	conn = bthost_find_conn(bthost, handle);
 	if (!conn)
 		return;
 
-	send_acl(bthost, handle, cid, data, len);
+	l2conn = btconn_find_l2cap_conn_by_dcid(conn, cid);
+	if (l2conn && (l2conn->mode == L2CAP_MODE_LE_CRED ||
+			l2conn->mode == L2CAP_MODE_LE_ENH_CRED))
+		sdu_hdr = true;
+
+	send_acl(bthost, handle, cid, sdu_hdr, data, len);
 }
 
 void bthost_send_cid_v(struct bthost *bthost, uint16_t handle, uint16_t cid,
@@ -1779,7 +1821,7 @@ static void rfcomm_sabm_send(struct bthost *bthost, struct btconn *conn,
 	cmd.length = RFCOMM_LEN8(0);
 	cmd.fcs = rfcomm_fcs2((uint8_t *)&cmd);
 
-	send_acl(bthost, conn->handle, l2conn->dcid, &cmd, sizeof(cmd));
+	send_acl(bthost, conn->handle, l2conn->dcid, false, &cmd, sizeof(cmd));
 }
 
 static bool l2cap_conn_rsp(struct bthost *bthost, struct btconn *conn,
@@ -2110,6 +2152,7 @@ static bool l2cap_le_conn_req(struct bthost *bthost, struct btconn *conn,
 				uint8_t ident, const void *data, uint16_t len)
 {
 	const struct bt_l2cap_pdu_le_conn_req *req = data;
+	struct l2cap_conn_cb_data *cb_data;
 	struct bt_l2cap_pdu_le_conn_rsp rsp;
 	uint16_t psm;
 
@@ -2124,7 +2167,8 @@ static bool l2cap_le_conn_req(struct bthost *bthost, struct btconn *conn,
 	rsp.mps = 23;
 	rsp.credits = 1;
 
-	if (bthost_find_l2cap_cb_by_psm(bthost, psm))
+	cb_data = bthost_find_l2cap_cb_by_psm(bthost, psm);
+	if (cb_data)
 		rsp.dcid = cpu_to_le16(conn->next_cid++);
 	else
 		rsp.result = cpu_to_le16(0x0002); /* PSM Not Supported */
@@ -2132,6 +2176,20 @@ static bool l2cap_le_conn_req(struct bthost *bthost, struct btconn *conn,
 	l2cap_sig_send(bthost, conn, BT_L2CAP_PDU_LE_CONN_RSP, ident, &rsp,
 								sizeof(rsp));
 
+	if (!rsp.result) {
+		struct l2conn *l2conn;
+
+		l2conn = bthost_add_l2cap_conn(bthost, conn,
+							le16_to_cpu(rsp.dcid),
+							le16_to_cpu(req->scid),
+							le16_to_cpu(psm));
+		l2conn->mode = L2CAP_MODE_LE_CRED;
+
+		if (cb_data && l2conn->psm == cb_data->psm && cb_data->func)
+			cb_data->func(conn->handle, l2conn->dcid,
+							cb_data->user_data);
+	}
+
 	return true;
 }
 
@@ -2139,11 +2197,14 @@ static bool l2cap_le_conn_rsp(struct bthost *bthost, struct btconn *conn,
 				uint8_t ident, const void *data, uint16_t len)
 {
 	const struct bt_l2cap_pdu_le_conn_rsp *rsp = data;
+	struct l2conn *l2conn;
 
 	if (len < sizeof(*rsp))
 		return false;
 	/* TODO add L2CAP connection before with proper PSM */
-	bthost_add_l2cap_conn(bthost, conn, 0, le16_to_cpu(rsp->dcid), 0);
+	l2conn = bthost_add_l2cap_conn(bthost, conn, 0,
+						le16_to_cpu(rsp->dcid), 0);
+	l2conn->mode = L2CAP_MODE_LE_CRED;
 
 	return true;
 }
@@ -2196,16 +2257,19 @@ static bool l2cap_ecred_conn_rsp(struct bthost *bthost, struct btconn *conn,
 		uint16_t scid[5];
 	} __attribute__ ((packed)) *rsp = data;
 	int num_scid, i;
+	struct l2conn *l2conn;
 
 	if (len < sizeof(*rsp))
 		return false;
 
 	num_scid = len / sizeof(*rsp->scid);
 
-	for (i = 0; i < num_scid; i++)
+	for (i = 0; i < num_scid; i++) {
 		/* TODO add L2CAP connection before with proper PSM */
-		bthost_add_l2cap_conn(bthost, conn, 0,
+		l2conn = bthost_add_l2cap_conn(bthost, conn, 0,
 				      le16_to_cpu(rsp->scid[i]), 0);
+		l2conn->mode = L2CAP_MODE_LE_ENH_CRED;
+	}
 
 
 	return true;
@@ -2333,7 +2397,7 @@ static void rfcomm_ua_send(struct bthost *bthost, struct btconn *conn,
 	cmd.length = RFCOMM_LEN8(0);
 	cmd.fcs = rfcomm_fcs2((uint8_t *)&cmd);
 
-	send_acl(bthost, conn->handle, l2conn->dcid, &cmd, sizeof(cmd));
+	send_acl(bthost, conn->handle, l2conn->dcid, false, &cmd, sizeof(cmd));
 }
 
 static void rfcomm_dm_send(struct bthost *bthost, struct btconn *conn,
@@ -2347,7 +2411,7 @@ static void rfcomm_dm_send(struct bthost *bthost, struct btconn *conn,
 	cmd.length = RFCOMM_LEN8(0);
 	cmd.fcs = rfcomm_fcs2((uint8_t *)&cmd);
 
-	send_acl(bthost, conn->handle, l2conn->dcid, &cmd, sizeof(cmd));
+	send_acl(bthost, conn->handle, l2conn->dcid, false, &cmd, sizeof(cmd));
 }
 
 static void rfcomm_sabm_recv(struct bthost *bthost, struct btconn *conn,
@@ -2636,12 +2700,97 @@ static void process_rfcomm(struct bthost *bthost, struct btconn *conn,
 	}
 }
 
+static void append_l2conn_data(struct bthost *bthost, struct l2conn *conn,
+				const void *data, uint16_t len)
+{
+	if (!conn->recv_data) {
+		bthost_debug(bthost, "Unexpected L2CAP SDU data: sCID 0x%4.4x ",
+								conn->scid);
+		return;
+	}
+
+	if (conn->recv_len + len > conn->data_len) {
+		bthost_debug(bthost, "Unexpected L2CAP SDU data: sCID 0x%4.4x ",
+								conn->scid);
+		return;
+	}
+
+	memcpy(conn->recv_data + conn->recv_len, data, len);
+	conn->recv_len += len;
+
+	bthost_debug(bthost, "L2CAP SDU data: %u/%u bytes", conn->recv_len,
+							conn->data_len);
+}
+
+static void free_l2conn_data(struct l2conn *conn)
+{
+	free(conn->recv_data);
+	conn->recv_data = NULL;
+	conn->recv_len = 0;
+	conn->data_len = 0;
+}
+
+static void new_l2conn_data(struct bthost *bthost, struct l2conn *conn,
+								uint16_t len)
+{
+	free(conn->recv_data);
+	conn->recv_data = malloc(len);
+	conn->recv_len = 0;
+	conn->data_len = len;
+}
+
+static bool process_l2cap_conn(struct bthost *bthost, struct btconn *conn,
+				struct l2conn *l2conn, struct iovec *data)
+{
+	struct bt_l2cap_pdu_le_flowctl_creds creds;
+	uint16_t sdu;
+
+	if (!l2conn)
+		return true;
+
+	switch (l2conn->mode) {
+	case L2CAP_MODE_LE_CRED:
+	case L2CAP_MODE_LE_ENH_CRED:
+		break;
+	case L2CAP_MODE_OTHER:
+		return true;
+	}
+
+	/* Credit-based flow control */
+
+	creds.cid = cpu_to_le16(l2conn->scid);
+	creds.credits = cpu_to_le16(1);
+	l2cap_sig_send(bthost, conn, BT_L2CAP_PDU_LE_FLOWCTL_CREDS, 0,
+							&creds, sizeof(creds));
+
+	if (!l2conn->data_len) {
+		if (!util_iov_pull_le16(data, &sdu)) {
+			free_l2conn_data(l2conn);
+			bthost_debug(bthost, "L2CAP invalid SDU");
+			return false;
+		}
+		new_l2conn_data(bthost, l2conn, sdu);
+	}
+
+	append_l2conn_data(bthost, l2conn, data->iov_base, data->iov_len);
+
+	if (l2conn->recv_len < l2conn->data_len)
+		return false;  /* SDU incomplete */
+
+	l2conn->data_len = 0;
+	data->iov_base = l2conn->recv_data;
+	data->iov_len = l2conn->recv_len;
+
+	return true;
+}
+
 static void process_l2cap(struct bthost *bthost, struct btconn *conn,
-					const void *data, uint16_t len)
+					const void *buf, uint16_t len)
 {
-	const struct bt_l2cap_hdr *l2_hdr = data;
+	const struct bt_l2cap_hdr *l2_hdr = buf;
 	struct cid_hook *hook;
 	struct l2conn *l2conn;
+	struct iovec data;
 	uint16_t cid, l2_len;
 
 	l2_len = le16_to_cpu(l2_hdr->len);
@@ -2654,31 +2803,37 @@ static void process_l2cap(struct bthost *bthost, struct btconn *conn,
 	bthost_debug(bthost, "L2CAP data: %u bytes", l2_len);
 
 	cid = le16_to_cpu(l2_hdr->cid);
+	l2conn = btconn_find_l2cap_conn_by_scid(conn, cid);
+
+	data.iov_base = (void *)l2_hdr->data;
+	data.iov_len = l2_len;
+
+	if (!process_l2cap_conn(bthost, conn, l2conn, &data))
+		return;
 
 	hook = find_cid_hook(conn, cid);
 	if (hook) {
-		hook->func(l2_hdr->data, l2_len, hook->user_data);
+		hook->func(data.iov_base, data.iov_len, hook->user_data);
 		return;
 	}
 
 	switch (cid) {
 	case 0x0001:
-		l2cap_sig(bthost, conn, l2_hdr->data, l2_len);
+		l2cap_sig(bthost, conn, data.iov_base, data.iov_len);
 		break;
 	case 0x0005:
-		l2cap_le_sig(bthost, conn, l2_hdr->data, l2_len);
+		l2cap_le_sig(bthost, conn, data.iov_base, data.iov_len);
 		break;
 	case 0x0006:
-		smp_data(conn->smp_data, l2_hdr->data, l2_len);
+		smp_data(conn->smp_data, data.iov_base, data.iov_len);
 		break;
 	case 0x0007:
-		smp_bredr_data(conn->smp_data, l2_hdr->data, l2_len);
+		smp_bredr_data(conn->smp_data, data.iov_base, data.iov_len);
 		break;
 	default:
-		l2conn = btconn_find_l2cap_conn_by_scid(conn, cid);
 		if (l2conn && l2conn->psm == 0x0003)
-			process_rfcomm(bthost, conn, l2conn, l2_hdr->data,
-								l2_len);
+			process_rfcomm(bthost, conn, l2conn, data.iov_base,
+								data.iov_len);
 		else
 			bthost_debug(bthost,
 					"Packet for unknown CID 0x%04x (%u)",
@@ -3494,7 +3649,7 @@ void bthost_send_rfcomm_data(struct bthost *bthost, uint16_t handle,
 	}
 
 	uih_frame[uih_len - 1] = rfcomm_fcs((void *)hdr);
-	send_acl(bthost, handle, rcconn->scid, uih_frame, uih_len);
+	send_acl(bthost, handle, rcconn->scid, false, uih_frame, uih_len);
 
 	free(uih_frame);
 }
-- 
2.44.0

