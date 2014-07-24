Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 08/14] android/tester-ng: Add socket listen - close than listen case
Date: Thu, 24 Jul 2014 10:38:01 +0200
Message-Id: <1406191087-5831-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This checks for another successfull listen after closing previous fd.
---
 android/tester-socket.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/tester-socket.c b/android/tester-socket.c
index 337e117..5994a3d 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -136,6 +136,29 @@ done:
 	schedule_action_verification(step);
 }
 
+static void socket_close_channel_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	if (!*action_data->fd) {
+		tester_warn("Ups no action_data->fd");
+
+		step->action_status = BT_STATUS_FAIL;
+		goto done;
+	}
+
+	close(*action_data->fd);
+	*action_data->fd = -1;
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+done:
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Socket Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -181,6 +204,19 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Socket Listen - Close and Listen again",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(socket_listen_action, &btsock_param),
+		ACTION_SUCCESS(socket_verify_fd_action, &btsock_param),
+		ACTION_SUCCESS(socket_verify_channel_action, &btsock_param),
+		ACTION_SUCCESS(socket_close_channel_action, &btsock_param),
+		ACTION_SUCCESS(socket_listen_action, &btsock_param),
+		ACTION_SUCCESS(socket_verify_fd_action, &btsock_param),
+		ACTION_SUCCESS(socket_verify_channel_action, &btsock_param),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_socket_tests(void)
-- 
1.9.1

