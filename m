Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/6] android: Create comon header for IPC
Date: Fri, 28 Feb 2014 14:09:29 +0100
Message-Id: <1393592969-4451-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393592969-4451-1-git-send-email-szymon.janc@tieto.com>
References: <1393592969-4451-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This header contains IPC specific structures and code not related to
BT and audio HAL protocols. This allows to fully decouple IPC from
HAL messages.

This is first step to make HAL part of IPC unit-testable and reusable
between BT HAL and audio HAL.
---
 android/a2dp.c          |  1 +
 android/audio-msg.h     |  7 ++----
 android/bluetooth.c     |  7 +++---
 android/hal-audio.c     |  7 +++---
 android/hal-avrcp.c     | 39 +++++++++++++++++----------------
 android/hal-bluetooth.c |  9 ++++----
 android/hal-handsfree.c |  9 ++++----
 android/hal-hidhost.c   |  5 +++--
 android/hal-ipc.c       | 11 +++++-----
 android/hal-msg.h       | 16 ++------------
 android/handsfree.c     |  1 +
 android/hidhost.c       |  1 +
 android/ipc-common.h    | 38 ++++++++++++++++++++++++++++++++
 android/ipc-tester.c    | 58 +++++++++++++++++++++++++------------------------
 android/ipc.c           | 16 +++++++-------
 android/main.c          |  1 +
 android/pan.c           |  1 +
 android/socket.c        |  2 +-
 android/test-ipc.c      | 56 +++++++++++++++++++++++++----------------------
 19 files changed, 163 insertions(+), 122 deletions(-)
 create mode 100644 android/ipc-common.h

diff --git a/android/a2dp.c b/android/a2dp.c
index 8e27413..180d015 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -40,6 +40,7 @@
 #include "profiles/audio/a2dp-codecs.h"
 #include "src/log.h"
 #include "hal-msg.h"
+#include "ipc-common.h"
 #include "ipc.h"
 #include "a2dp.h"
 #include "utils.h"
diff --git a/android/audio-msg.h b/android/audio-msg.h
index d4fc68a..5981355 100644
--- a/android/audio-msg.h
+++ b/android/audio-msg.h
@@ -28,13 +28,10 @@ static const char BLUEZ_AUDIO_SK_PATH[] = "\0bluez_audio_socket";
 #define AUDIO_SERVICE_ID		0
 #define AUDIO_SERVICE_ID_MAX		AUDIO_SERVICE_ID
 
-#define AUDIO_STATUS_SUCCESS		0x00
+#define AUDIO_STATUS_SUCCESS		IPC_STATUS_SUCCESS
 #define AUDIO_STATUS_FAILED		0x01
 
