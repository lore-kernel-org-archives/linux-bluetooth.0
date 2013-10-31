Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 13/14] android: Add support for handling pin reply command
Date: Thu, 31 Oct 2013 02:55:53 +0000
Message-Id: <1383188154-22905-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 00766eb..a6382dd 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -771,6 +771,49 @@ static bool remove_bond(void *buf, uint16_t len)
 	return true;
 }
 
+static uint8_t pin_reply(void *buf, uint16_t len)
+{
+	struct hal_cmd_pin_reply *cmd = buf;
+	bdaddr_t bdaddr;
+	char addr[18];
+
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+	ba2str(&bdaddr, addr);
+
+	DBG("%s accept %u pin_len %u", addr, cmd->accept, cmd->pin_len);
+
+	if (!cmd->accept && cmd->pin_len)
+		return HAL_STATUS_INVALID;
+
+	if (cmd->accept) {
+		struct mgmt_cp_pin_code_reply rp;
+
+		memset(&rp, 0, sizeof(rp));
+
+		bacpy(&rp.addr.bdaddr, &bdaddr);
+		rp.addr.type = BDADDR_BREDR;
+		rp.pin_len = cmd->pin_len;
+		memcpy(rp.pin_code, cmd->pin_code, rp.pin_len);
+
+		if (mgmt_reply(adapter->mgmt, MGMT_OP_PIN_CODE_REPLY,
+					adapter->index, sizeof(rp), &rp,
+					NULL, NULL, NULL) == 0)
+			return HAL_STATUS_FAILED;
+	} else {
+		struct mgmt_cp_pin_code_neg_reply rp;
+
+		bacpy(&rp.addr.bdaddr, &bdaddr);
+		rp.addr.type = BDADDR_BREDR;
+
+		if (mgmt_reply(adapter->mgmt, MGMT_OP_PIN_CODE_NEG_REPLY,
+					adapter->index, sizeof(rp), &rp,
+					NULL, NULL, NULL) == 0)
+			return HAL_STATUS_FAILED;
+	}
+
+	return HAL_STATUS_SUCCESS;
+}
+
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len)
 {
@@ -823,6 +866,12 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 			goto error;
 
 		break;
+	case HAL_OP_PIN_REPLY:
+		status = pin_reply(buf, len);
+		if (status != HAL_STATUS_SUCCESS)
+			goto error;
+
+		break;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
 		goto error;
-- 
1.8.4.rc3

