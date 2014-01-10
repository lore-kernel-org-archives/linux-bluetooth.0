Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 13/19] tools/rfcomm-tester: Add Connection refused client test case
Date: Fri, 10 Jan 2014 10:18:23 +0100
Message-Id: <1389345509-27206-14-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will test RFCOMM client connection to wrong server channel.
---
 tools/rfcomm-tester.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 271f554..f471c3b 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -262,6 +262,12 @@ const struct rfcomm_client_data connect_success = {
 	.client_channel = 0x0c
 };
 
+const struct rfcomm_client_data connect_nval = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0e,
+	.expected_connect_err = -ECONNREFUSED
+};
+
 static void test_basic(const void *test_data)
 {
 	int sk;
@@ -399,6 +405,8 @@ int main(int argc, char *argv[])
 					setup_powered_client, test_basic);
 	test_rfcomm("Basic RFCOMM Socket Client - Success", &connect_success,
 					setup_powered_client, test_connect);
+	test_rfcomm("Basic RFCOMM Socket Client - Conn Refused",
+			&connect_nval, setup_powered_client, test_connect);
 
 	return tester_run();
 }
-- 
1.8.3.1

