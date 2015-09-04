Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix typo in smp_ah comment for hash function
Date: Fri,  4 Sep 2015 17:08:18 +0200
Message-Id: <1441379298-127924-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ad82324f710f..4d56e593faad 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -495,7 +495,7 @@ static int smp_ah(struct crypto_blkcipher *tfm, const u8 irk[16],
 	}
 
 	/* The output of the random address function ah is:
-	 *	ah(h, r) = e(k, r') mod 2^24
+	 *	ah(k, r) = e(k, r') mod 2^24
 	 * The output of the security function e is then truncated to 24 bits
 	 * by taking the least significant 24 bits of the output of e as the
 	 * result of ah.
-- 
2.4.3

