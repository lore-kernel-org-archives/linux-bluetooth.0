Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] android/A2DP: Add retry logic to Audio IPC
Date: Tue, 21 Jan 2014 16:00:58 +0200
Message-Id: <1390312859-27349-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case the audio HAL disconnects without cleaning up its endpoints treat
it as unclean disconnection and attempt to reconnect.
---
 android/a2dp.c      | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 android/audio-ipc.c | 13 +++++++---
 android/audio-ipc.h |  2 +-
 android/ipc.c       |  9 +++----
 android/ipc.h       |  3 ++-
 5 files changed, 83 insertions(+), 12 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 5569691..a996f79 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -51,6 +51,7 @@
 #define L2CAP_PSM_AVDTP 0x19
 #define SVC_HINT_CAPTURING 0x08
 #define IDLE_TIMEOUT 1
+#define AUDIO_RETRY_TIMEOUT 2
 
 static GIOChannel *server = NULL;
 static GSList *devices = NULL;
@@ -58,6 +59,8 @@ static GSList *endpoints = NULL;
 static GSList *setups = NULL;
 static bdaddr_t adapter_addr;
 static uint32_t record_id = 0;
+static guint audio_retry_id = 0;
+static bool audio_retrying = false;
 
 struct a2dp_preset {
 	void *data;
@@ -1232,6 +1235,8 @@ static void bt_audio_open(const void *buf, uint16_t len)
 
 	DBG("");
 
+	audio_retrying = false;
+
 	if (cmd->presets == 0) {
 		error("No audio presets found");
 		goto failed;
@@ -1424,6 +1429,65 @@ static const struct ipc_handler audio_handlers[] = {
 	{ bt_stream_suspend, false, sizeof(struct audio_cmd_suspend_stream) },
 };
 
+static void bt_audio_unregister(void)
+{
+	DBG("");
+
+	if (audio_retry_id > 0)
+		g_source_remove(audio_retry_id);
+
+	g_slist_free_full(setups, setup_free);
+	setups = NULL;
+
+	g_slist_free_full(endpoints, unregister_endpoint);
+	endpoints = NULL;
+
+	audio_ipc_cleanup();
+}
+
+static void bt_audio_register(GDestroyNotify destroy)
+{
+	DBG("");
+
+	audio_ipc_init(destroy);
+
+	audio_ipc_register(audio_handlers, G_N_ELEMENTS(audio_handlers));
+}
+
+static gboolean audio_retry_register(void *data)
+{
+	GDestroyNotify destroy = data;
+
+	audio_retry_id = 0;
+	audio_retrying = true;
+
+	bt_audio_register(destroy);
+
+	return FALSE;
+}
+
+static void audio_disconnected(void *data)
+{
+	bool restart;
+
+	DBG("");
+
+	if (audio_retrying)
+		goto retry;
+
+	restart = endpoints != NULL ? true : false;
+
+	bt_audio_unregister();
+
+	if (!restart)
+		return;
+
+retry:
+	audio_retry_id = g_timeout_add_seconds(AUDIO_RETRY_TIMEOUT,
+						audio_retry_register,
+						audio_disconnected);
+}
+
 bool bt_a2dp_register(const bdaddr_t *addr)
 {
 	GError *err = NULL;
@@ -1431,8 +1495,6 @@ bool bt_a2dp_register(const bdaddr_t *addr)
 
 	DBG("");
 
-	audio_ipc_init();
-
 	bacpy(&adapter_addr, addr);
 
 	server = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
@@ -1462,7 +1524,7 @@ bool bt_a2dp_register(const bdaddr_t *addr)
 	ipc_register(HAL_SERVICE_ID_A2DP, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
-	audio_ipc_register(audio_handlers, G_N_ELEMENTS(audio_handlers));
+	bt_audio_register(audio_disconnected);
 
 	return true;
 
diff --git a/android/audio-ipc.c b/android/audio-ipc.c
index f4b55e3..ee444cf 100644
--- a/android/audio-ipc.c
+++ b/android/audio-ipc.c
@@ -46,6 +46,7 @@ static struct service_handler service;
 static gboolean audio_watch_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
+	GDestroyNotify destroy = user_data;
 	char buf[BLUEZ_AUDIO_MTU];
 	ssize_t ret;
 	int fd, err;
@@ -74,33 +75,39 @@ static gboolean audio_watch_cb(GIOChannel *io, GIOCondition cond,
 
 fail:
 	audio_ipc_cleanup();
+	if (destroy)
+		destroy(NULL);
 	return FALSE;
 }
 
 static gboolean audio_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
+	GDestroyNotify destroy = user_data;
+
 	DBG("");
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		error("Audio IPC: socket connect failed");
 		audio_ipc_cleanup();
+		if (destroy)
+			destroy(NULL);
 		return FALSE;
 	}
 
 	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-	g_io_add_watch(audio_io, cond, audio_watch_cb, NULL);
+	g_io_add_watch(audio_io, cond, audio_watch_cb, user_data);
 
 	info("Audio IPC: successfully connected");
 
 	return FALSE;
 }
 
-void audio_ipc_init(void)
+void audio_ipc_init(GDestroyNotify destroy)
 {
 	audio_io = ipc_connect(BLUEZ_AUDIO_SK_PATH, sizeof(BLUEZ_AUDIO_SK_PATH),
-							audio_connect_cb);
+						audio_connect_cb, destroy);
 }
 
 void audio_ipc_cleanup(void)
diff --git a/android/audio-ipc.h b/android/audio-ipc.h
index 0b5f216..ddff01e 100644
--- a/android/audio-ipc.h
+++ b/android/audio-ipc.h
@@ -21,7 +21,7 @@
  *
  */
 
-void audio_ipc_init(void);
+void audio_ipc_init(GDestroyNotify destroy);
 void audio_ipc_cleanup(void);
 
 void audio_ipc_register(const struct ipc_handler *handlers, uint8_t size);
diff --git a/android/ipc.c b/android/ipc.c
index ed3ef3c..8098409 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -141,7 +141,8 @@ static gboolean notif_watch_cb(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
-GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb)
+GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb,
+							void *user_data)
 {
 	struct sockaddr_un addr;
 	GIOCondition cond;
@@ -174,7 +175,7 @@ GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb)
 
 	cond = G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-	g_io_add_watch(io, cond, connect_cb, NULL);
+	g_io_add_watch(io, cond, connect_cb, user_data);
 
 	return io;
 }
@@ -215,7 +216,7 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 	}
 
 	notif_io = ipc_connect(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-							notif_connect_cb);
+						notif_connect_cb, NULL);
 	if (!notif_io)
 		raise(SIGTERM);
 
@@ -225,7 +226,7 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 void ipc_init(void)
 {
 	cmd_io = ipc_connect(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-							cmd_connect_cb);
+						cmd_connect_cb, NULL);
 	if (!cmd_io)
 		raise(SIGTERM);
 }
diff --git a/android/ipc.h b/android/ipc.h
index b1cc5c5..0ba9c67 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -34,7 +34,8 @@ struct service_handler {
 
 void ipc_init(void);
 void ipc_cleanup(void);
-GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb);
+GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb,
+							void *user_data);
 int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 						const void *buf, ssize_t len);
 
-- 
1.8.4.2

