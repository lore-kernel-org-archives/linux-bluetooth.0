Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/5] unit/test-ringbuf: Use tester framework
Date: Tue, 19 May 2015 20:31:00 +0530
Message-id: <1432047664-23655-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
References: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-ringbuf.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/unit/test-ringbuf.c b/unit/test-ringbuf.c
index e28e04b..a97524e 100644
--- a/unit/test-ringbuf.c
+++ b/unit/test-ringbuf.c
@@ -32,6 +32,7 @@
 #include <glib.h>
 
 #include "src/shared/ringbuf.h"
+#include "src/shared/tester.h"
 
 static unsigned int nlpo2(unsigned int x)
 {
@@ -54,7 +55,7 @@ static unsigned int align_power2(unsigned int u)
 	return 1 << fls(u - 1);
 }
 
-static void test_power2(void)
+static void test_power2(const void *data)
 {
 	size_t i;
 
@@ -68,25 +69,25 @@ static void test_power2(void)
 		while (size3 < i && size3 < SIZE_MAX)
 			size3 <<= 1;
 
-		if (g_test_verbose())
-			g_print("%zu -> size1=%zu size2=%zu size3=%zu\n",
+		tester_debug("%zu -> size1=%zu size2=%zu size3=%zu\n",
 						i, size1, size2, size3);
 
 		g_assert(size1 == size2);
 		g_assert(size2 == size3);
 		g_assert(size3 == size1);
 	}
+
+	tester_test_passed();
 }
 
-static void test_alloc(void)
+static void test_alloc(const void *data)
 {
 	int i;
 
 	for (i = 2; i < 10000; i++) {
 		struct ringbuf *rb;
 
-		if (g_test_verbose())
-			g_print("Iteration %i\n", i);
+		tester_debug("Iteration %i\n", i);
 
 		rb = ringbuf_new(i);
 		g_assert(rb != NULL);
@@ -95,9 +96,11 @@ static void test_alloc(void)
 
 		ringbuf_free(rb);
 	}
+
+	tester_test_passed();
 }
 
-static void test_printf(void)
+static void test_printf(const void *data)
 {
 	static size_t rb_size = 500;
 	static size_t rb_capa = 512;
@@ -115,8 +118,7 @@ static void test_printf(void)
 		if (!count)
 			continue;
 
-		if (g_test_verbose())
-			g_print("Iteration %i\n", i);
+		tester_debug("Iteration %i\n", i);
 
 		len = asprintf(&str, "%*c", (int) count, 'x');
 		g_assert(len == count);
@@ -140,15 +142,16 @@ static void test_printf(void)
 	}
 
 	ringbuf_free(rb);
+	tester_test_passed();
 }
 
 int main(int argc, char *argv[])
 {
-	g_test_init(&argc, &argv, NULL);
+	tester_init(&argc, &argv);
 
-	g_test_add_func("/ringbuf/power2", test_power2);
-	g_test_add_func("/ringbuf/alloc", test_alloc);
-	g_test_add_func("/ringbuf/printf", test_printf);
+	tester_add("/ringbuf/power2", NULL, NULL, test_power2, NULL);
+	tester_add("/ringbuf/alloc", NULL, NULL, test_alloc, NULL);
+	tester_add("/ringbuf/printf", NULL, NULL, test_printf, NULL);
 
-	return g_test_run();
+	return tester_run();
 }
-- 
1.9.1

