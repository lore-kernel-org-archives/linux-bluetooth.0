Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 45/49] Bluetooth: Fix missing const declarations in SMP functions
Date: Wed,  3 Dec 2014 17:02:39 +0200
Message-Id: <1417618963-18010-46-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Several SMP functions take read-only data. This patch fixes the
declaration of these parameters to use the const specifier as
appropriate.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 18 ++++++++++--------
 net/bluetooth/smp.h |  5 +++--
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 7839354592f4..423e99d13207 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -380,7 +380,8 @@ static int smp_h6(struct crypto_hash *tfm_cmac, const u8 w[16],
 	return err;
 }
 
-static int smp_ah(struct crypto_blkcipher *tfm, u8 irk[16], u8 r[3], u8 res[3])
+static int smp_ah(struct crypto_blkcipher *tfm, const u8 irk[16],
+		  const u8 r[3], u8 res[3])
 {
 	u8 _res[16];
 	int err;
@@ -406,7 +407,8 @@ static int smp_ah(struct crypto_blkcipher *tfm, u8 irk[16], u8 r[3], u8 res[3])
 	return 0;
 }
 
-bool smp_irk_matches(struct hci_dev *hdev, u8 irk[16], bdaddr_t *bdaddr)
+bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
+		     const bdaddr_t *bdaddr)
 {
 	struct l2cap_chan *chan = hdev->smp_data;
 	struct crypto_blkcipher *tfm;
@@ -427,7 +429,7 @@ bool smp_irk_matches(struct hci_dev *hdev, u8 irk[16], bdaddr_t *bdaddr)
 	return !memcmp(bdaddr->b, hash, 3);
 }
 
-int smp_generate_rpa(struct hci_dev *hdev, u8 irk[16], bdaddr_t *rpa)
+int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa)
 {
 	struct l2cap_chan *chan = hdev->smp_data;
 	struct crypto_blkcipher *tfm;
@@ -452,9 +454,9 @@ int smp_generate_rpa(struct hci_dev *hdev, u8 irk[16], bdaddr_t *rpa)
 	return 0;
 }
 
-static int smp_c1(struct crypto_blkcipher *tfm_aes, u8 k[16], u8 r[16],
-		  u8 preq[7], u8 pres[7], u8 _iat, bdaddr_t *ia, u8 _rat,
-		  bdaddr_t *ra, u8 res[16])
+static int smp_c1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
+		  const u8 r[16], const u8 preq[7], const u8 pres[7], u8 _iat,
+		  const bdaddr_t *ia, u8 _rat, const bdaddr_t *ra, u8 res[16])
 {
 	u8 p1[16], p2[16];
 	int err;
@@ -493,8 +495,8 @@ static int smp_c1(struct crypto_blkcipher *tfm_aes, u8 k[16], u8 r[16],
 	return err;
 }
 
-static int smp_s1(struct crypto_blkcipher *tfm_aes, u8 k[16], u8 r1[16],
-		  u8 r2[16], u8 _r[16])
+static int smp_s1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
+		  const u8 r1[16], const u8 r2[16], u8 _r[16])
 {
 	int err;
 
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index f955d6b7ceb2..3296bf42ae80 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -185,8 +185,9 @@ bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
 int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
 
-bool smp_irk_matches(struct hci_dev *hdev, u8 irk[16], bdaddr_t *bdaddr);
-int smp_generate_rpa(struct hci_dev *hdev, u8 irk[16], bdaddr_t *rpa);
+bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
+		     const bdaddr_t *bdaddr);
+int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa);
 
 int smp_register(struct hci_dev *hdev);
 void smp_unregister(struct hci_dev *hdev);
-- 
2.1.0

