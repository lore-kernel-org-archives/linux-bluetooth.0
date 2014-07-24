Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 10/14] android/tester-ng: Add various socket connect fail cases
Date: Thu, 24 Jul 2014 10:38:03 +0200
Message-Id: <1406191087-5831-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thiose test verifies socket porofile behaviour in case of invalid
parameters passed to 'connect' command.
---
 android/tester-socket.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/android/tester-socket.c b/android/tester-socket.c
index 1ccd29b..b49f230 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -69,6 +69,16 @@ static struct bt_action_data btsock_param = {
 	.fd = &got_fd_result,
 };
 
+static struct bt_action_data btsock_param_inv_bdaddr = {
+	.addr = NULL,
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
@@ -88,6 +98,25 @@ static void socket_listen_action(void)
 	schedule_action_verification(step);
 }
 
+static void socket_connect_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	*action_data->fd = -1;
+
+	step->action_status = data->if_sock->connect(action_data->addr,
+						action_data->sock_type,
+						action_data->service_uuid,
+						action_data->channel,
+						action_data->fd,
+						action_data->flags);
+
+	schedule_action_verification(step);
+}
+
 static void socket_verify_fd_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -227,6 +256,38 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Socket Connect - Invalid: sock_type 0",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION(BT_STATUS_PARM_INVALID, socket_connect_action,
+						&btsock_param_socktype_0),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDRLE("Socket Connect - Invalid: sock_type L2CAP",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION(BT_STATUS_UNSUPPORTED, socket_connect_action,
+						&btsock_param_socktype_l2cap),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDRLE("Socket Connect - Invalid: chan, uuid",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION(BT_STATUS_PARM_INVALID, socket_connect_action,
+						&btsock_param_channel_0),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDRLE("Socket Connect - Invalid: bdaddr",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION(BT_STATUS_PARM_INVALID, socket_connect_action,
+						&btsock_param_inv_bdaddr),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_socket_tests(void)
-- 
1.9.1

