Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 06/11] shared/hfp: Add send AT command API for HFP HF
Date: Fri, 10 Oct 2014 01:50:06 +0200
Message-Id: <1412898611-12199-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412898611-12199-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412898611-12199-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling send and response of AT command.
Note that we always wait for AT command response before sending next
command, however user can fill hfp_hf with more than one command.
All the commands are queued and send one by one.
---
 src/shared/hfp.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp.h |   8 +++
 2 files changed, 183 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 5179092..8bebe97 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -70,6 +70,9 @@ struct hfp_hf {
 	struct ringbuf *read_buf;
 	struct ringbuf *write_buf;
 
+	bool writer_active;
+	struct queue *cmd_queue;
+
 	struct queue *event_handlers;
 
 	hfp_debug_func_t debug_callback;
@@ -101,6 +104,14 @@ struct hfp_hf_result {
 	unsigned int offset;
 };
 
+struct cmd_response {
+	char *prefix;
+	hfp_response_func_t resp_cb;
+	struct hfp_hf_result *response;
+	char *resp_data;
+	void *user_data;
+};
+
 struct event_handler {
 	char *prefix;
 	void *user_data;
@@ -868,17 +879,103 @@ static void destroy_event_handler(void *data)
 	free(handler);
 }
 
+static bool hf_can_write_data(struct io *io, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	ssize_t bytes_written;
+
+	bytes_written = ringbuf_write(hfp->write_buf, hfp->fd);
+	if (bytes_written < 0)
+		return false;
+
+	if (ringbuf_len(hfp->write_buf) > 0)
+		return true;
+
+	return false;
+}
+
+static void hf_write_watch_destroy(void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	hfp->writer_active = false;
+}
+
 static void hf_skip_whitespace(struct hfp_hf_result *result)
 {
 	while (result->data[result->offset] == ' ')
 		result->offset++;
 }
 
+static bool is_response(const char *prefix, enum hfp_result *result)
+{
+	if (strcmp(prefix, "OK") == 0) {
+		*result = HFP_RESULT_OK;
+		return true;
+	}
+
+	if (strcmp(prefix, "ERROR") == 0) {
+		*result = HFP_RESULT_ERROR;
+		return true;
+	}
+
+	if (strcmp(prefix, "NO CARRIER") == 0) {
+		*result = HFP_RESULT_NO_CARRIER;
+		return true;
+	}
+
+	if (strcmp(prefix, "CONNECT") == 0) {
+		*result = HFP_RESULT_CONNECT;
+		return true;
+	}
+
+	if (strcmp(prefix, "NO ANSWER") == 0) {
+		*result = HFP_RESULT_NO_ANSWER;
+		return true;
+	}
+
+	if (strcmp(prefix, "DELAYED") == 0) {
+		*result = HFP_RESULT_DELAYED;
+		return true;
+	}
+
+	if (strcmp(prefix, "BLACKLISTED") == 0) {
+		*result = HFP_RESULT_BLACKLISTED;
+		return true;
+	}
+
+	return false;
+}
+
+static void hf_wakeup_writer(struct hfp_hf *hfp)
+{
+	if (hfp->writer_active)
+		return;
+
+	if (!ringbuf_len(hfp->write_buf))
+		return;
+
+	if (!io_set_write_handler(hfp->io, hf_can_write_data,
+					hfp, hf_write_watch_destroy))
+		return;
+
+	hfp->writer_active = true;
+}
+
+static void destroy_cmd_response(void *data)
+{
+	struct cmd_response *cmd = data;
+
+	free(cmd->prefix);
+	free(cmd);
+}
+
 static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
 {
 	struct event_handler *handler;
 	const char *separators = ";:\0";
 	struct hfp_hf_result result_data;
+	enum hfp_result result;
 	char lookup_prefix[18];
 	uint8_t pref_len = 0;
 	const char *prefix;
@@ -904,6 +1001,22 @@ static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
 	lookup_prefix[pref_len] = '\0';
 	result_data.offset += pref_len + 1;
 
+	if (is_response(lookup_prefix, &result)) {
+		struct cmd_response *cmd;
+
+		cmd = queue_peek_head(hfp->cmd_queue);
+		if (!cmd)
+			return;
+
+		cmd->resp_cb(cmd->prefix, result, cmd->user_data);
+
+		queue_remove(hfp->cmd_queue, cmd);
+		destroy_cmd_response(cmd);
+
+		hf_wakeup_writer(hfp);
+		return;
+	}
+
 	handler = queue_find(hfp->event_handlers, match_handler_event_prefix,
 								lookup_prefix);
 	if (!handler)
@@ -1032,6 +1145,18 @@ struct hfp_hf *hfp_hf_new(int fd)
 		return NULL;
 	}
 
+	hfp->cmd_queue = queue_new();
+	if (!hfp->cmd_queue) {
+		io_destroy(hfp->io);
+		ringbuf_free(hfp->write_buf);
+		ringbuf_free(hfp->read_buf);
+		queue_destroy(hfp->event_handlers, NULL);
+		free(hfp);
+		return NULL;
+	}
+
+	hfp->writer_active = false;
+
 	if (!io_set_read_handler(hfp->io, hf_can_read_data, hfp,
 							read_watch_destroy)) {
 		queue_destroy(hfp->event_handlers,
@@ -1083,6 +1208,9 @@ void hfp_hf_unref(struct hfp_hf *hfp)
 	queue_destroy(hfp->event_handlers, destroy_event_handler);
 	hfp->event_handlers = NULL;
 
+	queue_destroy(hfp->cmd_queue, destroy_cmd_response);
+	hfp->cmd_queue = NULL;
+
 	if (!hfp->in_disconnect) {
 		free(hfp);
 		return;
@@ -1142,6 +1270,53 @@ bool hfp_hf_set_close_on_unref(struct hfp_hf *hfp, bool do_close)
 	return true;
 }
 
+bool hfp_hf_send_command(struct hfp_hf *hfp, hfp_response_func_t resp_cb,
+				void *user_data, const char *format, ...)
+{
+	va_list ap;
+	char *fmt;
+	int len;
+	const char *separators = ";?=\0";
+	uint8_t prefix_len;
+	struct cmd_response *cmd;
+
+	if (!hfp || !format || !resp_cb)
+		return false;
+
+	if (asprintf(&fmt, "%s\r", format) < 0)
+		return false;
+
+	cmd = new0(struct cmd_response, 1);
+	if (!cmd)
+		return false;
+
+	va_start(ap, format);
+	len = ringbuf_vprintf(hfp->write_buf, fmt, ap);
+	va_end(ap);
+
+	free(fmt);
+
+	if (len < 0) {
+		free(cmd);
+		return false;
+	}
+
+	prefix_len = strcspn(format, separators);
+	cmd->prefix = strndup(format, prefix_len);
+	cmd->resp_cb = resp_cb;
+	cmd->user_data = user_data;
+
+	if (!queue_push_tail(hfp->cmd_queue, cmd)) {
+		ringbuf_drain(hfp->write_buf, len);
+		free(cmd);
+		return false;
+	}
+
+	hf_wakeup_writer(hfp);
+
+	return true;
+}
+
 bool hfp_hf_register(struct hfp_hf *hfp, hfp_hf_result_func_t callback,
 						const char *prefix,
 						void *user_data,
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 85037b1..5ee3017 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -32,6 +32,8 @@ enum hfp_result {
 	HFP_RESULT_NO_DIALTONE	= 6,
 	HFP_RESULT_BUSY		= 7,
 	HFP_RESULT_NO_ANSWER	= 8,
+	HFP_RESULT_DELAYED	= 9,
+	HFP_RESULT_BLACKLISTED	= 10,
 };
 
 enum hfp_error {
@@ -83,6 +85,10 @@ typedef void (*hfp_command_func_t)(const char *command, void *user_data);
 
 typedef void (*hfp_disconnect_func_t)(void *user_data);
 
+typedef void (*hfp_response_func_t)(const char *prefix,
+							enum hfp_result result,
+							void *user_data);
+
 struct hfp_gw;
 struct hfp_hf;
 
@@ -146,3 +152,5 @@ bool hfp_hf_register(struct hfp_hf *hfp, hfp_hf_result_func_t callback,
 					const char *prefix, void *user_data,
 					hfp_destroy_func_t destroy);
 bool hfp_hf_unregister(struct hfp_hf *hfp, const char *prefix);
+bool hfp_hf_send_command(struct hfp_hf *hfp, hfp_response_func_t resp_cb,
+				void *user_data, const char *format, ...);
-- 
1.8.4

