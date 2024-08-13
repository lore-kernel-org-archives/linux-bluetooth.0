Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08A19EED6
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560365; cv=none; b=kuM5FZwSnqvc4d6DrLWRZHW/BkLnu0PkUHJylJ/iaw/2+k3OrWgIHT7FpNpInkZG66MEQj922OlaaJWcDe6UCNJ864dySyvvKpoIgKYSu+h6uoScwMvzdEV/cCRsHxFqz8mkfaVDIcf0ZK1p01aDjurYLKnyUzQV87YKZzOqxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560365; c=relaxed/simple;
	bh=OmLzZGdWuPF45j6XD34nCJaofGbTvE2+hjDzxhqdni4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pAifcBMCIs2ChNj7ZegUvxS2XpurSv431hfkU/sOtHX2a0GsFDwbBzxcLu0s05jLEBuFzOSEI+AXszhLe+NtoQlwEE1/13rUtAiAGAtoPMP/xHrCdsurGp3mZiop1QJberShZDq1UbBRoBhsvtAG/h2HS/mtjJBRBN49kPwIxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asNPo+q1; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asNPo+q1"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f51551695cso1770155e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 07:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723560362; x=1724165162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUYqAOn5u8viMn7TewlPq4D7zd7j3WQ/jaFtNSrynUo=;
        b=asNPo+q1gjK9gvtbJUBsbGXLUF/vWp5m9EPEJnKJtlG9hFLQrl/zSnPOkAQupMhkjW
         YIZQmaWUxfTwXKwusWnWguQxzSpAD/trjbck/Y0U8HVyvyEBYN1mjNGwuTKKov5FYcSr
         1MC/cIHSoTkJ/f/BevuwlbkAxMTsIUC50BrZvZulRS3Ob60qrN7SbdRcS6mIwBRB88p/
         MkTOlZ53LuBC2gAYclu2Mn68cgDdWgWB0jAQMqGjiB/X+YCUjlSY6MUMm+VHm9c4NPOh
         eZE6u0pqU+387dJNy73mQTQWgiEawaB4Kau3WsZBULnE7+44uRgQ8L2ckRSyl6RC8KXO
         mDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560362; x=1724165162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUYqAOn5u8viMn7TewlPq4D7zd7j3WQ/jaFtNSrynUo=;
        b=N73GCxm3iT2iwn9h38b0sttsOM4ZQsWmhFH/l2OWrq+5Hiy482QbD50P96temm2pUM
         iyn17vFziFcHAEHEJNLuC5PfYBfj7vgECtAXHULwrIIwlF4yX1yVVoUOrie0qsESNT2t
         wdqJAXgZOXfp38Wb83/pO8YDwRa3RFfv6K5sCutpA02JQZQGXNomgm9RLXTolVvDjyBI
         6rwa24WIBNPCmCvZ3X4YyDQiZAMwUFoUb4MOD/snyhq+dfsVo7LKkseBZpfPCet1XDXC
         PvVRO8zlceogj3Cf9/o+hWbGoIFZFIL5Ft9hF4vMe9kCVtjJB+FhxPz5nTHwRl/1W3Qw
         o8hA==
X-Gm-Message-State: AOJu0Yx2D8o72T0KBtju4BsY1oNl856P0gUzv1oY193fuNHYFOesl0CB
	MWmBdL351QvNxG5yVdXxDx6OrR7ACqH1O2OKNKC8V7H6PjHz5CuiojUKtQ==
X-Google-Smtp-Source: AGHT+IHKiYNafPfZ/fXBAZS36Lz0aaG+HZzjLUaAfwqpEjid5RWEXY+D9xx347F+5TxbGzCrjZq6cA==
X-Received: by 2002:a05:6122:3d10:b0:4f2:e9eb:951e with SMTP id 71dfb90a1353d-4fabf0843b6mr4757222e0c.10.1723560361552;
        Tue, 13 Aug 2024 07:46:01 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f91f4c68aasm907435e0c.39.2024.08.13.07.46.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:46:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RESEND v2] Bluetooth: SMP: Fix assumption of Central always being Initiator
Date: Tue, 13 Aug 2024 10:45:59 -0400
Message-ID: <20240813144559.529786-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

