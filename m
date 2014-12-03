Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 20/49] Bluetooth: Add support for handling LE SC user response
Date: Wed,  3 Dec 2014 17:02:14 +0200
Message-Id: <1417618963-18010-21-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

With LE SC, once the user has responded to the numeric comparison it's
time to send DHKey check values in both directions. The DHKey check
value is generated using new smp_f5 and smp_f6 cryptographic functions.
The smp_f5 function is responsible for generating the LTK and the MacKey
values whereas the smp_f6 function takes the MacKey as input and
generates the DHKey Check value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 00bafcae8814..bdbfbdba0089 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -84,6 +84,7 @@ struct smp_chan {
 	u8			local_sk[32];
 	u8			remote_pk[64];
 	u8			dhkey[32];
+	u8			mackey[16];
 
 	struct crypto_blkcipher	*tfm_aes;
 	struct crypto_hash	*tfm_cmac;
@@ -175,6 +176,86 @@ static int smp_f4(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
 	return err;
 }
 
+static int smp_f5(struct crypto_hash *tfm_cmac, u8 w[32], u8 n1[16], u8 n2[16],
+		  u8 a1[7], u8 a2[7], u8 mackey[16], u8 ltk[16])
+{
+	/* The btle, salt and length "magic" values are as defined in
+	 * the SMP section of the Bluetooth core specification. In ASCII
+	 * the btle value ends up being 'btle'. The salt is just a
+	 * random number whereas length is the value 256 in little
+	 * endian format.
+	 */
+	const u8 btle[4] = { 0x65, 0x6c, 0x74, 0x62 };
+	const u8 salt[16] = { 0xbe, 0x83, 0x60, 0x5a, 0xdb, 0x0b, 0x37, 0x60,
+			      0x38, 0xa5, 0xf5, 0xaa, 0x91, 0x83, 0x88, 0x6c };
+	const u8 length[2] = { 0x00, 0x01 };
+	u8 m[53], t[16];
+	int err;
+
+	BT_DBG("w %32phN", w);
+	BT_DBG("n1 %16phN n2 %16phN", n1, n2);
+	BT_DBG("a1 %7phN a2 %7phN", a1, a2);
+
+	err = aes_cmac(tfm_cmac, salt, w, 32, t);
+	if (err)
+		return err;
+
+	BT_DBG("t %16phN", t);
+
+	memcpy(m, length, 2);
+	memcpy(m + 2, a2, 7);
+	memcpy(m + 9, a1, 7);
+	memcpy(m + 16, n2, 16);
+	memcpy(m + 32, n1, 16);
+	memcpy(m + 48, btle, 4);
+
+	m[52] = 0; /* Counter */
+
+	err = aes_cmac(tfm_cmac, t, m, sizeof(m), mackey);
+	if (err)
+		return err;
+
+	BT_DBG("mackey %16phN", mackey);
+
+	m[52] = 1; /* Counter */
+
+	err = aes_cmac(tfm_cmac, t, m, sizeof(m), ltk);
+	if (err)
+		return err;
+
+	BT_DBG("ltk %16phN", ltk);
+
+	return 0;
+}
+
+static int smp_f6(struct crypto_hash *tfm_cmac, const u8 w[16],
+		  const u8 n1[16], u8 n2[16], const u8 r[16],
+		  const u8 io_cap[3], const u8 a1[7], const u8 a2[7],
+		  u8 res[16])
+{
+	u8 m[65];
+	int err;
+
+	BT_DBG("w %16phN", w);
+	BT_DBG("n1 %16phN n2 %16phN", n1, n2);
+	BT_DBG("r %16phN io_cap %3phN a1 %7phN a2 %7phN", r, io_cap, a1, a2);
+
+	memcpy(m, a2, 7);
+	memcpy(m + 7, a1, 7);
+	memcpy(m + 14, io_cap, 3);
+	memcpy(m + 17, r, 16);
+	memcpy(m + 33, n2, 16);
+	memcpy(m + 49, n1, 16);
+
+	err = aes_cmac(tfm_cmac, w, m, sizeof(m), res);
+	if (err)
+		return err;
+
+	BT_DBG("res %16phN", res);
+
+	return err;
+}
+
 static int smp_g2(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
 		  const u8 x[16], const u8 y[16], u32 *val)
 {
@@ -1001,6 +1082,69 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	return smp;
 }
 
+static int sc_mackey_and_ltk(struct smp_chan *smp, u8 mackey[16], u8 ltk[16])
+{
+	struct hci_conn *hcon = smp->conn->hcon;
+	u8 *na, *nb, a[7], b[7];
+
+	if (hcon->out) {
+		na   = smp->prnd;
+		nb   = smp->rrnd;
+	} else {
+		na   = smp->rrnd;
+		nb   = smp->prnd;
+	}
+
+	memcpy(a, &hcon->init_addr, 6);
+	memcpy(b, &hcon->resp_addr, 6);
+	a[6] = hcon->init_addr_type;
+	b[6] = hcon->resp_addr_type;
+
+	return smp_f5(smp->tfm_cmac, smp->dhkey, na, nb, a, b, mackey, ltk);
+}
+
+static int sc_user_reply(struct smp_chan *smp, u16 mgmt_op, __le32 passkey)
+{
+	struct hci_conn *hcon = smp->conn->hcon;
+	struct smp_cmd_dhkey_check check;
+	u8 a[7], b[7], *local_addr, *remote_addr;
+	u8 io_cap[3], r[16];
+
+	switch (mgmt_op) {
+	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
+		smp_failure(smp->conn, SMP_PASSKEY_ENTRY_FAILED);
+		return 0;
+	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
+		smp_failure(smp->conn, SMP_NUMERIC_COMP_FAILED);
+		return 0;
+	}
+
+	memcpy(a, &hcon->init_addr, 6);
+	memcpy(b, &hcon->resp_addr, 6);
+	a[6] = hcon->init_addr_type;
+	b[6] = hcon->resp_addr_type;
+
+	if (hcon->out) {
+		local_addr = a;
+		remote_addr = b;
+		memcpy(io_cap, &smp->preq[1], 3);
+	} else {
+		local_addr = b;
+		remote_addr = a;
+		memcpy(io_cap, &smp->prsp[1], 3);
+	}
+
+	memcpy(r, &passkey, sizeof(passkey));
+	memset(r + sizeof(passkey), 0, sizeof(r) - sizeof(passkey));
+
+	smp_f6(smp->tfm_cmac, smp->mackey, smp->prnd, smp->rrnd, r, io_cap,
+	       local_addr, remote_addr, check.e);
+
+	smp_send_cmd(smp->conn, SMP_CMD_DHKEY_CHECK, sizeof(check), &check);
+
+	return 0;
+}
+
 int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
@@ -1026,6 +1170,11 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 
 	smp = chan->data;
 
+	if (test_bit(SMP_FLAG_SC, &smp->flags)) {
+		err = sc_user_reply(smp, mgmt_op, passkey);
+		goto unlock;
+	}
+
 	switch (mgmt_op) {
 	case MGMT_OP_USER_PASSKEY_REPLY:
 		value = le32_to_cpu(passkey);
@@ -1338,6 +1487,11 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		nb   = smp->prnd;
 	}
 
+	/* Generate MacKey and LTK */
+	err = sc_mackey_and_ltk(smp, smp->mackey, smp->tk);
+	if (err)
+		return SMP_UNSPECIFIED;
+
 	err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
 	if (err)
 		return SMP_UNSPECIFIED;
-- 
2.1.0

