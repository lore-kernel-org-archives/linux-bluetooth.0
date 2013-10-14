Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/22] cbuffer: Add methods for browsing through data
Date: Mon, 14 Oct 2013 10:34:21 +0200
Message-Id: <1381739678-16260-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch provides methods to read buffered data without taking it out
from the buffer. Its possible to take a peek at a byte stored at the
N-th positon from buffer's tail. It also adds method for checking the
size of free continous memory space of the buffer, which in pair with
manual memory access methods can reduce io read calls by allowing to
write more than one byte at a time.
---
 src/shared/cbuffer.c |   37 ++++++++++++++++++++++++++++++++++++-
 src/shared/cbuffer.h |    6 ++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/src/shared/cbuffer.c b/src/shared/cbuffer.c
index 7fd95cc..c1e5b08 100644
--- a/src/shared/cbuffer.c
+++ b/src/shared/cbuffer.c
@@ -123,7 +123,7 @@ unsigned int cbuffer_get_size(struct circular_buffer *cbuff)
 	return cbuff->size;
 }
 
-/* manual mode gives direct access to buffers memory space */
+/* Manual mode gives direct access to buffers memory space */
 char *cbuffer_get_free_cell(struct circular_buffer *cbuff)
 {
 	if (cbuffer_is_full(cbuff))
@@ -139,3 +139,38 @@ int cbuffer_consume_next_cell(struct circular_buffer *cbuff)
 	}
 	return -ENOSPC;
 }
+
+const char *cbuffer_peek_head(struct circular_buffer *cbuff, unsigned int n)
+{
+	int idx;
+	/* find decremented end offset */
+	idx = (cbuff->end - (n + 1)) & (2 * cbuff->size - 1);
+	return &cbuff->data[idx & (cbuff->size - 1)];
+}
+
+const char *cbuffer_peek_tail(struct circular_buffer *cbuff, unsigned int n)
+{
+	int idx;
+	/* find incremented start offset */
+	idx = (cbuff->start + n) & (2 * cbuff->size - 1);
+	return &(cbuff->data[idx & (cbuff->size - 1)]);
+}
+
+unsigned int cbuffer_get_length(struct circular_buffer *cbuff)
+{
+	return abs(cbuff->end - cbuff->start);
+}
+
+unsigned int cbuffer_get_free_chunk_size(struct circular_buffer *cbuff)
+{
+	int realstart = (cbuff->start  & (cbuff->size - 1));
+	int realend = (cbuff->end  & (cbuff->size - 1));
+
+	if (cbuffer_is_full(cbuff))
+			return 0;
+
+	if (realend >= realstart)
+		return cbuff->size - realend;
+	else
+		return realstart - realend;
+}
diff --git a/src/shared/cbuffer.h b/src/shared/cbuffer.h
index 4aaacfa..3880acd 100644
--- a/src/shared/cbuffer.h
+++ b/src/shared/cbuffer.h
@@ -34,3 +34,9 @@ unsigned int cbuffer_get_size(struct circular_buffer *cbuff);
 /* memory direct access functions */
 char *cbuffer_get_free_cell(struct circular_buffer *cbuff);
 int cbuffer_consume_next_cell(struct circular_buffer *cbuff);
+
+/* peek n-th char */
+const char *cbuffer_peek_head(struct circular_buffer *cbuff, unsigned int n);
+const char *cbuffer_peek_tail(struct circular_buffer *cbuff, unsigned int n);
+unsigned int cbuffer_get_free_chunk_size(struct circular_buffer *cbuff);
+unsigned int cbuffer_get_length(struct circular_buffer *cbuff);
-- 
1.7.9.5

