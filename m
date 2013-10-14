Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/22] cbuffer: Add discard method
Date: Mon, 14 Oct 2013 10:34:27 +0200
Message-Id: <1381739678-16260-12-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds discarding desired amount of oldest data from the buffer.
---
 src/shared/cbuffer.c |    9 +++++++++
 src/shared/cbuffer.h |    1 +
 2 files changed, 10 insertions(+)

diff --git a/src/shared/cbuffer.c b/src/shared/cbuffer.c
index 8d85059..a5ed7c5 100644
--- a/src/shared/cbuffer.c
+++ b/src/shared/cbuffer.c
@@ -124,6 +124,15 @@ unsigned int cbuffer_get_size(struct circular_buffer *cbuff)
 	return cbuff->size;
 }
 
+int cbuffer_discard(struct circular_buffer *cbuff, unsigned int amount)
+{
+	unsigned int len = cbuffer_get_length(cbuff);
+
+	amount = amount > len ? len : amount;
+	cbuff->start = (cbuff->start + amount) & (2 * cbuff->size - 1);
+	return amount;
+}
+
 /* Manual mode gives direct access to buffers memory space */
 char *cbuffer_get_free_cell(struct circular_buffer *cbuff)
 {
diff --git a/src/shared/cbuffer.h b/src/shared/cbuffer.h
index ff29d22..759d8a7 100644
--- a/src/shared/cbuffer.h
+++ b/src/shared/cbuffer.h
@@ -27,6 +27,7 @@ struct circular_buffer *cbuffer_init(unsigned int size);
 void cbuffer_free(struct circular_buffer *cbuff);
 int cbuffer_write(struct circular_buffer *cbuff, char source);
 int cbuffer_read(struct circular_buffer *cbuff, char *dest);
+int cbuffer_discard(struct circular_buffer *cbuff, unsigned int amount);
 void cbuffer_drain(struct circular_buffer *cbuff);
 int cbuffer_is_full(struct circular_buffer *cbuff);
 int cbuffer_is_empty(struct circular_buffer *cbuff);
-- 
1.7.9.5

