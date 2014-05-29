Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 10/10] shared/crypto: Remove not needed memcpy
Date: Thu, 29 May 2014 15:49:44 +0200
Message-Id: <1401371384-10427-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401371384-10427-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401371384-10427-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
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

