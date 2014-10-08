Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 04/11] shared/hfp: Add register/unregister event for HFP HF
Date: Wed,  8 Oct 2014 12:15:24 +0200
Message-Id: <1412763331-30989-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412763331-30989-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412763331-30989-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds API which allows to register/unregister for unsolicited
responses.
---
 src/shared/hfp.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp.h |   8 +++++
 2 files changed, 116 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index b7855ed..b1cf08e 100644
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
@@ -828,6 +842,32 @@ bool hfp_gw_disconnect(struct hfp_gw *hfp)
 	return io_shutdown(hfp->io);
 }
 
+static bool match_handler_event_prefix(const void *a, const void *b)
+{
+	const struct event_handler *handler = a;
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
@@ -863,6 +903,15 @@ struct hfp_hf *hfp_hf_new(int fd)
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
 
@@ -902,6 +951,9 @@ void hfp_hf_unref(struct hfp_hf *hfp)
 	ringbuf_free(hfp->write_buf);
 	hfp->write_buf = NULL;
 
+	queue_destroy(hfp->event_handlers, destroy_event_handler);
+	hfp->event_handlers = NULL;
+
 	if (!hfp->in_disconnect) {
 		free(hfp);
 		return;
@@ -961,6 +1013,62 @@ bool hfp_hf_set_close_on_unref(struct hfp_hf *hfp, bool do_close)
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
+	char *lookup_prefix;
+
+	lookup_prefix = strdup(prefix);
+	if (!lookup_prefix)
+		return false;
+
+	handler = queue_remove_if(hfp->event_handlers,
+						match_handler_event_prefix,
+						lookup_prefix);
+	free(lookup_prefix);
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
index a9a169b..85037b1 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -68,10 +68,14 @@ enum hfp_gw_cmd_type {
 };
 
 struct hfp_gw_result;
+struct hfp_hf_result;
 
 typedef void (*hfp_result_func_t)(struct hfp_gw_result *result,
 				enum hfp_gw_cmd_type type, void *user_data);
 
+typedef void (*hfp_hf_result_func_t)(struct hfp_hf_result *result,
+							void *user_data);
+
 typedef void (*hfp_destroy_func_t)(void *user_data);
 typedef void (*hfp_debug_func_t)(const char *str, void *user_data);
 
@@ -138,3 +142,7 @@ bool hfp_hf_set_disconnect_handler(struct hfp_hf *hfp,
 					void *user_data,
 					hfp_destroy_func_t destroy);
 bool hfp_hf_disconnect(struct hfp_hf *hfp);
+bool hfp_hf_register(struct hfp_hf *hfp, hfp_hf_result_func_t callback,
+					const char *prefix, void *user_data,
+					hfp_destroy_func_t destroy);
+bool hfp_hf_unregister(struct hfp_hf *hfp, const char *prefix);
-- 
1.8.4

