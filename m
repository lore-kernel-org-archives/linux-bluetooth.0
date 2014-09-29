Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/6] shared/hfp: Extract hfp_cleanup function
Date: Mon, 29 Sep 2014 15:47:16 +0200
Message-Id: <1411998438-26914-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1411998438-26914-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411998438-26914-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is yet another cleanup patch preparing us to support hfp_hf.
This one adds helper function to cleanup hfp
---
 src/shared/hfp.c | 56 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 20ddbd3..5d1f007 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -571,43 +571,51 @@ static bool set_debug(struct hfp *hfp, hfp_debug_func_t callback,
 	return true;
 }
 
-void hfp_gw_unref(struct hfp_gw *hfp)
+static void hfp_cleanup(struct hfp *hfp)
 {
-	if (!hfp)
-		return;
+	io_set_write_handler(hfp->io, NULL, NULL, NULL);
+	io_set_read_handler(hfp->io, NULL, NULL, NULL);
+	io_set_disconnect_handler(hfp->io, NULL, NULL, NULL);
 
-	if (__sync_sub_and_fetch(&hfp->hfp.ref_count, 1))
-		return;
+	io_destroy(hfp->io);
+	hfp->io = NULL;
 
-	hfp_gw_set_command_handler(hfp, NULL, NULL, NULL);
+	if (hfp->close_on_unref)
+		close(hfp->fd);
 
-	io_set_write_handler(hfp->hfp.io, NULL, NULL, NULL);
-	io_set_read_handler(hfp->hfp.io, NULL, NULL, NULL);
-	io_set_disconnect_handler(hfp->hfp.io, NULL, NULL, NULL);
+	set_debug(hfp, NULL, NULL, NULL);
 
-	io_destroy(hfp->hfp.io);
-	hfp->hfp.io = NULL;
+	ringbuf_free(hfp->read_buf);
+	hfp->read_buf = NULL;
 
-	if (hfp->hfp.close_on_unref)
-		close(hfp->hfp.fd);
+	ringbuf_free(hfp->write_buf);
+	hfp->write_buf = NULL;
 
-	set_debug(&hfp->hfp, NULL, NULL, NULL);
+	if (!hfp->in_disconnect) {
+		/*
+		 * Since struct hfp is a first field in hfp_gw, pointer to this
+		 * also points to hfp_gw, therefore we can do free here.
+		 */
+		free(hfp);
+		return;
+	}
 
-	ringbuf_free(hfp->hfp.read_buf);
-	hfp->hfp.read_buf = NULL;
+	hfp->destroyed = true;
+}
 
-	ringbuf_free(hfp->hfp.write_buf);
-	hfp->hfp.write_buf = NULL;
+void hfp_gw_unref(struct hfp_gw *hfp)
+{
+	if (!hfp)
+		return;
+
+	if (__sync_sub_and_fetch(&hfp->hfp.ref_count, 1))
+		return;
 
+	hfp_gw_set_command_handler(hfp, NULL, NULL, NULL);
 	queue_destroy(hfp->cmd_handlers, destroy_cmd_handler);
 	hfp->cmd_handlers = NULL;
 
-	if (!hfp->hfp.in_disconnect) {
-		free(hfp);
-		return;
-	}
-
-	hfp->hfp.destroyed = true;
+	hfp_cleanup(&hfp->hfp);
 }
 
 bool hfp_gw_set_debug(struct hfp_gw *hfp, hfp_debug_func_t callback,
-- 
1.8.4

