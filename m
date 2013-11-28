Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/10] android: Initialize IPC with command and notification sockets
Date: Thu, 28 Nov 2013 15:15:21 +0100
Message-Id: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pass sockets after succesfully connected to HAL. This will allow
to improve IPC helpers API.
---
 android/ipc.c  | 15 +++++++++++++++
 android/ipc.h  |  3 +++
 android/main.c |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/android/ipc.c b/android/ipc.c
index 25c36fd..028d4ad 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -36,6 +36,21 @@
 #include "ipc.h"
 #include "log.h"
 
+static int cmd_sk = -1;
+static int notif_sk = -1;
+
+void ipc_init(int command_sk, int notification_sk)
+{
+	cmd_sk = command_sk;
+	notif_sk = notification_sk;
+}
+
+void ipc_cleanup(void)
+{
+	cmd_sk = -1;
+	notif_sk = -1;
+}
+
 void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd)
 {
diff --git a/android/ipc.h b/android/ipc.h
index ad4a2d2..5786d2d 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -21,6 +21,9 @@
  *
  */
 
+void ipc_init(int command_sk, int notification_sk);
+void ipc_cleanup(void);
+
 void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd);
 void ipc_send_rsp(int sk, uint8_t service_id, uint8_t opcode, uint8_t status);
diff --git a/android/main.c b/android/main.c
index bfd2a87..4e6ad38 100644
--- a/android/main.c
+++ b/android/main.c
@@ -354,6 +354,9 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	g_io_add_watch(hal_cmd_io, cond, cmd_watch_cb, NULL);
 
+	ipc_init(g_io_channel_unix_get_fd(hal_cmd_io),
+				g_io_channel_unix_get_fd(hal_notif_io));
+
 	info("Successfully connected to HAL");
 
 	return FALSE;
@@ -494,6 +497,8 @@ static void cleanup_hal_connection(void)
 		g_io_channel_unref(hal_notif_io);
 		hal_notif_io = NULL;
 	}
+
+	ipc_cleanup();
 }
 
 static bool set_capabilities(void)
-- 
1.8.3.2

