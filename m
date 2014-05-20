Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: Rename smp->smp_flags to smp->flags
Date: Tue, 20 May 2014 09:45:50 +0300
Message-Id: <1400568352-20454-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
References: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no reason to have "smp" in this variable name since it is
already part of the SMP struct which provides sufficient context.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index efb73fdf710d..8d1a1903e458 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -59,7 +59,7 @@ struct smp_chan {
 	struct smp_ltk	*ltk;
 	struct smp_ltk	*slave_ltk;
 	struct smp_irk	*remote_irk;
-	unsigned long	smp_flags;
+	unsigned long	flags;
 };
 
 static inline void swap128(const u8 src[16], u8 dst[16])
@@ -396,7 +396,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 
 	/* Initialize key for JUST WORKS */
 	memset(smp->tk, 0, sizeof(smp->tk));
-	clear_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
+	clear_bit(SMP_FLAG_TK_VALID, &smp->flags);
 
 	BT_DBG("tk_request: auth:%d lcl:%d rem:%d", auth, local_io, remote_io);
 
@@ -415,19 +415,18 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 		method = JUST_WORKS;
 
 	/* Don't confirm locally initiated pairing attempts */
-	if (method == JUST_CFM && test_bit(SMP_FLAG_INITIATOR,
-					   &smp->smp_flags))
+	if (method == JUST_CFM && test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		method = JUST_WORKS;
 
 	/* If Just Works, Continue with Zero TK */
 	if (method == JUST_WORKS) {
-		set_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
+		set_bit(SMP_FLAG_TK_VALID, &smp->flags);
 		return 0;
 	}
 
 	/* Not Just Works/Confirm results in MITM Authentication */
 	if (method != JUST_CFM)
-		set_bit(SMP_FLAG_MITM_AUTH, &smp->smp_flags);
+		set_bit(SMP_FLAG_MITM_AUTH, &smp->flags);
 
 	/* If both devices have Keyoard-Display I/O, the master
 	 * Confirms and the slave Enters the passkey.
@@ -446,7 +445,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 		passkey %= 1000000;
 		put_unaligned_le32(passkey, smp->tk);
 		BT_DBG("PassKey: %d", passkey);
-		set_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
+		set_bit(SMP_FLAG_TK_VALID, &smp->flags);
 	}
 
 	hci_dev_lock(hcon->hdev);
@@ -494,7 +493,7 @@ static void smp_confirm(struct smp_chan *smp)
 		goto error;
 	}
 
-	clear_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags);
+	clear_bit(SMP_FLAG_CFM_PENDING, &smp->flags);
 
 	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 
@@ -605,7 +604,7 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 
 	BUG_ON(!smp);
 
-	complete = test_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
+	complete = test_bit(SMP_FLAG_COMPLETE, &smp->flags);
 	mgmt_smp_complete(conn->hcon, complete);
 
 	kfree(smp->csrk);
@@ -656,7 +655,7 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 		put_unaligned_le32(value, smp->tk);
 		/* Fall Through */
 	case MGMT_OP_USER_CONFIRM_REPLY:
-		set_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
+		set_bit(SMP_FLAG_TK_VALID, &smp->flags);
 		break;
 	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
 	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
@@ -668,7 +667,7 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	}
 
 	/* If it is our turn to send Pairing Confirm, do so now */
-	if (test_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags))
+	if (test_bit(SMP_FLAG_CFM_PENDING, &smp->flags))
 		smp_confirm(smp);
 
 	return 0;
@@ -724,7 +723,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (ret)
 		return SMP_UNSPECIFIED;
 
-	clear_bit(SMP_FLAG_INITIATOR, &smp->smp_flags);
+	clear_bit(SMP_FLAG_INITIATOR, &smp->flags);
 
 	return 0;
 }
@@ -772,10 +771,10 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (ret)
 		return SMP_UNSPECIFIED;
 
-	set_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags);
+	set_bit(SMP_FLAG_CFM_PENDING, &smp->flags);
 
 	/* Can't compose response until we have been confirmed */
-	if (test_bit(SMP_FLAG_TK_VALID, &smp->smp_flags))
+	if (test_bit(SMP_FLAG_TK_VALID, &smp->flags))
 		smp_confirm(smp);
 
 	return 0;
@@ -796,10 +795,10 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (conn->hcon->out)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
-	else if (test_bit(SMP_FLAG_TK_VALID, &smp->smp_flags))
+	else if (test_bit(SMP_FLAG_TK_VALID, &smp->flags))
 		smp_confirm(smp);
 	else
-		set_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags);
+		set_bit(SMP_FLAG_CFM_PENDING, &smp->flags);
 
 	return 0;
 }
@@ -878,7 +877,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 
-	clear_bit(SMP_FLAG_INITIATOR, &smp->smp_flags);
+	clear_bit(SMP_FLAG_INITIATOR, &smp->flags);
 
 	return 0;
 }
@@ -945,7 +944,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
 	}
 
-	set_bit(SMP_FLAG_INITIATOR, &smp->smp_flags);
+	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
 
 done:
 	hcon->pending_sec_level = sec_level;
@@ -1375,7 +1374,7 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 
 	clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
 	cancel_delayed_work_sync(&conn->security_timer);
-	set_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
+	set_bit(SMP_FLAG_COMPLETE, &smp->flags);
 	smp_notify_keys(conn);
 
 	smp_chan_destroy(conn);
-- 
1.9.0

