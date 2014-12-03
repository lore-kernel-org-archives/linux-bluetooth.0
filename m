Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/49] Bluetooth: Add basic support for AES-CMAC
Date: Wed,  3 Dec 2014 17:02:07 +0200
Message-Id: <1417618963-18010-14-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Most of the LE Secure Connections SMP crypto functions build on top of
the AES-CMAC function. This patch adds access to AES-CMAC in the kernel
crypto subsystem by allocating a crypto_hash handle for it in a similar
way that we have one for AES-CBC.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/Kconfig |  1 +
 net/bluetooth/smp.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 5e97a8ff850b..29bcafc41adf 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -10,6 +10,7 @@ menuconfig BT
 	select CRYPTO
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES
+	select CRYPTO_CMAC
 	select CRYPTO_ECB
 	select CRYPTO_SHA256
 	help
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d993d7d4fcc8..4fed367da380 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -72,6 +72,7 @@ struct smp_chan {
 	unsigned long	flags;
 
 	struct crypto_blkcipher	*tfm_aes;
+	struct crypto_hash	*tfm_cmac;
 };
 
 static inline void swap_buf(const u8 *src, u8 *dst, size_t len)
@@ -396,6 +397,7 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 	kfree(smp->slave_csrk);
 
 	crypto_free_blkcipher(smp->tfm_aes);
+	crypto_free_hash(smp->tfm_cmac);
 
 	/* If pairing failed clean up any keys we might have */
 	if (!complete) {
@@ -861,6 +863,14 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 		return NULL;
 	}
 
+	smp->tfm_cmac = crypto_alloc_hash("cmac(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(smp->tfm_cmac)) {
+		BT_ERR("Unable to create CMAC crypto context");
+		crypto_free_blkcipher(smp->tfm_aes);
+		kfree(smp);
+		return NULL;
+	}
+
 	smp->conn = conn;
 	chan->data = smp;
 
-- 
2.1.0

