Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/10] Bluetooth: Remove SMP data specific crypto context
Date: Tue, 18 Feb 2014 17:14:30 +0200
Message-Id: <1392736479-8808-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
References: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that each HCI device has its own AES crypto context we don't need
the one stored in the SMP data any more. This patch removes the variable
from struct smp_chan and updates the SMP code to use the per-hdev crypto
context.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 15 ++-------------
 net/bluetooth/smp.h |  1 -
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 5867c1c3f436..6dcb35640b6f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -413,21 +413,13 @@ static void confirm_work(struct work_struct *work)
 {
 	struct smp_chan *smp = container_of(work, struct smp_chan, confirm);
 	struct l2cap_conn *conn = smp->conn;
-	struct crypto_blkcipher *tfm;
+	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm_aes;
 	struct smp_cmd_pairing_confirm cp;
 	int ret;
 	u8 res[16], reason;
 
 	BT_DBG("conn %p", conn);
 
-	tfm = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm)) {
-		reason = SMP_UNSPECIFIED;
-		goto error;
-	}
-
-	smp->tfm = tfm;
-
 	if (conn->hcon->out)
 		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
 			     conn->hcon->src_type, &conn->hcon->src,
@@ -457,7 +449,7 @@ static void random_work(struct work_struct *work)
 	struct smp_chan *smp = container_of(work, struct smp_chan, random);
 	struct l2cap_conn *conn = smp->conn;
 	struct hci_conn *hcon = conn->hcon;
-	struct crypto_blkcipher *tfm = smp->tfm;
+	struct crypto_blkcipher *tfm = hcon->hdev->tfm_aes;
 	u8 reason, confirm[16], res[16], key[16];
 	int ret;
 
@@ -562,9 +554,6 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 
 	BUG_ON(!smp);
 
-	if (smp->tfm)
-		crypto_free_blkcipher(smp->tfm);
-
 	kfree(smp);
 	conn->smp_chan = NULL;
 	conn->hcon->smp_conn = NULL;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 4f373bc56ad7..8f54c9b152de 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -133,7 +133,6 @@ struct smp_chan {
 	u8		id_addr_type;
 	u8		irk[16];
 	unsigned long	smp_flags;
-	struct crypto_blkcipher	*tfm;
 	struct work_struct confirm;
 	struct work_struct random;
 };
-- 
1.8.5.3

