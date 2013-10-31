Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 3/5] android: Add stub for handling get_remote_services command
Date: Thu, 31 Oct 2013 16:25:50 +0100
Message-ID: <1383233152-15040-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383233152-15040-1-git-send-email-szymon.janc@tieto.com>
References: <1383233152-15040-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

Change-Id: I3a88c104a496fa3c3391b11dc85b6607861158f3
---
 android/adapter.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 10d4a8e..6ee4a21 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1215,6 +1215,11 @@ static uint8_t ssp_reply(void *buf, uint16_t len)
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
@@ -1308,6 +1313,11 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
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

