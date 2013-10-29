Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v4 1/2] android/hal: Add support for handling pin request event
Date: Tue, 29 Oct 2013 13:49:04 +0100
Message-ID: <1383050945-7984-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
v4: Added comment clarifying that pointer casting is safe here

 android/hal-bluetooth.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index a3f5038..230f742 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -78,6 +78,17 @@ static void handle_bond_state_change(void *buf)
 								ev->state);
 }
 
+static void handle_pin_request(void *buf)
+{
+	struct hal_ev_pin_request *ev = buf;
+	/* Those are declared as packed, so it's safe to assign pointers */
+	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
+	bt_bdname_t *name = (bt_bdname_t *) ev->name;
+
+	if (bt_hal_cbacks->pin_request_cb)
+		bt_hal_cbacks->pin_request_cb(addr, name, ev->class_of_dev);
+}
+
 void bt_thread_associate(void)
 {
 	if (bt_hal_cbacks->thread_evt_cb)
@@ -111,6 +122,9 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_BOND_STATE_CHANGED:
 		handle_bond_state_change(buf);
 		break;
+	case HAL_EV_PIN_REQUEST:
+		handle_pin_request(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
-- 
1.8.4.1

