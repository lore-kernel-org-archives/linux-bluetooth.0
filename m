Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 14/14] android: Add support for handling SSP reply command
Date: Thu, 31 Oct 2013 02:55:54 +0000
Message-Id: <1383188154-22905-15-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index a6382dd..9e12879 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -814,6 +814,94 @@ static uint8_t pin_reply(void *buf, uint16_t len)
 	return HAL_STATUS_SUCCESS;
 }
 
+static uint8_t user_confirm_reply(const bdaddr_t *bdaddr, bool accept)
+{
+	struct mgmt_addr_info cp;
+	uint16_t opcode;
+
+	if (accept)
+		opcode = MGMT_OP_USER_CONFIRM_REPLY;
+	else
+		opcode = MGMT_OP_USER_CONFIRM_NEG_REPLY;
+
+	bacpy(&cp.bdaddr, bdaddr);
+	cp.type = BDADDR_BREDR;
+
+	if (mgmt_reply(adapter->mgmt, opcode, adapter->index, sizeof(cp), &cp,
+							NULL, NULL, NULL) > 0)
+		return HAL_STATUS_SUCCESS;
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t user_passkey_reply(const bdaddr_t *bdaddr, bool accept,
+							uint32_t passkey)
+{
+	unsigned int id;
+
+	if (accept) {
+		struct mgmt_cp_user_passkey_reply cp;
+
+		memset(&cp, 0, sizeof(cp));
+		bacpy(&cp.addr.bdaddr, bdaddr);
+		cp.addr.type = BDADDR_BREDR;
+		cp.passkey = htobl(passkey);
+
+		id = mgmt_reply(adapter->mgmt, MGMT_OP_USER_PASSKEY_REPLY,
+					adapter->index, sizeof(cp), &cp,
+					NULL, NULL, NULL);
+	} else {
+		struct mgmt_cp_user_passkey_neg_reply cp;
+
+		memset(&cp, 0, sizeof(cp));
+		bacpy(&cp.addr.bdaddr, bdaddr);
+		cp.addr.type = BDADDR_BREDR;
+
+		id = mgmt_reply(adapter->mgmt, MGMT_OP_USER_PASSKEY_NEG_REPLY,
+					adapter->index, sizeof(cp), &cp,
+					NULL, NULL, NULL);
+	}
+
+	if (id == 0)
+		return HAL_STATUS_FAILED;
+
+	return HAL_STATUS_SUCCESS;
+}
+
+static uint8_t ssp_reply(void *buf, uint16_t len)
+{
+	struct hal_cmd_ssp_reply *cmd = buf;
+	uint8_t status;
+	bdaddr_t bdaddr;
+	char addr[18];
+
+	/* TODO should parameters sanity be verified here? */
+
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+	ba2str(&bdaddr, addr);
+
+	DBG("%s variant %u accept %u", addr, cmd->ssp_variant, cmd->accept);
+
+	switch (cmd->ssp_variant) {
+	case HAL_SSP_VARIANT_CONFIRM:
+	case HAL_SSP_VARIANT_CONSENT:
+		status = user_confirm_reply(&bdaddr, cmd->accept);
+		break;
+	case HAL_SSP_VARIANT_ENTRY:
+		status = user_passkey_reply(&bdaddr, cmd->accept,
+								cmd->passkey);
+		break;
+	case HAL_SSP_VARIANT_NOTIF:
+		status = HAL_STATUS_SUCCESS;
+		break;
+	default:
+		status = HAL_STATUS_INVALID;
+		break;
+	}
+
+	return status;
+}
+
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len)
 {
@@ -872,6 +960,12 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 			goto error;
 
 		break;
+	case HAL_OP_SSP_REPLY:
+		status = ssp_reply(buf, len);
+		if (status != HAL_STATUS_SUCCESS)
+			goto error;
+
+		break;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
 		goto error;
-- 
1.8.4.rc3

