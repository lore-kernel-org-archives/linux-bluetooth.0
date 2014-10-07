Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 05/11] shared/hfp: Add HFP HF parser
Date: Tue,  7 Oct 2014 11:22:14 +0200
Message-Id: <1412673740-24336-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412673740-24336-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412673740-24336-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds parser for AT responses and unsolicited results.
---
 src/shared/hfp.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index b1cf08e..d61d76d 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -868,6 +868,127 @@ static void destroy_event_handler(void *data)
 	free(handler);
 }
 
+static void hf_skip_whitespace(struct hfp_hf_result *result)
+{
+	while (result->data[result->offset] == ' ')
+		result->offset++;
+}
+
+static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
+{
+	struct event_handler *handler;
+	const char *separators = ";:\0";
+	struct hfp_hf_result result_data;
+	char lookup_prefix[18];
+	uint8_t pref_len = 0;
+	const char *prefix;
+	int i;
+
+	result_data.offset = 0;
+	result_data.data = data;
+
+	hf_skip_whitespace(&result_data);
+
+	if (strlen(data + result_data.offset) < 2)
+		return;
+
+	prefix = data + result_data.offset;
+
+	pref_len = strcspn(prefix, separators);
+	if (pref_len > 17 || pref_len < 2)
+		return;
+
+	for (i = 0; i < pref_len; i++)
+		lookup_prefix[i] = toupper(prefix[i]);
+
+	lookup_prefix[pref_len] = '\0';
+	result_data.offset += pref_len + 1;
+
+	handler = queue_find(hfp->event_handlers, match_handler_event_prefix,
+								lookup_prefix);
+
+	if (!handler)
+		return;
+
+	handler->callback(&result_data, handler->user_data);
+}
+
+static char *find_cr_lf(char *str, size_t len)
+{
+	char *ptr;
+	int count;
+	int offset;
+
+	offset = 0;
+
+	ptr = memchr(str, '\r', len);
+	while (ptr) {
+		/*
+		 * Check if there is more data after '\r'. If so check for
+		 * '\n'
+		 */
+		count = ptr-str;
+		if ((count < (int) (len - 1)) && *(ptr + 1) == '\n')
+			return ptr;
+
+		/* There is only '\r'? Let's try to find next one */
+		offset += count + 1;
+
+		if (offset >= (int)len)
+			return NULL;
+
+		ptr = memchr(str + offset, '\r', len - offset);
+	}
+
+	return NULL;
+}
+
+static void hf_process_input(struct hfp_hf *hfp)
+{
+	char *str, *ptr;
+	size_t len, count, offset;
+
+	str = ringbuf_peek(hfp->read_buf, 0, &len);
+	if (!str)
+		return;
+
+	offset = 0;
+
+	ptr = find_cr_lf(str, len);
+	while (ptr) {
+		count = ptr - (str + offset);
+		if (count == 0) {
+			/* 2 is for <cr><lf> */
+			offset += 2;
+		} else {
+			*ptr = '\0';
+			hf_call_prefix_handler(hfp, str + offset);
+			offset += count + 2;
+		}
+
+		if (offset >= len)
+			break;
+
+		ptr = find_cr_lf(str + offset, len - offset);
+	}
+
+	ringbuf_drain(hfp->read_buf, offset < len ? offset : len);
+}
+
+static bool hf_can_read_data(struct io *io, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+	ssize_t bytes_read;
+
+	bytes_read = ringbuf_read(hfp->read_buf, hfp->fd);
+	if (bytes_read < 0)
+		return false;
+
+	hf_process_input(hfp);
+
+	return true;
+}
+
 struct hfp_hf *hfp_hf_new(int fd)
 {
 	struct hfp_hf *hfp;
@@ -912,6 +1033,15 @@ struct hfp_hf *hfp_hf_new(int fd)
 		return NULL;
 	}
 
+	if (!io_set_read_handler(hfp->io, hf_can_read_data, hfp,
+							read_watch_destroy)) {
+		queue_destroy(hfp->event_handlers,
+						destroy_event_handler);
+		io_destroy(hfp->io);
+		ringbuf_free(hfp->write_buf);
+		ringbuf_free(hfp->read_buf);
+	}
+
 	return hfp_hf_ref(hfp);
 }
 
-- 
1.8.4

