Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: Update SMP crypto functions to take the SMP context
Date: Fri, 27 Jun 2014 14:23:04 +0300
Message-Id: <1403868187-19396-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
References: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Passing the full SMP context instead of just the crypto context lets us
use the crypto handle from the context which in turn removes the need to
lock the hci_dev. Passing the SMP context instead of just the crypto
handle allows a bit more detailed logging which is helpful in
multi-adapter scenarios.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 39ca9616d2de..2566a3e43bb5 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -172,13 +172,16 @@ int smp_generate_rpa(struct crypto_blkcipher *tfm, u8 irk[16], bdaddr_t *rpa)
 	return 0;
 }
 
-static int smp_c1(struct crypto_blkcipher *tfm, u8 k[16], u8 r[16],
-		  u8 preq[7], u8 pres[7], u8 _iat, bdaddr_t *ia,
-		  u8 _rat, bdaddr_t *ra, u8 res[16])
+static int smp_c1(struct smp_chan *smp, u8 k[16], u8 r[16], u8 preq[7],
+		  u8 pres[7], u8 _iat, bdaddr_t *ia, u8 _rat, bdaddr_t *ra,
+		  u8 res[16])
 {
+	struct hci_dev *hdev = smp->conn->hcon->hdev;
 	u8 p1[16], p2[16];
 	int err;
 
+	BT_DBG("%s", hdev->name);
+
 	memset(p1, 0, 16);
 
 	/* p1 = pres || preq || _rat || _iat */
@@ -196,7 +199,7 @@ static int smp_c1(struct crypto_blkcipher *tfm, u8 k[16], u8 r[16],
 	u128_xor((u128 *) res, (u128 *) r, (u128 *) p1);
 
 	/* res = e(k, res) */
-	err = smp_e(tfm, k, res);
+	err = smp_e(smp->tfm_aes, k, res);
 	if (err) {
 		BT_ERR("Encrypt data error");
 		return err;
@@ -206,23 +209,26 @@ static int smp_c1(struct crypto_blkcipher *tfm, u8 k[16], u8 r[16],
 	u128_xor((u128 *) res, (u128 *) res, (u128 *) p2);
 
 	/* res = e(k, res) */
-	err = smp_e(tfm, k, res);
+	err = smp_e(smp->tfm_aes, k, res);
 	if (err)
 		BT_ERR("Encrypt data error");
 
 	return err;
 }
 
-static int smp_s1(struct crypto_blkcipher *tfm, u8 k[16], u8 r1[16],
-		  u8 r2[16], u8 _r[16])
+static int smp_s1(struct smp_chan *smp, u8 k[16], u8 r1[16], u8 r2[16],
+		  u8 _r[16])
 {
+	struct hci_dev *hdev = smp->conn->hcon->hdev;
 	int err;
 
+	BT_DBG("%s", hdev->name);
+
 	/* Just least significant octets from r1 and r2 are considered */
 	memcpy(_r, r2, 8);
 	memcpy(_r + 8, r1, 8);
 
-	err = smp_e(tfm, k, _r);
+	err = smp_e(smp->tfm_aes, k, _r);
 	if (err)
 		BT_ERR("Encrypt data error");
 
@@ -475,23 +481,15 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 static u8 smp_confirm(struct smp_chan *smp)
 {
 	struct l2cap_conn *conn = smp->conn;
-	struct hci_dev *hdev = conn->hcon->hdev;
-	struct crypto_blkcipher *tfm = hdev->tfm_aes;
 	struct smp_cmd_pairing_confirm cp;
 	int ret;
 
 	BT_DBG("conn %p", conn);
 
-	/* Prevent mutual access to hdev->tfm_aes */
-	hci_dev_lock(hdev);
-
-	ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
+	ret = smp_c1(smp, smp->tk, smp->prnd, smp->preq, smp->prsp,
 		     conn->hcon->init_addr_type, &conn->hcon->init_addr,
 		     conn->hcon->resp_addr_type, &conn->hcon->resp_addr,
 		     cp.confirm_val);
-
-	hci_dev_unlock(hdev);
-
 	if (ret)
 		return SMP_UNSPECIFIED;
 
@@ -506,25 +504,17 @@ static u8 smp_random(struct smp_chan *smp)
 {
 	struct l2cap_conn *conn = smp->conn;
 	struct hci_conn *hcon = conn->hcon;
-	struct hci_dev *hdev = hcon->hdev;
-	struct crypto_blkcipher *tfm = hdev->tfm_aes;
 	u8 confirm[16];
 	int ret;
 
-	if (IS_ERR_OR_NULL(tfm))
+	if (IS_ERR_OR_NULL(smp->tfm_aes))
 		return SMP_UNSPECIFIED;
 
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
-	/* Prevent mutual access to hdev->tfm_aes */
-	hci_dev_lock(hdev);
-
-	ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp,
+	ret = smp_c1(smp, smp->tk, smp->rrnd, smp->preq, smp->prsp,
 		     hcon->init_addr_type, &hcon->init_addr,
 		     hcon->resp_addr_type, &hcon->resp_addr, confirm);
-
-	hci_dev_unlock(hdev);
-
 	if (ret)
 		return SMP_UNSPECIFIED;
 
@@ -538,7 +528,7 @@ static u8 smp_random(struct smp_chan *smp)
 		__le64 rand = 0;
 		__le16 ediv = 0;
 
-		smp_s1(tfm, smp->tk, smp->rrnd, smp->prnd, stk);
+		smp_s1(smp, smp->tk, smp->rrnd, smp->prnd, stk);
 
 		memset(stk + smp->enc_key_size, 0,
 		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
@@ -556,7 +546,7 @@ static u8 smp_random(struct smp_chan *smp)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 
-		smp_s1(tfm, smp->tk, smp->prnd, smp->rrnd, stk);
+		smp_s1(smp, smp->tk, smp->prnd, smp->rrnd, stk);
 
 		memset(stk + smp->enc_key_size, 0,
 		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
-- 
1.9.3

