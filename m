Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] Bluetooth: Add smp_irk_matches helper function
Date: Tue, 18 Feb 2014 10:19:31 +0200
Message-Id: <1392711577-31431-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
References: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a helper function to check whether a given IRK matches a
given Resolvable Private Address (RPA). The function will be needed for
implementing the rest of address resolving support.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/smp.h |  3 +++
 2 files changed, 49 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ae487e17380e..5f500b479f45 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -78,6 +78,52 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 	return err;
 }
 
+static int smp_ah(struct crypto_blkcipher *tfm, u8 irk[16], u8 r[3], u8 res[3])
+{
+	u8 _res[16], k[16];
+	int err;
+
+	/* r' = padding || r */
+	memset(_res, 0, 13);
+	_res[13] = r[2];
+	_res[14] = r[1];
+	_res[15] = r[0];
+
+	swap128(irk, k);
+	err = smp_e(tfm, k, _res);
+	if (err) {
+		BT_ERR("Encrypt error");
+		return err;
+	}
+
+	/* The output of the random address function ah is:
+	 *	ah(h, r) = e(k, r') mod 2^24
+	 * The output of the security function e is then truncated to 24 bits
+	 * by taking the least significant 24 bits of the output of e as the
+	 * result of ah.
+	 */
+	res[0] = _res[15];
+	res[1] = _res[14];
+	res[2] = _res[13];
+
+	return 0;
+}
+
+bool smp_irk_matches(struct crypto_blkcipher *tfm, u8 irk[16],
+		     bdaddr_t *bdaddr)
+{
+	u8 hash[3];
+	int err;
+
+	BT_DBG("RPA %pMR IRK %*phN", bdaddr, 16, irk);
+
+	err = smp_ah(tfm, irk, &bdaddr->b[3], hash);
+	if (err)
+		return false;
+
+	return !memcmp(bdaddr->b, hash, 3);
+}
+
 static int smp_c1(struct crypto_blkcipher *tfm, u8 k[16], u8 r[16],
 		  u8 preq[7], u8 pres[7], u8 _iat, bdaddr_t *ia,
 		  u8 _rat, bdaddr_t *ra, u8 res[16])
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 777ee93a6c9b..950d039c2ea2 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -143,4 +143,7 @@ int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
 
 void smp_chan_destroy(struct l2cap_conn *conn);
 
+bool smp_irk_matches(struct crypto_blkcipher *tfm, u8 irk[16],
+		     bdaddr_t *bdaddr);
+
 #endif /* __SMP_H */
-- 
1.8.5.3

