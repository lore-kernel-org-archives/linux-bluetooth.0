Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Add dedicated AES instance for each SMP context
Date: Fri, 27 Jun 2014 14:23:03 +0300
Message-Id: <1403868187-19396-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
References: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Many places have to be extra careful to not hold the hdev lock when
calling into the SMP code. This is because the SMP crypto functions use
the crypto handle that's part of the hci_dev struct. Giving the SMP
context its own handle helps simplifying the locking logic and removes
the risk for deadlocks.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a38941593e8b..39ca9616d2de 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -62,6 +62,8 @@ struct smp_chan {
 	struct smp_ltk	*slave_ltk;
 	struct smp_irk	*remote_irk;
 	unsigned long	flags;
+
+	struct crypto_blkcipher	*tfm_aes;
 };
 
 static inline void swap_buf(const u8 *src, u8 *dst, size_t len)
@@ -583,6 +585,13 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	if (!smp)
 		return NULL;
 
+	smp->tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(smp->tfm_aes)) {
+		BT_ERR("Unable to create ECB crypto context");
+		kfree(smp);
+		return NULL;
+	}
+
 	smp->conn = conn;
 	conn->smp_chan = smp;
 	conn->hcon->smp_conn = conn;
@@ -605,6 +614,8 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 	kfree(smp->csrk);
 	kfree(smp->slave_csrk);
 
+	crypto_free_blkcipher(smp->tfm_aes);
+
 	/* If pairing failed clean up any keys we might have */
 	if (!complete) {
 		if (smp->ltk) {
-- 
1.9.3

