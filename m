Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 61/62] lib: Remove bt_get_unaligned()
Date: Thu, 20 Mar 2014 11:43:26 -0300
Message-Id: <1395326607-27068-62-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 57ac7b5..303ad67 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -154,15 +154,6 @@ enum {
 #error "Unknown byte order"
 #endif
 
-/* Bluetooth unaligned access */
-#define bt_get_unaligned(ptr)			\
-({						\
-	struct __attribute__((packed)) {	\
-		typeof(*(ptr)) __v;		\
-	} *__p = (typeof(__p)) (ptr);		\
-	__p->__v;				\
-})
-
 #define bt_put_unaligned(val, ptr)		\
 do {						\
 	struct __attribute__((packed)) {	\
-- 
1.8.3.1

