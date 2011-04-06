Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 13/15] Bluetooth: Add support for Pairing features exchange
Date: Tue,  5 Apr 2011 22:51:54 -0300
Message-Id: <1302054716-24534-14-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements a simple version of the SMP Pairing Features
exchange procedure (Vol. 3 Part H, Section 2.3.5.1).

For now, everything that would cause a Pairing Method different of
Just Works to be chosen is rejected.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_event.c |    1 +
 net/bluetooth/smp.c       |  117 ++++++++++++++++++++++++--------------------
 2 files changed, 65 insertions(+), 53 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index aa0d013..e40ce9a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1555,6 +1555,7 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
 				/* Encryption implies authentication */
 				conn->link_mode |= HCI_LM_AUTH;
 				conn->link_mode |= HCI_LM_ENCRYPT;
+				conn->sec_level = conn->pending_sec_level;
 			} else
 				conn->link_mode &= ~HCI_LM_ENCRYPT;
 		}
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2724b70..b6f52ab 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -186,7 +186,30 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 	hci_send_acl(conn->hcon, skb, 0);
 }
 
-static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
+static __u8 seclevel_to_authreq(__u8 level)
+{
+	switch (level) {
+	case BT_SECURITY_HIGH:
+		/* Right now we don't support bonding */
+		return SMP_AUTH_MITM;
+
+	default:
+		return SMP_AUTH_NONE;
+	}
+}
+
+static void build_pairing_cmd(struct l2cap_conn *conn,
+				struct smp_cmd_pairing *cmd, __u8 authreq)
+{
+	cmd->io_capability = SMP_IO_NO_INPUT_OUTPUT;
+	cmd->oob_flag = SMP_OOB_NOT_PRESENT;
+	cmd->max_key_size = 16;
+	cmd->init_key_dist = 0x00;
+	cmd->resp_key_dist = 0x00;
+	cmd->auth_req = authreq;
+}
+
+static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing *rp = (void *) skb->data;
 
@@ -196,12 +219,11 @@ static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&conn->preq[1], rp, sizeof(*rp));
 	skb_pull(skb, sizeof(*rp));
 
-	rp->io_capability = 0x00;
-	rp->oob_flag = 0x00;
-	rp->max_key_size = 16;
-	rp->init_key_dist = 0x00;
-	rp->resp_key_dist = 0x00;
-	rp->auth_req &= (SMP_AUTH_BONDING | SMP_AUTH_MITM);
+	if (rp->oob_flag)
+		return SMP_OOB_NOT_AVAIL;
+
+	/* We didn't start the pairing, so no requirements */
+	build_pairing_cmd(conn, rp, SMP_AUTH_NONE);
 
 	/* Just works */
 	memset(conn->tk, 0, sizeof(conn->tk));
@@ -210,9 +232,11 @@ static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&conn->prsp[1], rp, sizeof(*rp));
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(*rp), rp);
+
+	return 0;
 }
 
-static void smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
+static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing *rp = (void *) skb->data;
 	struct smp_cmd_pairing_confirm cp;
@@ -222,29 +246,34 @@ static void smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
+	skb_pull(skb, sizeof(*rp));
+
+	if (rp->oob_flag)
+		return SMP_OOB_NOT_AVAIL;
+
 	/* Just works */
 	memset(conn->tk, 0, sizeof(conn->tk));
 
 	conn->prsp[0] = SMP_CMD_PAIRING_RSP;
 	memcpy(&conn->prsp[1], rp, sizeof(*rp));
-	skb_pull(skb, sizeof(*rp));
 
 	ret = smp_rand(conn->prnd);
 	if (ret)
-		return;
+		return SMP_UNSPECIFIED;
 
 	ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp, 0,
 			conn->src, 0, conn->dst, res);
 	if (ret)
-		return;
+		return SMP_UNSPECIFIED;
 
 	swap128(res, cp.confirm_val);
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
+
+	return 0;
 }
 
-static void smp_cmd_pairing_confirm(struct l2cap_conn *conn,
-							struct sk_buff *skb)
+static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
 
@@ -266,20 +295,22 @@ static void smp_cmd_pairing_confirm(struct l2cap_conn *conn,
 
 		ret = smp_rand(conn->prnd);
 		if (ret)
-			return;
+			return SMP_UNSPECIFIED;
 
 		ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp,
 					0, conn->dst, 0, conn->src, res);
 		if (ret)