SMP initiator role shall be considered the one that initiates the
pairing procedure with SMP_CMD_PAIRING_REQ:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part H
page 1557:

Figure 2.1: LE pairing phases

Note that by sending SMP_CMD_SECURITY_REQ it doesn't change the role to
be Initiator.

Link: https://github.com/bluez/bluez/issues/567
Fixes: b28b4943660f ("Bluetooth: Add strict checks for allowed SMP PDUs")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/smp.c | 146 ++++++++++++++++++++++----------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1e7ea3a4b7ef..4f9fdf400584 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -914,7 +914,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	 * Confirms and the responder Enters the passkey.
 	 */
 	if (smp->method == OVERLAP) {
-		if (hcon->role == HCI_ROLE_MASTER)
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			smp->method = CFM_PASSKEY;
 		else
 			smp->method = REQ_PASSKEY;
@@ -964,7 +964,7 @@ static u8 smp_confirm(struct smp_chan *smp)
 
 	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 
-	if (conn->hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 	else
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
@@ -980,7 +980,8 @@ static u8 smp_random(struct smp_chan *smp)
 	int ret;
 
 	bt_dev_dbg(conn->hcon->hdev, "conn %p %s", conn,
-		   conn->hcon->out ? "initiator" : "responder");
+		   test_bit(SMP_FLAG_INITIATOR, &smp->flags) ? "initiator" :
+		   "responder");
 
 	ret = smp_c1(smp->tk, smp->rrnd, smp->preq, smp->prsp,
 		     hcon->init_addr_type, &hcon->init_addr,
@@ -994,7 +995,7 @@ static u8 smp_random(struct smp_chan *smp)
 		return SMP_CONFIRM_FAILED;
 	}
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		u8 stk[16];
 		__le64 rand = 0;
 		__le16 ediv = 0;
@@ -1256,14 +1257,15 @@ static void smp_distribute_keys(struct smp_chan *smp)
 	rsp = (void *) &smp->prsp[1];
 
 	/* The responder sends its keys first */
-	if (hcon->out && (smp->remote_key_dist & KEY_DIST_MASK)) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags) &&
+	    (smp->remote_key_dist & KEY_DIST_MASK)) {
 		smp_allow_key_dist(smp);
 		return;
 	}
 
 	req = (void *) &smp->preq[1];
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		keydist = &rsp->init_key_dist;
 		*keydist &= req->init_key_dist;
 	} else {
@@ -1432,7 +1434,7 @@ static int sc_mackey_and_ltk(struct smp_chan *smp, u8 mackey[16], u8 ltk[16])
 	struct hci_conn *hcon = smp->conn->hcon;
 	u8 *na, *nb, a[7], b[7];
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		na   = smp->prnd;
 		nb   = smp->rrnd;
 	} else {
@@ -1460,7 +1462,7 @@ static void sc_dhkey_check(struct smp_chan *smp)
 	a[6] = hcon->init_addr_type;
 	b[6] = hcon->resp_addr_type;
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local_addr = a;
 		remote_addr = b;
 		memcpy(io_cap, &smp->preq[1], 3);
@@ -1539,7 +1541,7 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 		/* The round is only complete when the initiator
 		 * receives pairing random.
 		 */
-		if (!hcon->out) {
+		if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 			if (smp->passkey_round == 20)
@@ -1567,7 +1569,7 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
 
-		if (hcon->out) {
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 			return 0;
@@ -1578,7 +1580,7 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 	case SMP_CMD_PUBLIC_KEY:
 	default:
 		/* Initiating device starts the round */
-		if (!hcon->out)
+		if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			return 0;
 
 		bt_dev_dbg(hdev, "Starting passkey round %u",
@@ -1623,7 +1625,7 @@ static int sc_user_reply(struct smp_chan *smp, u16 mgmt_op, __le32 passkey)
 	}
 
 	/* Initiator sends DHKey check first */
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		sc_dhkey_check(smp);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
 	} else if (test_and_clear_bit(SMP_FLAG_DHKEY_PENDING, &smp->flags)) {
@@ -1746,7 +1748,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct hci_dev *hdev = conn->hcon->hdev;
-	struct smp_chan *smp;
+	struct smp_chan *smp = chan->data;
 	u8 key_size, auth, sec_level;
 	int ret;
 
@@ -1755,16 +1757,14 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*req))
 		return SMP_INVALID_PARAMS;
 
-	if (conn->hcon->role != HCI_ROLE_SLAVE)
+	if (smp && test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return SMP_CMD_NOTSUPP;
 
-	if (!chan->data)
+	if (!smp) {
 		smp = smp_chan_create(conn);
-	else
-		smp = chan->data;
-
-	if (!smp)
-		return SMP_UNSPECIFIED;
+		if (!smp)
+			return SMP_UNSPECIFIED;
+	}
 
 	/* We didn't start the pairing, so match remote */
 	auth = req->auth_req & AUTH_REQ_MASK(hdev);
@@ -1946,7 +1946,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rsp))
 		return SMP_INVALID_PARAMS;
 
