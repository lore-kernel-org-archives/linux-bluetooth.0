Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 5/5] android/gatt: Remove invalid cases from att_handler
Date: Tue,  9 Dec 2014 09:51:50 +0100
Message-Id: <1418115110-25335-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1418115110-25335-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418115110-25335-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For these att opcodes callback will never be called as its registered
for requests and commands.
---
 android/gatt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e7ca147..ac45ffc 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6564,15 +6564,11 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 	case ATT_OP_FIND_BY_TYPE_REQ:
 		status = find_by_type_request(ipdu, len, dev);
 		break;
-	case ATT_OP_HANDLE_NOTIFY:
-		/* Client will handle this */
-		return;
 	case ATT_OP_EXEC_WRITE_REQ:
 		status = write_execute_request(ipdu, len, dev);
 		if (!status)
 			return;
 		break;
-	case ATT_OP_HANDLE_CNF:
 	case ATT_OP_READ_MULTI_REQ:
 	default:
 		DBG("Unsupported request 0x%02x", ipdu[0]);
-- 
1.9.1

