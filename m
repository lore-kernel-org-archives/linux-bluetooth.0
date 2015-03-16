Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/8] Bluetooth: Add support for AES-CMAC hash for security manager device
Date: Mon, 16 Mar 2015 01:10:21 -0700
Message-Id: <1426493425-7427-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The security manager device will require the use of AES-CMAC hash for
out-of-band data generation. This patch makes sure it is correctly
set up and available.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 952ba6376e1c..12e9c833885b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -75,6 +75,7 @@ enum {
 
 struct smp_dev {
 	struct crypto_blkcipher	*tfm_aes;
+	struct crypto_hash	*tfm_cmac;
 };
 
 struct smp_chan {
@@ -2936,6 +2937,7 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 	struct l2cap_chan *chan;
 	struct smp_dev *smp;
 	struct crypto_blkcipher *tfm_aes;
+	struct crypto_hash *tfm_cmac;
 
 	if (cid == L2CAP_CID_SMP_BREDR) {
 		smp = NULL;
@@ -2953,12 +2955,22 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 		return ERR_CAST(tfm_aes);
 	}
 
+	tfm_cmac = crypto_alloc_hash("cmac(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm_cmac)) {
+		BT_ERR("Unable to create CMAC crypto context");
+		crypto_free_blkcipher(tfm_aes);
+		kzfree(smp);
+		return ERR_CAST(tfm_cmac);
+	}
+
 	smp->tfm_aes = tfm_aes;
+	smp->tfm_cmac = tfm_cmac;
 
 create_chan:
 	chan = l2cap_chan_create();
 	if (!chan) {
 		crypto_free_blkcipher(smp->tfm_aes);
+		crypto_free_hash(smp->tfm_cmac);
 		kzfree(smp);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -3005,6 +3017,8 @@ static void smp_del_chan(struct l2cap_chan *chan)
 		chan->data = NULL;
 		if (smp->tfm_aes)
 			crypto_free_blkcipher(smp->tfm_aes);
+		if (smp->tfm_cmac)
+			crypto_free_hash(smp->tfm_cmac);
 		kzfree(smp);
 	}
 
-- 
2.1.0

