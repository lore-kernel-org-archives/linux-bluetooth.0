Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 02/10] android/gatt: Fix handling signed write command from remote
Date: Thu, 29 May 2014 15:49:36 +0200
Message-Id: <1401371384-10427-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401371384-10427-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401371384-10427-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As per spec (BT spec 4.1 Vol[3], Part F, chapter 3.4.5.4) message which
should be taken to generate signature is opcode, handle and parameters
---
 android/gatt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index d93bdcb..b18ca4a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5059,8 +5059,9 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
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