-	if (conn->hcon->role != HCI_ROLE_MASTER)
+	if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return SMP_CMD_NOTSUPP;
 
 	skb_pull(skb, sizeof(*rsp));
@@ -2041,7 +2041,7 @@ static u8 sc_check_confirm(struct smp_chan *smp)
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		return sc_passkey_round(smp, SMP_CMD_PAIRING_CONFIRM);
 
-	if (conn->hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
@@ -2063,7 +2063,7 @@ static int fixup_sc_false_positive(struct smp_chan *smp)
 	u8 auth;
 
 	/* The issue is only observed when we're in responder role */
-	if (hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return SMP_UNSPECIFIED;
 
 	if (hci_dev_test_flag(hdev, HCI_SC_ONLY)) {
@@ -2099,7 +2099,8 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct hci_dev *hdev = hcon->hdev;
 
 	bt_dev_dbg(hdev, "conn %p %s", conn,
-		   hcon->out ? "initiator" : "responder");
+		   test_bit(SMP_FLAG_INITIATOR, &smp->flags) ? "initiator" :
+		   "responder");
 
 	if (skb->len < sizeof(smp->pcnf))
 		return SMP_INVALID_PARAMS;
@@ -2121,7 +2122,7 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 			return ret;
 	}
 
-	if (conn->hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
@@ -2156,7 +2157,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_bit(SMP_FLAG_SC, &smp->flags))
 		return smp_random(smp);
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		pkax = smp->local_pk;
 		pkbx = smp->remote_pk;
 		na   = smp->prnd;
@@ -2169,7 +2170,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	if (smp->method == REQ_OOB) {
-		if (!hcon->out)
+		if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
@@ -2180,7 +2181,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		return sc_passkey_round(smp, SMP_CMD_PAIRING_RANDOM);
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		u8 cfm[16];
 
 		err = smp_f4(smp->tfm_cmac, smp->remote_pk, smp->local_pk,
@@ -2221,7 +2222,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		return SMP_UNSPECIFIED;
 
 	if (smp->method == REQ_OOB) {
-		if (hcon->out) {
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 			sc_dhkey_check(smp);
 			SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
 		}
@@ -2295,10 +2296,27 @@ bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
 	return false;
 }
 
+static void smp_send_pairing_req(struct smp_chan *smp, __u8 auth)
+{
+	struct smp_cmd_pairing cp;
+
+	if (smp->conn->hcon->type == ACL_LINK)
+		build_bredr_pairing_cmd(smp, &cp, NULL);
+	else
+		build_pairing_cmd(smp->conn, &cp, NULL, auth);
+
+	smp->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&smp->preq[1], &cp, sizeof(cp));
+
+	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+
+	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
+}
+
 static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_security_req *rp = (void *) skb->data;
-	struct smp_cmd_pairing cp;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 	struct smp_chan *smp;
@@ -2347,18 +2365,22 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rp));
 
-	memset(&cp, 0, sizeof(cp));
-	build_pairing_cmd(conn, &cp, NULL, auth);
-
-	smp->preq[0] = SMP_CMD_PAIRING_REQ;
-	memcpy(&smp->preq[1], &cp, sizeof(cp));
-
-	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
-	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+	smp_send_pairing_req(smp, auth);
 
 	return 0;
 }
 
