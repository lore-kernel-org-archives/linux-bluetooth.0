Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix for a leftover debug of pairing credentials
Date: Wed, 31 Dec 2014 20:01:22 -0800
Message-Id: <1420084882-7554-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

One of the LE Secure Connections security credentials was still using
the BT_DBG instead of SMP_DBG.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 73643a6ca3cf..96c7d51a2753 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -300,7 +300,7 @@ static int smp_f6(struct crypto_hash *tfm_cmac, const u8 w[16],
 	if (err)
 		return err;
 
-	BT_DBG("res %16phN", res);
+	SMP_DBG("res %16phN", res);
 
 	return err;
 }
-- 
2.1.0

