Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/6] shared/hfp: Add set_debug helper which takes struct hfp as parameter
Date: Mon, 29 Sep 2014 15:47:15 +0200
Message-Id: <1411998438-26914-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1411998438-26914-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411998438-26914-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch build wrapper for set_debug as same function will be used
later by hfp_hf.

It also moves function in the file so it builds without any issues
---
 src/shared/hfp.c | 76 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 16feaf2..20ddbd3 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -533,6 +533,44 @@ struct hfp_gw *hfp_gw_ref(struct hfp_gw *hfp)
 	return hfp;
 }
 
+static void read_tracing(const void *buf, size_t count, void *user_data)
+{
+	struct hfp *hfp = user_data;
+
+	util_hexdump('>', buf, count, hfp->debug_callback, hfp->debug_data);
+}
+
+static void write_tracing(const void *buf, size_t count, void *user_data)
+{
+	struct hfp *hfp = user_data;
+
+	util_hexdump('<', buf, count, hfp->debug_callback, hfp->debug_data);
+}
+
+static bool set_debug(struct hfp *hfp, hfp_debug_func_t callback,
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
+		ringbuf_set_input_tracing(hfp->read_buf, read_tracing, hfp);
+		ringbuf_set_input_tracing(hfp->write_buf, write_tracing, hfp);
+	} else {
+		ringbuf_set_input_tracing(hfp->read_buf, NULL, NULL);
+		ringbuf_set_input_tracing(hfp->write_buf, NULL, NULL);
+	}
+
+	return true;
+}
+
 void hfp_gw_unref(struct hfp_gw *hfp)
 {
 	if (!hfp)
@@ -553,7 +591,7 @@ void hfp_gw_unref(struct hfp_gw *hfp)
 	if (hfp->hfp.close_on_unref)
 		close(hfp->hfp.fd);
 
-	hfp_gw_set_debug(hfp, NULL, NULL, NULL);
+	set_debug(&hfp->hfp, NULL, NULL, NULL);
 
 	ringbuf_free(hfp->hfp.read_buf);
 	hfp->hfp.read_buf = NULL;
@@ -572,44 +610,10 @@ void hfp_gw_unref(struct hfp_gw *hfp)
 	hfp->hfp.destroyed = true;
 }
 
-static void read_tracing(const void *buf, size_t count, void *user_data)
-{
-	struct hfp_gw *hfp = user_data;
-
-	util_hexdump('>', buf, count, hfp->hfp.debug_callback,
-							hfp->hfp.debug_data);
-}
-
-static void write_tracing(const void *buf, size_t count, void *user_data)
-{
-	struct hfp_gw *hfp = user_data;
-
-	util_hexdump('<', buf, count, hfp->hfp.debug_callback,
-							hfp->hfp.debug_data);
-}
-
 bool hfp_gw_set_debug(struct hfp_gw *hfp, hfp_debug_func_t callback,
 				void *user_data, hfp_destroy_func_t destroy)
 {
-	if (!hfp)
-		return false;
-
-	if (hfp->hfp.debug_destroy)
-		hfp->hfp.debug_destroy(hfp->hfp.debug_data);
-
-	hfp->hfp.debug_callback = callback;
-	hfp->hfp.debug_destroy = destroy;
-	hfp->hfp.debug_data = user_data;
-
-	if (hfp->hfp.debug_callback) {
-		ringbuf_set_input_tracing(hfp->hfp.read_buf, read_tracing, hfp);
-		ringbuf_set_input_tracing(hfp->hfp.write_buf, write_tracing, hfp);
-	} else {
-		ringbuf_set_input_tracing(hfp->hfp.read_buf, NULL, NULL);
-		ringbuf_set_input_tracing(hfp->hfp.write_buf, NULL, NULL);
-	}
-
-	return true;
+	return set_debug(&hfp->hfp, callback, user_data, destroy);
 }
 
 bool hfp_gw_set_close_on_unref(struct hfp_gw *hfp, bool do_close)
-- 
1.8.4

