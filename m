Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 43/49] Bluetooth: Add basic LE SC OOB support for remote OOB data
Date: Wed,  3 Dec 2014 17:02:37 +0200
Message-Id: <1417618963-18010-44-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds basic OOB pairing support when we've received the remote
OOB data. This includes tracking the remote r value (in smp->rr) as well
as doing the appropriate f4() call when needed. Previously the OOB rand
would have been stored in smp->rrnd however these are actually two
independent values so we need separate variables for them. Na/Nb in the
spec maps to smp->prnd/rrnd and ra/rb maps to smp->rr with smp->pr to
come once local OOB data is supported.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a38541d079f5..62ca2aaf72fa 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -71,6 +71,7 @@ struct smp_chan {
 	u8		rrnd[16]; /* SMP Pairing Random (remote) */
 	u8		pcnf[16]; /* SMP Pairing Confirm */
 	u8		tk[16]; /* SMP Temporary Key */
+	u8		rr[16];
 	u8		enc_key_size;
 	u8		remote_key_dist;
 	bdaddr_t	id_addr;
@@ -599,7 +600,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 		if (oob_data) {
 			set_bit(SMP_FLAG_OOB, &smp->flags);
 			oob_flag = SMP_OOB_PRESENT;
-			memcpy(smp->rrnd, oob_data->rand256, 16);
+			memcpy(smp->rr, oob_data->rand256, 16);
 			memcpy(smp->pcnf, oob_data->hash256, 16);
 		}
 
@@ -1334,6 +1335,9 @@ static void sc_dhkey_check(struct smp_chan *smp)
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		put_unaligned_le32(hcon->passkey_notify, r);
 
+	if (smp->method == REQ_OOB)
+		memcpy(r, smp->rr, 16);
+
 	smp_f6(smp->tfm_cmac, smp->mackey, smp->prnd, smp->rrnd, r, io_cap,
 	       local_addr, remote_addr, check.e);
 
@@ -1910,6 +1914,14 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_bit(SMP_FLAG_SC, &smp->flags))
 		return smp_random(smp);
 
+	if (smp->method == REQ_OOB) {
+		if (!hcon->out)
+			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
+				     sizeof(smp->prnd), smp->prnd);
+		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
+		goto mackey_and_ltk;
+	}
+
 	/* Passkey entry has special treatment */
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		return sc_passkey_round(smp, SMP_CMD_PAIRING_RANDOM);
@@ -1940,12 +1952,13 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		nb   = smp->prnd;
 	}
 
+mackey_and_ltk:
 	/* Generate MacKey and LTK */
 	err = sc_mackey_and_ltk(smp, smp->mackey, smp->tk);
 	if (err)
 		return SMP_UNSPECIFIED;
 
-	if (smp->method == JUST_WORKS) {
+	if (smp->method == JUST_WORKS || smp->method == REQ_OOB) {
 		if (hcon->out) {
 			sc_dhkey_check(smp);
 			SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
@@ -2314,6 +2327,9 @@ static u8 sc_select_method(struct smp_chan *smp)
 	struct smp_cmd_pairing *local, *remote;
 	u8 local_mitm, remote_mitm, local_io, remote_io, method;
 
+	if (test_bit(SMP_FLAG_OOB, &smp->flags))
+		return REQ_OOB;
+
 	/* The preq/prsp contain the raw Pairing Request/Response PDUs
 	 * which are needed as inputs to some crypto functions. To get
 	 * the "struct smp_cmd_pairing" from them we need to skip the
@@ -2412,6 +2428,24 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 		return sc_passkey_round(smp, SMP_CMD_PUBLIC_KEY);
 	}
 
+	if (smp->method == REQ_OOB) {
+		err = smp_f4(smp->tfm_cmac, smp->remote_pk, smp->remote_pk,
+			     smp->rr, 0, cfm.confirm_val);
+		if (err)
+			return SMP_UNSPECIFIED;
+
+		if (memcmp(cfm.confirm_val, smp->pcnf, 16))
+			return SMP_CONFIRM_FAILED;
+
+		if (hcon->out)
+			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
+				     sizeof(smp->prnd), smp->prnd);
+
+		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
+
+		return 0;
+	}
+
 	if (hcon->out)
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 
-- 
2.1.0

