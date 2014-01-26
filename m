Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] shared: Fix undefined behavior when calculating next power of two
Date: Sat, 25 Jan 2014 21:34:21 -0400
Message-Id: <1390700061-18666-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1390700061-18666-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390700061-18666-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to GCC documentation, __builtin_clz() is undefined if argument
is zero. The following problem was detected when compiling with -O0:

ERROR:unit/test-ringbuf.c:70:test_power2: assertion failed: (size1 ==
size2)

Also refactor align_power2() so the internal "find last set bit"
operation is in its own fls() function (similar to how kernel does).
fls() checks if argument is zero before calling __builtin_clz().
---
 src/shared/ringbuf.c | 9 ++++++++-
 unit/test-ringbuf.c  | 7 ++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/shared/ringbuf.c b/src/shared/ringbuf.c
index 3e5c7d3..f9c4376 100644
--- a/src/shared/ringbuf.c
+++ b/src/shared/ringbuf.c
@@ -48,9 +48,16 @@ struct ringbuf {
 
 #define RINGBUF_RESET 0
 
+/* Find last (most siginificant) set bit */
+static inline unsigned int fls(unsigned int x)
+{
+	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
+}
+
+/* Round up to nearest power of two */
 static inline unsigned int align_power2(unsigned int u)
 {
-	return 1 << ((sizeof(u) * 8) - __builtin_clz(u - 1));
+	return 1 << fls(u - 1);
 }
 
 struct ringbuf *ringbuf_new(size_t size)
diff --git a/unit/test-ringbuf.c b/unit/test-ringbuf.c
index e63321c..75be3a3 100644
--- a/unit/test-ringbuf.c
+++ b/unit/test-ringbuf.c
@@ -45,9 +45,14 @@ static unsigned int nlpo2(unsigned int x)
 	return x + 1;
 }
 
+static unsigned int fls(unsigned int x)
+{
+	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
+}
+
 static unsigned int align_power2(unsigned int u)
 {
-	return 1 << ((sizeof(u) * 8) - __builtin_clz(u - 1));
+	return 1 << fls(u - 1);
 }
 
 static void test_power2(void)
-- 
1.8.3.2

