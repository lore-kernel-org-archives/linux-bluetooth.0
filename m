Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 30/49] Bluetooth: Add passkey entry support for LE SC
Date: Wed,  3 Dec 2014 17:02:24 +0200
Message-Id: <1417618963-18010-31-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The passkey entry mechanism involves either both sides requesting the
user for a passkey, or one side requesting the passkey while the other
one displays it. The behavior as far as SMP PDUs are concerned are
considerably different from numeric comparison and therefore requires
several new functions to handle it.

In essence passkey entry involves both sides gradually committing to
each bit of the passkey which involves 20 rounds of pairing confirm and
pairing random PDUS being sent in both directions.

This patch adds a new smp->passkey_round variable to track the current
round of the passkey commitment and reuses the variables already present
in struct hci_conn for the passkey and entered key count.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 180 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 861d2cf3ccc9..7a9b491ffa1a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -55,6 +55,7 @@ enum {
 	SMP_FLAG_SC,
 	SMP_FLAG_REMOTE_PK,
 	SMP_FLAG_DEBUG_KEY,
+	SMP_FLAG_WAIT_USER,
 };
 
 struct smp_chan {
@@ -81,6 +82,7 @@ struct smp_chan {
 	u8		*link_key;
 	unsigned long	flags;
 	u8		method;
+	u8		passkey_round;
 
 	/* Secure Connections variables */
 	u8			local_pk[64];
@@ -1219,7 +1221,7 @@ static int sc_mackey_and_ltk(struct smp_chan *smp, u8 mackey[16], u8 ltk[16])
 	return smp_f5(smp->tfm_cmac, smp->dhkey, na, nb, a, b, mackey, ltk);
 }
 
-static void sc_dhkey_check(struct smp_chan *smp, __le32 passkey)
+static void sc_dhkey_check(struct smp_chan *smp)
 {
 	struct hci_conn *hcon = smp->conn->hcon;
 	struct smp_cmd_dhkey_check check;
@@ -1244,7 +1246,7 @@ static void sc_dhkey_check(struct smp_chan *smp, __le32 passkey)
 	memset(r, 0, sizeof(r));
 
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
-		memcpy(r, &passkey, sizeof(passkey));
+		put_unaligned_le32(hcon->passkey_notify, r);
 
 	smp_f6(smp->tfm_cmac, smp->mackey, smp->prnd, smp->rrnd, r, io_cap,
 	       local_addr, remote_addr, check.e);
@@ -1252,8 +1254,124 @@ static void sc_dhkey_check(struct smp_chan *smp, __le32 passkey)
 	smp_send_cmd(smp->conn, SMP_CMD_DHKEY_CHECK, sizeof(check), &check);
 }
 
+static u8 sc_passkey_send_confirm(struct smp_chan *smp)
+{
+	struct l2cap_conn *conn = smp->conn;
+	struct hci_conn *hcon = conn->hcon;
+	struct smp_cmd_pairing_confirm cfm;
+	u8 r;
+
+	r = ((hcon->passkey_notify >> smp->passkey_round) & 0x01);
+	r |= 0x80;
+
+	get_random_bytes(smp->prnd, sizeof(smp->prnd));
+
+	if (smp_f4(smp->tfm_cmac, smp->local_pk, smp->remote_pk, smp->prnd, r,
+		   cfm.confirm_val))
+		return SMP_UNSPECIFIED;
+
+	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cfm), &cfm);
+
+	return 0;
+}
+
+static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
+{
+	struct l2cap_conn *conn = smp->conn;
+	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
+	u8 cfm[16], r;
+
+	/* Ignore the PDU if we've already done 20 rounds (0 - 19) */
+	if (smp->passkey_round >= 20)
+		return 0;
+
+	switch (smp_op) {
+	case SMP_CMD_PAIRING_RANDOM:
+		r = ((hcon->passkey_notify >> smp->passkey_round) & 0x01);
+		r |= 0x80;
+
+		if (smp_f4(smp->tfm_cmac, smp->remote_pk, smp->local_pk,
+			   smp->rrnd, r, cfm))
+			return SMP_UNSPECIFIED;
+
+		if (memcmp(smp->pcnf, cfm, 16))
+			return SMP_CONFIRM_FAILED;
+
+		smp->passkey_round++;
+
+		if (smp->passkey_round == 20) {
+			/* Generate MacKey and LTK */
+			if (sc_mackey_and_ltk(smp, smp->mackey, smp->tk))
+				return SMP_UNSPECIFIED;
+		}
+
+		/* The round is only complete when the initiator
+		 * receives pairing random.
+		 */
+		if (!hcon->out) {
+			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
+				     sizeof(smp->prnd), smp->prnd);
+			if (smp->passkey_round == 20) {
+				sc_dhkey_check(smp);
+				SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
+			} else {
+				SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
+			}
+			return 0;
+		}
+
+		/* Start the next round */
+		if (smp->passkey_round != 20)
+			return sc_passkey_round(smp, 0);
+
+		/* Passkey rounds are complete - start DHKey Check */
+		sc_dhkey_check(smp);
+		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
+
+		break;
+
+	case SMP_CMD_PAIRING_CONFIRM:
+		if (test_bit(SMP_FLAG_WAIT_USER, &smp->flags)) {
+			set_bit(SMP_FLAG_CFM_PENDING, &smp->flags);
+			return 0;
+		}
+
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
+
+		if (hcon->out) {
+			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
+				     sizeof(smp->prnd), smp->prnd);
+			return 0;
+		}
+
+		return sc_passkey_send_confirm(smp);
+
+	case SMP_CMD_PUBLIC_KEY:
+	default:
+		/* Initiating device starts the round */
+		if (!hcon->out)
+			return 0;
+
+		BT_DBG("%s Starting passkey round %u", hdev->name,
+		       smp->passkey_round + 1);
+
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
+
+		return sc_passkey_send_confirm(smp);
+	}
+
+	return 0;
+}
+
 static int sc_user_reply(struct smp_chan *smp, u16 mgmt_op, __le32 passkey)
 {
+	struct l2cap_conn *conn = smp->conn;
+	struct hci_conn *hcon = conn->hcon;
+	u8 smp_op;
+
+	clear_bit(SMP_FLAG_WAIT_USER, &smp->flags);
+
 	switch (mgmt_op) {
 	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
 		smp_failure(smp->conn, SMP_PASSKEY_ENTRY_FAILED);
@@ -1261,9 +1379,22 @@ static int sc_user_reply(struct smp_chan *smp, u16 mgmt_op, __le32 passkey)
 	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
 		smp_failure(smp->conn, SMP_NUMERIC_COMP_FAILED);
 		return 0;
+	case MGMT_OP_USER_PASSKEY_REPLY:
+		hcon->passkey_notify = le32_to_cpu(passkey);
+		smp->passkey_round = 0;
+
+		if (test_and_clear_bit(SMP_FLAG_CFM_PENDING, &smp->flags))
+			smp_op = SMP_CMD_PAIRING_CONFIRM;
+		else
+			smp_op = 0;
+
+		if (sc_passkey_round(smp, smp_op))
+			return -EIO;
+
+		return 0;
 	}
 
-	sc_dhkey_check(smp, passkey);
+	sc_dhkey_check(smp);
 
 	return 0;
 }
