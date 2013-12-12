Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] android/tester: Check that fd is valid for Success case
Date: Thu, 12 Dec 2013 17:17:48 +0200
Message-Id: <1386861474-29524-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For the successful test case check that file descriptor is valid through
fcntl which is cheap way.
---
 android/android-tester.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 3f763d8..2bb7d73 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -17,6 +17,7 @@
 
 #include <stdlib.h>
 #include <unistd.h>
+#include <fcntl.h>
 
 #include <glib.h>
 #include <sys/socket.h>
@@ -757,6 +758,12 @@ static void test_generic_listen(const void *test_data)
 		goto clean;
 	}
 
+	/* Check that file descriptor is valid */
+	if (status == BT_STATUS_SUCCESS && fcntl(sock_fd, F_GETFD) == -1) {
+		tester_test_failed();
+		return;
+	}
+
 	tester_test_passed();
 
 clean:
-- 
1.8.3.2

