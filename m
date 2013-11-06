Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 14/14] android/hal: Remove not neede buf len from av HAL
Date: Wed, 6 Nov 2013 15:09:30 +0100
Message-ID: <1383746970-25906-15-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message correctness is verified upon reception and handling functions
can simply make assumption that data in buffer is correct.
---
 android/hal-av.c  | 2 +-
 android/hal-ipc.c | 2 +-
 android/hal.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/hal-av.c b/android/hal-av.c
index 9e1b3df..3da79c4 100644
--- a/android/hal-av.c
+++ b/android/hal-av.c
@@ -49,7 +49,7 @@ static void handle_audio_state(void *buf)
 }
 
 /* will be called from notification thread context */
-void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
+void bt_notify_av(uint16_t opcode, void *buf)
 {
 	if (!interface_ready())
 		return;
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 173229a..2de7c2f 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -53,7 +53,7 @@ static void notification_dispatch(struct hal_hdr *msg, int fd)
 		bt_notify_hh(msg->opcode, msg->payload);
 		break;
 	case HAL_SERVICE_ID_A2DP:
-		bt_notify_av(msg->opcode, msg->payload, msg->len);
+		bt_notify_av(msg->opcode, msg->payload);
 		break;
 	default:
 		DBG("Unhandled notification service=%d opcode=0x%x",
diff --git a/android/hal.h b/android/hal.h
index 9f1ecec..bcd0861 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -30,4 +30,4 @@ void bt_notify_adapter(uint16_t opcode, void *buf);
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
 void bt_notify_hh(uint16_t opcode, void *buf);
-void bt_notify_av(uint16_t opcode, void *buf, uint16_t len);
+void bt_notify_av(uint16_t opcode, void *buf);
-- 
1.8.4.2

