Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] android/hal: Add support for handling av connection state event
Date: Fri, 25 Oct 2013 17:52:04 +0200
Message-Id: <1382716327-25283-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1382716327-25283-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1382716327-25283-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-av.c  | 13 +++++++++++++
 android/hal-msg.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/android/hal-av.c b/android/hal-av.c
index 051fc3e..8aa096d 100644
--- a/android/hal-av.c
+++ b/android/hal-av.c
@@ -20,6 +20,7 @@
 
 #include "hal-log.h"
 #include "hal.h"
+#include "hal-msg.h"
 
 static const btav_callbacks_t *cbs = NULL;
 
@@ -28,6 +29,15 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
+static void handle_connection_state(void *buf)
+{
+	struct hal_msg_ev_bt_av_connection_state *ev = buf;
+
+	if (cbs->connection_state_cb)
+		cbs->connection_state_cb(ev->state,
+						(bt_bdaddr_t *) (ev->bdaddr));
+}
+
 /* will be called from notification thread context */
 void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -35,6 +45,9 @@ void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
 		return;
 
 	switch (opcode) {
+	case HAL_MSG_EV_BT_AV_CONNECTION_STATE:
+		handle_connection_state(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 5de8eb2..558e030 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -360,3 +360,9 @@ struct hal_ev_le_test_mode {
 	uint8_t  status;
 	uint16_t num_packets;
 } __attribute__((packed));
+
+#define HAL_MSG_EV_BT_AV_CONNECTION_STATE	0x81
+struct hal_msg_ev_bt_av_connection_state {
+	uint8_t state;
+	uint8_t bdaddr[6];
+} __attribute__((packed));
-- 
1.8.4.1

