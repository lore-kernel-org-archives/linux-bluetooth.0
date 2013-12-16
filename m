Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/tester: Add Socket test invalid chan and uuid
Date: Mon, 16 Dec 2013 10:38:56 +0200
Message-Id: <1387183137-19439-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387183137-19439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387183137-19439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

At least one of parameters: channel or uuid shouldn't be zero.
---
 android/android-tester.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 9b56616..9acc79d 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -804,6 +804,7 @@ static const struct socket_data btsock_inv_param_socktype_l2cap = {
 
 /* Test invalid: channel & uuid are both zeroes */
 static const struct socket_data btsock_inv_params_chan_uuid = {
+	.bdaddr = &bdaddr_dummy,
 	.sock_type = BTSOCK_RFCOMM,
 	.channel = 0,
 	.service_uuid = NULL,
@@ -1070,5 +1071,9 @@ int main(int argc, char *argv[])
 			&btsock_inv_param_socktype_l2cap,
 			setup_socket_interface, test_generic_connect, teardown);
 
+	test_bredrle("Socket Connect - Invalid: chan, uuid",
+			&btsock_inv_params_chan_uuid,
+			setup_socket_interface, test_generic_connect, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

