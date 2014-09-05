Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 8/8] Bluetooth: Add strict checks for allowed SMP PDUs
Date: Fri,  5 Sep 2014 22:19:55 +0300
Message-Id: <1409944795-21916-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1409944795-21916-1-git-send-email-johan.hedberg@gmail.com>
References: <1409944795-21916-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

SMP defines quite clearly when certain PDUs are to be expected/allowed
and when not, but doesn't have any explicit request/response definition.
So far the code has relied on each PDU handler to behave correctly if
receiving PDUs at an unexpected moment, however this requires many
different checks and is prone to errors.

This patch introduces a generic way to keep track of allowed PDUs and
thereby reduces the responsibility & load on individual command
handlers. The tracking is implemented using a simple bit-mask where each
opcode maps to its own bit. If the bit is set the corresponding PDU is
allow and if the bit is not set the PDU is not allowed.

As a simple example, when we send the Pairing Request we'd set the bit
for Pairing Response, and when we receive the Pairing Response we'd
clear the bit for Pairing Response.

Since the disallowed PDU rejection is now done in a single central place
we need to be a bit careful of which action makes most sense to all
cases. Previously some, such as Security Request, have been simply
ignored whereas others have caused an explicit disconnect.

The only PDU rejection action that keeps good interoperability and can
be used for all the applicable use cases is to drop the data. This may
raise some concerns of us now being more lenient for misbehaving (and
potentially malicious) devices, but the policy of simply dropping data
has been a successful one for many years e.g. in L2CAP (where this is
the *only* policy for such cases - we never request disconnection in
l2cap_core.c because of bad data). Furthermore, we cannot prevent
connected devices from creating the SMP context (through a Security or
Pairing Request), and once the context exists looking up the
corresponding bit for the received opcode and deciding to reject it is
essentially an equally lightweight operation as the kind of rejection
that l2cap_core.c already successfully does.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 120 +++++++++++++++++++++++++++++++++++-----------------
 net/bluetooth/smp.h |   2 +
 2 files changed, 84 insertions(+), 38 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index e76c963011e5..1201670afe38 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -31,6 +31,9 @@
 
 #include "smp.h"
 
+#define SMP_ALLOW_CMD(smp, code)	set_bit(code, &smp->allow_cmd)
+#define SMP_DISALLOW_CMD(smp, code)	clear_bit(code, &smp->allow_cmd)
+
 #define SMP_TIMEOUT	msecs_to_jiffies(30000)
 
 #define AUTH_REQ_MASK   0x07
@@ -47,6 +50,7 @@ enum {
 struct smp_chan {
 	struct l2cap_conn	*conn;
 	struct delayed_work	security_timer;
+	unsigned long           allow_cmd; /* Bitmask of allowed commands */
 
 	u8		preq[7]; /* SMP Pairing Request */
 	u8		prsp[7]; /* SMP Pairing Response */
@@ -553,6 +557,11 @@ static u8 smp_confirm(struct smp_chan *smp)
 
 	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 
+	if (conn->hcon->out)
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
+	else
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
+
 	return 0;
 }
 
@@ -691,6 +700,20 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 }
 
+static void smp_allow_key_dist(struct smp_chan *smp)
+{
+	/* Allow the first expected phase 3 PDU. The rest of the PDUs
+	 * will be allowed in each PDU handler to ensure we receive
+	 * them in the correct order.
+	 */
+	if (smp->remote_key_dist & SMP_DIST_ENC_KEY)
+		SMP_ALLOW_CMD(smp, SMP_CMD_ENCRYPT_INFO);
+	else if (smp->remote_key_dist & SMP_DIST_ID_KEY)
+		SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_INFO);
+	else if (smp->remote_key_dist & SMP_DIST_SIGN)
+		SMP_ALLOW_CMD(smp, SMP_CMD_SIGN_INFO);
+}
+
 static void smp_distribute_keys(struct smp_chan *smp)
 {
 	struct smp_cmd_pairing *req, *rsp;
@@ -704,8 +727,10 @@ static void smp_distribute_keys(struct smp_chan *smp)
 	rsp = (void *) &smp->prsp[1];
 
 	/* The responder sends its keys first */
-	if (hcon->out && (smp->remote_key_dist & KEY_DIST_MASK))
+	if (hcon->out && (smp->remote_key_dist & KEY_DIST_MASK)) {
+		smp_allow_key_dist(smp);
 		return;
+	}
 
 	req = (void *) &smp->preq[1];
 
@@ -790,8 +815,10 @@ static void smp_distribute_keys(struct smp_chan *smp)
 	}
 
 	/* If there are still keys to be received wait for them */
