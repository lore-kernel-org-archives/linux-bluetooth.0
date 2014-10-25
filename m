Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Pass only crypto context to SMP crypto functions
Date: Sat, 25 Oct 2014 21:15:37 +0200
Message-Id: <1414264539-19068-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1414264539-19068-1-git-send-email-johan.hedberg@gmail.com>
References: <1414264539-19068-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In order to make unit testing possible we need to make the SMP crypto
functions only take the crypto context instead of the full SMP context
(the latter would require having hci_dev, hci_conn, l2cap_chan,
l2cap_conn, etc around). The drawback is that we no-longer get the
involved hdev in the debug logs, but this is really the only way to make
simple unit tests for the code.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f09b6b65cf6b..fea3782989f4 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -191,16 +191,13 @@ int smp_generate_rpa(struct hci_dev *hdev, u8 irk[16], bdaddr_t *rpa)
 	return 0;
 }
 
-static int smp_c1(struct smp_chan *smp, u8 k[16], u8 r[16], u8 preq[7],
-		  u8 pres[7], u8 _iat, bdaddr_t *ia, u8 _rat, bdaddr_t *ra,
-		  u8 res[16])
+static int smp_c1(struct crypto_blkcipher *tfm_aes, u8 k[16], u8 r[16],
+		  u8 preq[7], u8 pres[7], u8 _iat, bdaddr_t *ia, u8 _rat,
+		  bdaddr_t *ra, u8 res[16])
 {
-	struct hci_dev *hdev = smp->conn->hcon->hdev;
 	u8 p1[16], p2[16];
 	int err;
 
-	BT_DBG("%s", hdev->name);
-
 	memset(p1, 0, 16);
 
 	/* p1 = pres || preq || _rat || _iat */
@@ -218,7 +215,7 @@ static int smp_c1(struct smp_chan *smp, u8 k[16], u8 r[16], u8 preq[7],
 	u128_xor((u128 *) res, (u128 *) r, (u128 *) p1);
 
 	/* res = e(k, res) */
-	err = smp_e(smp->tfm_aes, k, res);
+	err = smp_e(tfm_aes, k, res);
 	if (err) {
 		BT_ERR("Encrypt data error");
 		return err;
@@ -228,26 +225,23 @@ static int smp_c1(struct smp_chan *smp, u8 k[16], u8 r[16], u8 preq[7],
 	u128_xor((u128 *) res, (u128 *) res, (u128 *) p2);
 
 	/* res = e(k, res) */
-	err = smp_e(smp->tfm_aes, k, res);
+	err = smp_e(tfm_aes, k, res);
 	if (err)
 		BT_ERR("Encrypt data error");
 
 	return err;
 }
 
-static int smp_s1(struct smp_chan *smp, u8 k[16], u8 r1[16], u8 r2[16],
-		  u8 _r[16])
+static int smp_s1(struct crypto_blkcipher *tfm_aes, u8 k[16], u8 r1[16],
+		  u8 r2[16], u8 _r[16])
 {
-	struct hci_dev *hdev = smp->conn->hcon->hdev;
 	int err;
 
-	BT_DBG("%s", hdev->name);
-
 	/* Just least significant octets from r1 and r2 are considered */
 	memcpy(_r, r2, 8);
 	memcpy(_r + 8, r1, 8);
 
-	err = smp_e(smp->tfm_aes, k, _r);
+	err = smp_e(tfm_aes, k, _r);
 	if (err)
 		BT_ERR("Encrypt data error");
 
@@ -547,7 +541,7 @@ static u8 smp_confirm(struct smp_chan *smp)
 
 	BT_DBG("conn %p", conn);
 
-	ret = smp_c1(smp, smp->tk, smp->prnd, smp->preq, smp->prsp,
+	ret = smp_c1(smp->tfm_aes, smp->tk, smp->prnd, smp->preq, smp->prsp,
 		     conn->hcon->init_addr_type, &conn->hcon->init_addr,
 		     conn->hcon->resp_addr_type, &conn->hcon->resp_addr,
 		     cp.confirm_val);
@@ -578,7 +572,7 @@ static u8 smp_random(struct smp_chan *smp)
 
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
-	ret = smp_c1(smp, smp->tk, smp->rrnd, smp->preq, smp->prsp,
+	ret = smp_c1(smp->tfm_aes, smp->tk, smp->rrnd, smp->preq, smp->prsp,
 		     hcon->init_addr_type, &hcon->init_addr,
 		     hcon->resp_addr_type, &hcon->resp_addr, confirm);
 	if (ret)
@@ -594,7 +588,7 @@ static u8 smp_random(struct smp_chan *smp)
 		__le64 rand = 0;
 		__le16 ediv = 0;
 
-		smp_s1(smp, smp->tk, smp->rrnd, smp->prnd, stk);
+		smp_s1(smp->tfm_aes, smp->tk, smp->rrnd, smp->prnd, stk);
 
 		memset(stk + smp->enc_key_size, 0,
 		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
@@ -613,7 +607,7 @@ static u8 smp_random(struct smp_chan *smp)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 
-		smp_s1(smp, smp->tk, smp->prnd, smp->rrnd, stk);
+		smp_s1(smp->tfm_aes, smp->tk, smp->prnd, smp->rrnd, stk);
 
 		memset(stk + smp->enc_key_size, 0,
 		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
-- 
1.9.3

