Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] android/tester: trivial: Make test cases prints look nice
Date: Thu, 12 Dec 2013 17:17:49 +0200
Message-Id: <1386861474-29524-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/android-tester.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 2bb7d73..bb3f883 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -804,11 +804,11 @@ int main(int argc, char *argv[])
 	test_bredrle("Test Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-	test_bredrle("Test Socket Listen - Invalid sock type",
+	test_bredrle("Test Socket Listen - Invalid: sock_type 0",
 			&btsock_inv_param_socktype, setup_socket_interface,
 			test_generic_listen, teardown);
 
-	test_bredrle("Test Socket Listen - Invalid: L2CAP",
+	test_bredrle("Test Socket Listen - Invalid: sock_type L2CAP",
 			&btsock_inv_param_socktype_l2cap,
 			setup_socket_interface, test_generic_listen, teardown);
 
-- 
1.8.3.2

