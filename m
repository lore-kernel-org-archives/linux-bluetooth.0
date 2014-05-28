Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/9] android/gatt: Verify signature counter from remote
Date: Wed, 28 May 2014 16:44:29 +0200
Message-Id: <1401288283-13480-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We will receive signature counter as a part of signature in att packet.
We shall verify if signature counter has value as expected otherwise
drop the message.
---
 android/gatt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 89aca16..2e37a02 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4998,6 +4998,13 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	if (len) {
 		uint8_t t[ATT_SIGNATURE_LEN];
+		uint32_t r_sign_cnt = get_le32(s);
+
+		if (r_sign_cnt != sign_cnt) {
+			error("gatt: sign_cnt does not match (%d!=%d)",
+							sign_cnt, r_sign_cnt);
+			return;
+		}
 
 		/* Generate signature and verify it */
 		if (!bt_crypto_sign_att(crypto, csrk, value, vlen, sign_cnt,
-- 
1.8.4

