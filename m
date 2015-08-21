Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] shared/tester: Add valgrind support
Date: Fri, 21 Aug 2015 17:01:44 +0300
Message-Id: <1440165704-6885-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1440165704-6885-1-git-send-email-luiz.dentz@gmail.com>
References: <1440165704-6885-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add a call to VALGRIND_DO_ADDED_LEAK_CHECK at the end of each test.
---
 src/shared/tester.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 30857e0..c3120fb 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -35,6 +35,10 @@
 
 #include <glib.h>
 
+#ifdef HAVE_VALGRIND_MEMCHECK_H
+#include <valgrind/memcheck.h>
+#endif
+
 #include "src/shared/util.h"
 #include "src/shared/tester.h"
 
@@ -339,6 +343,10 @@ static gboolean teardown_callback(gpointer user_data)
 	print_progress(test->name, COLOR_MAGENTA, "teardown");
 	test->teardown_func(test->test_data);
 
+#ifdef HAVE_VALGRIND_MEMCHECK_H
+	VALGRIND_DO_ADDED_LEAK_CHECK;
+#endif
+
 	return FALSE;
 }
 
-- 
2.4.3

