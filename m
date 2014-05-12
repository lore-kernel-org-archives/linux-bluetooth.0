Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/8] android/gatt: Fix sending att responses
Date: Mon, 12 May 2014 15:02:31 +0200
Message-Id: <1399899758-4944-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1399899758-4944-1-git-send-email-marcin.kraglak@tieto.com>
References: <1399899758-4944-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

In case of error we should respond and not fail silently.
Before sending we should also check length value as, opdu is filled
only for some ATT operations and some are handled by read callbacks,
sending their own responses. We should be gradually moving to the later,
using response data queue.
---
 android/gatt.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 157ebe6..d8bcfb5 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4321,18 +4321,12 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		break;
 	case ATT_OP_WRITE_REQ:
 		status = write_req_request(ipdu, len, dev);
-		if (!status)
-			return;
 		break;
 	case ATT_OP_WRITE_CMD:
 		status = write_cmd_request(ipdu, len, dev);
-		if (!status)
-			return;
 		break;
 	case ATT_OP_PREP_WRITE_REQ:
 		status = write_prep_request(ipdu, len, dev);
-		if (!status)
-			return;
 		break;
 	case ATT_OP_EXEC_WRITE_REQ:
 		/* TODO */
@@ -4344,7 +4338,7 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 	default:
 		DBG("Unsupported request 0x%02x", ipdu[0]);
 		status = ATT_ECODE_REQ_NOT_SUPP;
-		goto done;
+		break;
 	}
 
 done:
@@ -4352,7 +4346,8 @@ done:
 		length = enc_error_resp(ipdu[0], 0x0000, status, opdu,
 							ATT_DEFAULT_LE_MTU);
 
-	g_attrib_send(dev->attrib, 0, opdu, length, NULL, NULL, NULL);
+	if (length)
+		g_attrib_send(dev->attrib, 0, opdu, length, NULL, NULL, NULL);
 }
 
 static void create_listen_connections(void *data, void *user_data)
-- 
1.8.5.3

