Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/22] cbuffer: Add seek and check routines
Date: Mon, 14 Oct 2013 10:34:23 +0200
Message-Id: <1381739678-16260-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds seek and check routines needed for some sanity checks
by the AT chat module. It will be needed for the boundary checks.
---
 src/shared/cbuffer.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/cbuffer.h |    6 ++++++
 2 files changed, 60 insertions(+)

diff --git a/src/shared/cbuffer.c b/src/shared/cbuffer.c
index c1e5b08..8d85059 100644
--- a/src/shared/cbuffer.c
+++ b/src/shared/cbuffer.c
@@ -22,6 +22,7 @@
  */
 
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 
 #include "cbuffer.h"
@@ -156,6 +157,59 @@ const char *cbuffer_peek_tail(struct circular_buffer *cbuff, unsigned int n)
 	return &(cbuff->data[idx & (cbuff->size - 1)]);
 }
 
+/* Checks for sequence in the given position */
+int cbuffer_starts_with_seq(struct circular_buffer *cbuff, const char *seq,
+				unsigned int offset)
+{
+	int i;
+	int seqlen = strlen(seq);
+	const char *ch;
+
+	ch = NULL;
+	for (i = 0; i < seqlen; ++i) {
+		ch = cbuffer_peek_tail(cbuff, offset + i);
+		if (seq[i] != *ch)
+			return 0;
+	}
+	return 1;
+}
+
+/* Seeks for sequence in the circular buffer */
+int cbuffer_seek_head_for_seq(struct circular_buffer *cbuff, const char *seq,
+				unsigned int offset)
+{
+	int i;
+	const char *pos;
+	const char *end;
+
+	end = cbuffer_peek_tail(cbuff, 0);
+	i = offset;
+	for (pos = cbuffer_peek_head(cbuff, i); pos != end; ++i) {
+		pos = cbuffer_peek_head(cbuff, i);
+		if (cbuffer_starts_with_seq(cbuff, seq, i))
+			return i;
+	}
+	return -ENODATA;
+}
+
+/* Seeks for sequence in the circular buffer */
+int cbuffer_seek_tail_for_seq(struct circular_buffer *cbuff, const char *seq,
+				unsigned int offset)
+{
+	int i;
+	const char *pos;
+	const char *end;
+
+	end = cbuffer_peek_head(cbuff, 0);
+	i = offset;
+	for (pos = cbuffer_peek_tail(cbuff, i); pos != end; ++i) {
+		pos = cbuffer_peek_tail(cbuff, i);
+		if (cbuffer_starts_with_seq(cbuff, seq, i))
+			return i;
+	}
+	return -ENODATA;
+}
+
 unsigned int cbuffer_get_length(struct circular_buffer *cbuff)
 {
 	return abs(cbuff->end - cbuff->start);
diff --git a/src/shared/cbuffer.h b/src/shared/cbuffer.h
index 3880acd..ff29d22 100644
--- a/src/shared/cbuffer.h
+++ b/src/shared/cbuffer.h
@@ -40,3 +40,9 @@ const char *cbuffer_peek_head(struct circular_buffer *cbuff, unsigned int n);
 const char *cbuffer_peek_tail(struct circular_buffer *cbuff, unsigned int n);
 unsigned int cbuffer_get_free_chunk_size(struct circular_buffer *cbuff);
 unsigned int cbuffer_get_length(struct circular_buffer *cbuff);
+int cbuffer_starts_with_seq(struct circular_buffer *cbuff, const char *seq,
+					unsigned int offset);
+int cbuffer_seek_head_for_seq(struct circular_buffer *cbuff, const char *seq,
+					unsigned int offset);
+int cbuffer_seek_tail_for_seq(struct circular_buffer *cbuff, const char *seq,
+					unsigned int offset);
-- 
1.7.9.5

