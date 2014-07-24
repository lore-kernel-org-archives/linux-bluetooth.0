Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 13/14] android/tester-ng: Add socket connect success cases
Date: Thu, 24 Jul 2014 10:38:06 +0200
Message-Id: <1406191087-5831-13-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adding socket connect cases requires to set up the the l2cap and
rfcomm servers on the emulated device. For this, the bthost_l2cap_connect_cb
type had to exposed in tester-main.h and pulled some bthost dependencies
along.
---
 android/tester-bluetooth.c |   2 +
 android/tester-gatt.c      |   3 +
 android/tester-hidhost.c   |   3 +
 android/tester-main.c      |  62 ++++++++++++++++-
 android/tester-main.h      |   9 +++
 android/tester-socket.c    | 168 ++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 244 insertions(+), 3 deletions(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 11d9039..018d712 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -14,7 +14,9 @@
  * limitations under the License.
  *
  */
+#include <stdbool.h>
 
+#include "emulator/bthost.h"
 #include "tester-main.h"
 
 static struct queue *list; /* List of bluetooth test cases */
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index b85cfc8..bdfbd8b 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -15,6 +15,9 @@
  *
  */
 
+#include <stdbool.h>
+
+#include "emulator/bthost.h"
 #include "tester-main.h"
 
 static struct queue *list; /* List of gatt test cases */
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index a32b0df..59ff01c 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -15,6 +15,9 @@
  *
  */
 
+#include <stdbool.h>
+
+#include "emulator/bthost.h"
 #include "tester-main.h"
 
 static struct queue *list; /* List of hidhost test cases */
diff --git a/android/tester-main.c b/android/tester-main.c
index c868943..3206a54 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -14,10 +14,11 @@
  * limitations under the License.
  *
  */
+#include <stdbool.h>
 
+#include "emulator/bthost.h"
 #include "tester-main.h"
 
-#include "emulator/bthost.h"
 #include "monitor/bt.h"
 
 static char exec_dir[PATH_MAX + 1];
@@ -1119,6 +1120,65 @@ void emu_set_ssp_mode_action(void)
 	schedule_action_verification(step);
 }
 
+void emu_add_l2cap_server_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct emu_set_l2cap_data *l2cap_data = current_data_step->set_data;
+	struct bthost *bthost;
+	struct step *step = g_new0(struct step, 1);
+
+	if (!l2cap_data) {
+		tester_warn("Invalid l2cap_data params");
+		return;
+	}
+
+	bthost = hciemu_client_get_host(data->hciemu);
+
+	bthost_add_l2cap_server(bthost, l2cap_data->psm, l2cap_data->func,
+							l2cap_data->user_data);
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
+static void rfcomm_connect_cb(uint16_t handle, uint16_t cid, void *user_data,
+								bool status)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	tester_print("Connect handle %d, cid %d cb status: %d", handle, cid,
+									status);
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
+void emu_add_rfcomm_server_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *rfcomm_data = current_data_step->set_data;
+	struct bthost *bthost;
+	struct step *step = g_new0(struct step, 1);
+
+	if (!rfcomm_data) {
+		tester_warn("Invalid l2cap_data params");
+		return;
+	}
+
+	bthost = hciemu_client_get_host(data->hciemu);
+
+	bthost_add_rfcomm_server(bthost, rfcomm_data->channel,
+						rfcomm_connect_cb, data);
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
 void dummy_action(void)
 {
 	struct step *step = g_new0(struct step, 1);
diff --git a/android/tester-main.h b/android/tester-main.h
index 4c4afce..1bff9b3 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -234,6 +234,13 @@ struct bt_action_data {
 	int *fd;
 };
 
+/* bthost's l2cap server setup parameters */
+struct emu_set_l2cap_data {
+	uint16_t psm;
+	bthost_l2cap_connect_cb func;
+	void *user_data;
+};
+
 /*
  * Callback data structure should be enhanced with data
  * returned by callbacks. It's used for test case step
@@ -287,6 +294,8 @@ void schedule_action_verification(struct step *step);
 void emu_setup_powered_remote_action(void);
 void emu_set_pin_code_action(void);
 void emu_set_ssp_mode_action(void);
+void emu_add_l2cap_server_action(void);
+void emu_add_rfcomm_server_action(void);
 
 /* Actions */
 void dummy_action(void);
diff --git a/android/tester-socket.c b/android/tester-socket.c
index b49f230..bd067ea 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -16,7 +16,9 @@
  */
 
 #include <fcntl.h>
+#include <stdbool.h>
 
+#include "emulator/bthost.h"
 #include "tester-main.h"
 
 #include "src/shared/util.h"
@@ -79,6 +81,52 @@ static struct bt_action_data btsock_param_inv_bdaddr = {
 	.fd = &got_fd_result,
 };
 
+static bt_bdaddr_t emu_remote_bdaddr_val = {
+	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
+};
+static bt_property_t prop_emu_remote_bdadr = {
+	.type = BT_PROPERTY_BDADDR,
+	.val = &emu_remote_bdaddr_val,
+	.len = sizeof(emu_remote_bdaddr_val),
+};
+static bt_property_t prop_emu_remotes_default_set[] = {
+	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
+						&emu_remote_bdaddr_val },
+};
+
+static struct bt_action_data btsock_param_emu_bdaddr = {
+	.addr = &emu_remote_bdaddr_val,
+	.sock_type = BTSOCK_RFCOMM,
+	.channel = 1,
+	.service_uuid = NULL,
+	.service_name = "Test service",
+	.flags = 0,
+	.fd = &got_fd_result,
+};
+
+static struct emu_set_l2cap_data l2cap_setup_data = {
+	.psm = 0x0003,
+	.func = NULL,
+	.user_data = NULL,
+};
+
+static struct bt_action_data prop_emu_remote_bdaddr_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_BDADDR,
+	.prop = &prop_emu_remote_bdadr,
+};
+
+static bt_property_t prop_emu_remotes_pin_req_set[] = {
+	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
+						&emu_remote_bdaddr_val },
+};
+
+static struct bt_action_data ssp_confirm_accept_reply = {
+	.addr = &emu_remote_bdaddr_val,
+	.ssp_variant = BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+	.accept = TRUE,
+};
+
 static void socket_listen_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -103,18 +151,83 @@ static void socket_connect_action(void)
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct bt_action_data *action_data = current_data_step->set_data;
-	struct step *step = g_new0(struct step, 1);
+	struct step *step;
+	int status;
 
 	*action_data->fd = -1;
 
