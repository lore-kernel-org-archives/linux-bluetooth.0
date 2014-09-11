Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Fix ignoring unknown SMP authentication requirement bits
Date: Wed, 10 Sep 2014 17:37:42 -0700
Message-Id: <1410395866-24301-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1410395866-24301-1-git-send-email-johan.hedberg@gmail.com>
References: <1410395866-24301-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The SMP specification states that we should ignore any unknown bits from
the authentication requirement. We already have a define for masking out
unknown bits but we haven't used it in all places so far. This patch
adds usage of the AUTH_REQ_MASK to all places that need it and ensures
that we don't pass unknown bits onward to other functions.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index dbd17a07dc2e..ef8f96d2c059 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -949,8 +949,11 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!smp)
 		return SMP_UNSPECIFIED;
 
+	/* We didn't start the pairing, so match remote */
+	auth = req->auth_req & AUTH_REQ_MASK;
+
 	if (!test_bit(HCI_BONDABLE, &hdev->dev_flags) &&
-	    (req->auth_req & SMP_AUTH_BONDING))
+	    (auth & SMP_AUTH_BONDING))
 		return SMP_PAIRING_NOTSUPP;
 
 	SMP_DISALLOW_CMD(smp, SMP_CMD_PAIRING_REQ);
@@ -959,9 +962,6 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&smp->preq[1], req, sizeof(*req));
 	skb_pull(skb, sizeof(*req));
 
-	/* We didn't start the pairing, so match remote */
-	auth = req->auth_req;
-
 	sec_level = authreq_to_seclevel(auth);
 	if (sec_level > conn->hcon->pending_sec_level)
 		conn->hcon->pending_sec_level = sec_level;
@@ -1024,6 +1024,8 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (check_enc_key_size(conn, key_size))
 		return SMP_ENC_KEY_SIZE;
 
+	auth = rsp->auth_req & AUTH_REQ_MASK;
+
 	/* If we need MITM check that it can be acheived */
 	if (conn->hcon->pending_sec_level >= BT_SECURITY_HIGH) {
 		u8 method;
@@ -1044,7 +1046,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	 */
 	smp->remote_key_dist &= rsp->resp_key_dist;
 
-	auth = (req->auth_req | rsp->auth_req);
+	auth |= req->auth_req;
 
 	ret = tk_request(conn, 0, auth, req->io_capability, rsp->io_capability);
 	if (ret)
@@ -1160,7 +1162,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_pairing cp;
 	struct hci_conn *hcon = conn->hcon;
 	struct smp_chan *smp;
-	u8 sec_level;
+	u8 sec_level, auth;
 
 	BT_DBG("conn %p", conn);
 
@@ -1170,7 +1172,9 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (hcon->role != HCI_ROLE_MASTER)
 		return SMP_CMD_NOTSUPP;
 
-	sec_level = authreq_to_seclevel(rp->auth_req);
+	auth = rp->auth_req & AUTH_REQ_MASK;
+
+	sec_level = authreq_to_seclevel(auth);
 	if (smp_sufficient_security(hcon, sec_level))
 		return 0;
 
@@ -1185,13 +1189,13 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 		return SMP_UNSPECIFIED;
 
 	if (!test_bit(HCI_BONDABLE, &hcon->hdev->dev_flags) &&
-	    (rp->auth_req & SMP_AUTH_BONDING))
+	    (auth & SMP_AUTH_BONDING))
 		return SMP_PAIRING_NOTSUPP;
 
 	skb_pull(skb, sizeof(*rp));
 
 	memset(&cp, 0, sizeof(cp));
-	build_pairing_cmd(conn, &cp, NULL, rp->auth_req);
+	build_pairing_cmd(conn, &cp, NULL, auth);
 
 	smp->preq[0] = SMP_CMD_PAIRING_REQ;
 	memcpy(&smp->preq[1], &cp, sizeof(cp));
-- 
1.9.3

