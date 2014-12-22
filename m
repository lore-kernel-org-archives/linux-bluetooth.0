Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: Export SMP crypto functions for self-test module
Date: Mon, 22 Dec 2014 19:53:07 +0200
Message-Id: <1419270792-29086-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1419270792-29086-1-git-send-email-johan.hedberg@gmail.com>
References: <1419270792-29086-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In order to run self-tests on the SMP crypto functions from a dedicated
self-test module the functions need to be exported to other modules.
This patch exports the necessary functions from smp.c and also adds an
extra bt_* prefix to them to avoid conflicts with any other kernel code.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 107 ++++++++++++++++++++++++++++------------------------
 net/bluetooth/smp.h |  22 +++++++++++
 2 files changed, 79 insertions(+), 50 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b67749bb55bf..507a4138fd6a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -200,8 +200,8 @@ static int aes_cmac(struct crypto_hash *tfm, const u8 k[16], const u8 *m,
 	return 0;
 }
 
-static int smp_f4(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
-		  const u8 x[16], u8 z, u8 res[16])
+int bt_smp_f4(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
+	      const u8 x[16], u8 z, u8 res[16])
 {
 	u8 m[65];
 	int err;
@@ -222,9 +222,10 @@ static int smp_f4(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
 
 	return err;
 }
+EXPORT_SYMBOL(bt_smp_f4);
 
-static int smp_f5(struct crypto_hash *tfm_cmac, u8 w[32], u8 n1[16], u8 n2[16],
-		  u8 a1[7], u8 a2[7], u8 mackey[16], u8 ltk[16])
+int bt_smp_f5(struct crypto_hash *tfm_cmac, u8 w[32], u8 n1[16], u8 n2[16],
+	      u8 a1[7], u8 a2[7], u8 mackey[16], u8 ltk[16])
 {
 	/* The btle, salt and length "magic" values are as defined in
 	 * the SMP section of the Bluetooth core specification. In ASCII
@@ -274,11 +275,11 @@ static int smp_f5(struct crypto_hash *tfm_cmac, u8 w[32], u8 n1[16], u8 n2[16],
 
 	return 0;
 }
+EXPORT_SYMBOL(bt_smp_f5);
 
-static int smp_f6(struct crypto_hash *tfm_cmac, const u8 w[16],
-		  const u8 n1[16], u8 n2[16], const u8 r[16],
-		  const u8 io_cap[3], const u8 a1[7], const u8 a2[7],
-		  u8 res[16])
+int bt_smp_f6(struct crypto_hash *tfm_cmac, const u8 w[16], const u8 n1[16],
+	      u8 n2[16], const u8 r[16], const u8 io_cap[3], const u8 a1[7],
+	      const u8 a2[7], u8 res[16])
 {
 	u8 m[65];
 	int err;
@@ -302,9 +303,10 @@ static int smp_f6(struct crypto_hash *tfm_cmac, const u8 w[16],
 
 	return err;
 }
+EXPORT_SYMBOL(bt_smp_f6);
 
-static int smp_g2(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
-		  const u8 x[16], const u8 y[16], u32 *val)
+int bt_smp_g2(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
+	      const u8 x[16], const u8 y[16], u32 *val)
 {
 	u8 m[80], tmp[16];
 	int err;
@@ -328,9 +330,10 @@ static int smp_g2(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
 
 	return 0;
 }
+EXPORT_SYMBOL(bt_smp_g2);
 
-static int smp_h6(struct crypto_hash *tfm_cmac, const u8 w[16],
-		  const u8 key_id[4], u8 res[16])
+int bt_smp_h6(struct crypto_hash *tfm_cmac, const u8 w[16], const u8 key_id[4],
+	      u8 res[16])
 {
 	int err;
 
@@ -344,6 +347,7 @@ static int smp_h6(struct crypto_hash *tfm_cmac, const u8 w[16],
 
 	return err;
 }
+EXPORT_SYMBOL(bt_smp_h6);
 
 /* The following functions map to the legacy SMP crypto functions e, c1,
  * s1 and ah.
@@ -388,9 +392,9 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 	return err;
 }
 
-static int smp_c1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
-		  const u8 r[16], const u8 preq[7], const u8 pres[7], u8 _iat,
-		  const bdaddr_t *ia, u8 _rat, const bdaddr_t *ra, u8 res[16])
+int bt_smp_c1(struct crypto_blkcipher *tfm_aes, const u8 k[16], const u8 r[16],
+	      const u8 preq[7], const u8 pres[7], u8 _iat, const bdaddr_t *ia,
+	      u8 _rat, const bdaddr_t *ra, u8 res[16])
 {
 	u8 p1[16], p2[16];
 	int err;
@@ -428,9 +432,10 @@ static int smp_c1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
 
 	return err;
 }
+EXPORT_SYMBOL(bt_smp_c1);
 
-static int smp_s1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
-		  const u8 r1[16], const u8 r2[16], u8 _r[16])
+int bt_smp_s1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
+	      const u8 r1[16], const u8 r2[16], u8 _r[16])
 {
 	int err;
 
@@ -444,9 +449,10 @@ static int smp_s1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
 
 	return err;
 }
+EXPORT_SYMBOL(bt_smp_s1);
 
-static int smp_ah(struct crypto_blkcipher *tfm, const u8 irk[16],
-		  const u8 r[3], u8 res[3])
+int bt_smp_ah(struct crypto_blkcipher *tfm, const u8 irk[16], const u8 r[3],
+	      u8 res[3])
 {
 	u8 _res[16];
 	int err;
@@ -471,6 +477,7 @@ static int smp_ah(struct crypto_blkcipher *tfm, const u8 irk[16],
 
 	return 0;
 }
+EXPORT_SYMBOL(bt_smp_ah);
 
 bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
 		     const bdaddr_t *bdaddr)
@@ -487,7 +494,7 @@ bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
 
 	BT_DBG("RPA %pMR IRK %*phN", bdaddr, 16, irk);
 
-	err = smp_ah(tfm, irk, &bdaddr->b[3], hash);
+	err = bt_smp_ah(tfm, irk, &bdaddr->b[3], hash);
 	if (err)
 		return false;
 
@@ -510,7 +517,7 @@ int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa)
 	rpa->b[5] &= 0x3f;	/* Clear two most significant bits */
 	rpa->b[5] |= 0x40;	/* Set second most significant bit */
 
-	err = smp_ah(tfm, irk, &rpa->b[3], rpa->b);
+	err = bt_smp_ah(tfm, irk, &rpa->b[3], rpa->b);
 	if (err < 0)
 		return err;
 
@@ -866,10 +873,10 @@ static u8 smp_confirm(struct smp_chan *smp)
 
 	BT_DBG("conn %p", conn);
 
-	ret = smp_c1(smp->tfm_aes, smp->tk, smp->prnd, smp->preq, smp->prsp,
-		     conn->hcon->init_addr_type, &conn->hcon->init_addr,
-		     conn->hcon->resp_addr_type, &conn->hcon->resp_addr,
-		     cp.confirm_val);
+	ret = bt_smp_c1(smp->tfm_aes, smp->tk, smp->prnd, smp->preq, smp->prsp,
+			conn->hcon->init_addr_type, &conn->hcon->init_addr,
+			conn->hcon->resp_addr_type, &conn->hcon->resp_addr,
+			cp.confirm_val);
 	if (ret)
 		return SMP_UNSPECIFIED;
 
@@ -897,9 +904,9 @@ static u8 smp_random(struct smp_chan *smp)
 
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
-	ret = smp_c1(smp->tfm_aes, smp->tk, smp->rrnd, smp->preq, smp->prsp,
-		     hcon->init_addr_type, &hcon->init_addr,
-		     hcon->resp_addr_type, &hcon->resp_addr, confirm);
+	ret = bt_smp_c1(smp->tfm_aes, smp->tk, smp->rrnd, smp->preq, smp->prsp,
+			hcon->init_addr_type, &hcon->init_addr,
+			hcon->resp_addr_type, &hcon->resp_addr, confirm);
 	if (ret)
 		return SMP_UNSPECIFIED;
 
@@ -913,7 +920,7 @@ static u8 smp_random(struct smp_chan *smp)
 		__le64 rand = 0;
 		__le16 ediv = 0;
 
-		smp_s1(smp->tfm_aes, smp->tk, smp->rrnd, smp->prnd, stk);
+		bt_smp_s1(smp->tfm_aes, smp->tk, smp->rrnd, smp->prnd, stk);
 
 		memset(stk + smp->enc_key_size, 0,
 		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
@@ -932,7 +939,7 @@ static u8 smp_random(struct smp_chan *smp)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 
-		smp_s1(smp->tfm_aes, smp->tk, smp->prnd, smp->rrnd, stk);
+		bt_smp_s1(smp->tfm_aes, smp->tk, smp->prnd, smp->rrnd, stk);
 
 		memset(stk + smp->enc_key_size, 0,
 		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
@@ -1094,13 +1101,13 @@ static void sc_generate_link_key(struct smp_chan *smp)
 	if (!smp->link_key)
 		return;
 
-	if (smp_h6(smp->tfm_cmac, smp->tk, tmp1, smp->link_key)) {
+	if (bt_smp_h6(smp->tfm_cmac, smp->tk, tmp1, smp->link_key)) {
 		kfree(smp->link_key);
 		smp->link_key = NULL;
 		return;
 	}
 
-	if (smp_h6(smp->tfm_cmac, smp->link_key, lebr, smp->link_key)) {
+	if (bt_smp_h6(smp->tfm_cmac, smp->link_key, lebr, smp->link_key)) {
 		kfree(smp->link_key);
 		smp->link_key = NULL;
 		return;
@@ -1141,10 +1148,10 @@ static void sc_generate_ltk(struct smp_chan *smp)
 	if (key->type == HCI_LK_DEBUG_COMBINATION)
 		set_bit(SMP_FLAG_DEBUG_KEY, &smp->flags);
 
-	if (smp_h6(smp->tfm_cmac, key->val, tmp2, smp->tk))
+	if (bt_smp_h6(smp->tfm_cmac, key->val, tmp2, smp->tk))
 		return;
 
-	if (smp_h6(smp->tfm_cmac, smp->tk, brle, smp->tk))
+	if (bt_smp_h6(smp->tfm_cmac, smp->tk, brle, smp->tk))
 		return;
 
 	sc_add_ltk(smp);
@@ -1337,7 +1344,7 @@ static int sc_mackey_and_ltk(struct smp_chan *smp, u8 mackey[16], u8 ltk[16])
 	a[6] = hcon->init_addr_type;
 	b[6] = hcon->resp_addr_type;
 
-	return smp_f5(smp->tfm_cmac, smp->dhkey, na, nb, a, b, mackey, ltk);
+	return bt_smp_f5(smp->tfm_cmac, smp->dhkey, na, nb, a, b, mackey, ltk);
 }
 
 static void sc_dhkey_check(struct smp_chan *smp)
@@ -1370,8 +1377,8 @@ static void sc_dhkey_check(struct smp_chan *smp)
 	if (smp->method == REQ_OOB)
 		memcpy(r, smp->rr, 16);
 
-	smp_f6(smp->tfm_cmac, smp->mackey, smp->prnd, smp->rrnd, r, io_cap,
-	       local_addr, remote_addr, check.e);
+	bt_smp_f6(smp->tfm_cmac, smp->mackey, smp->prnd, smp->rrnd, r, io_cap,
+		  local_addr, remote_addr, check.e);
 
 	smp_send_cmd(smp->conn, SMP_CMD_DHKEY_CHECK, sizeof(check), &check);
 }
@@ -1388,8 +1395,8 @@ static u8 sc_passkey_send_confirm(struct smp_chan *smp)
 
 	get_random_bytes(smp->prnd, sizeof(smp->prnd));
 
-	if (smp_f4(smp->tfm_cmac, smp->local_pk, smp->remote_pk, smp->prnd, r,
-		   cfm.confirm_val))
+	if (bt_smp_f4(smp->tfm_cmac, smp->local_pk, smp->remote_pk, smp->prnd,
+		      r, cfm.confirm_val))
 		return SMP_UNSPECIFIED;
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cfm), &cfm);
@@ -1413,8 +1420,8 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 		r = ((hcon->passkey_notify >> smp->passkey_round) & 0x01);
 		r |= 0x80;
 
-		if (smp_f4(smp->tfm_cmac, smp->remote_pk, smp->local_pk,
-			   smp->rrnd, r, cfm))
+		if (bt_smp_f4(smp->tfm_cmac, smp->remote_pk, smp->local_pk,
+			      smp->rrnd, r, cfm))
 			return SMP_UNSPECIFIED;
 
 		if (memcmp(smp->pcnf, cfm, 16))
@@ -1974,8 +1981,8 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (hcon->out) {
 		u8 cfm[16];
 
-		err = smp_f4(smp->tfm_cmac, smp->remote_pk, smp->local_pk,
-			     smp->rrnd, 0, cfm);
+		err = bt_smp_f4(smp->tfm_cmac, smp->remote_pk, smp->local_pk,
+				smp->rrnd, 0, cfm);
 		if (err)
 			return SMP_UNSPECIFIED;
 
@@ -2001,7 +2008,7 @@ mackey_and_ltk:
 		return 0;
 	}
 
-	err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
+	err = bt_smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
 	if (err)
 		return SMP_UNSPECIFIED;
 
@@ -2464,8 +2471,8 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	if (smp->method == REQ_OOB) {
-		err = smp_f4(smp->tfm_cmac, smp->remote_pk, smp->remote_pk,
-			     smp->rr, 0, cfm.confirm_val);
+		err = bt_smp_f4(smp->tfm_cmac, smp->remote_pk, smp->remote_pk,
+				smp->rr, 0, cfm.confirm_val);
 		if (err)
 			return SMP_UNSPECIFIED;
 
@@ -2499,8 +2506,8 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (conn->hcon->out)
 		return 0;
 
-	err = smp_f4(smp->tfm_cmac, smp->local_pk, smp->remote_pk, smp->prnd,
-		     0, cfm.confirm_val);
+	err = bt_smp_f4(smp->tfm_cmac, smp->local_pk, smp->remote_pk,
+			smp->prnd, 0, cfm.confirm_val);
 	if (err)
 		return SMP_UNSPECIFIED;
 
@@ -2545,8 +2552,8 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		put_unaligned_le32(hcon->passkey_notify, r);
 
-	err = smp_f6(smp->tfm_cmac, smp->mackey, smp->rrnd, smp->prnd, r,
-		     io_cap, remote_addr, local_addr, e);
+	err = bt_smp_f6(smp->tfm_cmac, smp->mackey, smp->rrnd, smp->prnd, r,
+			io_cap, remote_addr, local_addr, e);
 	if (err)
 		return SMP_UNSPECIFIED;
 
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 3296bf42ae80..e66ff590d079 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -23,6 +23,8 @@
 #ifndef __SMP_H
 #define __SMP_H
 
+#include <linux/crypto.h>
+
 struct smp_command_hdr {
 	__u8	code;
 } __packed;
@@ -192,4 +194,24 @@ int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa);
 int smp_register(struct hci_dev *hdev);
 void smp_unregister(struct hci_dev *hdev);
 
+/* Exported crypto functions for self-test module */
+int bt_smp_c1(struct crypto_blkcipher *tfm_aes, const u8 k[16], const u8 r[16],
+	      const u8 preq[7], const u8 pres[7], u8 _iat, const bdaddr_t *ia,
+	      u8 _rat, const bdaddr_t *ra, u8 res[16]);
+int bt_smp_s1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
+	      const u8 r1[16], const u8 r2[16], u8 _r[16]);
+int bt_smp_ah(struct crypto_blkcipher *tfm, const u8 irk[16], const u8 r[3],
+	      u8 res[3]);
+int bt_smp_f4(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
+	      const u8 x[16], u8 z, u8 res[16]);
+int bt_smp_f5(struct crypto_hash *tfm_cmac, u8 w[32], u8 n1[16], u8 n2[16],
+	      u8 a1[7], u8 a2[7], u8 mackey[16], u8 ltk[16]);
+int bt_smp_f6(struct crypto_hash *tfm_cmac, const u8 w[16], const u8 n1[16],
+	      u8 n2[16], const u8 r[16], const u8 io_cap[3], const u8 a1[7],
+	      const u8 a2[7], u8 res[16]);
+int bt_smp_g2(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
+	      const u8 x[16], const u8 y[16], u32 *val);
+int bt_smp_h6(struct crypto_hash *tfm_cmac, const u8 w[16], const u8 key_id[4],
+	      u8 res[16]);
+
 #endif /* __SMP_H */
-- 
2.1.0

