Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 3/5] android/hal: Add support for handling bond state change event
Date: Tue, 29 Oct 2013 12:52:40 +0100
Message-ID: <1383047562-4799-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383047562-4799-1-git-send-email-szymon.janc@tieto.com>
References: <1383047562-4799-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 5f6dcbe..a3f5038 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -68,6 +68,16 @@ static void handle_adapter_props_changed(void *buf, uint16_t len)
 	bt_hal_cbacks->adapter_properties_cb(ev->status, ev->num_props, props);
 }
 
+static void handle_bond_state_change(void *buf)
+{
+	struct hal_ev_bond_state_changed *ev = buf;
+	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
+
+	if (bt_hal_cbacks->bond_state_changed_cb)
+		bt_hal_cbacks->bond_state_changed_cb(ev->status, addr,
+								ev->state);
+}
+
 void bt_thread_associate(void)
 {
 	if (bt_hal_cbacks->thread_evt_cb)
@@ -98,6 +108,9 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_ADAPTER_PROPS_CHANGED:
 		handle_adapter_props_changed(buf, len);
 		break;
+	case HAL_EV_BOND_STATE_CHANGED:
+		handle_bond_state_change(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
-- 
1.8.4.1

