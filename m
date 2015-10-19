Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 1/4] shared: Make new0 abort on failure
Date: Mon, 19 Oct 2015 22:30:55 +0200
Message-Id: <1445286658-11969-2-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1445286658-11969-1-git-send-email-szymon.janc@codecoup.pl>
References: <1445286658-11969-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

New is used to allocate small (typically much less than 1 page) and if
such allocation fails system is most likely in state where recovery is
unlikely. Also by default Linux follows an optimistic memory allocation
strategy with OOM killer.

Aborting on allocationg failure allows to significantly simplify error
paths (which were most likely never tested anyway) and thus makes code
easier to understand.

btd_malloc name is used as malloc wrapper so that it can be exported
by bluetoothd and used also in external plugins.
---
 src/shared/util.c | 16 ++++++++++++++++
 src/shared/util.h | 14 +++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index a70c709..7878552 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -37,6 +37,22 @@
 
 #include "src/shared/util.h"
 
+void *btd_malloc(size_t size)
+{
+	if (__builtin_expect(!!size, 1)) {
+		void *ptr;
+
+		ptr = malloc(size);
+		if (ptr)
+			return ptr;
+
+		fprintf(stderr, "failed to allocate %zu bytes\n", size);
+		abort();
+	}
+
+	return NULL;
+}
+
 void util_debug(util_debug_func_t function, void *user_data,
 						const char *format, ...)
 {
diff --git a/src/shared/util.h b/src/shared/util.h
index 65f5359..ff705d0 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -25,6 +25,7 @@
 #include <stdlib.h>
 #include <alloca.h>
 #include <byteswap.h>
+#include <string.h>
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define le16_to_cpu(val) (val)
@@ -78,10 +79,21 @@ do {						\
 #define PTR_TO_INT(p) ((int) ((intptr_t) (p)))
 #define INT_TO_PTR(u) ((void *) ((intptr_t) (u)))
 
-#define new0(t, n) ((t*) calloc((n), sizeof(t)))
+#define new0(type, count)			\
+	(type *) (__extension__ ({		\
+		size_t __n = (size_t) (count);	\
+		size_t __s = sizeof(type);	\
+		void *__p;			\
+		__p = btd_malloc(__n * __s);	\
+		memset(__p, 0, __n * __s);	\
+		__p;				\
+	}))
+
 #define newa(t, n) ((t*) alloca(sizeof(t)*(n)))
 #define malloc0(n) (calloc((n), 1))
 
+void *btd_malloc(size_t size);
+
 typedef void (*util_debug_func_t)(const char *str, void *user_data);
 
 void util_debug(util_debug_func_t function, void *user_data,
-- 
2.5.0

