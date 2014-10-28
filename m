Return-Path: <cyrus@holtmann.org>
From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Subject: [PATCH BlueZ v2 2/2] shared: Change util.h to compile in strict C
Date: Tue, 28 Oct 2014 15:03:08 -0200
Message-Id: <1414515788-31370-2-git-send-email-gabrielfrancosouza@gmail.com>
In-Reply-To: <1414515788-31370-1-git-send-email-gabrielfrancosouza@gmail.com>
References: <A6A9B75B-1238-4B6C-A9CD-C9E76F306DE7@holtmann.org>
 <1414515788-31370-1-git-send-email-gabrielfrancosouza@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/util.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/shared/util.h b/src/shared/util.h
index 04c600f..8437662 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -57,18 +57,18 @@
 #endif
 
 #define get_unaligned(ptr)			\
-({						\
+__extension__ ({				\
 	struct __attribute__((packed)) {	\
-		typeof(*(ptr)) __v;		\
-	} *__p = (typeof(__p)) (ptr);		\
+		__typeof__(*(ptr)) __v;		\
+	} *__p = (__typeof__(__p)) (ptr);	\
 	__p->__v;				\
 })
 
 #define put_unaligned(val, ptr)			\
 do {						\
 	struct __attribute__((packed)) {	\
-		typeof(*(ptr)) __v;		\
-	} *__p = (typeof(__p)) (ptr);		\
+		__typeof__(*(ptr)) __v;		\
+	} *__p = (__typeof__(__p)) (ptr);	\
 	__p->__v = (val);			\
 } while (0)
 
-- 
2.1.2

