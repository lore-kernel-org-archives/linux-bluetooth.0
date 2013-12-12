Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] android/tester: Add Socket test success with valid fd
Date: Thu, 12 Dec 2013 17:17:50 +0200
Message-Id: <1386861474-29524-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check that Socket listen() returns valid file descriptor
---
 android/android-tester.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index bb3f883..4a96fb8 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -727,6 +727,15 @@ static const struct socket_data btsock_inv_params_chan_uuid = {
 	.expected_status = BT_STATUS_PARM_INVALID,
 };
 
+static const struct socket_data btsock_sucess = {
+	.sock_type = BTSOCK_RFCOMM,
+	.channel = 1,
+	.service_uuid = NULL,
+	.service_name = "Test service",
+	.flags = 0,
+	.expected_status = BT_STATUS_SUCCESS,
+};
+
 static void setup_socket_interface(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -816,5 +825,9 @@ int main(int argc, char *argv[])
 			&btsock_inv_params_chan_uuid,
 			setup_socket_interface, test_generic_listen, teardown);
 
+	test_bredrle("Test Socket Listen - Check returned fd valid",
+			&btsock_sucess,
+			setup_socket_interface, test_generic_listen, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

