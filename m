Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] android/tester: Add Socket test connect invalid sock_type L2CAP
Date: Thu, 12 Dec 2013 17:17:53 +0200
Message-Id: <1386861474-29524-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/android-tester.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index a6fbcb5..7518f98 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -715,6 +715,7 @@ static const struct socket_data btsock_inv_param_socktype = {
 };
 
 static const struct socket_data btsock_inv_param_socktype_l2cap = {
+	.bdaddr = &bdaddr_dummy,
 	.sock_type = BTSOCK_L2CAP,
 	.channel = 1,
 	.service_uuid = NULL,
@@ -867,5 +868,9 @@ int main(int argc, char *argv[])
 			&btsock_inv_param_socktype, setup_socket_interface,
 			test_generic_connect, teardown);
 
+	test_bredrle("Test Socket Connect - Invalid: sock_type L2CAP",
+			&btsock_inv_param_socktype_l2cap,
+			setup_socket_interface, test_generic_connect, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