+static void smp_send_security_req(struct smp_chan *smp, __u8 auth)
+{
+	struct smp_cmd_security_req cp;
+
+	cp.auth_req = auth;
+	smp_send_cmd(smp->conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_REQ);
+
+	clear_bit(SMP_FLAG_INITIATOR, &smp->flags);
+}
+
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
@@ -2427,23 +2449,11 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 			authreq |= SMP_AUTH_MITM;
 	}
 
-	if (hcon->role == HCI_ROLE_MASTER) {
-		struct smp_cmd_pairing cp;
+	if (hcon->role == HCI_ROLE_MASTER)
+		smp_send_pairing_req(smp, authreq);
+	else
+		smp_send_security_req(smp, authreq);
 
-		build_pairing_cmd(conn, &cp, NULL, authreq);
-		smp->preq[0] = SMP_CMD_PAIRING_REQ;
-		memcpy(&smp->preq[1], &cp, sizeof(cp));
-
-		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
-		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
-	} else {
-		struct smp_cmd_security_req cp;
-		cp.auth_req = authreq;
-		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
-		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_REQ);
-	}
-
-	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
 	ret = 0;
 
 unlock:
@@ -2694,8 +2704,6 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 sc_select_method(struct smp_chan *smp)
 {
-	struct l2cap_conn *conn = smp->conn;
-	struct hci_conn *hcon = conn->hcon;
 	struct smp_cmd_pairing *local, *remote;
 	u8 local_mitm, remote_mitm, local_io, remote_io, method;
 
@@ -2708,7 +2716,7 @@ static u8 sc_select_method(struct smp_chan *smp)
 	 * the "struct smp_cmd_pairing" from them we need to skip the
 	 * first byte which contains the opcode.
 	 */
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local = (void *) &smp->preq[1];
 		remote = (void *) &smp->prsp[1];
 	} else {
@@ -2777,7 +2785,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* Non-initiating device sends its public key after receiving
 	 * the key from the initiating device.
 	 */
-	if (!hcon->out) {
+	if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		err = sc_send_public_key(smp);
 		if (err)
 			return err;
@@ -2839,7 +2847,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	if (smp->method == REQ_OOB) {
-		if (hcon->out)
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 
@@ -2848,7 +2856,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 		return 0;
 	}
 
-	if (hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 
 	if (smp->method == REQ_PASSKEY) {
@@ -2863,7 +2871,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* The Initiating device waits for the non-initiating device to
 	 * send the confirm value.
 	 */
-	if (conn->hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return 0;
 
 	err = smp_f4(smp->tfm_cmac, smp->local_pk, smp->remote_pk, smp->prnd,
@@ -2897,7 +2905,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	a[6] = hcon->init_addr_type;
 	b[6] = hcon->resp_addr_type;
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local_addr = a;
 		remote_addr = b;
 		memcpy(io_cap, &smp->prsp[1], 3);
@@ -2922,7 +2930,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (crypto_memneq(check->e, e, 16))
 		return SMP_DHKEY_CHECK_FAILED;
 
-	if (!hcon->out) {
+	if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		if (test_bit(SMP_FLAG_WAIT_USER, &smp->flags)) {
 			set_bit(SMP_FLAG_DHKEY_PENDING, &smp->flags);
 			return 0;
@@ -2934,7 +2942,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	sc_add_ltk(smp);
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		hci_le_start_enc(hcon, 0, 0, smp->tk, smp->enc_key_size);
 		hcon->enc_key_size = smp->enc_key_size;
 	}
@@ -3083,7 +3091,6 @@ static void bredr_pairing(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
-	struct smp_cmd_pairing req;
 	struct smp_chan *smp;
 
 	bt_dev_dbg(hdev, "chan %p", chan);
@@ -3135,14 +3142,7 @@ static void bredr_pairing(struct l2cap_chan *chan)
 
 	bt_dev_dbg(hdev, "starting SMP over BR/EDR");
 
-	/* Prepare and send the BR/EDR SMP Pairing Request */
-	build_bredr_pairing_cmd(smp, &req, NULL);
-
-	smp->preq[0] = SMP_CMD_PAIRING_REQ;
-	memcpy(&smp->preq[1], &req, sizeof(req));
-
-	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(req), &req);
-	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+	smp_send_pairing_req(smp, 0x00);
 }
 
 static void smp_resume_cb(struct l2cap_chan *chan)
-- 
2.46.0