-	if (smp->remote_key_dist & KEY_DIST_MASK)
+	if (smp->remote_key_dist & KEY_DIST_MASK) {
+		smp_allow_key_dist(smp);
 		return;
+	}
 
 	set_bit(SMP_FLAG_COMPLETE, &smp->flags);
 	smp_notify_keys(conn);
@@ -829,6 +856,8 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	smp->conn = conn;
 	chan->data = smp;
 
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_FAIL);
+
 	INIT_DELAYED_WORK(&smp->security_timer, smp_timeout);
 
 	hci_conn_hold(conn->hcon);
@@ -925,6 +954,8 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	    (req->auth_req & SMP_AUTH_BONDING))
 		return SMP_PAIRING_NOTSUPP;
 
+	SMP_DISALLOW_CMD(smp, SMP_CMD_PAIRING_REQ);
+
 	smp->preq[0] = SMP_CMD_PAIRING_REQ;
 	memcpy(&smp->preq[1], req, sizeof(*req));
 	skb_pull(skb, sizeof(*req));
@@ -958,6 +989,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&smp->prsp[1], &rsp, sizeof(rsp));
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(rsp), &rsp);
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 
 	/* Request setup of TK */
 	ret = tk_request(conn, 0, auth, rsp.io_capability, req->io_capability);
@@ -983,6 +1015,8 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (conn->hcon->role != HCI_ROLE_MASTER)
 		return SMP_CMD_NOTSUPP;
 
+	SMP_DISALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+
 	skb_pull(skb, sizeof(*rsp));
 
 	req = (void *) &smp->preq[1];
@@ -1040,13 +1074,19 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(smp->pcnf))
 		return SMP_INVALID_PARAMS;
 
+	SMP_DISALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
+
 	memcpy(smp->pcnf, skb->data, sizeof(smp->pcnf));
 	skb_pull(skb, sizeof(smp->pcnf));
 
-	if (conn->hcon->out)
+	if (conn->hcon->out) {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
-	else if (test_bit(SMP_FLAG_TK_VALID, &smp->flags))
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
+		return 0;
+	}
+
+	if (test_bit(SMP_FLAG_TK_VALID, &smp->flags))
 		return smp_confirm(smp);
 	else
 		set_bit(SMP_FLAG_CFM_PENDING, &smp->flags);
@@ -1064,6 +1104,8 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(smp->rrnd))
 		return SMP_INVALID_PARAMS;
 
+	SMP_DISALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
+
 	memcpy(smp->rrnd, skb->data, sizeof(smp->rrnd));
 	skb_pull(skb, sizeof(smp->rrnd));
 
@@ -1122,7 +1164,6 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_security_req *rp = (void *) skb->data;
 	struct smp_cmd_pairing cp;
 	struct hci_conn *hcon = conn->hcon;
-	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp;
 	u8 sec_level;
 
@@ -1144,10 +1185,6 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (smp_ltk_encrypt(conn, hcon->pending_sec_level))
 		return 0;
 
-	/* If SMP is already in progress ignore this request */
-	if (chan->data)
-		return 0;
-
 	smp = smp_chan_create(conn);
 	if (!smp)
 		return SMP_UNSPECIFIED;
@@ -1165,6 +1202,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&smp->preq[1], &cp, sizeof(cp));
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
 
 	return 0;
 }
@@ -1227,10 +1265,12 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 		memcpy(&smp->preq[1], &cp, sizeof(cp));
 
 		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
 	} else {
 		struct smp_cmd_security_req cp;
 		cp.auth_req = authreq;
 		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_REQ);
 	}
 
 	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
@@ -1252,9 +1292,8 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
 
-	/* Ignore this PDU if it wasn't requested */
-	if (!(smp->remote_key_dist & SMP_DIST_ENC_KEY))
-		return 0;
+	SMP_DISALLOW_CMD(smp, SMP_CMD_ENCRYPT_INFO);
+	SMP_ALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
 
 	skb_pull(skb, sizeof(*rp));
 
