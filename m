Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 15/15] android: Add initial support for handling adapter get property command
Date: Fri, 25 Oct 2013 10:56:18 +0200
Message-ID: <1382691378-31940-15-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
References: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for HAL_BT_PROP_BDADDR property only.
---
 android/adapter.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 5837e99..e6791e7 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -322,6 +322,49 @@ static bool set_mode(uint16_t opcode, uint8_t mode)
 	return false;
 }
 
+static void send_adapter_name(void)
+{
+	struct hal_ev_adapter_props_changed *ev;
+	int len;
+
+	len = sizeof(*ev) + sizeof(struct hal_property) + sizeof(bdaddr_t);
+
+	ev = g_malloc(len);
+
+	ev->num_props = 1;
+	ev->status = HAL_ERROR_SUCCESS;
+
+	ev->props[0].type = HAL_BT_PROP_BDADDR;
+	ev->props[0].len = sizeof(bdaddr_t);
+	baswap((bdaddr_t *) ev->props[0].val, &adapter->bdaddr);
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
+
+	g_free(ev);
+}
+
+static bool get_property(void *buf, uint16_t len)
+{
+	struct hal_cmd_get_adapter_prop *cmd = buf;
+
+	switch (cmd->type) {
+	case HAL_BT_PROP_BDADDR:
+		send_adapter_name();
+		return true;
+	case HAL_BT_PROP_BDNAME:
+	case HAL_BT_PROP_UUIDS:
+	case HAL_BT_PROP_CLASS_OF_DEVICE:
+	case HAL_BT_PROP_TYPE_OF_DEVICE:
+	case HAL_BT_PROP_SERVICE_RECORD:
+	case HAL_BT_PROP_ADP_SCAN_MODE:
+	case HAL_BT_PROP_ADP_BONDED_DEVICES:
+	case HAL_BT_PROP_ADP_DISC_TIMEOUT:
+	default:
+		return false;
+	}
+}
+
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len)
 {
@@ -352,6 +395,13 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 			return;
 		}
 		break;
+	case HAL_OP_GET_ADAPTER_PROP:
+		if (get_property(buf, len)) {
+			ipc_send(io, HAL_SERVICE_ID_BLUETOOTH, opcode, 0, NULL,
+									-1);
+			return;
+		}
+		break;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
 		break;
-- 
1.8.4.1

