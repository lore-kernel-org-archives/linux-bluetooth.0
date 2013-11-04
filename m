Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv3 2/4] android: Add stub of get_remote_services command
Date: Mon, 4 Nov 2013 09:06:48 +0100
Message-ID: <1383552410-2220-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1383552410-2220-1-git-send-email-marcin.kraglak@tieto.com>
References: <1383552410-2220-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/android/adapter.c b/android/adapter.c
index 6f2a061..af62b11 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1459,6 +1459,11 @@ static uint8_t ssp_reply(void *buf, uint16_t len)
 	return status;
 }
 
+static uint8_t get_remote_services(void *buf, uint16_t len)
+{
+	return HAL_STATUS_UNSUPPORTED;
+}
+
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len)
 {
@@ -1563,6 +1568,11 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 			goto error;
 
 		break;
+	case HAL_OP_GET_REMOTE_SERVICES:
+		status = get_remote_services(buf, len);
+		if (status != HAL_STATUS_SUCCESS)
+			goto error;
+		break;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
 		goto error;
-- 
1.8.4.1

