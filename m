Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 03/13] Bluetooth: Add SMP function for generating RPAs
Date: Sun, 23 Feb 2014 19:42:19 +0200
Message-Id: <1393177349-361-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
References: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need a function in smp.c to generate Resolvable Random Addresses in
order to support privacy. The local RPA will need to be generated before
advertising, scanning or connecting and regenerated at periodic
intervals. This patch adds the necessary function for RPA generation.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 18 ++++++++++++++++++
 net/bluetooth/smp.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a5920e8cea59..88ff4d11cc19 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -124,6 +124,24 @@ bool smp_irk_matches(struct crypto_blkcipher *tfm, u8 irk[16],
 	return !memcmp(bdaddr->b, hash, 3);
 }
 
+int smp_generate_rpa(struct crypto_blkcipher *tfm, u8 irk[16], bdaddr_t *rpa)
+{
+	int err;
+
+	get_random_bytes(&rpa->b[3], 3);
+
+	rpa->b[5] &= 0x3f;
+	rpa->b[5] |= 0x40;
+
+	err = smp_ah(tfm, irk, &rpa->b[3], rpa->b);
+	if (err < 0)
+		return err;
+
+	BT_DBG("RPA %pMR", rpa);
+
+	return 0;
+}
+
 static int smp_c1(struct crypto_blkcipher *tfm, u8 k[16], u8 r[16],
 		  u8 preq[7], u8 pres[7], u8 _iat, bdaddr_t *ia,
 		  u8 _rat, bdaddr_t *ra, u8 res[16])
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index d8cc543f523c..f32f1212f650 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -152,5 +152,6 @@ void smp_chan_destroy(struct l2cap_conn *conn);
 
 bool smp_irk_matches(struct crypto_blkcipher *tfm, u8 irk[16],
 		     bdaddr_t *bdaddr);
+int smp_generate_rpa(struct crypto_blkcipher *tfm, u8 irk[16], bdaddr_t *rpa);
 
 #endif /* __SMP_H */
-- 
1.8.5.3

