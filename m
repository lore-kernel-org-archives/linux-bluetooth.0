Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] android/hal-hidhost: Add implementation of .connection_state_cb
Date: Thu, 31 Oct 2013 14:19:47 +0200
Message-Id: <1383221988-1601-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1383221988-1601-1-git-send-email-luiz.dentz@gmail.com>
References: <1383221988-1601-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-hidhost.c   | 25 +++++++++++++++++++++++++
 android/hal-ipc-api.txt |  1 +
 android/hal-ipc.c       |  3 +++
 android/hal-msg.h       | 14 ++++++++++++++
 android/hal.h           |  1 +
 5 files changed, 44 insertions(+)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 032e961..9354b95 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -31,6 +31,31 @@ static bool interface_ready(void)
 	return bt_hh_cbacks != NULL;
 }
 
+static void handle_conn_state(void *buf)
+{
+	struct hal_ev_hid_conn_state *ev = buf;
+
+	if (bt_hh_cbacks->connection_state_cb)
+		bt_hh_cbacks->connection_state_cb((bt_bdaddr_t *) (ev->bdaddr),
+								ev->state);
+}
+
+/* will be called from notification thread context */
+void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
+{
+	if (!interface_ready())
+		return;
+
+	switch (opcode) {
+	case HAL_EV_HID_CONN_STATE:
+		handle_conn_state(buf);
+		break;
+	default:
+		DBG("Unhandled callback opcode=0x%x", opcode);
+		break;
+	}
+}
+
 static bt_status_t hh_connect(bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_hid_connect cmd;
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index a5d1980..6b11684 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -574,6 +574,7 @@ Notifications:
 	Opcode 0x81 - Connection State notification
 
 		Notification parameters: Remote address (6 octets)
+		                         Connection State (1 octets)
 
 		Valid connection states: 0x00 = Connected
 		                         0x01 = Connecting
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index f68e789..14be69b 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -49,6 +49,9 @@ static void notification_dispatch(struct hal_hdr *msg, int fd)
 	case HAL_SERVICE_ID_BLUETOOTH:
 		bt_notify_adapter(msg->opcode, msg->payload, msg->len);
 		break;
+	case HAL_SERVICE_ID_HIDHOST:
+		bt_notify_hh(msg->opcode, msg->payload, msg->len);
+		break;
 	case HAL_SERVICE_ID_A2DP:
 		bt_notify_av(msg->opcode, msg->payload, msg->len);
 		break;
diff --git a/android/hal-msg.h b/android/hal-msg.h
index dfe73cc..b792411 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -423,6 +423,20 @@ struct hal_ev_le_test_mode {
 	uint16_t num_packets;
 } __attribute__((packed));
 
+#define HAL_HID_STATE_CONNECTED		0x00
+#define HAL_HID_STATE_CONNECTING	0x01
+#define HAL_HID_STATE_DISCONNECTED	0x02
+#define HAL_HID_STATE_DISCONNECTING	0x03
+#define HAL_HID_STATE_NO_HID		0x07
+#define HAL_HID_STATE_FAILED		0x08
+#define HAL_HID_STATE_UNKNOWN		0x09
+
+#define HAL_EV_HID_CONN_STATE		0x81
+struct hal_ev_hid_conn_state {
+	uint8_t bdaddr[6];
+	uint8_t state;
+} __attribute__((packed));
+
 #define HAL_EV_AV_CONNECTION_STATE	0x81
 struct hal_ev_av_connection_state {
 	uint8_t state;
diff --git a/android/hal.h b/android/hal.h
index a377649..5d6a93e 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -29,4 +29,5 @@ btav_interface_t *bt_get_av_interface(void);
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len);
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
+void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len);
 void bt_notify_av(uint16_t opcode, void *buf, uint16_t len);
-- 
1.8.3.1

