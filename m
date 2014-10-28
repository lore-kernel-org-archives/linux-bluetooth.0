Return-Path: <cyrus@holtmann.org>
From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Subject: [PATCH BlueZ v2 1/2] lib: Change bluetooth.h to compile in strict C
Date: Tue, 28 Oct 2014 15:03:07 -0200
Message-Id: <1414515788-31370-1-git-send-email-gabrielfrancosouza@gmail.com>
In-Reply-To: <A6A9B75B-1238-4B6C-A9CD-C9E76F306DE7@holtmann.org>
References: <A6A9B75B-1238-4B6C-A9CD-C9E76F306DE7@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

This change enables programs writen with strict C syntax
(e.g. "-std=c11 -pedantic") to compile when including
bluetooth.h.

v2: Resend with fixed commits.

 lib/bluetooth.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 61c1f9a..f214d81 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -156,18 +156,18 @@ enum {
 
 /* Bluetooth unaligned access */
 #define bt_get_unaligned(ptr)			\
-({						\
+__extension__ ({				\
 	struct __attribute__((packed)) {	\
-		typeof(*(ptr)) __v;		\
-	} *__p = (typeof(__p)) (ptr);		\
+		__typeof__(*(ptr)) __v;		\
+	} *__p = (__typeof__(__p)) (ptr);	\
 	__p->__v;				\
 })
 
 #define bt_put_unaligned(val, ptr)		\
 do {						\
 	struct __attribute__((packed)) {	\
-		typeof(*(ptr)) __v;		\
-	} *__p = (typeof(__p)) (ptr);		\
+		__typeof__(*(ptr)) __v;		\
+	} *__p = (__typeof__(__p)) (ptr);	\
 	__p->__v = (val);			\
 } while(0)
 
-- 
2.1.2

