Return-Path: <cyrus@holtmann.org>
Message-ID: <1328439464.32199.22.camel@pohly-mobl1.fritz.box>
Subject: [PATCH] bluetooth.h: fix compile issue in C++ with ifdef
From: Patrick Ohly <patrick.ohly@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Milan Crha <mcrha@redhat.com>,
 ying.an.deng@intel.com, ulf.hofemeier@intel.com, ning.w.wang@intel.com,
 Tino Keitel <tino.keitel+syncevolution@tikei.de>, Rohan Garg
 <rohan16garg@gmail.com>
Date: Sun, 05 Feb 2012 11:57:44 +0100
In-Reply-To: <1328439363.32199.20.camel@pohly-mobl1.fritz.box>
References: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
	 <1326705845.6454.274.camel@aeonflux>
	 <1326708597.3360.133.camel@pohly-mobl1.fritz.box>
	 <1328439363.32199.20.camel@pohly-mobl1.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

The new variant of the code is in an ifdef and only used for C++
to avoid unexpected regressions in C applications.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bluetooth.h |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 5bd4f03..3293915 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -109,6 +109,11 @@ enum {
 #endif
 
 /* Bluetooth unaligned access */
+#ifndef __cplusplus
+/*
+ * traditional code, doesn't work in C++ because
+ * of the void * to struct pointer assignment
+ */
 #define bt_get_unaligned(ptr)			\
 ({						\
 	struct __attribute__((packed)) {	\
@@ -125,6 +130,31 @@ do {						\
 	__p->__v = (val);			\
 } while(0)
 
+#else /* __cplusplus */
+
+/*
+ * modified code with typeof typecast, for C++;
+ * the traditional code continues to be used for
+ * C to avoid unexpected regressions with this
+ * code here (it should work in C and C++, though)
+ */
+#define bt_get_unaligned(ptr)			\
+({						\
+	struct __attribute__((packed)) {	\
+		typeof(*(ptr)) __v;		\
+	} *__p = (typeof(__p)) (ptr);		\
+	__p->__v;				\
+})
+
+#define bt_put_unaligned(val, ptr)		\
+do {						\
+	struct __attribute__((packed)) {	\
+		typeof(*(ptr)) __v;		\
+	} *__p = (typeof(__p)) (ptr);		\
+	__p->__v = (val);			\
+} while(0)
+#endif /* __cplusplus */
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 static inline uint64_t bt_get_le64(void *ptr)
 {
-- 
1.7.8.3
