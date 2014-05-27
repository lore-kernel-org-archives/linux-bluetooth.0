Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/6] android/gatt: Use proper variable to store response length
Date: Tue, 27 May 2014 12:15:31 +0200
Message-Id: <1401185734-23672-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes confirmations being not send.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 18e1e03..dab9781 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5101,7 +5101,7 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		 * registered for this indication, event will be send in
 		 * handle_notification
 		 */
-		length = enc_confirmation(opdu, sizeof(opdu));
+		resp_length = enc_confirmation(opdu, sizeof(opdu));
 		status = 0;
 		break;
 	case ATT_OP_HANDLE_NOTIFY:
-- 
1.9.3

