Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 06/14] android/tester-ng: Add socket listen - verify fd case
Date: Thu, 24 Jul 2014 10:37:59 +0200
Message-Id: <1406191087-5831-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-socket.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/android/tester-socket.c b/android/tester-socket.c
index 7f39200..e01e0b9 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -59,6 +59,16 @@ static struct bt_action_data btsock_param_channel_0 = {
 	.fd = &got_fd_result,
 };
 
+static struct bt_action_data btsock_param = {
+	.addr = &bdaddr_dummy,
+	.sock_type = BTSOCK_RFCOMM,
+	.channel = 1,
+	.service_uuid = NULL,
+	.service_name = "Test service",
+	.flags = 0,
+	.fd = &got_fd_result,
+};
+
 static void socket_listen_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -78,6 +88,25 @@ static void socket_listen_action(void)
 	schedule_action_verification(step);
 }
 
+static void socket_verify_fd_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	if (!*action_data->fd) {
+		step->action_status = BT_STATUS_FAIL;
+		goto done;
+	}
+
+	step->action_status = (fcntl(*action_data->fd, F_GETFD) < 0) ?
+					BT_STATUS_FAIL : BT_STATUS_SUCCESS;
+
+done:
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Socket Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -106,6 +135,14 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Socket Listen - Check returned fd valid",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(socket_listen_action, &btsock_param),
+		ACTION_SUCCESS(socket_verify_fd_action, &btsock_param),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_socket_tests(void)
-- 
1.9.1

