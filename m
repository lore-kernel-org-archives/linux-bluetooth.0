Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 5/8] android/ipc-tester: Add sending test data with ipc
Date: Thu, 16 Jan 2014 09:38:29 +0100
Message-Id: <1389861512-2326-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1389861512-2326-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389861512-2326-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds some data structures used to send data with ipc during test setup
and run stage.
---
 android/ipc-tester.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index 6ba6e1f..0a04fb7 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -55,6 +55,18 @@ struct test_data {
 	bool setup_done;
 };
 
+struct ipc_data {
+	void *buffer;
+	size_t len;
+};
+
+struct generic_data {
+	struct ipc_data ipc_data;
+
+	unsigned int num_services;
+	int init_services[];
+};
+
 #define CONNECT_TIMEOUT (5 * 1000)
 #define SERVICE_NAME "bluetoothd"
 
@@ -453,6 +465,13 @@ static void teardown(const void *data)
 
 static void ipc_send_tc(const void *data)
 {
+	const struct generic_data *generic_data = data;
+	const struct ipc_data *ipc_data = &generic_data->ipc_data;
+
+	if (ipc_data->len) {
+		if (write(cmd_sk, ipc_data->buffer, ipc_data->len) < 0)
+			tester_test_failed();
+	}
 }
 
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
@@ -467,13 +486,22 @@ static void ipc_send_tc(const void *data)
 							3, user, g_free); \
 	} while (0)
 
+static const struct generic_data dummy_data = {
+	.ipc_data = {
+		.buffer = "",
+		.len = 1,
+	},
+	.init_services = {HAL_SERVICE_ID_BLUETOOTH},
+	.num_services = 1,
+};
+
 int main(int argc, char *argv[])
 {
 	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
 
 	tester_init(&argc, &argv);
 
-	test_bredrle("Test Dummy", NULL, setup, ipc_send_tc, teardown);
+	test_bredrle("Test Dummy", &dummy_data, setup, ipc_send_tc, teardown);
 
 	return tester_run();
 }
-- 
1.8.5.2

