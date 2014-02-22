Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 4/7] shared: Add support for disconnect handler in HFP
Date: Sat, 22 Feb 2014 22:09:22 +0100
Message-Id: <1393103365-19908-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1393103365-19908-1-git-send-email-szymon.janc@gmail.com>
References: <1393103365-19908-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

---
 src/shared/hfp.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/hfp.h |  6 ++++++
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 09fbe3e..98408ca 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -51,6 +51,13 @@ struct hfp_gw {
 	hfp_debug_func_t debug_callback;
 	hfp_destroy_func_t debug_destroy;
 	void *debug_data;
+
+	hfp_disconnect_func_t disconnect_callback;
+	hfp_destroy_func_t disconnect_destroy;
+	void *disconnect_data;
+
+	bool in_disconnect;
+	bool destroyed;
 };
 
 static void write_watch_destroy(void *user_data)
@@ -227,6 +234,7 @@ void hfp_gw_unref(struct hfp_gw *hfp)
 
 	io_set_write_handler(hfp->io, NULL, NULL, NULL);
 	io_set_read_handler(hfp->io, NULL, NULL, NULL);
+	io_set_disconnect_handler(hfp->io, NULL, NULL, NULL);
 
 	io_destroy(hfp->io);
 	hfp->io = NULL;
@@ -242,7 +250,12 @@ void hfp_gw_unref(struct hfp_gw *hfp)
 	ringbuf_free(hfp->write_buf);
 	hfp->write_buf = NULL;
 
-	free(hfp);
+	if (!hfp->in_disconnect) {
+		free(hfp);
+		return;
+	}
+
+	hfp->destroyed = true;
 }
 
 static void read_tracing(const void *buf, size_t count, void *user_data)
@@ -391,3 +404,54 @@ bool hfp_gw_set_command_handler(struct hfp_gw *hfp,
 
 	return true;
 }
+
+static void disconnect_watch_destroy(void *user_data)
+{
+	struct hfp_gw *hfp = user_data;
+
+	if (hfp->disconnect_destroy)
+		hfp->disconnect_destroy(hfp->disconnect_data);
+
+	if (hfp->destroyed)
+		free(hfp);
+}
+
+static bool io_disconnected(struct io *io, void *user_data)
+{
+	struct hfp_gw *hfp = user_data;
+
+	hfp->in_disconnect = true;
+
+	if (hfp->disconnect_callback)
+		hfp->disconnect_callback(hfp->disconnect_data);
+
+	hfp->in_disconnect = false;
+
+	return false;
+}
+
+bool hfp_gw_set_disconnect_handler(struct hfp_gw *hfp,
+					hfp_disconnect_func_t callback,
+					void *user_data,
+					hfp_destroy_func_t destroy)
+{
+	if (!hfp)
+		return false;
+
+	if (hfp->disconnect_destroy)
+		hfp->disconnect_destroy(hfp->disconnect_data);
+
+	if (!io_set_disconnect_handler(hfp->io, io_disconnected, hfp,
+						disconnect_watch_destroy)) {
+		hfp->disconnect_callback = NULL;
+		hfp->disconnect_destroy = NULL;
+		hfp->disconnect_data = NULL;
+		return false;
+	}
+
+	hfp->disconnect_callback = callback;
+	hfp->disconnect_destroy = destroy;
+	hfp->disconnect_data = user_data;
+
+	return true;
+}
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 836b166..6bb51bc 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -64,6 +64,7 @@ typedef void (*hfp_destroy_func_t)(void *user_data);
 typedef void (*hfp_debug_func_t)(const char *str, void *user_data);
 
 typedef void (*hfp_command_func_t)(const char *command, void *user_data);
+typedef void (*hfp_disconnect_func_t)(void *user_data);
 
 struct hfp_gw;
 
@@ -86,3 +87,8 @@ bool hfp_gw_send_info(struct hfp_gw *hfp, const char *format, ...)
 bool hfp_gw_set_command_handler(struct hfp_gw *hfp,
 				hfp_command_func_t callback,
 				void *user_data, hfp_destroy_func_t destroy);
+
+bool hfp_gw_set_disconnect_handler(struct hfp_gw *hfp,
+					hfp_disconnect_func_t callback,
+					void *user_data,
+					hfp_destroy_func_t destroy);
-- 
1.9.0

