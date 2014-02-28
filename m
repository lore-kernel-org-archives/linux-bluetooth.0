Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 1/6] shared/hfp: Add prefix handlers functionality
Date: Fri, 28 Feb 2014 10:22:33 +0100
Message-Id: <1393579358-11514-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add two functions: hfp_gw_register_prefix_handler() and
hfp_gw_unregister_prefix_handler(). It will allow user to register for
specific command. Current implementation just adds or removes data
from hfp_gw structure.
---
 Makefile.tools   |  1 +
 src/shared/hfp.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp.h | 18 ++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/Makefile.tools b/Makefile.tools
index 9f7ba9f..31e1093 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -63,6 +63,7 @@ emulator_hfp_SOURCES = emulator/hfp.c \
 				monitor/mainloop.h monitor/mainloop.c \
 				src/shared/io.h src/shared/io-mainloop.c \
 				src/shared/util.h src/shared/util.c \
+				src/shared/queue.h src/shared/queue.c \
 				src/shared/ringbuf.h src/shared/ringbuf.c \
 				src/shared/hfp.h src/shared/hfp.c
 
diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 854cf46..12d0754 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -32,6 +32,7 @@
 
 #include "src/shared/util.h"
 #include "src/shared/ringbuf.h"
+#include "src/shared/queue.h"
 #include "src/shared/io.h"
 #include "src/shared/hfp.h"
 
@@ -42,6 +43,7 @@ struct hfp_gw {
 	struct io *io;
 	struct ringbuf *read_buf;
 	struct ringbuf *write_buf;
+	struct queue *prefix_handlers;
 	bool writer_active;
 	bool permissive_syntax;
 	bool result_pending;
@@ -60,6 +62,37 @@ struct hfp_gw {
 	bool destroyed;
 };
 
+struct prefix_handler_data {
+	char *prefix;
+	void *user_data;
+	hfp_destroy_func_t destroy;
+	hfp_result_func_t callback;
+};
+
+static void destroy_prefix_handler_data(void *data)
+{
+	struct prefix_handler_data *handler = data;
+
+	if (handler->destroy)
+		handler->destroy(handler->user_data);
+
+	free(handler);
+}
+
+static bool match_handler_prefix(const void *a, const void *b)
+{
+	const struct prefix_handler_data *handler = a;
+	const char *prefix = b;
+
+	if (strlen(handler->prefix) != strlen(prefix))
+		return false;
+
+	if (memcmp(handler->prefix, prefix, strlen(prefix)))
+		return false;
+
+	return true;
+}
+
 static void write_watch_destroy(void *user_data)
 {
 	struct hfp_gw *hfp = user_data;
@@ -196,8 +229,19 @@ struct hfp_gw *hfp_gw_new(int fd)
 		return NULL;
 	}
 
+	hfp->prefix_handlers = queue_new();
+	if (!hfp->prefix_handlers) {
+		io_destroy(hfp->io);
+		ringbuf_free(hfp->write_buf);
+		ringbuf_free(hfp->read_buf);
+		free(hfp);
+		return NULL;
+	}
+
 	if (!io_set_read_handler(hfp->io, can_read_data,
 					hfp, read_watch_destroy)) {
+		queue_destroy(hfp->prefix_handlers,
+						destroy_prefix_handler_data);
 		io_destroy(hfp->io);
 		ringbuf_free(hfp->write_buf);
 		ringbuf_free(hfp->read_buf);
@@ -250,6 +294,9 @@ void hfp_gw_unref(struct hfp_gw *hfp)
 	ringbuf_free(hfp->write_buf);
 	hfp->write_buf = NULL;
 
+	queue_destroy(hfp->prefix_handlers, destroy_prefix_handler_data);
+	hfp->prefix_handlers = NULL;
+
 	if (!hfp->in_disconnect) {
 		free(hfp);
 		return;
@@ -405,6 +452,44 @@ bool hfp_gw_set_command_handler(struct hfp_gw *hfp,
 	return true;
 }
 
+bool hfp_gw_register_prefix_handler(struct hfp_gw *hfp,
+						hfp_result_func_t callback,
+						char *prefix, void *user_data,
+						hfp_destroy_func_t destroy)
+{
+	struct prefix_handler_data *handler;
+
+	handler = queue_find(hfp->prefix_handlers, match_handler_prefix,
+									prefix);
+	if (handler)
+		return false;
+
+	handler = new0(struct prefix_handler_data, 1);
+	if (!handler)
+		return false;
+
+	handler->callback = callback;
+	handler->prefix = prefix;
+	handler->destroy = destroy;
+	handler->user_data = user_data;
+
+	return queue_push_tail(hfp->prefix_handlers, handler);
+}
+
+bool hfp_gw_unregister_prefix_handler(struct hfp_gw *hfp, char *prefix)
+{
+	struct prefix_handler_data *handler;
+
+	handler = queue_remove_if(hfp->prefix_handlers, match_handler_prefix,
+									prefix);
+	if (!handler)
+		return false;
+
+	destroy_prefix_handler_data(handler);
+
+	return true;
+}
+
 static void disconnect_watch_destroy(void *user_data)
 {
 	struct hfp_gw *hfp = user_data;
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index b0bd934..4dc293f 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -60,6 +60,18 @@ enum hfp_error {
 	HFP_ERROR_NETWORK_NOT_ALLOWED		= 32,
 };
 
+enum hfp_cmd_type {
+	HFP_AT_READ,
+	HFP_AT_SET,
+	HFP_AT_TEST,
+	HFP_AT_COMMAND
+};
+
+struct hfp_gw_result;
+
+typedef void (*hfp_result_func_t)(struct hfp_gw_result *result,
+				enum hfp_cmd_type type, void *user_data);
+
 typedef void (*hfp_destroy_func_t)(void *user_data);
 typedef void (*hfp_debug_func_t)(const char *str, void *user_data);
 
@@ -94,3 +106,9 @@ bool hfp_gw_set_disconnect_handler(struct hfp_gw *hfp,
 					hfp_destroy_func_t destroy);
 
 bool hfp_gw_disconnect(struct hfp_gw *hfp);
+
+bool hfp_gw_register_prefix_handler(struct hfp_gw *hfp,
+						hfp_result_func_t callback,
+						char *prefix, void *user_data,
+						hfp_destroy_func_t destroy);
+bool hfp_gw_unregister_prefix_handler(struct hfp_gw *hfp, char *prefix);
-- 
1.8.5.3

