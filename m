Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] tools/rfcomm-tester: Add bind after connected test case
Date: Thu, 13 Feb 2014 15:11:23 +0100
Message-ID: <1392300683-13835-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This testcase will check if it's possible to bind socket on the same
channel number as used by some other socket connected to remote device.
---
 tools/rfcomm-tester.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 44df7e7..c6aa8c7 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -56,6 +56,7 @@ struct test_data {
 struct rfcomm_client_data {
 	uint8_t server_channel;
 	uint8_t client_channel;
+	uint8_t bind_channel;
 	int expected_connect_err;
 };
 
@@ -300,6 +301,12 @@ const struct rfcomm_client_data connect_nval = {
 	.expected_connect_err = -ECONNREFUSED
 };
 
+const struct rfcomm_client_data connect_bind_success = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c,
+	.bind_channel = 0x0c
+};
+
 const struct rfcomm_server_data listen_success = {
 	.server_channel = 0x0c,
 	.client_channel = 0x0c,
@@ -371,6 +378,7 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 {
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_client_data *client_data = data->test_data;
+	const uint8_t *master_addr;
 	socklen_t len = sizeof(int);
 	int sk, err, sk_err;
 
@@ -389,10 +397,24 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 		return false;
 	}
 
-	if (err < 0)
+	if (!client_data->bind_channel) {
+		if (err < 0)
+			tester_test_failed();
+		else
+			tester_test_passed();
+		return false;
+	}
+
+	master_addr = hciemu_get_master_bdaddr(data->hciemu);
+	sk = create_rfcomm_sock((bdaddr_t *) master_addr,
+						client_data->bind_channel);
+	if (sk < 0) {
 		tester_test_failed();
-	else
+	} else {
+		close(sk);
 		tester_test_passed();
+	}
+
 
 	return false;
 }
@@ -546,6 +568,9 @@ int main(int argc, char *argv[])
 					setup_powered_server, test_server);
 	test_rfcomm("Basic RFCOMM Socket Server - Conn Refused", &listen_nval,
 					setup_powered_server, test_server);
+	test_rfcomm("Basic RFCOMM Socket Server - Bind Connected",
+			&connect_bind_success, setup_powered_client,
+								test_connect);
 
 	return tester_run();
 }
-- 
1.8.5.4