-	step->action_status = data->if_sock->connect(action_data->addr,
+	status = data->if_sock->connect(action_data->addr,
 						action_data->sock_type,
 						action_data->service_uuid,
 						action_data->channel,
 						action_data->fd,
 						action_data->flags);
 
+	tester_print("status %d sock_fd %d", status, *action_data->fd);
+
+	if (!status)
+		return;
+
+	step = g_new0(struct step, 1);
+	step->action_status = status;
+
+	schedule_action_verification(step);
+}
+
+static gboolean socket_chan_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	int sock_fd = g_io_channel_unix_get_fd(io);
+	struct step *step = g_new0(struct step, 1);
+	int channel, len;
+
+	tester_print("%s", __func__);
+
+	if (cond & G_IO_HUP) {
+		tester_warn("Socket %d hang up", sock_fd);
+
+		step->action_status = BT_STATUS_FAIL;
+		goto done;
+	}
+
+	if (cond & (G_IO_ERR | G_IO_NVAL)) {
+		tester_warn("Socket error: sock %d cond %d", sock_fd, cond);
+
+		step->action_status = BT_STATUS_FAIL;
+		goto done;
+	}
+
+	len = read(sock_fd, &channel, sizeof(channel));
+	if (len != sizeof(channel)) {
+		tester_warn("Socket read failed");
+
+		step->action_status = BT_STATUS_FAIL;
+		goto done;
+	}
+
+	tester_print("read correct channel: %d", channel);
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+done:
 	schedule_action_verification(step);
+	return FALSE;
+}
+
+static void socket_read_fd_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
+	GIOChannel *io;
+
+	io = g_io_channel_unix_new(*action_data->fd);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+							socket_chan_cb, NULL);
+
+	g_io_channel_unref(io);
 }
 
 static void socket_verify_fd_action(void)
@@ -288,6 +401,57 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Socket Connect - Check returned fd valid",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(bt_create_bond_action,
+						&prop_emu_remote_bdaddr_req),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 1),
+		CALLBACK_SSP_REQ(BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+					prop_emu_remotes_pin_req_set, 1),
+		ACTION_SUCCESS(bt_ssp_reply_accept_action,
+						&ssp_confirm_accept_reply),
+		CALLBACK_DEVICE_PROPS(NULL, 0),
+		ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
+		ACTION_SUCCESS(emu_add_rfcomm_server_action,
+						&btsock_param_emu_bdaddr),
+		ACTION_SUCCESS(socket_connect_action, &btsock_param_emu_bdaddr),
+		ACTION_SUCCESS(socket_verify_fd_action,
+						&btsock_param_emu_bdaddr),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDRLE("Socket Connect - Check returned chann",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(bt_create_bond_action,
+						&prop_emu_remote_bdaddr_req),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 1),
+		CALLBACK_SSP_REQ(BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+					prop_emu_remotes_pin_req_set, 1),
+		ACTION_SUCCESS(bt_ssp_reply_accept_action,
+						&ssp_confirm_accept_reply),
+		CALLBACK_DEVICE_PROPS(NULL, 0),
+		ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
+		ACTION_SUCCESS(emu_add_rfcomm_server_action,
+						&btsock_param_emu_bdaddr),
+		ACTION_SUCCESS(socket_connect_action, &btsock_param_emu_bdaddr),
+		ACTION_SUCCESS(socket_verify_fd_action,
+						&btsock_param_emu_bdaddr),
+		ACTION_SUCCESS(socket_verify_channel_action,
+						&btsock_param_emu_bdaddr),
+		ACTION_SUCCESS(socket_read_fd_action, &btsock_param_emu_bdaddr),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_socket_tests(void)
-- 
1.9.1

