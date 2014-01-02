Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 01/10] android/ipc: Add initial code for audio IPC
Date: Thu,  2 Jan 2014 13:58:25 +0200
Message-Id: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add initial code for listen and accept connections on the abstract
socket defined for the audio IPC.
---
v2: Split audio IPC services for HAL services and fix invalid messages or
disconnections causing the daemon to exit. The audio HAL is independent of
bluetooth and should only affect A2DP service.

 android/hal-msg.h |  1 +
 android/ipc.c     | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 android/ipc.h     |  3 +++
 3 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index c351501..b14eced 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -24,6 +24,7 @@
 #define BLUEZ_HAL_MTU 1024
 
 static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
+static const char BLUEZ_AUDIO_SK_PATH[] = "\0bluez_audio_socket";
 
 struct hal_hdr {
 	uint8_t  service_id;
diff --git a/android/ipc.c b/android/ipc.c
index 9e8ccc3..4c5a77e 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -49,6 +49,7 @@ static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
 
 static GIOChannel *cmd_io = NULL;
 static GIOChannel *notif_io = NULL;
+static GIOChannel *audio_io = NULL;
 
 static void ipc_handle_msg(const void *buf, ssize_t len)
 {
@@ -145,7 +146,8 @@ static gboolean notif_watch_cb(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
-static GIOChannel *connect_hal(GIOFunc connect_cb)
+static GIOChannel *ipc_connect(const char *path, size_t size,
+							GIOFunc connect_cb)
 {
 	struct sockaddr_un addr;
 	GIOCondition cond;
@@ -167,11 +169,11 @@ static GIOChannel *connect_hal(GIOFunc connect_cb)
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
@@ -218,7 +220,8 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	notif_io = connect_hal(notif_connect_cb);
+	notif_io = ipc_connect(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
+							notif_connect_cb);
 	if (!notif_io)
 		raise(SIGTERM);
 
@@ -227,7 +230,8 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 
 void ipc_init(void)
 {
-	cmd_io = connect_hal(cmd_connect_cb);
+	cmd_io = ipc_connect(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
+							cmd_connect_cb);
 	if (!cmd_io)
 		raise(SIGTERM);
 }
@@ -338,3 +342,65 @@ void ipc_unregister(uint8_t service)
 	services[service].handler = NULL;
 	services[service].size = 0;
 }
+
+static gboolean audio_watch_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	char buf[BLUEZ_HAL_MTU];
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
diff --git a/android/ipc.h b/android/ipc.h
index 6cd102b..8e92811 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -37,3 +37,6 @@ void ipc_send_notif(uint8_t service_id, uint8_t opcode,  uint16_t len,
 void ipc_register(uint8_t service, const struct ipc_handler *handlers,
 								uint8_t size);
 void ipc_unregister(uint8_t service);
+
+void audio_ipc_init(void);
+void audio_ipc_cleanup(void);
-- 
1.8.4.2