-#define AUDIO_OP_STATUS			0x00
-struct audio_status {
-	uint8_t code;
-} __attribute__((packed));
+#define AUDIO_OP_STATUS			IPC_OP_STATUS
 
 #define AUDIO_OP_OPEN			0x01
 struct audio_preset {
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 26493f7..8ad7d5d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -46,6 +46,7 @@
 #include "src/sdpd.h"
 #include "src/log.h"
 #include "hal-msg.h"
+#include "ipc-common.h"
 #include "ipc.h"
 #include "utils.h"
 #include "bluetooth.h"
@@ -1062,7 +1063,7 @@ static bool rssi_above_threshold(int old, int new)
 static void update_new_device(struct device *dev, int8_t rssi,
 						const struct eir_data *eir)
 {
-	uint8_t buf[BLUEZ_HAL_MTU];
+	uint8_t buf[IPC_MTU];
 	struct hal_ev_device_found *ev = (void*) buf;
 	bdaddr_t android_bdaddr;
 	uint8_t android_type;
@@ -1115,7 +1116,7 @@ static void update_new_device(struct device *dev, int8_t rssi,
 static void update_device(struct device *dev, int8_t rssi,
 						const struct eir_data *eir)
 {
-	uint8_t buf[BLUEZ_HAL_MTU];
+	uint8_t buf[IPC_MTU];
 	struct hal_ev_remote_device_props *ev = (void *) buf;
 	int size;
 
@@ -1157,7 +1158,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, bool confirm,
 					const uint8_t *data, uint8_t data_len)
 {
-	uint8_t buf[BLUEZ_HAL_MTU];
+	uint8_t buf[IPC_MTU];
 	struct eir_data eir;
 	struct device *dev;
 
diff --git a/android/hal-audio.c b/android/hal-audio.c
index e72e097..e1f3f0d 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -33,6 +33,7 @@
 #include <sbc/sbc.h>
 
 #include "audio-msg.h"
+#include "ipc-common.h"
 #include "hal-log.h"
 #include "hal-msg.h"
 #include "../profiles/audio/a2dp-codecs.h"
@@ -614,9 +615,9 @@ static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 	ssize_t ret;
 	struct msghdr msg;
 	struct iovec iv[2];
-	struct hal_hdr cmd;
+	struct ipc_hdr cmd;
 	char cmsgbuf[CMSG_SPACE(sizeof(int))];
-	struct hal_status s;
+	struct ipc_status s;
 	size_t s_len = sizeof(s);
 
 	pthread_mutex_lock(&sk_mutex);
@@ -708,7 +709,7 @@ static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 	}
 
 	if (cmd.opcode == AUDIO_OP_STATUS) {
-		struct hal_status *s = rsp;
+		struct ipc_status *s = rsp;
 
 		if (sizeof(*s) != cmd.len) {
 			error("audio: Invalid status length");
diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index a11aaa3..46e25a0 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -23,6 +23,7 @@
 #include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
+#include "ipc-common.h"
 #include "hal-ipc.h"
 
 static const btrc_callbacks_t *cbs = NULL;
@@ -252,7 +253,7 @@ static bt_status_t get_play_status_rsp(btrc_play_status_t status,
 static bt_status_t list_player_app_attr_rsp(int num_attr,
 						btrc_player_attr_t *p_attrs)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_avrcp_list_player_attrs *cmd = (void *) buf;
 	size_t len;
 
@@ -265,7 +266,7 @@ static bt_status_t list_player_app_attr_rsp(int num_attr,
 		return BT_STATUS_PARM_INVALID;
 
 	len = sizeof(*cmd) + num_attr;
-	if (len > BLUEZ_HAL_MTU)
+	if (len > IPC_MTU)
 		return BT_STATUS_PARM_INVALID;
 
 	cmd->number = num_attr;
@@ -278,7 +279,7 @@ static bt_status_t list_player_app_attr_rsp(int num_attr,
 
 static bt_status_t list_player_app_value_rsp(int num_val, uint8_t *p_vals)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_avrcp_list_player_values *cmd = (void *) buf;
 	size_t len;
 
@@ -292,7 +293,7 @@ static bt_status_t list_player_app_value_rsp(int num_val, uint8_t *p_vals)
 
 	len = sizeof(*cmd) + num_val;
 
-	if (len > BLUEZ_HAL_MTU)
+	if (len > IPC_MTU)
 		return BT_STATUS_PARM_INVALID;
 
 	cmd->number = num_val;
@@ -305,7 +306,7 @@ static bt_status_t list_player_app_value_rsp(int num_val, uint8_t *p_vals)
 
 static bt_status_t get_player_app_value_rsp(btrc_player_settings_t *p_vals)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_avrcp_get_player_attrs *cmd = (void *) buf;
 	size_t len, attrs_len;
 	int i;
@@ -322,7 +323,7 @@ static bt_status_t get_player_app_value_rsp(btrc_player_settings_t *p_vals)
 				sizeof(struct hal_avrcp_player_attr_value);
 	len = sizeof(*cmd) + attrs_len;
 
-	if (len > BLUEZ_HAL_MTU)
+	if (len > IPC_MTU)
 		return BT_STATUS_PARM_INVALID;
 
 	cmd->number = p_vals->num_attr;
@@ -342,7 +343,7 @@ static int write_text(uint8_t *ptr, uint8_t id, uint8_t *text, size_t *len)
 	struct hal_avrcp_player_setting_text *value = (void *) ptr;
 	size_t attr_len = sizeof(*value);
 
-	if (attr_len + *len > BLUEZ_HAL_MTU)
+	if (attr_len + *len > IPC_MTU)
 		return 0;
 
 	value->id = id;
@@ -351,8 +352,8 @@ static int write_text(uint8_t *ptr, uint8_t id, uint8_t *text, size_t *len)
 	*len += attr_len;
 	ptr += attr_len;
 
-	if (value->len + *len > BLUEZ_HAL_MTU)
-		value->len = BLUEZ_HAL_MTU - *len;
+	if (value->len + *len > IPC_MTU)
+		value->len = IPC_MTU - *len;
 
 	memcpy(value->text, text, value->len);
 
@@ -367,7 +368,7 @@ static uint8_t write_player_setting_text(uint8_t *ptr, uint8_t num_attr,
 {
 	int i;
 
-	for (i = 0; i < num_attr && *len < BLUEZ_HAL_MTU; i++) {
+	for (i = 0; i < num_attr && *len < IPC_MTU; i++) {
 		int ret;
 
 		ret = write_text(ptr, p_attrs[i].id, p_attrs[i].text, len);
@@ -383,7 +384,7 @@ static uint8_t write_player_setting_text(uint8_t *ptr, uint8_t num_attr,
 static bt_status_t get_player_app_attr_text_rsp(int num_attr,
 					btrc_player_setting_text_t *p_attrs)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_avrcp_get_player_attrs_text *cmd = (void *) buf;
 	uint8_t *ptr;
 	size_t len;
@@ -408,7 +409,7 @@ static bt_status_t get_player_app_attr_text_rsp(int num_attr,
 static bt_status_t get_player_app_value_text_rsp(int num_val,
 					btrc_player_setting_text_t *p_vals)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_avrcp_get_player_values_text *cmd = (void *) buf;
 	uint8_t *ptr;
 	size_t len;
@@ -436,7 +437,7 @@ static uint8_t write_element_attr_text(uint8_t *ptr, uint8_t num_attr,
 {
 	int i;
 
-	for (i = 0; i < num_attr && *len < BLUEZ_HAL_MTU; i++) {
+	for (i = 0; i < num_attr && *len < IPC_MTU; i++) {
 		int ret;
 
 		ret = write_text(ptr, p_attrs[i].attr_id, p_attrs[i].text, len);
@@ -452,7 +453,7 @@ static uint8_t write_element_attr_text(uint8_t *ptr, uint8_t num_attr,
 static bt_status_t get_element_attr_rsp(uint8_t num_attr,
 					btrc_element_attr_val_t *p_attrs)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_avrcp_get_element_attrs_text *cmd = (void *) buf;
 	size_t len;
 	uint8_t *ptr;
@@ -490,7 +491,7 @@ static bt_status_t set_player_app_value_rsp(btrc_status_t rsp_status)
 static bt_status_t play_status_changed_rsp(btrc_notification_type_t type,
 						btrc_play_status_t *play_status)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_avrcp_register_notification *cmd = (void *) buf;
 	size_t len;
 
@@ -509,7 +510,7 @@ static bt_status_t play_status_changed_rsp(btrc_notification_type_t type,
 static bt_status_t track_change_rsp(btrc_notification_type_t type,
 							btrc_uid_t *track)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_avrcp_register_notification *cmd = (void *) buf;
 	size_t len;
 
@@ -554,7 +555,7 @@ static bt_status_t track_reached_start_rsp(btrc_notification_type_t type)
 static bt_status_t play_pos_changed_rsp(btrc_notification_type_t type,
 							uint32_t *song_pos)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_avrcp_register_notification *cmd = (void *) buf;
 	size_t len;
 
@@ -573,7 +574,7 @@ static bt_status_t play_pos_changed_rsp(btrc_notification_type_t type,
 static bt_status_t settings_changed_rsp(btrc_notification_type_t type,
 					btrc_player_settings_t *player_setting)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_avrcp_register_notification *cmd = (void *) buf;
 	struct hal_avrcp_player_attr_value *attrs;
 	size_t len, param_len;
@@ -582,7 +583,7 @@ static bt_status_t settings_changed_rsp(btrc_notification_type_t type,
 	param_len = player_setting->num_attr * sizeof(*attrs);
 	len = sizeof(*cmd) + param_len;
 
-	if (len > BLUEZ_HAL_MTU)
+	if (len > IPC_MTU)
 		return BT_STATUS_PARM_INVALID;
 
 	cmd->event = BTRC_EVT_APP_SETTINGS_CHANGED;
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 3160d7b..6871f5d 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -25,6 +25,7 @@
 #include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
+#include "ipc-common.h"
 #include "hal-ipc.h"
 #include "hal-utils.h"
 
@@ -525,7 +526,7 @@ static int get_adapter_property(bt_property_type_t type)
 
 static int set_adapter_property(const bt_property_t *property)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_set_adapter_prop *cmd = (void *) buf;
 	size_t len;
 
@@ -582,7 +583,7 @@ static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 						const bt_property_t *property)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_set_remote_device_prop *cmd = (void *) buf;
 	size_t len;
 
@@ -792,7 +793,7 @@ static int dut_mode_configure(uint8_t enable)
 
 static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t buf_len)
 {
-	char cmd_buf[BLUEZ_HAL_MTU];
+	char cmd_buf[IPC_MTU];
 	struct hal_cmd_dut_mode_send *cmd = (void *) cmd_buf;
 	size_t len;
 
@@ -813,7 +814,7 @@ static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t buf_len)
 
 static int le_test_mode(uint16_t opcode, uint8_t *buf, uint8_t buf_len)
 {
-	char cmd_buf[BLUEZ_HAL_MTU];
+	char cmd_buf[IPC_MTU];
 	struct hal_cmd_le_test_mode *cmd = (void *) cmd_buf;
 	size_t len;
 
diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index ab65d95..1b150c3 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -23,6 +23,7 @@
 #include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
+#include "ipc-common.h"
 #include "hal-ipc.h"
 
 static const bthf_callbacks_t *cbs = NULL;
@@ -360,7 +361,7 @@ static bt_status_t device_status_notification(bthf_network_state_t state,
 
 static bt_status_t cops_response(const char *cops)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_handsfree_cops_response *cmd = (void *) buf;
 	size_t len;
 
@@ -408,7 +409,7 @@ static bt_status_t cind_response(int svc, int num_active, int num_held,
 
 static bt_status_t formatted_at_response(const char *rsp)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_handsfree_formatted_at_response *cmd = (void *) buf;
 	size_t len;
 
@@ -454,7 +455,7 @@ static bt_status_t clcc_response(int index, bthf_call_direction_t dir,
 					const char *number,
 					bthf_call_addrtype_t type)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_handsfree_clcc_response *cmd = (void *) buf;
 	size_t len;
 
@@ -489,7 +490,7 @@ static bt_status_t phone_state_change(int num_active, int num_held,
 					const char *number,
 					bthf_call_addrtype_t type)
 {
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	struct hal_cmd_handsfree_phone_state_change *cmd = (void *) buf;
 	size_t len;
 
diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index dcaf996..c758d2a 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -23,6 +23,7 @@
 #include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
+#include "ipc-common.h"
 #include "hal-ipc.h"
 
 static const bthh_callbacks_t *cbacks;
@@ -293,7 +294,7 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 						bthh_report_type_t report_type,
 						char *report)
 {
-	uint8_t buf[BLUEZ_HAL_MTU];
+	uint8_t buf[IPC_MTU];
 	struct hal_cmd_hidhost_set_report *cmd = (void *) buf;
 
 	DBG("");
@@ -317,7 +318,7 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 
 static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
 {
-	uint8_t buf[BLUEZ_HAL_MTU];
+	uint8_t buf[IPC_MTU];
 	struct hal_cmd_hidhost_send_data *cmd = (void *) buf;
 
 	DBG("");
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 1ba03f5..fda3228 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -31,6 +31,7 @@
 #include "hal.h"
 #include "hal-msg.h"
 #include "hal-log.h"
+#include "ipc-common.h"
 #include "hal-ipc.h"
 
 #define CONNECT_TIMEOUT (5 * 1000)
@@ -64,7 +65,7 @@ void hal_ipc_unregister(uint8_t service)
 
 static void handle_msg(void *buf, ssize_t len)
 {
-	struct hal_hdr *msg = buf;
+	struct ipc_hdr *msg = buf;
 	const struct hal_ipc_handler *handler;
 	uint8_t opcode;
 
@@ -130,7 +131,7 @@ static void *notification_handler(void *data)
 	struct iovec iv;
 	struct cmsghdr *cmsg;
 	char cmsgbuf[CMSG_SPACE(sizeof(int))];
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	ssize_t ret;
 	int fd;
 
@@ -320,9 +321,9 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 	ssize_t ret;
 	struct msghdr msg;
 	struct iovec iv[2];
-	struct hal_hdr cmd;
+	struct ipc_hdr cmd;
 	char cmsgbuf[CMSG_SPACE(sizeof(int))];
-	struct hal_status s;
+	struct ipc_status s;
 	size_t s_len = sizeof(s);
 
 	if (cmd_sk < 0) {
@@ -418,7 +419,7 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 	}
 
 	if (cmd.opcode == HAL_OP_STATUS) {
-		struct hal_status *s = rsp;
+		struct ipc_status *s = rsp;
 
 		if (sizeof(*s) != cmd.len) {
 			error("Invalid status length, aborting");
diff --git a/android/hal-msg.h b/android/hal-msg.h
index bde9717..1e12868 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -21,17 +21,8 @@
  *
  */
 
-#define BLUEZ_HAL_MTU 1024
-
 static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
 
-struct hal_hdr {
-	uint8_t  service_id;
-	uint8_t  opcode;
-	uint16_t len;
-	uint8_t  payload[0];
-} __attribute__((packed));
-
 #define HAL_MINIMUM_EVENT		0x81
 
 #define HAL_SERVICE_ID_CORE		0
@@ -49,7 +40,7 @@ struct hal_hdr {
 
 /* Core Service */
 
-#define HAL_STATUS_SUCCESS		0x00
+#define HAL_STATUS_SUCCESS		IPC_STATUS_SUCCESS
 #define HAL_STATUS_FAILED		0x01
 #define HAL_STATUS_NOT_READY		0x02
 #define HAL_STATUS_NOMEM		0x03
@@ -61,10 +52,7 @@ struct hal_hdr {
 #define HAL_STATUS_AUTH_FAILURE		0x09
 #define HAL_STATUS_REMOTE_DEVICE_DOWN	0x0a
 
-#define HAL_OP_STATUS			0x00
-struct hal_status {
-	uint8_t code;
-} __attribute__((packed));
+#define HAL_OP_STATUS			IPC_OP_STATUS
 
 #define HAL_OP_REGISTER_MODULE		0x01
 struct hal_cmd_register_module {
diff --git a/android/handsfree.c b/android/handsfree.c
index ef8c776..81ddcc7 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -39,6 +39,7 @@
 #include "src/shared/hfp.h"
 #include "btio/btio.h"
 #include "hal-msg.h"
+#include "ipc-common.h"
 #include "ipc.h"
 #include "handsfree.h"
 #include "bluetooth.h"
diff --git a/android/hidhost.c b/android/hidhost.c
index 0c6eb7d..e469210 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -44,6 +44,7 @@
 #include "src/log.h"
 
 #include "hal-msg.h"
+#include "ipc-common.h"
 #include "ipc.h"
 #include "hidhost.h"
 #include "utils.h"
diff --git a/android/ipc-common.h b/android/ipc-common.h
new file mode 100644
index 0000000..27736e4
--- /dev/null
+++ b/android/ipc-common.h
@@ -0,0 +1,38 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#define IPC_MTU 1024
+
+#define IPC_STATUS_SUCCESS	0x00
+
+struct ipc_hdr {
+	uint8_t  service_id;
+	uint8_t  opcode;
+	uint16_t len;
+	uint8_t  payload[0];
+} __attribute__((packed));
+
+#define IPC_OP_STATUS		0x00
+struct ipc_status {
+	uint8_t code;
+} __attribute__((packed));
diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index eab8ea5..2378101 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -45,6 +45,8 @@
 #include "src/shared/hciemu.h"
 
 #include "hal-msg.h"
+#include "ipc-common.h"
+
 #include <cutils/properties.h>
 
 #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
@@ -72,7 +74,7 @@ struct generic_data {
 };
 
 struct regmod_msg {
-	struct hal_hdr header;
+	struct ipc_hdr header;
 	struct hal_cmd_register_module cmd;
 } __attribute__((packed));
 
@@ -413,8 +415,8 @@ static gboolean check_for_daemon(gpointer user_data)
 
 static bool setup_module(int service_id)
 {
-	struct hal_hdr response;
-	struct hal_hdr expected_response;
+	struct ipc_hdr response;
+	struct ipc_hdr expected_response;
 
 	struct regmod_msg btmodule_msg = {
 		.header = {
@@ -564,7 +566,7 @@ static void ipc_send_tc(const void *data)
 
 #define test_opcode_valid(_name, _service, _opcode, _len, _servicelist...) \
 	do {								\
-		static struct hal_hdr hdr = {				\
+		static struct ipc_hdr hdr = {				\
 			.service_id = _service,				\
 			.opcode = _opcode,				\
 			.len = _len,					\
@@ -578,8 +580,8 @@ static void ipc_send_tc(const void *data)
 	} while (0)
 
 struct vardata {
-	struct hal_hdr hdr;
-	uint8_t buf[BLUEZ_HAL_MTU];
+	struct ipc_hdr hdr;
+	uint8_t buf[IPC_MTU];
 } __attribute__((packed));
 
 #define test_datasize_valid(_name, _service, _opcode, _hlen, _addatasize, \
@@ -642,24 +644,24 @@ static struct malformed_data3_struct malformed_data3_msg = {
 	. redundant_data = 666,
 };
 
-struct hal_hdr enable_unknown_service_hdr = {
+struct ipc_hdr enable_unknown_service_hdr = {
 	.service_id = HAL_SERVICE_ID_MAX + 1,
 	.opcode = HAL_OP_REGISTER_MODULE,
 	.len = 0,
 };
 
-struct hal_hdr enable_bt_service_hdr = {
+struct ipc_hdr enable_bt_service_hdr = {
 	.service_id = HAL_SERVICE_ID_BLUETOOTH,
 	.opcode = HAL_OP_ENABLE,
 	.len = 0,
 };
 
 struct bt_set_adapter_prop_data {
-	struct hal_hdr hdr;
+	struct ipc_hdr hdr;
 	struct hal_cmd_set_adapter_prop prop;
 
 	/* data placeholder for hal_cmd_set_adapter_prop.val[0] */
-	uint8_t buf[BLUEZ_HAL_MTU - sizeof(struct hal_hdr) -
+	uint8_t buf[IPC_MTU - sizeof(struct ipc_hdr) -
 				sizeof(struct hal_cmd_set_adapter_prop)];
 } __attribute__((packed));
 
@@ -692,11 +694,11 @@ static struct bt_set_adapter_prop_data bt_set_adapter_prop_data_unders = {
 };
 
 struct bt_set_remote_prop_data {
-	struct hal_hdr hdr;
+	struct ipc_hdr hdr;
 	struct hal_cmd_set_remote_device_prop prop;
 
 	/* data placeholder for hal_cmd_set_remote_device_prop.val[0] */
-	uint8_t buf[BLUEZ_HAL_MTU - sizeof(struct hal_hdr) -
+	uint8_t buf[IPC_MTU - sizeof(struct ipc_hdr) -
 				sizeof(struct hal_cmd_set_remote_device_prop)];
 } __attribute__((packed));
 
@@ -727,11 +729,11 @@ static struct bt_set_remote_prop_data bt_set_remote_prop_data_unders = {
 };
 
 struct hidhost_set_info_data {
-	struct hal_hdr hdr;
+	struct ipc_hdr hdr;
 	struct hal_cmd_hidhost_set_info info;
 
 	/* data placeholder for hal_cmd_hidhost_set_info.descr[0] field */
-	uint8_t buf[BLUEZ_HAL_MTU - sizeof(struct hal_hdr) -
+	uint8_t buf[IPC_MTU - sizeof(struct ipc_hdr) -
 				sizeof(struct hal_cmd_hidhost_set_info)];
 } __attribute__((packed));
 
@@ -762,11 +764,11 @@ static struct hidhost_set_info_data hidhost_set_info_data_unders = {
 };
 
 struct hidhost_set_report_data {
-	struct hal_hdr hdr;
+	struct ipc_hdr hdr;
 	struct hal_cmd_hidhost_set_report report;
 
 	/* data placeholder for hal_cmd_hidhost_set_report.data[0] field */
-	uint8_t buf[BLUEZ_HAL_MTU - sizeof(struct hal_hdr) -
+	uint8_t buf[IPC_MTU - sizeof(struct ipc_hdr) -
 				sizeof(struct hal_cmd_hidhost_set_report)];
 } __attribute__((packed));
 
@@ -797,11 +799,11 @@ static struct hidhost_set_report_data hidhost_set_report_data_unders = {
 };
 
 struct hidhost_send_data_data {
-	struct hal_hdr hdr;
+	struct ipc_hdr hdr;
 	struct hal_cmd_hidhost_send_data hiddata;
 
 	/* data placeholder for hal_cmd_hidhost_send_data.data[0] field */
-	uint8_t buf[BLUEZ_HAL_MTU - sizeof(struct hal_hdr) -
+	uint8_t buf[IPC_MTU - sizeof(struct ipc_hdr) -
 				sizeof(struct hal_cmd_hidhost_send_data)];
 } __attribute__((packed));
 
@@ -935,14 +937,14 @@ int main(int argc, char *argv[])
 	test_generic("Data size BT Set Adapter Prop Vardata+",
 			ipc_send_tc, setup, teardown,
 			&bt_set_adapter_prop_data_overs,
-			(sizeof(struct hal_hdr) +
+			(sizeof(struct ipc_hdr) +
 				sizeof(struct hal_cmd_set_adapter_prop) +
 				sizeof(set_name)),
 			HAL_SERVICE_ID_BLUETOOTH);
 	test_generic("Data size BT Set Adapter Prop Vardata+",
 			ipc_send_tc, setup, teardown,
 			&bt_set_adapter_prop_data_unders,
-			(sizeof(struct hal_hdr) +
+			(sizeof(struct ipc_hdr) +
 				sizeof(struct hal_cmd_set_adapter_prop) +
 				sizeof(set_name)),
 			HAL_SERVICE_ID_BLUETOOTH);
@@ -973,14 +975,14 @@ int main(int argc, char *argv[])
 	test_generic("Data size BT Set Remote Prop Vardata+",
 			ipc_send_tc, setup, teardown,
 			&bt_set_remote_prop_data_overs,
-			(sizeof(struct hal_hdr) +
+			(sizeof(struct ipc_hdr) +
 				sizeof(struct hal_cmd_set_remote_device_prop) +
 				sizeof(set_name)),
 			HAL_SERVICE_ID_BLUETOOTH);
 	test_generic("Data size BT Set Remote Prop Vardata-",
 			ipc_send_tc, setup, teardown,
 			&bt_set_remote_prop_data_unders,
-			(sizeof(struct hal_hdr) +
+			(sizeof(struct ipc_hdr) +
 				sizeof(struct hal_cmd_set_remote_device_prop) +
 				sizeof(set_name)),
 			HAL_SERVICE_ID_BLUETOOTH);
@@ -1127,14 +1129,14 @@ int main(int argc, char *argv[])
 	test_generic("Data size HIDHOST Set Info Vardata+",
 			ipc_send_tc, setup, teardown,
 			&hidhost_set_info_data_overs,
-			(sizeof(struct hal_hdr) +
+			(sizeof(struct ipc_hdr) +
 				sizeof(struct hal_cmd_hidhost_set_info) +
 				sizeof(set_info_data)),
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
 	test_generic("Data size HIDHOST Set Info Vardata-",
 			ipc_send_tc, setup, teardown,
 			&hidhost_set_info_data_unders,
-			(sizeof(struct hal_hdr) +
+			(sizeof(struct ipc_hdr) +
 				sizeof(struct hal_cmd_hidhost_set_info) +
 				sizeof(set_info_data)),
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
@@ -1173,14 +1175,14 @@ int main(int argc, char *argv[])
 	test_generic("Data size HIDHOST Set Report Vardata+",
 			ipc_send_tc, setup, teardown,
 			&hidhost_set_report_data_overs,
-			(sizeof(struct hal_hdr) +
+			(sizeof(struct ipc_hdr) +
 				sizeof(struct hal_cmd_hidhost_set_report) +
 				sizeof(set_rep_data)),
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
 	test_generic("Data size HIDHOST Set Report Vardata-",
 			ipc_send_tc, setup, teardown,
 			&hidhost_set_report_data_unders,
-			(sizeof(struct hal_hdr) +
+			(sizeof(struct ipc_hdr) +
 				sizeof(struct hal_cmd_hidhost_set_report) +
 				sizeof(set_rep_data)),
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
@@ -1195,14 +1197,14 @@ int main(int argc, char *argv[])
 	test_generic("Data size HIDHOST Send Vardata+",
 			ipc_send_tc, setup, teardown,
 			&hidhost_send_data_overs,
-			(sizeof(struct hal_hdr) +
+			(sizeof(struct ipc_hdr) +
 				sizeof(struct hal_cmd_hidhost_send_data) +
 				sizeof(send_data_data)),
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
 	test_generic("Data size HIDHOST Send Vardata-",
 			ipc_send_tc, setup, teardown,
 			&hidhost_send_data_unders,
-			(sizeof(struct hal_hdr) +
+			(sizeof(struct ipc_hdr) +
 				sizeof(struct hal_cmd_hidhost_send_data) +
 				sizeof(send_data_data)),
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_HIDHOST);
diff --git a/android/ipc.c b/android/ipc.c
index 6b14bbe..8cd34ea 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -36,7 +36,7 @@
 #include <unistd.h>
 #include <glib.h>
 
-#include "hal-msg.h"
+#include "ipc-common.h"
 #include "ipc.h"
 #include "src/log.h"
 
@@ -92,7 +92,7 @@ static void ipc_disconnect(struct ipc *ipc, bool in_cleanup)
 static int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 						const void *buf, ssize_t len)
 {
-	const struct hal_hdr *msg = buf;
+	const struct ipc_hdr *msg = buf;
 	const struct ipc_handler *handler;
 
 	if (len < (ssize_t) sizeof(*msg)) {
@@ -118,7 +118,7 @@ static int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 	}
 
 	/* if opcode is valid */
-	if (msg->opcode == HAL_OP_STATUS ||
+	if (msg->opcode == IPC_OP_STATUS ||
 			msg->opcode > handlers[msg->service_id].size) {
 		DBG("invalid opcode 0x%x for service 0x%x", msg->opcode,
 							msg->service_id);
@@ -146,7 +146,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 {
 	struct ipc *ipc = user_data;
 
-	char buf[BLUEZ_HAL_MTU];
+	char buf[IPC_MTU];
 	ssize_t ret;
 	int fd, err;
 
@@ -329,7 +329,7 @@ static void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 {
 	struct msghdr msg;
 	struct iovec iv[2];
-	struct hal_hdr m;
+	struct ipc_hdr m;
 	char cmsgbuf[CMSG_SPACE(sizeof(int))];
 	struct cmsghdr *cmsg;
 
@@ -374,19 +374,19 @@ static void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 void ipc_send_rsp(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
 								uint8_t status)
 {
-	struct hal_status s;
+	struct ipc_status s;
 	int sk;
 
 	sk = g_io_channel_unix_get_fd(ipc->cmd_io);
 
-	if (status == HAL_STATUS_SUCCESS) {
+	if (status == IPC_STATUS_SUCCESS) {
 		ipc_send(sk, service_id, opcode, 0, NULL, -1);
 		return;
 	}
 
 	s.code = status;
 
-	ipc_send(sk, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
+	ipc_send(sk, service_id, IPC_OP_STATUS, sizeof(s), &s, -1);
 }
 
 void ipc_send_rsp_full(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
diff --git a/android/main.c b/android/main.c
index bd1bcb9..a6742ef 100644
--- a/android/main.c
+++ b/android/main.c
@@ -48,6 +48,7 @@
 
 #include "lib/bluetooth.h"
 
+#include "ipc-common.h"
 #include "ipc.h"
 #include "bluetooth.h"
 #include "socket.h"
diff --git a/android/pan.c b/android/pan.c
index b4a3494..1e404ab 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -50,6 +50,7 @@
 #include "src/log.h"
 
 #include "hal-msg.h"
+#include "ipc-common.h"
 #include "ipc.h"
 #include "utils.h"
 #include "bluetooth.h"
diff --git a/android/socket.c b/android/socket.c
index d463255..ee98b54 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -39,7 +39,7 @@
 #include "src/log.h"
 
 #include "hal-msg.h"
-#include "hal-ipc.h"
+#include "ipc-common.h"
 #include "ipc.h"
 #include "utils.h"
 #include "bluetooth.h"
diff --git a/android/test-ipc.c b/android/test-ipc.c
index 6172991..bb7d15f 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -39,9 +39,13 @@
 #include <glib.h>
 #include "src/shared/util.h"
 #include "src/log.h"
-#include "android/hal-msg.h"
+#include "android/ipc-common.h"
 #include "android/ipc.h"
 
+static const char HAL_SK_PATH[] = "\0test_hal_socket";
+
+#define SERVICE_ID_MAX 10
+
 struct test_data {
 	bool disconnect;
 	const void *cmd;
@@ -79,11 +83,11 @@ static gboolean cmd_watch(GIOChannel *io, GIOCondition cond,
 {
 	struct context *context = user_data;
 	const struct test_data *test_data = context->data;
-	const struct hal_hdr *sent_msg = test_data->cmd;
+	const struct ipc_hdr *sent_msg = test_data->cmd;
 	uint8_t buf[128];
 	int sk;
 
-	struct hal_hdr success_resp = {
+	struct ipc_hdr success_resp = {
 		.service_id = sent_msg->service_id,
 		.opcode = sent_msg->opcode,
 		.len = 0,
@@ -98,8 +102,8 @@ static gboolean cmd_watch(GIOChannel *io, GIOCondition cond,
 
 	sk = g_io_channel_unix_get_fd(io);
 
-	g_assert(read(sk, buf, sizeof(buf)) == sizeof(struct hal_hdr));
-	g_assert(!memcmp(&success_resp, buf, sizeof(struct hal_hdr)));
+	g_assert(read(sk, buf, sizeof(buf)) == sizeof(struct ipc_hdr));
+	g_assert(!memcmp(&success_resp, buf, sizeof(struct ipc_hdr)));
 
 	context_quit(context);
 
@@ -180,7 +184,7 @@ static struct context *create_context(gconstpointer data)
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_UNIX;
 
-	memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
+	memcpy(addr.sun_path, HAL_SK_PATH, sizeof(HAL_SK_PATH));
 
 	ret = bind(sk, (struct sockaddr *) &addr, sizeof(addr));
 	g_assert(ret == 0);
@@ -236,8 +240,8 @@ static void test_init(gconstpointer data)
 {
 	struct context *context = create_context(data);
 
-	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-					HAL_SERVICE_ID_MAX, true, NULL, NULL);
+	ipc = ipc_init(HAL_SK_PATH, sizeof(HAL_SK_PATH), SERVICE_ID_MAX,
+						true, NULL, NULL);
 
 	g_assert(ipc);
 
@@ -287,8 +291,8 @@ static void test_cmd(gconstpointer data)
 {
 	struct context *context = create_context(data);
 
-	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-			HAL_SERVICE_ID_MAX, true, disconnected, context);
+	ipc = ipc_init(HAL_SK_PATH, sizeof(HAL_SK_PATH), SERVICE_ID_MAX,
+					true, disconnected, context);
 
 	g_assert(ipc);
 
@@ -305,8 +309,8 @@ static void test_cmd_reg(gconstpointer data)
 	struct context *context = create_context(data);
 	const struct test_data *test_data = context->data;
 
-	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-			HAL_SERVICE_ID_MAX, true, disconnected, context);
+	ipc = ipc_init(HAL_SK_PATH, sizeof(HAL_SK_PATH), SERVICE_ID_MAX,
+					true, disconnected, context);
 
 	g_assert(ipc);
 
@@ -325,8 +329,8 @@ static void test_cmd_reg_1(gconstpointer data)
 {
 	struct context *context = create_context(data);
 
-	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-			HAL_SERVICE_ID_MAX, true, disconnected, context);
+	ipc = ipc_init(HAL_SK_PATH, sizeof(HAL_SK_PATH), SERVICE_ID_MAX,
+					true, disconnected, context);
 
 	g_assert(ipc);
 
@@ -357,13 +361,13 @@ static void test_cmd_handler_invalid(const void *buf, uint16_t len)
 
 static const struct test_data test_init_1 = {};
 
-static const struct hal_hdr test_cmd_1_hdr = {
+static const struct ipc_hdr test_cmd_1_hdr = {
 	.service_id = 0,
 	.opcode = 1,
 	.len = 0
 };
 
-static const struct hal_hdr test_cmd_2_hdr = {
+static const struct ipc_hdr test_cmd_2_hdr = {
 	.service_id = 0,
 	.opcode = 2,
 	.len = 0
@@ -443,8 +447,8 @@ static const struct test_data test_cmd_hdr_invalid = {
 #define VARDATA_EX1 "some data example"
 
 struct vardata {
-	struct hal_hdr hdr;
-	uint8_t data[BLUEZ_HAL_MTU - sizeof(struct hal_hdr)];
+	struct ipc_hdr hdr;
+	uint8_t data[IPC_MTU - sizeof(struct ipc_hdr)];
 } __attribute__((packed));
 
 static const struct vardata test_cmd_vardata = {
@@ -460,7 +464,7 @@ static const struct ipc_handler cmd_vardata_handlers[] = {
 
 static const struct test_data test_cmd_vardata_valid = {
 	.cmd = &test_cmd_vardata,
-	.cmd_size = sizeof(struct hal_hdr) + sizeof(VARDATA_EX1),
+	.cmd_size = sizeof(struct ipc_hdr) + sizeof(VARDATA_EX1),
 	.service = 0,
 	.handlers = cmd_vardata_handlers,
 	.handlers_size = 1,
@@ -472,7 +476,7 @@ static const struct ipc_handler cmd_vardata_handlers_valid2[] = {
 
 static const struct test_data test_cmd_vardata_valid_2 = {
 	.cmd = &test_cmd_vardata,
-	.cmd_size = sizeof(struct hal_hdr) + sizeof(VARDATA_EX1),
+	.cmd_size = sizeof(struct ipc_hdr) + sizeof(VARDATA_EX1),
 	.service = 0,
 	.handlers = cmd_vardata_handlers_valid2,
 	.handlers_size = 1,
@@ -480,22 +484,22 @@ static const struct test_data test_cmd_vardata_valid_2 = {
 
 static const struct test_data test_cmd_vardata_invalid_1 = {
 	.cmd = &test_cmd_vardata,
-	.cmd_size = sizeof(struct hal_hdr) + sizeof(VARDATA_EX1) - 1,
+	.cmd_size = sizeof(struct ipc_hdr) + sizeof(VARDATA_EX1) - 1,
 	.service = 0,
 	.handlers = cmd_vardata_handlers,
 	.handlers_size = 1,
 	.disconnect = true,
 };
 
-static const struct hal_hdr test_cmd_service_offrange_hdr = {
-	.service_id = HAL_SERVICE_ID_MAX + 1,
+static const struct ipc_hdr test_cmd_service_offrange_hdr = {
+	.service_id = SERVICE_ID_MAX + 1,
 	.opcode = 1,
 	.len = 0
 };
 
 static const struct test_data test_cmd_service_offrange = {
 	.cmd = &test_cmd_service_offrange_hdr,
-	.cmd_size = sizeof(struct hal_hdr),
+	.cmd_size = sizeof(struct ipc_hdr),
 	.service = 0,
 	.handlers = cmd_handlers,
 	.handlers_size = 1,
@@ -511,7 +515,7 @@ static const struct vardata test_cmd_invalid_data_1 = {
 
 static const struct test_data test_cmd_msg_invalid_1 = {
 	.cmd = &test_cmd_invalid_data_1,
-	.cmd_size = sizeof(struct hal_hdr) + sizeof(VARDATA_EX1) - 1,
+	.cmd_size = sizeof(struct ipc_hdr) + sizeof(VARDATA_EX1) - 1,
 	.service = 0,
 	.handlers = cmd_handlers,
 	.handlers_size = 1,
@@ -527,7 +531,7 @@ static const struct vardata test_cmd_invalid_data_2 = {
 
 static const struct test_data test_cmd_msg_invalid_2 = {
 	.cmd = &test_cmd_invalid_data_2,
-	.cmd_size = sizeof(struct hal_hdr) + sizeof(VARDATA_EX1),
+	.cmd_size = sizeof(struct ipc_hdr) + sizeof(VARDATA_EX1),
 	.service = 0,
 	.handlers = cmd_handlers,
 	.handlers_size = 1,
-- 
1.8.3.2

