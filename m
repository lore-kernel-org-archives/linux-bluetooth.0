Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 5/7] android/a2dp: Use common IPC for audio socket
Date: Tue, 25 Feb 2014 11:50:17 +0100
Message-Id: <1393325419-16544-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393325419-16544-1-git-send-email-szymon.janc@tieto.com>
References: <1393325419-16544-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes audio HAL to use same code for IPC as BT HAL.
---
 android/Android.mk  |   1 -
 android/Makefile.am |   1 -
 android/a2dp.c      |  72 ++++++++++++++++--------
 android/audio-ipc.c | 155 ----------------------------------------------------
 android/audio-ipc.h |  31 -----------
 android/audio-msg.h |   1 +
 6 files changed, 49 insertions(+), 212 deletions(-)
 delete mode 100644 android/audio-ipc.c
 delete mode 100644 android/audio-ipc.h

diff --git a/android/Android.mk b/android/Android.mk
index 82c834b..56b86ba 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -35,7 +35,6 @@ LOCAL_SRC_FILES := \
 	bluez/android/hidhost.c \
 	bluez/android/socket.c \
 	bluez/android/ipc.c \
-	bluez/android/audio-ipc.c \
 	bluez/android/avdtp.c \
 	bluez/android/a2dp.c \
 	bluez/android/avctp.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index b93b840..b09948f 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -32,7 +32,6 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
 				android/ipc.h android/ipc.c \
-				android/audio-ipc.h android/audio-ipc.c \
 				android/avdtp.h android/avdtp.c \
 				android/a2dp.h android/a2dp.c \
 				android/avctp.h android/avctp.c \
diff --git a/android/a2dp.c b/android/a2dp.c
index b05d4bd..3ac6452 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -47,7 +47,6 @@
 #include "avdtp.h"
 #include "avrcp.h"
 #include "audio-msg.h"
-#include "audio-ipc.h"
 
 #define L2CAP_PSM_AVDTP 0x19
 #define SVC_HINT_CAPTURING 0x08
@@ -64,6 +63,7 @@ static guint audio_retry_id = 0;
 static bool audio_retrying = false;
 
 static struct ipc *hal_ipc = NULL;
+static struct ipc *audio_ipc = NULL;
 
 struct a2dp_preset {
 	void *data;
@@ -1298,12 +1298,14 @@ static void bt_audio_open(const void *buf, uint16_t len)
 
 	g_slist_free(presets);
 
-	audio_ipc_send_rsp_full(AUDIO_OP_OPEN, sizeof(rsp), &rsp, -1);
+	ipc_send_rsp_full(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_OPEN,
+							sizeof(rsp), &rsp, -1);
 
 	return;
 
 failed:
-	audio_ipc_send_rsp(AUDIO_OP_OPEN, AUDIO_STATUS_FAILED);
+	ipc_send_rsp(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_OPEN,
+							AUDIO_STATUS_FAILED);
 }
 
 static struct a2dp_endpoint *find_endpoint(uint8_t id)
@@ -1330,14 +1332,16 @@ static void bt_audio_close(const void *buf, uint16_t len)
 	endpoint = find_endpoint(cmd->id);
 	if (!endpoint) {
 		error("Unable to find endpoint %u", cmd->id);
-		audio_ipc_send_rsp(AUDIO_OP_CLOSE, AUDIO_STATUS_FAILED);
+		ipc_send_rsp(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_CLOSE,
+							AUDIO_STATUS_FAILED);
 		return;
 	}
 
 	endpoints = g_slist_remove(endpoints, endpoint);
 	unregister_endpoint(endpoint);
 
-	audio_ipc_send_rsp(AUDIO_OP_CLOSE, AUDIO_STATUS_SUCCESS);
+	ipc_send_rsp(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_CLOSE,
+							AUDIO_STATUS_SUCCESS);
 }
 
 static void bt_stream_open(const void *buf, uint16_t len)
@@ -1353,14 +1357,16 @@ static void bt_stream_open(const void *buf, uint16_t len)
 	setup = find_setup(cmd->id);
 	if (!setup) {
 		error("Unable to find stream for endpoint %u", cmd->id);
-		audio_ipc_send_rsp(AUDIO_OP_OPEN_STREAM, AUDIO_STATUS_FAILED);
+		ipc_send_rsp(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_OPEN_STREAM,
+							AUDIO_STATUS_FAILED);
 		return;
 	}
 
 	if (!avdtp_stream_get_transport(setup->stream, &fd, NULL, &omtu,
 								NULL)) {
 		error("avdtp_stream_get_transport: failed");
-		audio_ipc_send_rsp(AUDIO_OP_OPEN_STREAM, AUDIO_STATUS_FAILED);
+		ipc_send_rsp(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_OPEN_STREAM,
+							AUDIO_STATUS_FAILED);
 		return;
 	}
 
