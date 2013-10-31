Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v2] android: Add support for handling remove bond command
Date: Thu, 31 Oct 2013 11:23:33 +0100
Message-ID: <1383215013-24490-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

Bond state change is send when command complete for unpair device is
received and status was success.
---
 android/adapter.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 60c62f4..a3f9aa6 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -751,6 +751,34 @@ static bool cancel_bond(void *buf, uint16_t len)
 				NULL) > 0;
 }
 
+static void unpair_device_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_unpair_device *rp = param;
+
+	DBG("status %u", status);
+
+	if (status != MGMT_STATUS_SUCCESS)
+		return;
+
+	send_bond_state_change(&rp->addr.bdaddr, HAL_STATUS_SUCCESS,
+							HAL_BOND_STATE_NONE);
+}
+
+static bool remove_bond(void *buf, uint16_t len)
+{
+	struct hal_cmd_remove_bond *cmd = buf;
+	struct mgmt_cp_unpair_device cp;
+
+	cp.disconnect = 1;
+	cp.addr.type = BDADDR_BREDR;
+	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
+
+	return mgmt_send(adapter->mgmt, MGMT_OP_UNPAIR_DEVICE,
+				adapter->index, sizeof(cp), &cp,
+				unpair_device_complete, NULL, NULL) > 0;
+}
+
 static uint8_t pin_reply(void *buf, uint16_t len)
 {
 	struct hal_cmd_pin_reply *cmd = buf;
@@ -929,6 +957,11 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 			goto error;
 
 		break;
+	case HAL_OP_REMOVE_BOND:
+		if (!remove_bond(buf, len))
+			goto error;
+
+		break;
 	case HAL_OP_PIN_REPLY:
 		status = pin_reply(buf, len);
 		if (status != HAL_STATUS_SUCCESS)
-- 
1.8.4.1

