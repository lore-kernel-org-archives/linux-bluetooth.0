Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Rename smp->local_rr into smp->local_rand
Date: Mon, 16 Mar 2015 10:25:14 -0700
Message-Id: <1426526714-20083-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The variable for the out-of-band random number was badly named and
with that confusing. Just rename it to local_rand so it is clear
what value it represents.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 895cfc9bd413..c2aa7766d68f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -78,7 +78,7 @@ struct smp_dev {
 	/* Secure Connections OOB data */
 	u8			local_pk[64];
 	u8			local_sk[32];
-	u8			local_rr[16];
+	u8			local_rand[16];
 	bool			debug_key;
 
 	struct crypto_blkcipher	*tfm_aes;
@@ -569,14 +569,14 @@ int smp_generate_oob(struct hci_dev *hdev, u8 hash[16], u8 rand[16])
 	SMP_DBG("OOB Public Key Y: %32phN", smp->local_pk + 32);
 	SMP_DBG("OOB Private Key:  %32phN", smp->local_sk);
 
-	get_random_bytes(smp->local_rr, 16);
+	get_random_bytes(smp->local_rand, 16);
 
 	err = smp_f4(smp->tfm_cmac, smp->local_pk, smp->local_pk,
-		     smp->local_rr, 0, hash);
+		     smp->local_rand, 0, hash);
 	if (err < 0)
 		return err;
 
-	memcpy(rand, smp->local_rr, 16);
+	memcpy(rand, smp->local_rand, 16);
 
 	return 0;
 }
@@ -1837,7 +1837,7 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 
 		memcpy(smp->local_pk, smp_dev->local_pk, 64);
 		memcpy(smp->local_sk, smp_dev->local_sk, 32);
-		memcpy(smp->lr, smp_dev->local_rr, 16);
+		memcpy(smp->lr, smp_dev->local_rand, 16);
 
 		if (smp_dev->debug_key)
 			set_bit(SMP_FLAG_DEBUG_KEY, &smp->flags);
-- 
2.1.0