@@ -1371,7 +1377,8 @@ static void bt_stream_open(const void *buf, uint16_t len)
 	rsp->preset->len = setup->preset->len;
 	memcpy(rsp->preset->data, setup->preset->data, setup->preset->len);
 
-	audio_ipc_send_rsp_full(AUDIO_OP_OPEN_STREAM, len, rsp, fd);
+	ipc_send_rsp_full(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_OPEN_STREAM,
+								len, rsp, fd);
 
 	g_free(rsp);
 }
@@ -1396,12 +1403,14 @@ static void bt_stream_close(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	audio_ipc_send_rsp(AUDIO_OP_CLOSE_STREAM, AUDIO_STATUS_SUCCESS);
+	ipc_send_rsp(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_CLOSE_STREAM,
+							AUDIO_STATUS_SUCCESS);
 
 	return;
 
 failed:
-	audio_ipc_send_rsp(AUDIO_OP_CLOSE_STREAM, AUDIO_STATUS_FAILED);
+	ipc_send_rsp(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_CLOSE_STREAM,
+							AUDIO_STATUS_FAILED);
 }
 
 static void bt_stream_resume(const void *buf, uint16_t len)
@@ -1426,12 +1435,14 @@ static void bt_stream_resume(const void *buf, uint16_t len)
 		}
 	}
 
-	audio_ipc_send_rsp(AUDIO_OP_RESUME_STREAM, AUDIO_STATUS_SUCCESS);
+	ipc_send_rsp(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_RESUME_STREAM,
+							AUDIO_STATUS_SUCCESS);
 
 	return;
 
 failed:
-	audio_ipc_send_rsp(AUDIO_OP_RESUME_STREAM, AUDIO_STATUS_FAILED);
+	ipc_send_rsp(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_RESUME_STREAM,
+							AUDIO_STATUS_FAILED);
 }
 
 static void bt_stream_suspend(const void *buf, uint16_t len)
@@ -1454,12 +1465,14 @@ static void bt_stream_suspend(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	audio_ipc_send_rsp(AUDIO_OP_SUSPEND_STREAM, AUDIO_STATUS_SUCCESS);
+	ipc_send_rsp(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_SUSPEND_STREAM,
+							AUDIO_STATUS_SUCCESS);
 
 	return;
 
 failed:
-	audio_ipc_send_rsp(AUDIO_OP_SUSPEND_STREAM, AUDIO_STATUS_FAILED);
+	ipc_send_rsp(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_SUSPEND_STREAM,
+							AUDIO_STATUS_FAILED);
 }
 
 static const struct ipc_handler audio_handlers[] = {
@@ -1490,16 +1503,26 @@ static void bt_audio_unregister(void)
 	g_slist_free_full(setups, setup_free);
 	setups = NULL;
 
-	audio_ipc_cleanup();
+	ipc_cleanup(audio_ipc);
+	audio_ipc = NULL;
 }
 
-static void bt_audio_register(GDestroyNotify destroy)
+static bool bt_audio_register(GDestroyNotify destroy)
 {
 	DBG("");
 
-	audio_ipc_init(destroy);
+	audio_ipc = ipc_init(BLUEZ_AUDIO_SK_PATH, sizeof(BLUEZ_AUDIO_SK_PATH),
+							AUDIO_SERVICE_ID_MAX);
+	if (!audio_ipc)
+		return false;
+
+	ipc_set_fail_handler(audio_ipc, destroy, NULL);
+	ipc_disable_notifications(audio_ipc);
 
-	audio_ipc_register(audio_handlers, G_N_ELEMENTS(audio_handlers));
+	ipc_register(audio_ipc, AUDIO_SERVICE_ID, audio_handlers,
+						G_N_ELEMENTS(audio_handlers));
+
+	return true;
 }
 
 static gboolean audio_retry_register(void *data)
@@ -1581,9 +1604,8 @@ bool bt_a2dp_register(struct ipc *ipc, const bdaddr_t *addr)
 	ipc_register(hal_ipc, HAL_SERVICE_ID_A2DP, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
-	bt_audio_register(audio_disconnected);
-
-	return true;
+	if (bt_audio_register(audio_disconnected))
+		return true;
 
 fail:
 	g_io_channel_shutdown(server, TRUE, NULL);
@@ -1608,8 +1630,6 @@ void bt_a2dp_unregister(void)
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_A2DP);
 	hal_ipc = NULL;
 
-	audio_ipc_unregister();
-
 	bt_adapter_remove_record(record_id);
 	record_id = 0;
 
@@ -1619,5 +1639,9 @@ void bt_a2dp_unregister(void)
 		server = NULL;
 	}
 
-	audio_ipc_cleanup();
+	if (audio_ipc) {
+		ipc_unregister(audio_ipc, AUDIO_SERVICE_ID);
+		ipc_cleanup(audio_ipc);
+		audio_ipc = NULL;
+	}
 }
