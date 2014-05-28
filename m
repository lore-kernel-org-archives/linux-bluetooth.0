Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 7/9] shared/crypto: Fix byte order of message
Date: Wed, 28 May 2014 16:44:39 +0200
Message-Id: <1401288283-13480-12-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message should be swapped before we send it to the kernel for signing
---
 src/shared/crypto.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index ad89174..c400081 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -265,6 +265,7 @@ bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 	uint8_t tmp[16], out[16];
 	uint16_t msg_len = m_len + sizeof(uint32_t);
 	uint8_t msg[msg_len];
+	uint8_t msg_s[msg_len];
 
 	if (!crypto)
 		return false;
@@ -283,7 +284,10 @@ bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 	if (fd < 0)
 		return false;
 
-	len = send(fd, msg, msg_len, 0);
+	/* Swap msg before signing */
+	swap_buf(msg, msg_s, msg_len);
+
+	len = send(fd, msg_s, msg_len, 0);
 	if (len < 0) {
 		close(fd);
 		return false;
-- 
1.8.4

