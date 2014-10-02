Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 01/11] shared/hfp: Add support for HFP HF
Date: Thu,  2 Oct 2014 21:29:49 +0200
Message-Id: <1412278199-5761-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412278199-5761-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412278199-5761-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add struct hfp_hf plus fuctions to create an instance ref and
unref. This code based on existing hfp_gw
---
 src/shared/hfp.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp.h |  6 ++++
 2 files changed, 98 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index efc981f..dbd049a 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -62,6 +62,18 @@ struct hfp_gw {
 	bool destroyed;
 };
 
+struct hfp_hf {
+	int ref_count;
+	int fd;
+	bool close_on_unref;
+	struct io *io;
+	struct ringbuf *read_buf;
+	struct ringbuf *write_buf;
+
+	bool in_disconnect;
+	bool destroyed;
+};
+
 struct cmd_handler {
 	char *prefix;
 	void *user_data;
@@ -807,3 +819,83 @@ bool hfp_gw_disconnect(struct hfp_gw *hfp)
 
 	return io_shutdown(hfp->io);
 }
+
+struct hfp_hf *hfp_hf_new(int fd)
+{
+	struct hfp_hf *hfp;
+
+	if (fd < 0)
+		return NULL;
+
+	hfp = new0(struct hfp_hf, 1);
+	if (!hfp)
+		return NULL;
+
+	hfp->fd = fd;
+	hfp->close_on_unref = false;
+
+	hfp->read_buf = ringbuf_new(4096);
+	if (!hfp->read_buf) {
+		free(hfp);
+		return NULL;
+	}
+
+	hfp->write_buf = ringbuf_new(4096);
+	if (!hfp->write_buf) {
+		ringbuf_free(hfp->read_buf);
+		free(hfp);
+		return NULL;
+	}
+
+	hfp->io = io_new(fd);
+	if (!hfp->io) {
+		ringbuf_free(hfp->write_buf);
+		ringbuf_free(hfp->read_buf);
+		free(hfp);
+		return NULL;
+	}
+
+	return hfp_hf_ref(hfp);
+}
+
+struct hfp_hf *hfp_hf_ref(struct hfp_hf *hfp)
+{
+	if (!hfp)
+		return NULL;
+
+	__sync_fetch_and_add(&hfp->ref_count, 1);
+
+	return hfp;
+}
+
+void hfp_hf_unref(struct hfp_hf *hfp)
+{
+	if (!hfp)
+		return;
+
+	if (__sync_sub_and_fetch(&hfp->ref_count, 1))
+		return;
+
+	io_set_write_handler(hfp->io, NULL, NULL, NULL);
+	io_set_read_handler(hfp->io, NULL, NULL, NULL);
+	io_set_disconnect_handler(hfp->io, NULL, NULL, NULL);
+
+	io_destroy(hfp->io);
+	hfp->io = NULL;
+
+	if (hfp->close_on_unref)
+		close(hfp->fd);
+
+	ringbuf_free(hfp->read_buf);
+	hfp->read_buf = NULL;
+
+	ringbuf_free(hfp->write_buf);
+	hfp->write_buf = NULL;
+
+	if (!hfp->in_disconnect) {
+		free(hfp);
+		return;
+	}
+
+	hfp->destroyed = true;
+}
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 743db65..50d9c4b 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -76,9 +76,11 @@ typedef void (*hfp_destroy_func_t)(void *user_data);
 typedef void (*hfp_debug_func_t)(const char *str, void *user_data);
 
 typedef void (*hfp_command_func_t)(const char *command, void *user_data);
+
 typedef void (*hfp_disconnect_func_t)(void *user_data);
 
 struct hfp_gw;
+struct hfp_hf;
 
 struct hfp_gw *hfp_gw_new(int fd);
 
@@ -124,3 +126,7 @@ bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
 bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
 								uint8_t len);
 bool hfp_gw_result_has_next(struct hfp_gw_result *result);
+
+struct hfp_hf *hfp_hf_new(int fd);
+struct hfp_hf *hfp_hf_ref(struct hfp_hf *hfp);
+void hfp_hf_unref(struct hfp_hf *hfp);
-- 
1.8.4

