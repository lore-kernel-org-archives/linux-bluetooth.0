Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Use kzfree instead of kfree in security manager
Date: Mon, 16 Mar 2015 00:01:06 -0700
Message-Id: <1426489267-28272-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Within the security manager, it makes sense to use kzfree instead of
kfree for all data structures. This ensures that no key material leaks
by accident.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 9155840068cf..a2be6fcc3c51 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -681,9 +681,9 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 	complete = test_bit(SMP_FLAG_COMPLETE, &smp->flags);
 	mgmt_smp_complete(hcon, complete);
 
-	kfree(smp->csrk);
-	kfree(smp->slave_csrk);
-	kfree(smp->link_key);
+	kzfree(smp->csrk);
+	kzfree(smp->slave_csrk);
+	kzfree(smp->link_key);
 
 	crypto_free_blkcipher(smp->tfm_aes);
 	crypto_free_hash(smp->tfm_cmac);
@@ -717,7 +717,7 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 	}
 
 	chan->data = NULL;
-	kfree(smp);
+	kzfree(smp);
 	hci_conn_drop(hcon);
 }
 
@@ -1097,13 +1097,13 @@ static void sc_generate_link_key(struct smp_chan *smp)
 		return;
 
 	if (smp_h6(smp->tfm_cmac, smp->tk, tmp1, smp->link_key)) {
-		kfree(smp->link_key);
+		kzfree(smp->link_key);
 		smp->link_key = NULL;
 		return;
 	}
 
 	if (smp_h6(smp->tfm_cmac, smp->link_key, lebr, smp->link_key)) {
-		kfree(smp->link_key);
+		kzfree(smp->link_key);
 		smp->link_key = NULL;
 		return;
 	}
@@ -1300,7 +1300,7 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	smp->tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(smp->tfm_aes)) {
 		BT_ERR("Unable to create ECB crypto context");
-		kfree(smp);
+		kzfree(smp);
 		return NULL;
 	}
 
@@ -1308,7 +1308,7 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	if (IS_ERR(smp->tfm_cmac)) {
 		BT_ERR("Unable to create CMAC crypto context");
 		crypto_free_blkcipher(smp->tfm_aes);
-		kfree(smp);
+		kzfree(smp);
 		return NULL;
 	}
 
-- 
2.1.0

