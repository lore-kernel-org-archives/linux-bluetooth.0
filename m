Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 04/11] shared/hfp: Add register/unregister event for HFP HF
Date: Fri, 24 Oct 2014 13:59:28 +0200
Message-Id: <1414151975-20588-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1414151975-20588-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1414151975-20588-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp.h |   9 +++++
 2 files changed, 109 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index b7855ed..84c0db1 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -70,6 +70,8 @@ struct hfp_hf {
 	struct ringbuf *read_buf;
 	struct ringbuf *write_buf;
 
+	struct queue *event_handlers;
+
 	hfp_debug_func_t debug_callback;
 	hfp_destroy_func_t debug_destroy;
 	void *debug_data;
@@ -94,6 +96,18 @@ struct hfp_gw_result {
 	unsigned int offset;
 };
 
+struct hfp_hf_result {
+	const char *data;
+	unsigned int offset;
+};
+
+struct event_handler {
+	char *prefix;
+	void *user_data;
+	hfp_destroy_func_t destroy;
+	hfp_hf_result_func_t callback;
+};
+
 static void destroy_cmd_handler(void *data)
 {
 	struct cmd_handler *handler = data;
@@ -828,6 +842,29 @@ bool hfp_gw_disconnect(struct hfp_gw *hfp)
 	return io_shutdown(hfp->io);
 }
 
+static bool match_handler_event_prefix(const void *a, const void *b)
+{
+	const struct event_handler *handler = a;
+	const char *prefix = b;
+
+	if (memcmp(handler->prefix, prefix, strlen(prefix)))
+		return false;
+
+	return true;
+}
+
+static void destroy_event_handler(void *data)
+{
+	struct event_handler *handler = data;
+
+	if (handler->destroy)
+		handler->destroy(handler->user_data);
+
+	free(handler->prefix);
+
+	free(handler);
+}
+
 struct hfp_hf *hfp_hf_new(int fd)
 {
 	struct hfp_hf *hfp;
@@ -863,6 +900,15 @@ struct hfp_hf *hfp_hf_new(int fd)
 		return NULL;
 	}
 
+	hfp->event_handlers = queue_new();
+	if (!hfp->event_handlers) {
+		io_destroy(hfp->io);
+		ringbuf_free(hfp->write_buf);
+		ringbuf_free(hfp->read_buf);
+		free(hfp);
+		return NULL;
+	}
+
 	return hfp_hf_ref(hfp);
 }
 
@@ -902,6 +948,9 @@ void hfp_hf_unref(struct hfp_hf *hfp)
 	ringbuf_free(hfp->write_buf);
 	hfp->write_buf = NULL;
 
+	queue_destroy(hfp->event_handlers, destroy_event_handler);
+	hfp->event_handlers = NULL;
+
 	if (!hfp->in_disconnect) {
 		free(hfp);
 		return;
@@ -961,6 +1010,57 @@ bool hfp_hf_set_close_on_unref(struct hfp_hf *hfp, bool do_close)
 	return true;
 }
 
+bool hfp_hf_register(struct hfp_hf *hfp, hfp_hf_result_func_t callback,
+						const char *prefix,
+						void *user_data,
+						hfp_destroy_func_t destroy)
+{
+	struct event_handler *handler;
+
+	if (!callback)
+		return false;
+
+	handler = new0(struct event_handler, 1);
+	if (!handler)
+		return false;
+
+	handler->callback = callback;
+	handler->user_data = user_data;
+
+	handler->prefix = strdup(prefix);
+	if (!handler->prefix) {
+		free(handler);
+		return false;
+	}
+
+	if (queue_find(hfp->event_handlers, match_handler_event_prefix,
+							handler->prefix)) {
+		destroy_event_handler(handler);
+		return false;
+	}
+
+	handler->destroy = destroy;
+
+	return queue_push_tail(hfp->event_handlers, handler);
+}
+
+bool hfp_hf_unregister(struct hfp_hf *hfp, const char *prefix)
+{
+	struct cmd_handler *handler;
+
+	/* Cast to void as queue_remove needs that */
+	handler = queue_remove_if(hfp->event_handlers,
+						match_handler_event_prefix,
+						(void *) prefix);
+
+	if (!handler)
+		return false;
+
+	destroy_event_handler(handler);
+
+	return true;
+}
+
 static void hf_disconnect_watch_destroy(void *user_data)
 {
 	struct hfp_hf *hfp = user_data;
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index d98d14b..3860e25 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -125,6 +125,11 @@ bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
 								uint8_t len);
 bool hfp_gw_result_has_next(struct hfp_gw_result *result);
 
+struct hfp_hf_result;
+
+typedef void (*hfp_hf_result_func_t)(struct hfp_hf_result *result,
+							void *user_data);
+
 struct hfp_hf;
 
 struct hfp_hf *hfp_hf_new(int fd);
@@ -139,3 +144,7 @@ bool hfp_hf_set_disconnect_handler(struct hfp_hf *hfp,
 					void *user_data,
 					hfp_destroy_func_t destroy);
 bool hfp_hf_disconnect(struct hfp_hf *hfp);
+bool hfp_hf_register(struct hfp_hf *hfp, hfp_hf_result_func_t callback,
+					const char *prefix, void *user_data,
+					hfp_destroy_func_t destroy);
+bool hfp_hf_unregister(struct hfp_hf *hfp, const char *prefix);
-- 
1.8.4

