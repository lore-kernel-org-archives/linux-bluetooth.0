Return-Path: <cyrus@holtmann.org>
Message-ID: <1326708715.3360.135.camel@pohly-mobl1.fritz.box>
Subject: [PATCH] bluetooth.h: fix compile issue when using in C++
From: Patrick Ohly <patrick.ohly@intel.com>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 16 Jan 2012 11:11:55 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The compiler error is:
 /usr/include/bluetooth/bluetooth.h::131:9: error: invalid conversion from 'void*' to 'bt_get_le64(void*)::<anonymous struct>*'
 ...

The reason is that C++, in contrast to C, does not allow conversion of
void * to anything, and this code gets compiled as C++ when the app is
written in C++. The macro with the assignment itself is older, but only
recent Bluez starts to use it in inline functions, thus triggering the
problem.

This patch keeps the "struct __attribute__((packed))" magic and merely
changes the typecast so that it works in C and C++. Like the existing
macro this patch relies on support for typeof.
---
 lib/bluetooth.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 5bd4f03..2fee4ac 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -113,7 +113,7 @@ enum {
 ({						\
 	struct __attribute__((packed)) {	\
 		typeof(*(ptr)) __v;		\
-	} *__p = (void *) (ptr);		\
+	} *__p = (typeof(__p)) (ptr);		\
 	__p->__v;				\
 })
 
@@ -121,7 +121,7 @@ enum {
 do {						\
 	struct __attribute__((packed)) {	\
 		typeof(*(ptr)) __v;		\
-	} *__p = (void *) (ptr);		\
+	} *__p = (typeof(__p)) (ptr);		\
 	__p->__v = (val);			\
 } while(0)
 
-- 
1.7.7.3


