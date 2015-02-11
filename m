Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 08/10] android/gatt: Remove not needed checks and jumps
Date: Wed, 11 Feb 2015 15:34:06 +0100
Message-Id: <1423665248-5121-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the end we check the status anyway so its safe to break out of switch
statement. There is also no point in calling 'goto label' when the 'label'
is right after switch statement closing bracket.
---
 android/gatt.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 49bcda2..c518d27 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6617,8 +6617,6 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		break;
 	case ATT_OP_WRITE_REQ:
 		status = write_req_request(ipdu, len, dev);
-		if (!status)
-			return;
 		break;
 	case ATT_OP_WRITE_CMD:
 		write_cmd_request(ipdu, len, dev);
@@ -6630,22 +6628,18 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		return;
 	case ATT_OP_PREP_WRITE_REQ:
 		status = write_prep_request(ipdu, len, dev);
-		if (!status)
-			return;
 		break;
 	case ATT_OP_FIND_BY_TYPE_REQ:
 		status = find_by_type_request(ipdu, len, dev);
 		break;
 	case ATT_OP_EXEC_WRITE_REQ:
 		status = write_execute_request(ipdu, len, dev);
-		if (!status)
-			return;
 		break;
 	case ATT_OP_READ_MULTI_REQ:
 	default:
 		DBG("Unsupported request 0x%02x", ipdu[0]);
 		status = ATT_ECODE_REQ_NOT_SUPP;
-		goto done;
+		break;
 	}
 
 done:
-- 
1.9.1

