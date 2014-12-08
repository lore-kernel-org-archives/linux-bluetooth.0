Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/5] android/gatt: Remove not handled att ops in request handler
Date: Mon,  8 Dec 2014 09:22:40 +0100
Message-Id: <1418026960-21104-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1418026960-21104-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418026960-21104-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For those att operations callback will never be called as its registered
for ATT_OP_TYPE_REQ.
---
 android/gatt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8f0864f..7d1348c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6572,15 +6572,11 @@ static void att_req_handler(const uint8_t *ipdu, uint16_t len,
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

