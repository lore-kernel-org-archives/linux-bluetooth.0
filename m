Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/6] android: Add initial code for handling adapter set property command
Date: Fri, 25 Oct 2013 17:14:59 +0200
Message-ID: <1382714103-27689-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382714103-27689-1-git-send-email-szymon.janc@tieto.com>
References: <1382714103-27689-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No commands are handled yet.
---
 android/adapter.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 685b00d..13cce8f 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -365,6 +365,20 @@ static bool get_property(void *buf, uint16_t len)
 	}
 }
 
+static uint8_t set_property(void *buf, uint16_t len)
+{
+	struct hal_cmd_set_adapter_prop *cmd = buf;
+
+	switch (cmd->type) {
+	case HAL_PROP_ADAPTER_NAME:
+	case HAL_PROP_ADAPTER_SCAN_MODE:
+	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
+	default:
+		DBG("Unhandled property type 0x%x", cmd->type);
+		return HAL_STATUS_FAILED;
+	}
+}
+
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len)
 {
@@ -396,6 +410,12 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 			goto error;
 
 		break;
+	case HAL_OP_SET_ADAPTER_PROP:
+		status = set_property(buf, len);
+		if (status != HAL_STATUS_SUCCESS)
+			goto error;
+
+		break;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
 		goto error;
-- 
1.8.4.1

