Return-Path: <xerofoify@gmail.com>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH RESEND] bluetooth:Fix error handling in the function aes_cmac
Date: Mon, 11 Jan 2016 18:05:40 -0500
Message-Id: <1452553540-25028-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes error handling in the function aes_cmac by properly
checking if the call to the function crypto_hast_init failed by
returning a error code and if so tell the user with BT_ERR that
the crypto hash table initialization failed before returning the
error code to signal to the caller of this particular function
that their call of aes_cmac has failed.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/smp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ad82324..2f73bf9 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -184,7 +184,11 @@ static int aes_cmac(struct crypto_hash *tfm, const u8 k[16], const u8 *m,
 	desc.tfm = tfm;
 	desc.flags = 0;
 
-	crypto_hash_init(&desc);
+	err = crypto_hash_init(&desc);
+	if (err) {
+		BT_ERR("crypto hash init failed: %d", err);
+		return err;
+	}
 
 	/* Swap key and message from LSB to MSB */
 	swap_buf(k, tmp, 16);
-- 
2.1.4
