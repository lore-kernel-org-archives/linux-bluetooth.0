Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/9] android/gatt: Fix handling signed write command from remote
Date: Wed, 28 May 2014 16:44:30 +0200
Message-Id: <1401288283-13480-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401288283-13480-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As per spec (BT spec 4.1 Vol[3], Part F, chapter 3.4.5.4) message which
should be taken to generate signature is opcode, handle and parameters
---
 android/gatt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2e37a02..6638fe6 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5007,8 +5007,9 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 		}
 
 		/* Generate signature and verify it */
-		if (!bt_crypto_sign_att(crypto, csrk, value, vlen, sign_cnt,
-									t)) {
+		if (!bt_crypto_sign_att(crypto, csrk, cmd,
+						cmd_len - ATT_SIGNATURE_LEN,
+						sign_cnt, t)) {
 			error("gatt: Error when generating att signature");
 			return;
 		}
-- 
1.8.4

