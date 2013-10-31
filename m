Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/14] android: Add support for handling remove bond command
Date: Thu, 31 Oct 2013 02:55:48 +0000
Message-Id: <1383188154-22905-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 0f174a6..0a91149 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -639,6 +639,26 @@ static bool cancel_bond(void *buf, uint16_t len)
 				NULL) > 0;
 }
 
+static bool remove_bond(void *buf, uint16_t len)
+{
+	struct hal_cmd_remove_bond *cmd = buf;
+	struct mgmt_cp_unpair_device cp;
+
+	cp.disconnect = 1;
+	cp.addr.type = BDADDR_BREDR;
+	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_UNPAIR_DEVICE,
+				adapter->index, sizeof(cp), &cp,
+				NULL, NULL, NULL) == 0)
+		return false;
+
+	send_bond_state_change(&cp.addr.bdaddr, HAL_STATUS_SUCCESS,
+							HAL_BOND_STATE_NONE);
+
+	return true;
+}
+
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len)
 {
@@ -686,6 +706,11 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 			goto error;
 
 		break;
+	case HAL_OP_REMOVE_BOND:
+		if (!remove_bond(buf, len))
+			goto error;
+
+		break;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
 		goto error;
-- 
1.8.4.rc3

