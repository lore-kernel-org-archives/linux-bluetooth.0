Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] android/ipc-tester: Register services
Date: Mon, 13 Jan 2014 11:37:01 +0100
Message-Id: <1389609422-21200-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1389609422-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389609422-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds basic bluetooth service registration during setup procedure.
Without this daemon would reject commands for not registered services.

---
 android/ipc-negative-tester.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/android/ipc-negative-tester.c b/android/ipc-negative-tester.c
index 46a8754..7b2bbf8 100644
--- a/android/ipc-negative-tester.c
+++ b/android/ipc-negative-tester.c
@@ -404,13 +404,53 @@ failed:
 	return false;
 }
 
+struct regmod_msg {
+	struct hal_hdr header;
+	struct hal_cmd_register_module cmd;
+};
+
+static bool setup_module(int service_id)
+{
+	struct hal_hdr response;
+	struct hal_hdr expected_response;
+
+	struct regmod_msg btmodule_msg = {
+		.header = {
+			.service_id = HAL_SERVICE_ID_CORE,
+			.opcode = HAL_OP_REGISTER_MODULE,
+			.len = sizeof(struct hal_cmd_register_module),
+			},
+		.cmd = {
+			.service_id = service_id,
+			},
+	};
+
+	if (write(cmd_sk, &btmodule_msg, sizeof(btmodule_msg)) < 0)
+		goto fail;
+
+	if (read(cmd_sk, &response, sizeof(response)) < 0)
+		goto fail;
+
+	expected_response = btmodule_msg.header;
+	expected_response.len = 0;
+
+	if (memcmp(&response, &expected_response, sizeof(response)) == 0)
+		return true;
+
+fail:
+	tester_warn("Module registration failed.");
+	return false;
+}
+
 static void setup(const void *data)
 {
+	const struct generic_data *generic_data = data;
 	struct test_data *test_data = tester_get_data();
 	int signal_fd[2];
 	char buf[1024];
 	pid_t pid;
 	int len;
+	unsigned int i;
 
 	if (pipe(signal_fd)) {
 		tester_setup_failed();
@@ -454,9 +494,15 @@ static void setup(const void *data)
 		return;
 	}
 
-	/* TODO: register modules */
+	tester_print("Will init %d services.", generic_data->num_services);
+
+	for (i = 0; i < generic_data->num_services; i++)
+		if (!setup_module(generic_data->init_services[i]))
+			tester_setup_failed();
 
 	test_data->setup_done = true;
+
+	tester_setup_complete();
 }
 
 static void teardown(const void *data)
-- 
1.8.5

