Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/14] android: Add support for handling create bond command
Date: Thu, 31 Oct 2013 02:55:46 +0000
Message-Id: <1383188154-22905-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index d730dde..8c5482b 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -568,6 +568,64 @@ static uint8_t set_property(void *buf, uint16_t len)
 	}
 }
 
+static uint8_t status_mgmt2hal(uint8_t mgmt)
+{
+	switch (mgmt) {
+	case MGMT_STATUS_SUCCESS:
+		return HAL_STATUS_SUCCESS;
+	case MGMT_STATUS_NO_RESOURCES:
+		return HAL_STATUS_NOMEM;
+	case MGMT_STATUS_BUSY:
+		return HAL_STATUS_BUSY;
+	case MGMT_STATUS_NOT_SUPPORTED:
+		return HAL_STATUS_UNSUPPORTED;
+	case MGMT_STATUS_INVALID_PARAMS:
+		return HAL_STATUS_INVALID;
+	case MGMT_STATUS_AUTH_FAILED:
+		return HAL_STATUS_AUTH_FAILURE;
+	case MGMT_STATUS_NOT_CONNECTED:
+		return HAL_STATUS_REMOTE_DEVICE_DOWN;
+	default:
+		return HAL_STATUS_FAILED;
+	}
+}
+
+static void pair_device_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_pair_device *rp = param;
+
+	DBG("status %u", status);
+
+	/* On success bond state change will be send when new link key event
+	 * is received */
+	if (status == MGMT_STATUS_SUCCESS)
+		return;
+
+	send_bond_state_change(&rp->addr.bdaddr, status_mgmt2hal(status),
+							HAL_BOND_STATE_NONE);
+}
+
+static bool create_bond(void *buf, uint16_t len)
+{
+	struct hal_cmd_create_bond *cmd = buf;
+	struct mgmt_cp_pair_device cp;
+
+	cp.io_cap = DEFAULT_IO_CAPABILITY;
+	cp.addr.type = BDADDR_BREDR;
+	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_PAIR_DEVICE, adapter->index,
+				sizeof(cp), &cp, pair_device_complete, NULL,
+				NULL) == 0)
+		return false;
+
+	send_bond_state_change(&cp.addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+
+	return true;
+}
+
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len)
 {
@@ -605,6 +663,11 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 			goto error;
 
 		break;
+	case HAL_OP_CREATE_BOND:
+		if (!create_bond(buf, len))
+			goto error;
+
+		break;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
 		goto error;
-- 
1.8.4.rc3

