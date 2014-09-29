Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 6/6] shared/hfp: Wakeup writer and similar can use struct hfp now
Date: Mon, 29 Sep 2014 15:47:18 +0200
Message-Id: <1411998438-26914-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1411998438-26914-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411998438-26914-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is yet another patch of hfp cleanup as a preparation for hfp_hf
role. Basically handling write can be done using struct hfp.
---
 src/shared/hfp.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index a1af841..d467c52 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -107,39 +107,39 @@ static bool match_handler_prefix(const void *a, const void *b)
 
 static void write_watch_destroy(void *user_data)
 {
-	struct hfp_gw *hfp = user_data;
+	struct hfp *hfp = user_data;
 
-	hfp->hfp.writer_active = false;
+	hfp->writer_active = false;
 }
 
 static bool can_write_data(struct io *io, void *user_data)
 {
-	struct hfp_gw *hfp = user_data;
+	struct hfp *hfp = user_data;
 	ssize_t bytes_written;
 
-	bytes_written = ringbuf_write(hfp->hfp.write_buf, hfp->hfp.fd);
+	bytes_written = ringbuf_write(hfp->write_buf, hfp->fd);
 	if (bytes_written < 0)
 		return false;
 
-	if (ringbuf_len(hfp->hfp.write_buf) > 0)
+	if (ringbuf_len(hfp->write_buf) > 0)
 		return true;
 
 	return false;
 }
 
-static void wakeup_writer(struct hfp_gw *hfp)
+static void wakeup_writer(struct hfp *hfp)
 {
-	if (hfp->hfp.writer_active)
+	if (hfp->writer_active)
 		return;
 
-	if (!ringbuf_len(hfp->hfp.write_buf))
+	if (!ringbuf_len(hfp->write_buf))
 		return;
 
-	if (!io_set_write_handler(hfp->hfp.io, can_write_data,
-					hfp, write_watch_destroy))
+	if (!io_set_write_handler(hfp->io, can_write_data,
+						hfp, write_watch_destroy))
 		return;
 
-	hfp->hfp.writer_active = true;
+	hfp->writer_active = true;
 }
 
 static void skip_whitespace(struct hfp_gw_result *result)
@@ -655,7 +655,7 @@ bool hfp_gw_send_result(struct hfp_gw *hfp, enum hfp_result result)
 	if (ringbuf_printf(hfp->hfp.write_buf, "\r\n%s\r\n", str) < 0)
 		return false;
 
-	wakeup_writer(hfp);
+	wakeup_writer(&hfp->hfp);
 
 	hfp->result_pending = false;
 
@@ -670,7 +670,7 @@ bool hfp_gw_send_error(struct hfp_gw *hfp, enum hfp_error error)
 	if (ringbuf_printf(hfp->hfp.write_buf, "\r\n+CME ERROR: %u\r\n", error) < 0)
 		return false;
 
-	wakeup_writer(hfp);
+	wakeup_writer(&hfp->hfp);
 
 	hfp->result_pending = false;
 
@@ -701,7 +701,7 @@ bool hfp_gw_send_info(struct hfp_gw *hfp, const char *format, ...)
 	if (hfp->result_pending)
 		return true;
 
-	wakeup_writer(hfp);
+	wakeup_writer(&hfp->hfp);
 
 	return true;
 }
-- 
1.8.4

