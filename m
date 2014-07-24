Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 04/14] android/tester-ng: Add socket listen - invalid param cases
Date: Thu, 24 Jul 2014 10:37:57 +0200
Message-Id: <1406191087-5831-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-main.h   | 14 +++++++++++
 android/tester-socket.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/android/tester-main.h b/android/tester-main.h
index 0f3f165..4c4afce 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -76,6 +76,12 @@
 		.set_data = data_set, \
 	}
 
+#define ACTION(status, act_fun, data_set) { \
+		.action_status = status, \
+		.action = act_fun, \
+		.set_data = data_set, \
+	}
+
 #define CALLBACK_STATE(cb, cb_res) { \
 		.callback = cb, \
 		.callback_result.state = cb_res, \
@@ -218,6 +224,14 @@ struct bt_action_data {
 	uint8_t pin_len;
 	uint8_t ssp_variant;
 	bool accept;
+
+	/* Socket HAL specific params */
+	btsock_type_t sock_type;
+	int channel;
+	const uint8_t *service_uuid;
+	const char *service_name;
+	int flags;
+	int *fd;
 };
 
 /*
diff --git a/android/tester-socket.c b/android/tester-socket.c
index fd0f035..4ab8d7e 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -15,14 +15,79 @@
  *
  */
 
+#include <fcntl.h>
+
 #include "tester-main.h"
 
+#include "src/shared/util.h"
+
 static struct queue *list; /* List of socket test cases */
 
+static bt_bdaddr_t bdaddr_dummy = {
+	.address = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55}
+};
+
+static int got_fd_result = -1;
+
+static struct bt_action_data btsock_param_socktype_0 = {
+	.addr = &bdaddr_dummy,
+	.sock_type = 0,
+	.channel = 1,
+	.service_uuid = NULL,
+	.service_name = "Test service",
+	.flags = 0,
+	.fd = &got_fd_result,
+};
+
+static struct bt_action_data btsock_param_socktype_l2cap = {
+	.addr = &bdaddr_dummy,
+	.sock_type = BTSOCK_L2CAP,
+	.channel = 1,
+	.service_uuid = NULL,
+	.service_name = "Test service",
+	.flags = 0,
+	.fd = &got_fd_result,
+};
+
+static void socket_listen_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	*action_data->fd = -1;
+
+	step->action_status = data->if_sock->listen(action_data->sock_type,
+						action_data->service_name,
+						action_data->service_uuid,
+						action_data->channel,
+						action_data->fd,
+						action_data->flags);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Socket Init",
 		ACTION_SUCCESS(dummy_action, NULL),
 	),
+	TEST_CASE_BREDRLE("Socket Listen - Invalid: sock_type 0",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION(BT_STATUS_PARM_INVALID, socket_listen_action,
+						&btsock_param_socktype_0),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDRLE("Socket Listen - Invalid: sock_type L2CAP",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION(BT_STATUS_UNSUPPORTED, socket_listen_action,
+						&btsock_param_socktype_l2cap),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_socket_tests(void)
-- 
1.9.1

