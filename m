Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] shared/hfp: Fix crash due to invalid free
Date: Wed,  4 Jun 2014 19:41:08 +0200
Message-Id: <1401903668-27548-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1401903668-27548-1-git-send-email-szymon.janc@tieto.com>
References: <1401903668-27548-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there are no characters before '\r' memchr() will return pointer
matching passed string. This will results either in double free (if
'\r' happen to be the first byte in ringbuffer buffer) or in freeing
pointer inside ringbuffer buffer (if '\r' is not the first byte).
---
 src/shared/hfp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 36c8c3e..196e777 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -381,6 +381,7 @@ static void process_input(struct hfp_gw *hfp)
 {
 	char *str, *ptr;
 	size_t len, count;
+	bool free_ptr = false;
 
 	str = ringbuf_peek(hfp->read_buf, 0, &len);
 	if (!str)
@@ -407,6 +408,7 @@ static void process_input(struct hfp_gw *hfp)
 
 		*ptr = '\0';
 		count = asprintf(&ptr, "%s%s", str, str2);
+		free_ptr = true;
 		str = ptr;
 	} else {
 		count = ptr - str;
@@ -424,7 +426,7 @@ static void process_input(struct hfp_gw *hfp)
 
 	len = ringbuf_drain(hfp->read_buf, count + 1);
 
-	if (str == ptr)
+	if (free_ptr)
 		free(ptr);
 }
 
-- 
1.9.3

