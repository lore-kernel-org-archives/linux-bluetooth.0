Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 02/11] shared/hfp: Add set_debug and close_on_unref API for HFP HF
Date: Fri, 24 Oct 2014 13:59:26 +0200
Message-Id: <1414151975-20588-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1414151975-20588-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1414151975-20588-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp.h |  3 +++
 2 files changed, 60 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index dbd049a..ad2daa2 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -70,6 +70,10 @@ struct hfp_hf {
 	struct ringbuf *read_buf;
 	struct ringbuf *write_buf;
 
+	hfp_debug_func_t debug_callback;
+	hfp_destroy_func_t debug_destroy;
+	void *debug_data;
+
 	bool in_disconnect;
 	bool destroyed;
 };
@@ -886,6 +890,8 @@ void hfp_hf_unref(struct hfp_hf *hfp)
 	if (hfp->close_on_unref)
 		close(hfp->fd);
 
+	hfp_hf_set_debug(hfp, NULL, NULL, NULL);
+
 	ringbuf_free(hfp->read_buf);
 	hfp->read_buf = NULL;
 
@@ -899,3 +905,54 @@ void hfp_hf_unref(struct hfp_hf *hfp)
 
 	hfp->destroyed = true;
 }
+
+static void hf_read_tracing(const void *buf, size_t count,
+							void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	util_hexdump('>', buf, count, hfp->debug_callback, hfp->debug_data);
+}
+
+static void hf_write_tracing(const void *buf, size_t count,
+							void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	util_hexdump('<', buf, count, hfp->debug_callback, hfp->debug_data);
+}
+
+bool hfp_hf_set_debug(struct hfp_hf *hfp, hfp_debug_func_t callback,
+				void *user_data, hfp_destroy_func_t destroy)
+{
+	if (!hfp)
+		return false;
+
+	if (hfp->debug_destroy)
+		hfp->debug_destroy(hfp->debug_data);
+
+	hfp->debug_callback = callback;
+	hfp->debug_destroy = destroy;
+	hfp->debug_data = user_data;
+
+	if (hfp->debug_callback) {
+		ringbuf_set_input_tracing(hfp->read_buf, hf_read_tracing, hfp);
+		ringbuf_set_input_tracing(hfp->write_buf, hf_write_tracing,
+									hfp);
+	} else {
+		ringbuf_set_input_tracing(hfp->read_buf, NULL, NULL);
+		ringbuf_set_input_tracing(hfp->write_buf, NULL, NULL);
+	}
+
+	return true;
+}
+
+bool hfp_hf_set_close_on_unref(struct hfp_hf *hfp, bool do_close)
+{
+	if (!hfp)
+		return false;
+
+	hfp->close_on_unref = do_close;
+
+	return true;
+}
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 0b57e2e..21d205b 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -131,3 +131,6 @@ struct hfp_hf *hfp_hf_new(int fd);
 
 struct hfp_hf *hfp_hf_ref(struct hfp_hf *hfp);
 void hfp_hf_unref(struct hfp_hf *hfp);
+bool hfp_hf_set_debug(struct hfp_hf *hfp, hfp_debug_func_t callback,
+				void *user_data, hfp_destroy_func_t destroy);
+bool hfp_hf_set_close_on_unref(struct hfp_hf *hfp, bool do_close);
-- 
1.8.4

