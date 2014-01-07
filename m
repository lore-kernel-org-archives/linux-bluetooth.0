Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 01/10] android/ipc: Add initial code for audio IPC
Date: Tue,  7 Jan 2014 13:53:14 +0200
Message-Id: <1389095603-30504-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add initial code for listen and accept connections on the abstract
socket defined for the audio IPC.
---
v2: Split audio IPC services for HAL services and fix invalid messages or
disconnections causing the daemon to exit. The audio HAL is independent of
bluetooth and should only affect A2DP service.
v3: Split audio IPC related functions to separate files (audio-ipc.{c,h}),
please disregard git thinking there is a copy of hdp code because they are
similar.

 android/Android.mk                                 |   1 +
 android/Makefile.am                                |   2 +
 android/audio-ipc.c                                | 104 +++++++++++++++++++++
 .../health/hdp_manager.h => android/audio-ipc.h    |   7 +-
 monitor/analyze.h => android/audio-msg.h           |   7 +-
 android/ipc.c                                      |  14 +--
 android/ipc.h                                      |   1 +
 7 files changed, 124 insertions(+), 12 deletions(-)
 create mode 100644 android/audio-ipc.c
 copy profiles/health/hdp_manager.h => android/audio-ipc.h (86%)
 copy monitor/analyze.h => android/audio-msg.h (83%)

diff --git a/android/Android.mk b/android/Android.mk
index 7d9cc4f..27631cc 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -26,6 +26,7 @@ LOCAL_SRC_FILES := \
 	hidhost.c \
 	socket.c \
 	ipc.c ipc.h \
+	audio-ipc.c audio-ipc.h \
 	avdtp.c \
 	a2dp.c \
 	pan.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 7d9b580..8810369 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -15,6 +15,7 @@ noinst_PROGRAMS += android/bluetoothd
 android_bluetoothd_SOURCES = android/main.c \
 				src/log.c \
 				android/hal-msg.h \
+				android/audio-msg.h \
 				android/utils.h \
 				src/sdpd-database.c src/sdpd-server.c \
 				src/sdpd-service.c src/sdpd-request.c \
@@ -25,6 +26,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
 				android/ipc.h android/ipc.c \
+				android/audio-ipc.h android/audio-ipc.c \
 				android/avdtp.h android/avdtp.c \
 				android/a2dp.h android/a2dp.c \
 				android/socket.h android/socket.c \
diff --git a/android/audio-ipc.c b/android/audio-ipc.c
new file mode 100644
index 0000000..b537f21
--- /dev/null
+++ b/android/audio-ipc.c
@@ -0,0 +1,104 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stddef.h>
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <glib.h>
+
+#include "ipc.h"
+#include "log.h"
+#include "audio-msg.h"
+#include "audio-ipc.h"
+
+static GIOChannel *audio_io = NULL;
+
+static gboolean audio_watch_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	char buf[BLUEZ_AUDIO_MTU];
+	ssize_t ret;
+	int fd;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		info("Audio IPC: command socket closed");
+		goto fail;
+	}
+
+	fd = g_io_channel_unix_get_fd(io);
+
+	ret = read(fd, buf, sizeof(buf));
+	if (ret < 0) {
+		error("Audio IPC: command read failed (%s)", strerror(errno));
+		goto fail;
+	}
+
+	return TRUE;
+
+fail:
+	audio_ipc_cleanup();
+	return FALSE;
+}
+
+static gboolean audio_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	DBG("");
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		error("Audio IPC: socket connect failed");
+		audio_ipc_cleanup();
+		return FALSE;
+	}
+
+	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+
+	g_io_add_watch(audio_io, cond, audio_watch_cb, NULL);
+
+	info("Audio IPC: successfully connected");
+
+	return FALSE;
+}
+
+void audio_ipc_init(void)
+{
+	audio_io = ipc_connect(BLUEZ_AUDIO_SK_PATH, sizeof(BLUEZ_AUDIO_SK_PATH),
+							audio_connect_cb);
+}
+
+void audio_ipc_cleanup(void)
+{
+	if (audio_io) {
+		g_io_channel_shutdown(audio_io, TRUE, NULL);
+		g_io_channel_unref(audio_io);
+		audio_io = NULL;
+	}
+}
diff --git a/profiles/health/hdp_manager.h b/android/audio-ipc.h
similarity index 86%
copy from profiles/health/hdp_manager.h
copy to android/audio-ipc.h
index 1cab4d0..769bfd6 100644
--- a/profiles/health/hdp_manager.h
+++ b/android/audio-ipc.h
@@ -2,7 +2,8 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -20,5 +21,5 @@
  *
  */
 
-int hdp_manager_init(void);
-void hdp_manager_exit(void);
+void audio_ipc_init(void);
+void audio_ipc_cleanup(void);
diff --git a/monitor/analyze.h b/android/audio-msg.h
similarity index 83%
copy from monitor/analyze.h
copy to android/audio-msg.h
index 7cdda51..d5b4099 100644
--- a/monitor/analyze.h
+++ b/android/audio-msg.h
@@ -2,8 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2011-2012  Intel Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -22,4 +21,6 @@
  *
  */
 
-void analyze_trace(const char *path);
+#define BLUEZ_AUDIO_MTU 1024
+
+static const char BLUEZ_AUDIO_SK_PATH[] = "\0bluez_audio_socket";
diff --git a/android/ipc.c b/android/ipc.c
index 9e8ccc3..8a91248 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -145,7 +145,7 @@ static gboolean notif_watch_cb(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
-static GIOChannel *connect_hal(GIOFunc connect_cb)
+GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb)
 {
 	struct sockaddr_un addr;
 	GIOCondition cond;
@@ -167,11 +167,11 @@ static GIOChannel *connect_hal(GIOFunc connect_cb)
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_UNIX;
 
-	memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
+	memcpy(addr.sun_path, path, size);
 
 	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		error("IPC: failed to connect HAL socket: %d (%s)", errno,
-							strerror(errno));
+		error("IPC: failed to connect HAL socket %s: %d (%s)", &path[1],
+							errno, strerror(errno));
 		g_io_channel_unref(io);
 		return NULL;
 	}
@@ -218,7 +218,8 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	notif_io = connect_hal(notif_connect_cb);
+	notif_io = ipc_connect(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
+							notif_connect_cb);
 	if (!notif_io)
 		raise(SIGTERM);
 
@@ -227,7 +228,8 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 
 void ipc_init(void)
 {
-	cmd_io = connect_hal(cmd_connect_cb);
+	cmd_io = ipc_connect(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
+							cmd_connect_cb);
 	if (!cmd_io)
 		raise(SIGTERM);
 }
diff --git a/android/ipc.h b/android/ipc.h
index 6cd102b..02ad6bb 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -28,6 +28,7 @@ struct ipc_handler {
 };
 void ipc_init(void);
 void ipc_cleanup(void);
+GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb);
 
 void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status);
 void ipc_send_rsp_full(uint8_t service_id, uint8_t opcode, uint16_t len,
-- 
1.8.4.2

