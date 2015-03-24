Return-Path: <cyrus@holtmann.org>
From: Richard Palethorpe <richard@lm-technologies.com>
To: linux-bluetooth@vger.kernel.org
Cc: Richard Palethorpe <richard@lm-technologies.com>
Subject: [PATCH] lib: Fix compilation error in C++ due to inline function
Date: Tue, 24 Mar 2015 14:52:24 +0000
Message-Id: <1427208744-11805-1-git-send-email-richard@lm-technologies.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds explicit typecasts to an inline function to make it C++ compatible.
---
 lib/bluetooth.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 6ca64b6..ab24443 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -345,8 +345,8 @@ typedef struct {
 
 static inline void bswap_128(const void *src, void *dst)
 {
-	const uint8_t *s = src;
-	uint8_t *d = dst;
+	const uint8_t *s = (const uint8_t *)src;
+	uint8_t *d = (uint8_t *)dst;
 	int i;
 
 	for (i = 0; i < 16; i++)
-- 
2.3.4

