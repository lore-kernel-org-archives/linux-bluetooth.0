Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 13/14] android/hal: Remove not neede buf len from hidhost HAL
Date: Wed, 6 Nov 2013 15:09:29 +0100
Message-ID: <1383746970-25906-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message correctness is verified upon reception and handling functions
can simply make assumption that data in buffer is correct.
---
 android/hal-hidhost.c | 2 +-
 android/hal-ipc.c     | 2 +-
 android/hal.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index f1a2223..a96e122 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -78,7 +78,7 @@ static void handle_get_report(void *buf)
 }
 
 /* will be called from notification thread context */
-void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
+void bt_notify_hh(uint16_t opcode, void *buf)
 {
 	if (!interface_ready())
 		return;
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 7ca9fe4..173229a 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -50,7 +50,7 @@ static void notification_dispatch(struct hal_hdr *msg, int fd)
 		bt_notify_adapter(msg->opcode, msg->payload);
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
-		bt_notify_hh(msg->opcode, msg->payload, msg->len);
+		bt_notify_hh(msg->opcode, msg->payload);
 		break;
 	case HAL_SERVICE_ID_A2DP:
 		bt_notify_av(msg->opcode, msg->payload, msg->len);
diff --git a/android/hal.h b/android/hal.h
index c10a27c..9f1ecec 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -29,5 +29,5 @@ btav_interface_t *bt_get_av_interface(void);
 void bt_notify_adapter(uint16_t opcode, void *buf);
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
-void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len);
+void bt_notify_hh(uint16_t opcode, void *buf);
 void bt_notify_av(uint16_t opcode, void *buf, uint16_t len);
-- 
1.8.4.2

