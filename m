Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/22] cbuffer: Add direct access to buffer's memory
Date: Mon, 14 Oct 2013 10:34:19 +0200
Message-Id: <1381739678-16260-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch gives direct access to cbuffers memory. Its essential to
make glib's io read/write functions operate directly in the buffer
instead using intermediate buffering or reading by one char.
---
 src/shared/cbuffer.c |   17 +++++++++++++++++
 src/shared/cbuffer.h |    3 +++
 2 files changed, 20 insertions(+)

diff --git a/src/shared/cbuffer.c b/src/shared/cbuffer.c
index 7dde707..7fd95cc 100644
--- a/src/shared/cbuffer.c
+++ b/src/shared/cbuffer.c
@@ -122,3 +122,20 @@ unsigned int cbuffer_get_size(struct circular_buffer *cbuff)
 {
 	return cbuff->size;
 }
+
+/* manual mode gives direct access to buffers memory space */
+char *cbuffer_get_free_cell(struct circular_buffer *cbuff)
+{
+	if (cbuffer_is_full(cbuff))
+		return NULL;
+	return &(cbuff->data[cbuff->end & (cbuff->size - 1)]);
+}
+
+int cbuffer_consume_next_cell(struct circular_buffer *cbuff)
+{
+	if (!cbuffer_is_full(cbuff)) {
+		cbuffer_incr(cbuff, &cbuff->end);
+		return 0;
+	}
+	return -ENOSPC;
+}
diff --git a/src/shared/cbuffer.h b/src/shared/cbuffer.h
index 8865f1f..4aaacfa 100644
--- a/src/shared/cbuffer.h
+++ b/src/shared/cbuffer.h
@@ -31,3 +31,6 @@ void cbuffer_drain(struct circular_buffer *cbuff);
 int cbuffer_is_full(struct circular_buffer *cbuff);
 int cbuffer_is_empty(struct circular_buffer *cbuff);
 unsigned int cbuffer_get_size(struct circular_buffer *cbuff);
+/* memory direct access functions */
+char *cbuffer_get_free_cell(struct circular_buffer *cbuff);
+int cbuffer_consume_next_cell(struct circular_buffer *cbuff);
-- 
1.7.9.5

