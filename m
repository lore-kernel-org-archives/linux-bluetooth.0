Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/9] shared/crypto: Fix concatenate of sign counter into the msg
Date: Wed, 28 May 2014 16:44:34 +0200
Message-Id: <1401288283-13480-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes incorrectly concatenated sign counter to the message
---
 src/shared/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index e46f07f..b50baa5 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -273,7 +273,7 @@ bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 	memcpy(msg, m, m_len);
 
 	/* Add sign_counter to the message */
-	put_le32(sign_cnt, msg + msg_len);
+	put_le32(sign_cnt, msg + m_len);
 
 	/* The most significant octet of key corresponds to key[0] */
 	swap128(key, tmp);
-- 
1.8.4

