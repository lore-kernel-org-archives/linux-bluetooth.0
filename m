Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 05/11] shared/hfp: Add HFP HF parser
Date: Fri, 24 Oct 2014 13:59:29 +0200
Message-Id: <1414151975-20588-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1414151975-20588-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1414151975-20588-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds parser for AT responses and unsolicited results.
---
 src/shared/hfp.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 84c0db1..37a18d9 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -865,6 +865,170 @@ static void destroy_event_handler(void *data)
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
+	if (!handler)
+		return;
+
+	handler->callback(&result_data, handler->user_data);
+}
+
+static char *find_cr_lf(char *str, size_t len)
+{
+	char *ptr;
+	size_t count, offset;
+
+	offset = 0;
+
+	ptr = memchr(str, '\r', len);
+	while (ptr) {
+		/*
+		 * Check if there is more data after '\r'. If so check for
+		 * '\n'
+		 */
+		count = ptr - str;
+		if ((count < (len - 1)) && *(ptr + 1) == '\n')
+			return ptr;
+
+		/* There is only '\r'? Let's try to find next one */
+		offset += count + 1;
+
+		if (offset >= len)
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
+	char *str, *ptr, *str2, *tmp;
+	size_t len, count, offset, len2;
+	bool free_tmp = false;
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
+		ptr = find_cr_lf(str + offset, len - offset);
+	}
+
+	/*
+	 * Just check if there is no wrapped data in ring buffer.
+	 * Should not happen too often
+	 */
+	if (len == ringbuf_len(hfp->read_buf))
+		goto done;
+
+	/* If we are here second time for some reason, that is wrong */
+	if (free_tmp)
+		goto done;
+
+	str2 = ringbuf_peek(hfp->read_buf, len, &len2);
+	if (!str2)
+		goto done;
+
+	ptr = find_cr_lf(str2, len2);
+	if (!ptr) {
+		/* Might happen that we wrap between \r and \n */
+		ptr = memchr(str2, '\n', len2);
+		if (!ptr)
+			goto done;
+	}
+
+	count = ptr - str2;
+
+	if (count) {
+		*ptr = '\0';
+
+		tmp = malloc(len + count);
+
+		/* "str" here is not a string so we need to use memcpy */
+		memcpy(tmp, str, len);
+		memcpy(tmp + len, str2, count);
+
+		free_tmp = true;
+	} else {
+		str[len-1] = '\0';
+		tmp = str;
+	}
+
+	hf_call_prefix_handler(hfp, tmp);
+	offset += count;
+
+done:
+	ringbuf_drain(hfp->read_buf, offset);
+
+	if (free_tmp)
+		free(tmp);
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
@@ -909,6 +1073,17 @@ struct hfp_hf *hfp_hf_new(int fd)
 		return NULL;
 	}
 
+	if (!io_set_read_handler(hfp->io, hf_can_read_data, hfp,
+							read_watch_destroy)) {
+		queue_destroy(hfp->event_handlers,
+						destroy_event_handler);
+		io_destroy(hfp->io);
+		ringbuf_free(hfp->write_buf);
+		ringbuf_free(hfp->read_buf);
+		free(hfp);
+		return NULL;
+	}
+
 	return hfp_hf_ref(hfp);
 }
 
-- 
1.8.4

