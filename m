Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] shared/crypto: Remove not needed memcpy
Date: Wed, 28 May 2014 18:13:48 +0200
Message-Id: <1401293628-16946-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This memcpy is done later in this function. This is some garbage.
---
This should be part of "[PATCH 0/9] android: Fixes to sign write". Please apply it on top of this set.

 src/shared/crypto.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index c400081..c438ab3 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -279,7 +279,6 @@ bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 	/* The most significant octet of key corresponds to key[0] */
 	swap_buf(key, tmp, 16);
 
-	memcpy(signature, tmp + 4, 12);
 	fd = alg_new(crypto->cmac_aes, tmp, 16);
 	if (fd < 0)
 		return false;
-- 
1.8.4

