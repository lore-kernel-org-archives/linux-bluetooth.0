Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Fix wrong size argument
Date: Thu, 19 Jun 2014 13:36:19 +0300
Message-Id: <1403174179-23272-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Instead of sizeof of (uint8_t *) pass real length, though for that
function it doesn't matter at this point.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5007817..7ce57ca 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5688,7 +5688,7 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		 * registered for this indication, event will be send in
 		 * handle_notification
 		 */
-		resp_length = enc_confirmation(opdu, sizeof(opdu));
+		resp_length = enc_confirmation(opdu, length);
 		status = 0;
 		break;
 	case ATT_OP_HANDLE_NOTIFY:
-- 
1.8.3.2

