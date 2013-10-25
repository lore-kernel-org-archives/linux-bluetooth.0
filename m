Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/6] android: Use common exit path for commands in bt_adapter_handle_cmd
Date: Fri, 25 Oct 2013 17:14:58 +0200
Message-ID: <1382714103-27689-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All adapter commands return no parameters so putting error and success
response on common exit path. This will make function easier to follow
when more commands support will be added.
---
 android/adapter.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index ec90cca..685b00d 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -374,39 +374,37 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 	case HAL_OP_ENABLE:
 		if (adapter->current_settings & MGMT_SETTING_POWERED) {
 			status = HAL_STATUS_DONE;
-			break;
+			goto error;
 		}
 
-		if (set_mode(MGMT_OP_SET_POWERED, 0x01)) {
-			ipc_send(io, HAL_SERVICE_ID_BLUETOOTH, opcode, 0, NULL,
-									-1);
-			return;
-		}
+		if (!set_mode(MGMT_OP_SET_POWERED, 0x01))
+			goto error;
+
 		break;
 	case HAL_OP_DISABLE:
 		if (!(adapter->current_settings & MGMT_SETTING_POWERED)) {
 			status = HAL_STATUS_DONE;
-			break;
+			goto error;
 		}
 
-		if (set_mode(MGMT_OP_SET_POWERED, 0x00)) {
-			ipc_send(io, HAL_SERVICE_ID_BLUETOOTH, opcode, 0, NULL,
-									-1);
-			return;
-		}
+		if (!set_mode(MGMT_OP_SET_POWERED, 0x00))
+			goto error;
+
 		break;
 	case HAL_OP_GET_ADAPTER_PROP:
-		if (get_property(buf, len)) {
-			ipc_send(io, HAL_SERVICE_ID_BLUETOOTH, opcode, 0, NULL,
-									-1);
-			return;
-		}
+		if (!get_property(buf, len))
+			goto error;
+
 		break;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
-		break;
+		goto error;
 	}
 
+	ipc_send(io, HAL_SERVICE_ID_BLUETOOTH, opcode, 0, NULL, -1);
+	return;
+
+error:
 	ipc_send_rsp(io, HAL_SERVICE_ID_BLUETOOTH, status);
 }
 
-- 
1.8.4.1

