Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/tester: Add test Connect returns valid fd
Date: Fri, 20 Dec 2013 14:09:53 +0200
Message-Id: <1387541393-2669-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387541393-2669-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387541393-2669-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The case is analog for similar test case with listen().
---
 android/android-tester.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 4148c0e..fa65416 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1101,12 +1101,14 @@ static const struct socket_data btsock_inv_params_chan_uuid = {
 };
 
 static const struct socket_data btsock_success = {
+	.bdaddr = &bdaddr_dummy,
 	.sock_type = BTSOCK_RFCOMM,
 	.channel = 1,
 	.service_uuid = NULL,
 	.service_name = "Test service",
 	.flags = 0,
 	.expected_status = BT_STATUS_SUCCESS,
+	.test_channel = false
 };
 
 static const struct socket_data btsock_success_check_chan = {
@@ -1619,6 +1621,10 @@ int main(int argc, char *argv[])
 			&btsock_inv_listen_listen,
 			setup_socket_interface, test_listen_listen, teardown);
 
+	test_bredrle("Socket Connect - Check returned fd valid",
+			&btsock_success, setup_socket_interface,
+			test_generic_connect, teardown);
+
 	test_bredrle("Socket Connect - Invalid: sock_type 0",
 			&btsock_inv_param_socktype, setup_socket_interface,
 			test_generic_connect, teardown);
-- 
1.8.3.2