@@ -1532,6 +1663,9 @@ static u8 sc_check_confirm(struct smp_chan *smp)
 	if (!test_bit(SMP_FLAG_REMOTE_PK, &smp->flags))
 		return SMP_UNSPECIFIED;
 
+	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
+		return sc_passkey_round(smp, SMP_CMD_PAIRING_CONFIRM);
+
 	if (conn->hcon->out) {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
@@ -1592,6 +1726,10 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_bit(SMP_FLAG_SC, &smp->flags))
 		return smp_random(smp);
 
+	/* Passkey entry has special treatment */
+	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
+		return sc_passkey_round(smp, SMP_CMD_PAIRING_RANDOM);
+
 	if (hcon->out) {
 		u8 cfm[16];
 
@@ -1623,24 +1761,25 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (err)
 		return SMP_UNSPECIFIED;
 
-	err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
-	if (err)
-		return SMP_UNSPECIFIED;
-
 	if (smp->method == JUST_WORKS) {
 		if (hcon->out) {
-			sc_dhkey_check(smp, passkey);
+			sc_dhkey_check(smp);
 			SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
 		}
 		return 0;
 	}
 
-	err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
-					hcon->type, hcon->dst_type,
-					passkey, 0);
+	err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
+	if (err)
+		return SMP_UNSPECIFIED;
+
+	err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst, hcon->type,
+					hcon->dst_type, passkey, 0);
 	if (err)
 		return SMP_UNSPECIFIED;
 
+	set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
+
 	return 0;
 }
 
@@ -2071,6 +2210,33 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!memcmp(debug_pk, smp->remote_pk, 64))
 		set_bit(SMP_FLAG_DEBUG_KEY, &smp->flags);
 
+	if (smp->method == DSP_PASSKEY) {
+		get_random_bytes(&hcon->passkey_notify,
+				 sizeof(hcon->passkey_notify));
+		hcon->passkey_notify %= 1000000;
+		hcon->passkey_entered = 0;
+		smp->passkey_round = 0;
+		if (mgmt_user_passkey_notify(hdev, &hcon->dst, hcon->type,
+					     hcon->dst_type,
+					     hcon->passkey_notify,
+					     hcon->passkey_entered))
+			return SMP_UNSPECIFIED;
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
+		return sc_passkey_round(smp, SMP_CMD_PUBLIC_KEY);
+	}
+
+	if (hcon->out)
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
+
+	if (smp->method == REQ_PASSKEY) {
+		if (mgmt_user_passkey_request(hdev, &hcon->dst, hcon->type,
+					      hcon->dst_type))
+			return SMP_UNSPECIFIED;
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
+		set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
+		return 0;
+	}
+
 	/* The Initiating device waits for the non-initiating device to
 	 * send the confirm value.
 	 */
@@ -2121,6 +2287,9 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	memset(r, 0, sizeof(r));
 
+	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
+		put_unaligned_le32(hcon->passkey_notify, r);
+
 	err = smp_f6(smp->tfm_cmac, smp->mackey, smp->rrnd, smp->prnd, r,
 		     io_cap, remote_addr, local_addr, e);
 	if (err)
-- 
2.1.0

