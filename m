Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Fix compilation of C++ programs that include <bluetooth/bluetooth.h>
Date: Fri, 13 Jan 2012 09:18:53 +0100
Message-ID: <1326442733-11966-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

C++ doesn't allow for implicit conversion from void*.

/usr/include/bluetooth/bluetooth.h: In function ‘uint64_t bt_get_le64(void*)’:
/usr/include/bluetooth/bluetooth.h:131: error: invalid conversion from ‘void*’ to ‘bt_get_le64(void*)::<anonymous struct>*’
/usr/include/bluetooth/bluetooth.h: In function ‘uint64_t bt_get_be64(void*)’:
/usr/include/bluetooth/bluetooth.h:136: error: invalid conversion from ‘void*’ to ‘bt_get_be64(void*)::<anonymous struct>*’
/usr/include/bluetooth/bluetooth.h: In function ‘uint32_t bt_get_le32(void*)’:
/usr/include/bluetooth/bluetooth.h:141: error: invalid conversion from ‘void*’ to ‘bt_get_le32(void*)::<anonymous struct>*’
/usr/include/bluetooth/bluetooth.h: In function ‘uint32_t bt_get_be32(void*)’:
/usr/include/bluetooth/bluetooth.h:146: error: invalid conversion from ‘void*’ to ‘bt_get_be32(void*)::<anonymous struct>*’
/usr/include/bluetooth/bluetooth.h: In function ‘uint16_t bt_get_le16(void*)’:
/usr/include/bluetooth/bluetooth.h:151: error: invalid conversion from ‘void*’ to ‘bt_get_le16(void*)::<anonymous struct>*’
/usr/include/bluetooth/bluetooth.h: In function ‘uint16_t bt_get_be16(void*)’:
/usr/include/bluetooth/bluetooth.h:156: error: invalid conversion from ‘void*’ to ‘bt_get_be16(void*)::<anonymous struct>*’
---
 lib/bluetooth.h |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 5bd4f03..b4891ef 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -111,17 +111,19 @@ enum {
 /* Bluetooth unaligned access */
 #define bt_get_unaligned(ptr)			\
 ({						\
-	struct __attribute__((packed)) {	\
+	struct __s {				\
 		typeof(*(ptr)) __v;		\
-	} *__p = (void *) (ptr);		\
+	} __attribute__((packed)) ;		\
+	struct __s *__p = (struct __s *) (ptr);	\
 	__p->__v;				\
 })
 
 #define bt_put_unaligned(val, ptr)		\
 do {						\
-	struct __attribute__((packed)) {	\
+	struct __s {				\
 		typeof(*(ptr)) __v;		\
-	} *__p = (void *) (ptr);		\
+	}__attribute__((packed)) ;		\
+	struct __s *__p = (struct __s *) (ptr);	\
 	__p->__v = (val);			\
 } while(0)
 
-- 
on behalf of ST-Ericsson

