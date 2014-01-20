Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 05/11] android/ipc-tester: Add sending test data with ipc
Date: Mon, 20 Jan 2014 10:36:04 +0100
Message-Id: <1390210570-28260-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds some data structures used to send data with ipc during
test setup and run stage. Test execution macro is extended for easy
data preparation.
---
 android/ipc-tester.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index b6f8131..7cd50f5 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -55,6 +55,23 @@ struct test_data {
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
+struct regmod_msg {
+	struct hal_hdr header;
+	struct hal_cmd_register_module cmd;
+} __attribute__((packed));
+
 #define CONNECT_TIMEOUT (5 * 1000)
 #define SERVICE_NAME "bluetoothd"
 
@@ -460,27 +477,64 @@ static void teardown(const void *data)
 
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
 
-#define test_generic(name, data, test_setup, test, test_teardown) \
+#define service_data(args...) { args }
+
+#define gen_data(writelen, writebuf, servicelist...) \
+	{								\
+		.ipc_data = {						\
+			.buffer = writebuf,				\
+			.len = writelen,				\
+		},							\
+		.init_services = service_data(servicelist),		\
+		.num_services = sizeof((const int[])			\
+					service_data(servicelist)) /	\
+					sizeof(int),			\
+	}
+
+#define test_generic(name, test, setup, teardown, buffer, writelen, \
+							services...) \
 	do {								\
 		struct test_data *user;					\
+		static const struct generic_data data =			\
+				gen_data(writelen, buffer, services);	\
 		user = g_malloc0(sizeof(struct test_data));		\
 		if (!user)						\
 			break;						\
 		user->hciemu_type = HCIEMU_TYPE_BREDRLE;		\
-		tester_add_full(name, data, test_pre_setup, test_setup,	\
-				test, test_teardown, test_post_teardown,\
+		tester_add_full(name, &data, test_pre_setup, setup,	\
+				test, teardown, test_post_teardown,	\
 				3, user, g_free);			\
 	} while (0)
 
+struct regmod_msg register_bt_msg = {
+	.header = {
+		.service_id = HAL_SERVICE_ID_CORE,
+		.opcode = HAL_OP_REGISTER_MODULE,
+		.len = sizeof(struct hal_cmd_register_module),
+		},
+	.cmd = {
+		.service_id = HAL_SERVICE_ID_BLUETOOTH,
+		},
+};
+
 int main(int argc, char *argv[])
 {
 	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
 
 	tester_init(&argc, &argv);
 
-	test_generic("Test Dummy", NULL, setup, ipc_send_tc, teardown);
+	test_generic("Too small data",
+				ipc_send_tc, setup, teardown,
+				&register_bt_msg, 1);
 
 	return tester_run();
 }
-- 
1.8.5.2