@@ -1278,13 +1317,13 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
 
-	/* Ignore this PDU if it wasn't requested */
-	if (!(smp->remote_key_dist & SMP_DIST_ENC_KEY))
-		return 0;
-
 	/* Mark the information as received */
 	smp->remote_key_dist &= ~SMP_DIST_ENC_KEY;
 
+	SMP_DISALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
+	if (smp->remote_key_dist & SMP_DIST_ID_KEY)
+		SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_INFO);
+
 	skb_pull(skb, sizeof(*rp));
 
 	hci_dev_lock(hdev);
@@ -1311,9 +1350,8 @@ static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*info))
 		return SMP_INVALID_PARAMS;
 
-	/* Ignore this PDU if it wasn't requested */
-	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
-		return 0;
+	SMP_DISALLOW_CMD(smp, SMP_CMD_IDENT_INFO);
+	SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_ADDR_INFO);
 
 	skb_pull(skb, sizeof(*info));
 
@@ -1336,13 +1374,13 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	if (skb->len < sizeof(*info))
 		return SMP_INVALID_PARAMS;
 
-	/* Ignore this PDU if it wasn't requested */
-	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
-		return 0;
-
 	/* Mark the information as received */
 	smp->remote_key_dist &= ~SMP_DIST_ID_KEY;
 
+	SMP_DISALLOW_CMD(smp, SMP_CMD_IDENT_ADDR_INFO);
+	if (smp->remote_key_dist & SMP_DIST_SIGN)
+		SMP_ALLOW_CMD(smp, SMP_CMD_SIGN_INFO);
+
 	skb_pull(skb, sizeof(*info));
 
 	hci_dev_lock(hcon->hdev);
@@ -1392,13 +1430,11 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
 
-	/* Ignore this PDU if it wasn't requested */
-	if (!(smp->remote_key_dist & SMP_DIST_SIGN))
-		return 0;
-
 	/* Mark the information as received */
 	smp->remote_key_dist &= ~SMP_DIST_SIGN;
 
+	SMP_DISALLOW_CMD(smp, SMP_CMD_SIGN_INFO);
+
 	skb_pull(skb, sizeof(*rp));
 
 	hci_dev_lock(hdev);
@@ -1418,6 +1454,7 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
+	struct smp_chan *smp;
 	__u8 code, reason;
 	int err = 0;
 
@@ -1437,18 +1474,19 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 	code = skb->data[0];
 	skb_pull(skb, sizeof(code));
 
-	/*
-	 * The SMP context must be initialized for all other PDUs except
-	 * pairing and security requests. If we get any other PDU when
-	 * not initialized simply disconnect (done if this function
-	 * returns an error).
+	smp = chan->data;
+
+	if (code > SMP_CMD_MAX)
+		goto drop;
+
+	if (smp && !test_bit(code, &smp->allow_cmd))
+		goto drop;
+
+	/* If we don't have a context the only allowed commands are
+	 * pairing request and security request.
 	 */
-	if (code != SMP_CMD_PAIRING_REQ && code != SMP_CMD_SECURITY_REQ &&
-	    !chan->data) {
-		BT_ERR("Unexpected SMP command 0x%02x. Disconnecting.", code);
-		err = -EOPNOTSUPP;
-		goto done;
-	}
+	if (!smp && code != SMP_CMD_PAIRING_REQ && code != SMP_CMD_SECURITY_REQ)
+		goto drop;
 
 	switch (code) {
 	case SMP_CMD_PAIRING_REQ:
@@ -1510,6 +1548,12 @@ done:
 	}
 
 	return err;
+
+drop:
+	BT_ERR("%s unexpected SMP command 0x%02x from %pMR", hcon->hdev->name,
+	       code, &hcon->dst);
+	kfree_skb(skb);
+	return 0;
 }
 
 static void smp_teardown_cb(struct l2cap_chan *chan, int err)
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index cf1094617c69..5240537efde3 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -102,6 +102,8 @@ struct smp_cmd_security_req {
 	__u8	auth_req;
 } __packed;
 
+#define SMP_CMD_MAX		0x0b
+
 #define SMP_PASSKEY_ENTRY_FAILED	0x01
 #define SMP_OOB_NOT_AVAIL		0x02
 #define SMP_AUTH_REQUIREMENTS		0x03
-- 
1.9.3

