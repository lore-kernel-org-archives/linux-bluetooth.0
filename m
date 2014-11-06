Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/4] android/gatt: Fix sign counter comparison
Date: Thu,  6 Nov 2014 10:30:36 +0100
Message-Id: <1415266238-12423-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1415266238-12423-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1415266238-12423-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes invalid sign counter comparison and fixes one issue with
TC_SEC_CSIGN_BI_03_C PTS test case.
---
 android/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index d601cda..828f788 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5935,8 +5935,8 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 		uint8_t t[ATT_SIGNATURE_LEN];
 		uint32_t r_sign_cnt = get_le32(s);
 
-		if (r_sign_cnt <= sign_cnt) {
-			error("gatt: Invalid sign counter (%d<=%d)",
+		if (r_sign_cnt < sign_cnt) {
+			error("gatt: Invalid sign counter (%d<%d)",
 							r_sign_cnt, sign_cnt);
 			return;
 		}
-- 
1.9.1

