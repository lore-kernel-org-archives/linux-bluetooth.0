Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/tester: Make code consistent using < 0 comparison
Date: Fri, 20 Dec 2013 14:09:52 +0200
Message-Id: <1387541393-2669-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387541393-2669-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387541393-2669-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/android-tester.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index fb95dd2..4148c0e 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1194,7 +1194,7 @@ static void test_generic_listen(const void *test_data)
 	}
 
 	/* Check that file descriptor is valid */
-	if (status == BT_STATUS_SUCCESS && fcntl(sock_fd, F_GETFD) == -1) {
+	if (status == BT_STATUS_SUCCESS && fcntl(sock_fd, F_GETFD) < 0) {
 		tester_test_failed();
 		return;
 	}
@@ -1327,7 +1327,7 @@ static void test_generic_connect(const void *test_data)
 	}
 
 	/* Check that file descriptor is valid */
-	if (status == BT_STATUS_SUCCESS && fcntl(sock_fd, F_GETFD) == -1) {
+	if (status == BT_STATUS_SUCCESS && fcntl(sock_fd, F_GETFD) < 0) {
 		tester_test_failed();
 		return;
 	}
@@ -1462,7 +1462,7 @@ static void test_socket_real_connect(const void *test_data)
 	}
 
 	/* Check that file descriptor is valid */
-	if (status == BT_STATUS_SUCCESS && fcntl(sock_fd, F_GETFD) == -1) {
+	if (status == BT_STATUS_SUCCESS && fcntl(sock_fd, F_GETFD) < 0) {
 		tester_test_failed();
 		return;
 	}
-- 
1.8.3.2

