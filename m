Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/6] shared/hfp: Extract creation hfp to separate function
Date: Mon, 29 Sep 2014 15:47:14 +0200
Message-Id: <1411998438-26914-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1411998438-26914-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411998438-26914-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This code is going to be common between gw and hf.
---
 src/shared/hfp.c | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 6176514..16feaf2 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -455,6 +455,33 @@ static bool can_read_data(struct io *io, void *user_data)
 	return true;
 }
 
+static bool hfp_create(struct hfp *hfp, int fd)
+{
+	hfp->fd = fd;
+	hfp->close_on_unref = false;
+
+	hfp->read_buf = ringbuf_new(4096);
+	if (!hfp->read_buf)
+		return false;
+
+	hfp->write_buf = ringbuf_new(4096);
+	if (!hfp->write_buf) {
+		ringbuf_free(hfp->read_buf);
+		return false;
+	}
+
+	hfp->io = io_new(fd);
+	if (!hfp->io) {
+		ringbuf_free(hfp->write_buf);
+		ringbuf_free(hfp->read_buf);
+		return false;
+	}
+
+	hfp->writer_active = false;
+
+	return true;
+}
+
 struct hfp_gw *hfp_gw_new(int fd)
 {
 	struct hfp_gw *hfp;
@@ -466,26 +493,7 @@ struct hfp_gw *hfp_gw_new(int fd)
 	if (!hfp)
 		return NULL;
 
-	hfp->hfp.fd = fd;
-	hfp->hfp.close_on_unref = false;
-
-	hfp->hfp.read_buf = ringbuf_new(4096);
-	if (!hfp->hfp.read_buf) {
-		free(hfp);
-		return NULL;
-	}
-
-	hfp->hfp.write_buf = ringbuf_new(4096);
-	if (!hfp->hfp.write_buf) {
-		ringbuf_free(hfp->hfp.read_buf);
-		free(hfp);
-		return NULL;
-	}
-
-	hfp->hfp.io = io_new(fd);
-	if (!hfp->hfp.io) {
-		ringbuf_free(hfp->hfp.write_buf);
-		ringbuf_free(hfp->hfp.read_buf);
+	if (!hfp_create(&hfp->hfp, fd)) {
 		free(hfp);
 		return NULL;
 	}
@@ -510,7 +518,6 @@ struct hfp_gw *hfp_gw_new(int fd)
 		return NULL;
 	}
 
-	hfp->hfp.writer_active = false;
 	hfp->result_pending = false;
 
 	return hfp_gw_ref(hfp);
-- 
1.8.4

