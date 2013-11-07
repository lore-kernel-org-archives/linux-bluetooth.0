Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/3] android/hal: Use a2dp instead of av in a2dp HAL
Date: Thu, 7 Nov 2013 16:32:07 +0100
Message-ID: <1383838327-5971-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383838327-5971-1-git-send-email-szymon.janc@tieto.com>
References: <1383838327-5971-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Match functions names to HAL name. Where not needed av prefix is
removed.
---
 android/hal-a2dp.c      | 20 ++++++++++----------
 android/hal-bluetooth.c |  2 +-
 android/hal-ipc.c       |  2 +-
 android/hal.h           |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index 2ebf801..f0c301e 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -49,7 +49,7 @@ static void handle_audio_state(void *buf)
 }
 
 /* will be called from notification thread context */
-void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
+void bt_notify_a2dp(uint16_t opcode, void *buf, uint16_t len)
 {
 	if (!interface_ready())
 		return;
@@ -67,7 +67,7 @@ void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
 	}
 }
 
-static bt_status_t av_connect(bt_bdaddr_t *bd_addr)
+static bt_status_t a2dp_connect(bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_a2dp_connect cmd;
 
@@ -82,7 +82,7 @@ static bt_status_t av_connect(bt_bdaddr_t *bd_addr)
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
-static bt_status_t av_disconnect(bt_bdaddr_t *bd_addr)
+static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_a2dp_disconnect cmd;
 
@@ -97,7 +97,7 @@ static bt_status_t av_disconnect(bt_bdaddr_t *bd_addr)
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
-static bt_status_t av_init(btav_callbacks_t *callbacks)
+static bt_status_t init(btav_callbacks_t *callbacks)
 {
 	DBG("");
 
@@ -108,7 +108,7 @@ static bt_status_t av_init(btav_callbacks_t *callbacks)
 	return BT_STATUS_SUCCESS;
 }
 
-static void av_cleanup()
+static void cleanup()
 {
 	DBG("");
 
@@ -122,13 +122,13 @@ static void av_cleanup()
 
 static btav_interface_t iface = {
 	.size = sizeof(iface),
-	.init = av_init,
-	.connect = av_connect,
-	.disconnect = av_disconnect,
-	.cleanup = av_cleanup
+	.init = init,
+	.connect = a2dp_connect,
+	.disconnect = disconnect,
+	.cleanup = cleanup
 };
 
-btav_interface_t *bt_get_av_interface()
+btav_interface_t *bt_get_a2dp_interface()
 {
 	return &iface;
 }
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 88c7b99..3e5d41f 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -654,7 +654,7 @@ static const void *get_profile_interface(const char *profile_id)
 		return bt_get_pan_interface();
 
 	if (!strcmp(profile_id, BT_PROFILE_ADVANCED_AUDIO_ID))
-		return bt_get_av_interface();
+		return bt_get_a2dp_interface();
 
 	return NULL;
 }
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 14be69b..1d33374 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -53,7 +53,7 @@ static void notification_dispatch(struct hal_hdr *msg, int fd)
 		bt_notify_hh(msg->opcode, msg->payload, msg->len);
 		break;
 	case HAL_SERVICE_ID_A2DP:
-		bt_notify_av(msg->opcode, msg->payload, msg->len);
+		bt_notify_a2dp(msg->opcode, msg->payload, msg->len);
 		break;
 	default:
 		DBG("Unhandled notification service=%d opcode=0x%x",
diff --git a/android/hal.h b/android/hal.h
index 5d6a93e..f47ec2a 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -24,10 +24,10 @@
 btsock_interface_t *bt_get_sock_interface(void);
 bthh_interface_t *bt_get_hidhost_interface(void);
 btpan_interface_t *bt_get_pan_interface(void);
-btav_interface_t *bt_get_av_interface(void);
+btav_interface_t *bt_get_a2dp_interface(void);
 
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len);
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
 void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len);
-void bt_notify_av(uint16_t opcode, void *buf, uint16_t len);
+void bt_notify_a2dp(uint16_t opcode, void *buf, uint16_t len);
-- 
1.8.4.2

