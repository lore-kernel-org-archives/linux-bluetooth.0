Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 05/14] android/tester-ng: Add socket listen - invalid channel case
Date: Thu, 24 Jul 2014 10:37:58 +0200
Message-Id: <1406191087-5831-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-socket.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/tester-socket.c b/android/tester-socket.c
index 4ab8d7e..7f39200 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -49,6 +49,16 @@ static struct bt_action_data btsock_param_socktype_l2cap = {
 	.fd = &got_fd_result,
 };
 
+static struct bt_action_data btsock_param_channel_0 = {
+	.addr = &bdaddr_dummy,
+	.sock_type = BTSOCK_RFCOMM,
+	.channel = 0,
+	.service_uuid = NULL,
+	.service_name = "Test service",
+	.flags = 0,
+	.fd = &got_fd_result,
+};
+
 static void socket_listen_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -88,6 +98,14 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Socket Listen - Invalid: chan, uuid",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION(BT_STATUS_PARM_INVALID, socket_listen_action,
+						&btsock_param_channel_0),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_socket_tests(void)
-- 
1.9.1

