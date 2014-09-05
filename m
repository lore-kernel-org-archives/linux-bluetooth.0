Return-Path: <cyrus@holtmann.org>
From: behanw@converseincode.com
To: davem@davemloft.net,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org,
	Behan Webster <behanw@converseincode.com>,
	Mark Charlebois <charlebm@gmail.com>,
	=?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>
Subject: [PATCH] bluetooth: LLVMLinux: Remove VLAIS from bluetooth/amp.c
Date: Fri,  5 Sep 2014 16:03:34 -0700
Message-Id: <1409958214-5651-1-git-send-email-behanw@converseincode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Behan Webster <behanw@converseincode.com>

Replaced the use of a Variable Length Array In Struct (VLAIS) with a C99
compliant equivalent. This patch allocates the appropriate amount of memory
using an char array.

The new code can be compiled with both gcc and clang.

struct shash_desc contains a flexible array member member ctx declared with
CRYPTO_MINALIGN_ATTR, so sizeof(struct shash_desc) aligns the beginning
of the array declared after struct shash_desc with long long.

No trailing padding is required because it is not a struct type that can
be used in an array.

The CRYPTO_MINALIGN_ATTR is required so that desc is aligned with long long
as would be the case for a struct containing a member with
CRYPTO_MINALIGN_ATTR.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Jan-Simon Möller <dl9pf@gmx.de>
---
 net/bluetooth/amp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 016cdb6..2640d78 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -149,15 +149,14 @@ static int hmac_sha256(u8 *key, u8 ksize, char *plaintext, u8 psize, u8 *output)
 	if (ret) {
 		BT_DBG("crypto_ahash_setkey failed: err %d", ret);
 	} else {
-		struct {
-			struct shash_desc shash;
-			char ctx[crypto_shash_descsize(tfm)];
-		} desc;
+		char desc[sizeof(struct shash_desc) +
+			crypto_shash_descsize(tfm)] CRYPTO_MINALIGN_ATTR;
+		struct shash_desc *shash = (struct shash_desc *)desc;
 
-		desc.shash.tfm = tfm;
-		desc.shash.flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+		shash->tfm = tfm;
+		shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
 
-		ret = crypto_shash_digest(&desc.shash, plaintext, psize,
+		ret = crypto_shash_digest(shash, plaintext, psize,
 					  output);
 	}
 
-- 
1.9.1
