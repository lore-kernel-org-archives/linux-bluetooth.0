Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 2/2] android/gatt: Fix handling sing counter
Date: Mon, 22 Sep 2014 12:54:07 +0200
Message-Id: <1411383247-11461-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1411383247-11461-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411383247-11461-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to BT spec 4.1, Part H, 2.4.5 Signing Algorithm, sign
counter shall increment on each message however there is not specific
requirement that it should increment by 1. In fact in case of lost
package we would unsync with remote and would be no able to recover
in other way then re-pair.

This patch reject write sign commands if remote sign counter is less
or equal to previous one.
---
 android/gatt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e06ad1f..8127fc1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5921,16 +5921,16 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 		uint8_t t[ATT_SIGNATURE_LEN];
 		uint32_t r_sign_cnt = get_le32(s);
 
-		if (r_sign_cnt != sign_cnt) {
-			error("gatt: sign_cnt does not match (%d!=%d)",
-							sign_cnt, r_sign_cnt);
+		if (r_sign_cnt <= sign_cnt) {
+			error("gatt: Invalid sign_cnt (%d<=%d)?",
+							r_sign_cnt, sign_cnt);
 			return;
 		}
 
 		/* Generate signature and verify it */
 		if (!bt_crypto_sign_att(crypto, csrk, cmd,
 						cmd_len - ATT_SIGNATURE_LEN,
-						sign_cnt, t)) {
+						r_sign_cnt, t)) {
 			error("gatt: Error when generating att signature");
 			return;
 		}
@@ -5940,7 +5940,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 			return;
 		}
 		/* Signature OK, proceed with write */
-		bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK, sign_cnt++);
+		bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK, r_sign_cnt);
 		gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
 								&dev->bdaddr);
 	}
-- 
1.8.4

