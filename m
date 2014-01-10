Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 19/19] tools/rfcomm-tester: Add RFCOMM server negative test case
Date: Fri, 10 Jan 2014 10:18:29 +0100
Message-Id: <1389345509-27206-20-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test case create RFCOMM server and reject incoming connection
from bthost.
---
 tools/rfcomm-tester.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 72e765f..7997a4b 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -311,6 +311,12 @@ const struct rfcomm_server_data listen_success = {
 	.expected_status = true
 };
 
+const struct rfcomm_server_data listen_nval = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0e,
+	.expected_status = false
+};
+
 static void test_basic(const void *test_data)
 {
 	int sk;
@@ -551,6 +557,8 @@ int main(int argc, char *argv[])
 			&connect_nval, setup_powered_client, test_connect);
 	test_rfcomm("Basic RFCOMM Socket Server - Success", &listen_success,
 					setup_powered_server, test_server);
+	test_rfcomm("Basic RFCOMM Socket Server - Conn Refused", &listen_nval,
+					setup_powered_server, test_server);
 
 	return tester_run();
 }
-- 
1.8.3.1

