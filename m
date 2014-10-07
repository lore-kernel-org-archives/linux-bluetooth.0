Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 03/11] shared/hfp: Add set disconnect handler and disconnect API to HFP HF
Date: Tue,  7 Oct 2014 11:22:12 +0200
Message-Id: <1412673740-24336-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412673740-24336-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412673740-24336-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp.h |  5 +++++
 2 files changed, 68 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index ad2daa2..b7855ed 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -74,6 +74,10 @@ struct hfp_hf {
 	hfp_destroy_func_t debug_destroy;
 	void *debug_data;
 
+	hfp_disconnect_func_t disconnect_callback;
+	hfp_destroy_func_t disconnect_destroy;
+	void *disconnect_data;
+
 	bool in_disconnect;
 	bool destroyed;
 };
@@ -956,3 +960,62 @@ bool hfp_hf_set_close_on_unref(struct hfp_hf *hfp, bool do_close)
 
 	return true;
 }
+
+static void hf_disconnect_watch_destroy(void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	if (hfp->disconnect_destroy)
+		hfp->disconnect_destroy(hfp->disconnect_data);
+
+	if (hfp->destroyed)
+		free(hfp);
+}
+
+static bool hf_io_disconnected(struct io *io, void *user_data)
+{
+	struct hfp_hf *hfp = user_data;
+
+	hfp->in_disconnect = true;
+
+	if (hfp->disconnect_callback)
+		hfp->disconnect_callback(hfp->disconnect_data);
+
+	hfp->in_disconnect = false;
+
+	return false;
+}
+
+bool hfp_hf_set_disconnect_handler(struct hfp_hf *hfp,
+						hfp_disconnect_func_t callback,
+						void *user_data,
+						hfp_destroy_func_t destroy)
+{
+	if (!hfp)
+		return false;
+
+	if (hfp->disconnect_destroy)
+		hfp->disconnect_destroy(hfp->disconnect_data);
+
+	if (!io_set_disconnect_handler(hfp->io, hf_io_disconnected, hfp,
+						hf_disconnect_watch_destroy)) {
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
+
+bool hfp_hf_disconnect(struct hfp_hf *hfp)
+{
+	if (!hfp)
+		return false;
+
+	return io_shutdown(hfp->io);
+}
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index ae67ac2..a9a169b 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -133,3 +133,8 @@ void hfp_hf_unref(struct hfp_hf *hfp);
 bool hfp_hf_set_debug(struct hfp_hf *hfp, hfp_debug_func_t callback,
 				void *user_data, hfp_destroy_func_t destroy);
 bool hfp_hf_set_close_on_unref(struct hfp_hf *hfp, bool do_close);
+bool hfp_hf_set_disconnect_handler(struct hfp_hf *hfp,
+					hfp_disconnect_func_t callback,
+					void *user_data,
+					hfp_destroy_func_t destroy);
+bool hfp_hf_disconnect(struct hfp_hf *hfp);
-- 
1.8.4

