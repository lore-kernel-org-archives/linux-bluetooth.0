Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 5/9] shared/crypto: Fix order of sign counter added to signature
Date: Wed, 28 May 2014 16:44:37 +0200
Message-Id: <1401288283-13480-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index b50baa5..d4c4cc7 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -301,7 +301,7 @@ bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 	 * As to BT spec. 4.1 Vol[3], Part C, chapter 10.4.1 sign counter should
 	 * be placed in the signature
 	 */
-	put_le32(sign_cnt, out + 8);
+	put_be32(sign_cnt, out + 8);
 
 	/*
 	 * The most significant octet of hash corresponds to out[0]  - swap it.
-- 
1.8.4

