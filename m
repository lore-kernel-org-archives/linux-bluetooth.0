Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 7/7] android/tester: Add Socket listen() invalid L2CAP socket type
Date: Thu, 12 Dec 2013 14:48:34 +0200
Message-Id: <1386852514-17270-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386852514-17270-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386852514-17270-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check that we get BT_STATUS_UNSUPPORTED for socket type BTSOCK_L2CAP.
---
 android/android-tester.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index f5df0df..a50ed7b 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -707,6 +707,15 @@ static const struct socket_data btsock_inv_param_socktype = {
 	.expected_status = BT_STATUS_PARM_INVALID,
 };
 
+static const struct socket_data btsock_inv_param_socktype_l2cap = {
+	.sock_type = BTSOCK_L2CAP,
+	.channel = 1,
+	.service_uuid = NULL,
+	.service_name = "Test service",
+	.flags = 0,
+	.expected_status = BT_STATUS_UNSUPPORTED,
+};
+
 static void setup_socket_interface(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -782,5 +791,9 @@ int main(int argc, char *argv[])
 			&btsock_inv_param_socktype, setup_socket_interface,
 			test_generic_listen, teardown);
 
+	test_bredrle("Test Socket Listen - Invalid: L2CAP",
+			&btsock_inv_param_socktype_l2cap,
+			setup_socket_interface, test_generic_listen, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

