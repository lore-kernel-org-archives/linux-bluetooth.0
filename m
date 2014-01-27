Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] unit/ringbuf: Fix memory leak
Date: Mon, 27 Jan 2014 10:36:09 +0200
Message-Id: <1390811769-11861-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

free allocated memory before exit
---
 src/shared/ringbuf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/shared/ringbuf.c b/src/shared/ringbuf.c
index 3e5c7d3..d59dc5c 100644
--- a/src/shared/ringbuf.c
+++ b/src/shared/ringbuf.c
@@ -228,9 +228,14 @@ int ringbuf_vprintf(struct ringbuf *ringbuf, const char *format, va_list ap)
 		return -1;
 
 	len = vasprintf(&str, format, ap);
-	if (len < 0 || (size_t) len > avail)
+	if (len < 0)
 		return -1;
 
+	if ((size_t) len > avail) {
+		free(str);
+		return -1;
+	}
+
 	/* Determine possible length of string before wrapping */
 	offset = ringbuf->in & (ringbuf->size - 1);
 	end = MIN((size_t) len, ringbuf->size - offset);
-- 
1.8.3.2

