Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Subject: [PATCH] sbc: fix "always_inline function might not be inlinable" warning
Date: Fri, 24 Feb 2012 14:13:16 +0200
Message-Id: <1330085596-3645-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"__attribute__((always_inline))" does not replace "inline" and they
still need to be used together. This fixes "always_inline function
might not be inlinable [-Wattributes]" warning in gcc 4.7
---
 sbc/sbc_primitives.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 3fec8d5..17ad4f7 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -31,7 +31,7 @@
 #define SBC_X_BUFFER_SIZE 328
 
 #ifdef __GNUC__
-#define SBC_ALWAYS_INLINE __attribute__((always_inline))
+#define SBC_ALWAYS_INLINE inline __attribute__((always_inline))
 #else
 #define SBC_ALWAYS_INLINE inline
 #endif
-- 
1.7.3.4