diff --git a/android/audio-ipc.c b/android/audio-ipc.c
deleted file mode 100644
index ce2d86d..0000000
--- a/android/audio-ipc.c
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
- *
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stddef.h>
-#include <errno.h>
-#include <stdint.h>
-#include <string.h>
-#include <signal.h>
-#include <stdbool.h>
-#include <unistd.h>
-#include <glib.h>
-
-#include "src/log.h"
-#include "ipc.h"
-#include "audio-msg.h"
-#include "audio-ipc.h"
-
-static GIOChannel *audio_io = NULL;
-
-static struct service_handler service;
-
-static gboolean audio_watch_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	GDestroyNotify destroy = user_data;
-	char buf[BLUEZ_AUDIO_MTU];
-	ssize_t ret;
-	int fd, err;
-
-	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		info("Audio IPC: command socket closed");
-		goto fail;
-	}
-
-	fd = g_io_channel_unix_get_fd(io);
-
-	ret = read(fd, buf, sizeof(buf));
-	if (ret < 0) {
-		error("Audio IPC: command read failed (%s)", strerror(errno));
-		goto fail;
-	}
-
-	err = ipc_handle_msg(&service, AUDIO_SERVICE_ID, buf, ret);
-	if (err < 0) {
-		error("Audio IPC: failed to handle message (%s)",
-							strerror(-err));
-		goto fail;
-	}
-
-	return TRUE;
-
-fail:
-	audio_ipc_cleanup();
-	if (destroy)
-		destroy(NULL);
-	return FALSE;
-}
-
-static gboolean audio_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	GDestroyNotify destroy = user_data;
-
-	DBG("");
-
-	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		error("Audio IPC: socket connect failed");
-		audio_ipc_cleanup();
-		if (destroy)
-			destroy(NULL);
-		return FALSE;
-	}
-
-	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-
-	g_io_add_watch(audio_io, cond, audio_watch_cb, user_data);
-
-	info("Audio IPC: successfully connected");
-
-	return FALSE;
-}
-
-void audio_ipc_init(GDestroyNotify destroy)
-{
-	audio_io = ipc_connect(BLUEZ_AUDIO_SK_PATH, sizeof(BLUEZ_AUDIO_SK_PATH),
-						audio_connect_cb, destroy);
-}
-
-void audio_ipc_cleanup(void)
-{
-	if (audio_io) {
-		g_io_channel_shutdown(audio_io, TRUE, NULL);
-		g_io_channel_unref(audio_io);
-		audio_io = NULL;
-	}
-}
-
-void audio_ipc_register(const struct ipc_handler *handlers, uint8_t size)
-{
-	service.handler = handlers;
-	service.size = size;
-}
-
-void audio_ipc_unregister(void)
-{
-	service.handler = NULL;
-	service.size = 0;
-}
-
-void audio_ipc_send_rsp(uint8_t opcode, uint8_t status)
-{
-	struct audio_status s;
-	int sk;
-
-	sk = g_io_channel_unix_get_fd(audio_io);
-
-	if (status == AUDIO_STATUS_SUCCESS) {
-		ipc_send(sk, AUDIO_SERVICE_ID, opcode, 0, NULL, -1);
-		return;
-	}
-
-	s.code = status;
-
-	ipc_send(sk, AUDIO_SERVICE_ID, AUDIO_OP_STATUS, sizeof(s), &s, -1);
-}
-
-void audio_ipc_send_rsp_full(uint8_t opcode, uint16_t len, void *param, int fd)
-{
-	ipc_send(g_io_channel_unix_get_fd(audio_io), AUDIO_SERVICE_ID, opcode,
-							len, param, fd);
-}
diff --git a/android/audio-ipc.h b/android/audio-ipc.h
deleted file mode 100644
index 83207c8..0000000
--- a/android/audio-ipc.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
- *
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-void audio_ipc_init(GDestroyNotify destroy);
-void audio_ipc_cleanup(void);
-
-void audio_ipc_register(const struct ipc_handler *handlers, uint8_t size);
-void audio_ipc_unregister(void);
-
-void audio_ipc_send_rsp(uint8_t opcode, uint8_t status);
-void audio_ipc_send_rsp_full(uint8_t opcode, uint16_t len, void *param, int fd);
diff --git a/android/audio-msg.h b/android/audio-msg.h
index 17cde09..d4fc68a 100644
--- a/android/audio-msg.h
+++ b/android/audio-msg.h
@@ -26,6 +26,7 @@
 static const char BLUEZ_AUDIO_SK_PATH[] = "\0bluez_audio_socket";
 
 #define AUDIO_SERVICE_ID		0
+#define AUDIO_SERVICE_ID_MAX		AUDIO_SERVICE_ID
 
 #define AUDIO_STATUS_SUCCESS		0x00
 #define AUDIO_STATUS_FAILED		0x01
-- 
1.8.3.2

