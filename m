Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix potential NULL dereference in SMP channel setup
Date: Tue, 17 Mar 2015 11:38:24 -0700
Message-Id: <1426617504-27460-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the allocation of the L2CAP channel for the BR/EDR security manager
fails, then the smp variable might be NULL. In that case do not try to
free the non-existing crypto contexts

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6a5afb972358..1ec3f66b5a74 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3124,9 +3124,11 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 create_chan:
 	chan = l2cap_chan_create();
 	if (!chan) {
-		crypto_free_blkcipher(smp->tfm_aes);
-		crypto_free_hash(smp->tfm_cmac);
-		kzfree(smp);
+		if (smp) {
+			crypto_free_blkcipher(smp->tfm_aes);
+			crypto_free_hash(smp->tfm_cmac);
+			kzfree(smp);
+		}
 		return ERR_PTR(-ENOMEM);
 	}
 
-- 
2.1.0