-			return;
+			return SMP_CONFIRM_FAILED;
 
 		swap128(res, cp.confirm_val);
 
 		smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 	}
+
+	return 0;
 }
 
-static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
+static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct hci_conn *hcon = conn->hcon;
 	struct crypto_blkcipher *tfm = hcon->hdev->tfm;
@@ -298,19 +329,15 @@ static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
 				conn->dst, 0, conn->src, res);
 	if (ret)
-		return;
+		return SMP_UNSPECIFIED;
 
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
 	swap128(res, confirm);
 
 	if (memcmp(conn->pcnf, confirm, sizeof(conn->pcnf)) != 0) {
-		struct smp_cmd_pairing_fail cp;
-
 		BT_ERR("Pairing failed (confirmation values mismatch)");
-		cp.reason = SMP_CONFIRM_FAILED;
-		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(cp), &cp);
-		return;
+		return SMP_CONFIRM_FAILED;
 	}
 
 	if (conn->hcon->out) {
@@ -335,9 +362,11 @@ static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 							sizeof(buf), 0);
 		BT_DBG("key %s", buf);
 	}
+
+	return 0;
 }
 
-static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
+static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_security_req *rp = (void *) skb->data;
 	struct smp_cmd_pairing cp;
@@ -346,17 +375,12 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	BT_DBG("conn %p", conn);
 
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
-		return;
+		return 0;
 
 	skb_pull(skb, sizeof(*rp));
-	memset(&cp, 0, sizeof(cp));
 
-	cp.io_capability = 0x00;
-	cp.oob_flag = 0x00;
-	cp.max_key_size = 16;
-	cp.init_key_dist = 0x00;
-	cp.resp_key_dist = 0x00;
-	cp.auth_req = rp->auth_req & (SMP_AUTH_BONDING | SMP_AUTH_MITM);
+	memset(&cp, 0, sizeof(cp));
+	build_pairing_cmd(conn, &cp, rp->auth_req);
 
 	conn->preq[0] = SMP_CMD_PAIRING_REQ;
 	memcpy(&conn->preq[1], &cp, sizeof(cp));
@@ -364,18 +388,8 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 
 	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
-}
 
-static __u8 seclevel_to_authreq(__u8 level)
-{
-	switch (level) {
-	case BT_SECURITY_HIGH:
-		/* For now we don't support bonding */
-		return SMP_AUTH_MITM;
-
-	default:
-		return SMP_AUTH_NONE;
-	}
+	return 0;
 }
 
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
@@ -401,13 +415,8 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 
 	if (hcon->link_mode & HCI_LM_MASTER) {
 		struct smp_cmd_pairing cp;
-		cp.io_capability = 0x00;
-		cp.oob_flag = 0x00;
-		cp.max_key_size = 16;
-		cp.init_key_dist = 0x00;
-		cp.resp_key_dist = 0x00;
-		cp.auth_req = authreq;
 
+		build_pairing_cmd(conn, &cp, authreq);
 		conn->preq[0] = SMP_CMD_PAIRING_REQ;
 		memcpy(&conn->preq[1], &cp, sizeof(cp));
 
@@ -440,26 +449,28 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	switch (code) {
 	case SMP_CMD_PAIRING_REQ:
-		smp_cmd_pairing_req(conn, skb);
+		reason = smp_cmd_pairing_req(conn, skb);
 		break;
 
 	case SMP_CMD_PAIRING_FAIL:
+		reason = 0;
+		err = -EPERM;
 		break;
 
 	case SMP_CMD_PAIRING_RSP:
-		smp_cmd_pairing_rsp(conn, skb);
+		reason = smp_cmd_pairing_rsp(conn, skb);
 		break;
 
 	case SMP_CMD_SECURITY_REQ:
-		smp_cmd_security_req(conn, skb);
+		reason = smp_cmd_security_req(conn, skb);
 		break;
 
 	case SMP_CMD_PAIRING_CONFIRM:
-		smp_cmd_pairing_confirm(conn, skb);
+		reason = smp_cmd_pairing_confirm(conn, skb);
 		break;
 
 	case SMP_CMD_PAIRING_RANDOM:
-		smp_cmd_pairing_random(conn, skb);
+		reason = smp_cmd_pairing_random(conn, skb);
 		break;
 
 	case SMP_CMD_ENCRYPT_INFO:
-- 
1.7.4.1

