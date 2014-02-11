Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/6] shared: Add support for disconnect handler in HFP
Date: Tue, 11 Feb 2014 17:49:03 +0100
Message-Id: <1392137346-26272-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com>
References: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is no longer possible to send any data after disconnection.
Extra reference is taken for disconnect watch to allow users to drop
own reference in disconnect callback.
---
 src/shared/hfp.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/shared/hfp.h |  6 ++++++
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 43e88a6..3944e97 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -51,6 +51,9 @@ struct hfp_gw {
 	hfp_debug_func_t debug_callback;
 	hfp_destroy_func_t debug_destroy;
 	void *debug_data;
+	hfp_disconnect_func_t disconnect_callback;
+	hfp_destroy_func_t disconnect_destroy;
+	void *disconnect_data;
 };
 
 static void write_watch_destroy(void *user_data)
@@ -227,6 +230,7 @@ void hfp_gw_unref(struct hfp_gw *hfp)
 
 	io_set_write_handler(hfp->io, NULL, NULL, NULL);
 	io_set_read_handler(hfp->io, NULL, NULL, NULL);
+	io_set_disconnect_handler(hfp->io, NULL, NULL, NULL);
 
 	io_destroy(hfp->io);
 	hfp->io = NULL;
@@ -307,7 +311,7 @@ bool hfp_gw_send_result(struct hfp_gw *hfp, enum hfp_result result)
 {
 	const char *str;
 
-	if (!hfp)
+	if (!hfp || !hfp->io)
 		return false;
 
 	switch (result) {
@@ -333,7 +337,7 @@ bool hfp_gw_send_result(struct hfp_gw *hfp, enum hfp_result result)
 
 bool hfp_gw_send_error(struct hfp_gw *hfp, enum hfp_error error)
 {
-	if (!hfp)
+	if (!hfp || !hfp->io)
 		return false;
 
 	if (ringbuf_printf(hfp->write_buf, "\r\n+CME ERROR: %u\r\n", error) < 0)
@@ -352,7 +356,7 @@ bool hfp_gw_send_info(struct hfp_gw *hfp, const char *format, ...)
 	char *fmt;
 	int len;
 
-	if (!hfp || !format)
+	if (!hfp || !hfp->io || !format)
 		return false;
 
 	if (asprintf(&fmt, "\r\n%s\r\n", format) < 0)
@@ -391,3 +395,53 @@ bool hfp_gw_set_command_handler(struct hfp_gw *hfp,
 
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
+	hfp_gw_unref(hfp);
+}
+
+static bool io_disconnected(struct io *io, void *user_data)
+{
+	struct hfp_gw *hfp = user_data;
+
+	io_destroy(hfp->io);
+	hfp->io = NULL;
+
+	if (hfp->disconnect_callback)
+		hfp->disconnect_callback(hfp->disconnect_data);
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
+	if (!io_set_disconnect_handler(hfp->io, io_disconnected,
+						hfp_gw_ref(hfp),
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
index 2eca6d8..75ec484 100644
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
1.8.5.3

