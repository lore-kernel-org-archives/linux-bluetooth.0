Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/14] android: Add support for handling cancel bond command
Date: Thu, 31 Oct 2013 02:55:47 +0000
Message-Id: <1383188154-22905-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 8c5482b..0f174a6 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -626,6 +626,19 @@ static bool create_bond(void *buf, uint16_t len)
 	return true;
 }
 
+static bool cancel_bond(void *buf, uint16_t len)
+{
+	struct hal_cmd_cancel_bond *cmd = buf;
+	struct mgmt_addr_info cp;
+
+	cp.type = BDADDR_BREDR;
+	android2bdaddr(cmd->bdaddr, &cp.bdaddr);
+
+	return mgmt_reply(adapter->mgmt, MGMT_OP_CANCEL_PAIR_DEVICE,
+				adapter->index, sizeof(cp), &cp, NULL, NULL,
+				NULL) > 0;
+}
+
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len)
 {
@@ -668,6 +681,11 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 			goto error;
 
 		break;
+	case HAL_OP_CANCEL_BOND:
+		if (!cancel_bond(buf, len))
+			goto error;
+
+		break;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
 		goto error;
-- 
1.8.4.rc3

