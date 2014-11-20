Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 7/8] shared/hfp: Improve handling AT commands
Date: Thu, 20 Nov 2014 16:55:14 +0100
Message-Id: <1416498915-19534-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch improves handling AT commands in cases:

1. In ring buffer we have currupted commands like Y\rAT+X\r
2. In ring buffer for some reason we have more than AT commands and all
commands are unknow except the last one.

In bith cases parser read data until first \r and then stop to read.
This is fixed with this patch
---
 src/shared/hfp.c | 91 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 41eae74..5a91d12 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -476,54 +476,73 @@ static void process_input(struct hfp_gw *hfp)
 	char *str, *ptr;
 	size_t len, count;
 	bool free_ptr = false;
+	bool read_again;
 
-	str = ringbuf_peek(hfp->read_buf, 0, &len);
-	if (!str)
-		return;
+	do {
+		str = ringbuf_peek(hfp->read_buf, 0, &len);
+		if (!str)
+			return;
 
-	ptr = memchr(str, '\r', len);
-	if (!ptr) {
-		char *str2;
-		size_t len2;
+		ptr = memchr(str, '\r', len);
+		if (!ptr) {
+			char *str2;
+			size_t len2;
 
-		/*
-		 * If there is no more data in ringbuffer,
-		 * it's just an incomplete command.
-		 */
-		if (len == ringbuf_len(hfp->read_buf))
-			return;
+			/*
+			 * If there is no more data in ringbuffer,
+			 * it's just an incomplete command.
+			 */
+			if (len == ringbuf_len(hfp->read_buf))
+				return;
 
-		str2 = ringbuf_peek(hfp->read_buf, len, &len2);
-		if (!str2)
-			return;
+			str2 = ringbuf_peek(hfp->read_buf, len, &len2);
+			if (!str2)
+				return;
 
-		ptr = memchr(str2, '\r', len2);
-		if (!ptr)
-			return;
+			ptr = memchr(str2, '\r', len2);
+			if (!ptr)
+				return;
 
-		*ptr = '\0';
+			*ptr = '\0';
 
-		count = len2 + len;
-		ptr = malloc(count);
-		if (!ptr)
-			return;
+			count = len2 + len;
+			ptr = malloc(count);
+			if (!ptr)
+				return;
 
-		memcpy(ptr, str, len);
-		memcpy(ptr + len, str2, len2);
+			memcpy(ptr, str, len);
+			memcpy(ptr + len, str2, len2);
 
-		free_ptr = true;
-		str = ptr;
-	} else {
-		count = ptr - str;
-		*ptr = '\0';
-	}
+			free_ptr = true;
+			str = ptr;
+		} else {
+			count = ptr - str;
+			*ptr = '\0';
+		}
+
+		if (!handle_at_command(hfp, str))
+			/*
+			 * Command is not handled that means that was some
+			 * trash. Let's skip that and keep reading from ring
+			 * buffer.
+			 */
+			read_again = true;
+		else
+			/*
+			 * Command has been handled. If we are waiting for a
+			 * result from upper layer, we can stop reading. If we
+			 * already reply i.e. ERROR on unknown command, then we
+			 * can keep reading ring buffer. Actually ring buffer
+			 * should be empty but lets just look there.
+			 */
+			read_again = !hfp->result_pending;
 
-	handle_at_command(hfp, str);
+		ringbuf_drain(hfp->read_buf, count + 1);
 
-	ringbuf_drain(hfp->read_buf, count + 1);
+		if (free_ptr)
+			free(ptr);
 
-	if (free_ptr)
-		free(ptr);
+	} while (read_again);
 }
 
 static void read_watch_destroy(void *user_data)
-- 
1.8.4

