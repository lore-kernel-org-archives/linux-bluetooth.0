Return-Path: <cyrus@holtmann.org>
From: Richard Palethorpe <richard@lm-technologies.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com
Subject: [PATCH V2] lib: Fix compilation error in C++ due to inline function
Date: Fri, 27 Mar 2015 16:33:39 +0000
Message-Id: <1427474019-25186-1-git-send-email-richard@lm-technologies.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds explicit typecasts to an inline function to make it C++
compatible. What follows is a sample error message from g++ when
compiling without this patch.

/usr/include/bluetooth/bluetooth.h:
  In function 'void bswap_128(const void*, void*)':
/usr/include/bluetooth/bluetooth.h:348:21:
  error: invalid conversion from 'const void*' to 'const uint8_t*
         {aka const unsigned char*}' [-fpermissive]
  const uint8_t *s = src;
---
 lib/bluetooth.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 6ca64b6..852a6b2 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -345,8 +345,8 @@ typedef struct {
 
 static inline void bswap_128(const void *src, void *dst)
 {
-	const uint8_t *s = src;
-	uint8_t *d = dst;
+	const uint8_t *s = (const uint8_t *) src;
+	uint8_t *d = (uint8_t *) dst;
 	int i;
 
 	for (i = 0; i < 16; i++)
-- 
2.3.4

