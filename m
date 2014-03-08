Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/handsfree: Use string type in IPC messages
Date: Sat,  8 Mar 2014 17:35:31 +0100
Message-Id: <1394296531-22469-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394296531-22469-1-git-send-email-szymon.janc@tieto.com>
References: <1394296531-22469-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This type is used to carry NULL terminated string. If last byte is not
NULL this is an IPC error. It doesn't change memory structure of
messages but emphasize that buffer should be NULL terminated.
---
 android/hal-handsfree.c | 38 ++++++++++++++++++++------------------
 android/hal-msg.h       | 23 +++++++++++------------
 android/handsfree.c     |  9 +++------
 3 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 4117ed0..7471ec8 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -84,13 +84,14 @@ static void handle_dial(void *buf, uint16_t len)
 {
 	struct hal_ev_handsfree_dial *ev = buf;
 
-	if (len != sizeof(*ev) + ev->number_len) {
+	if (len != sizeof(*ev) + ev->number.len ||
+			ev->number.data[ev->number.len - 1] != '\0') {
 		error("invalid dial event, aborting");
 		exit(EXIT_FAILURE);
 	}
 
 	if (cbs->dial_call_cmd_cb)
-		cbs->dial_call_cmd_cb((char *) ev->number);
+		cbs->dial_call_cmd_cb((char *) ev->number.data);
 }
 
 static void handle_dtmf(void *buf, uint16_t len)
@@ -145,13 +146,14 @@ static void handle_unknown_at(void *buf, uint16_t len)
 {
 	struct hal_ev_handsfree_unknown_at *ev = buf;
 
-	if (len != sizeof(*ev) + ev->len) {
+	if (len != sizeof(*ev) + ev->at.len ||
+					ev->at.data[ev->at.len - 1] != '\0') {
 		error("invalid unknown command event, aborting");
 		exit(EXIT_FAILURE);
 	}
 
 	if (cbs->unknown_at_cmd_cb)
-		cbs->unknown_at_cmd_cb((char *) ev->buf);
+		cbs->unknown_at_cmd_cb((char *) ev->at.data);
 }
 
 static void handle_hsp_key_press(void *buf, uint16_t len)
@@ -387,10 +389,10 @@ static bt_status_t cops_response(const char *cops)
 	if (!cops)
 		return BT_STATUS_PARM_INVALID;
 
-	cmd->len = strlen(cops);
-	memcpy(cmd->buf, cops, cmd->len);
+	cmd->cops.len = strlen(cops) + 1;
+	memcpy(cmd->cops.data, cops, cmd->cops.len);
 
-	len = sizeof(*cmd) + cmd->len;
+	len = sizeof(*cmd) + cmd->cops.len;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 						HAL_OP_HANDSFREE_COPS_RESPONSE,
@@ -435,10 +437,10 @@ static bt_status_t formatted_at_response(const char *rsp)
 	if (!rsp)
 		return BT_STATUS_PARM_INVALID;
 
-	cmd->len = strlen(rsp);
-	memcpy(cmd->buf, rsp, cmd->len);
+	cmd->resp.len = strlen(rsp) + 1;
+	memcpy(cmd->resp.data, rsp, cmd->resp.len);
 
-	len = sizeof(*cmd) + cmd->len;
+	len = sizeof(*cmd) + cmd->resp.len;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE,
@@ -486,13 +488,13 @@ static bt_status_t clcc_response(int index, bthf_call_direction_t dir,
 	cmd->type = type;
 
 	if (number) {
-		cmd->number_len = strlen(number);
-		memcpy(cmd->number, number, cmd->number_len);
+		cmd->number.len = strlen(number) + 1;
+		memcpy(cmd->number.data, number, cmd->number.len);
 	} else {
-		cmd->number_len = 0;
+		cmd->number.len = 0;
 	}
 
-	len = sizeof(*cmd) + cmd->number_len;
+	len = sizeof(*cmd) + cmd->number.len;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 						HAL_OP_HANDSFREE_CLCC_RESPONSE,
@@ -519,13 +521,13 @@ static bt_status_t phone_state_change(int num_active, int num_held,
 	cmd->type = type;
 
 	if (number) {
-		cmd->number_len = strlen(number);
-		memcpy(cmd->number, number, cmd->number_len);
+		cmd->number.len = strlen(number) + 1;
+		memcpy(cmd->number.data, number, cmd->number.len);
 	} else {
-		cmd->number_len = 0;
+		cmd->number.len = 0;
 	}
 
-	len = sizeof(*cmd) + cmd->number_len;
+	len = sizeof(*cmd) + cmd->number.len;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_PHONE_STATE_CHANGE,
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 1b2b31a..ec8c342 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -23,6 +23,11 @@
 
 static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
 
+struct hal_string {
+	uint16_t len;
+	uint8_t data[0];
+} __attribute__((packed));
+
 #define HAL_MINIMUM_EVENT		0x81
 
 #define HAL_SERVICE_ID_CORE		0
@@ -436,8 +441,7 @@ struct hal_cmd_handsfree_device_status_notif {
 
 #define HAL_OP_HANDSFREE_COPS_RESPONSE		0x09
 struct hal_cmd_handsfree_cops_response {
-	uint16_t len;
-	uint8_t buf[0];
+	struct hal_string cops;
 } __attribute__((packed));
 
 #define HAL_HANDSFREE_CALL_STATE_ACTIVE		0x00
@@ -461,8 +465,7 @@ struct hal_cmd_handsfree_cind_response {
 
 #define HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE	0x0B
 struct hal_cmd_handsfree_formatted_at_response {
-	uint16_t len;
-	uint8_t buf[0];
+	struct hal_string resp;
 } __attribute__((packed));
 
 #define HAL_HANDSFREE_AT_RESPONSE_ERROR		0x00
@@ -495,8 +498,7 @@ struct hal_cmd_handsfree_clcc_response {
 	uint8_t mode;
 	uint8_t mpty;
 	uint8_t type;
-	uint16_t number_len;
-	uint8_t number[0];
+	struct hal_string number;
 } __attribute__((packed));
 
 #define HAL_OP_HANDSFREE_PHONE_STATE_CHANGE	0x0E
@@ -505,8 +507,7 @@ struct hal_cmd_handsfree_phone_state_change {
 	uint8_t num_held;
 	uint8_t state;
 	uint8_t type;
-	uint16_t number_len;
-	uint8_t number[0];
+	struct hal_string number;
 } __attribute__((packed));
 
 /* GATT HAL API */
@@ -1016,8 +1017,7 @@ struct hal_ev_handsfree_volume {
 
 #define HAL_EV_HANDSFREE_DIAL		0x87
 struct hal_ev_handsfree_dial {
-	uint16_t number_len;
-	uint8_t number[0];
+	struct hal_string number;
 } __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_DTMF		0x88
@@ -1054,8 +1054,7 @@ struct hal_ev_handsfree_chld {
 
 #define HAL_EV_HANDSFREE_UNKNOWN_AT	0x8F
 struct hal_ev_handsfree_unknown_at {
-	uint16_t len;
-	uint8_t buf[0];
+	struct hal_string at;
 } __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_HSP_KEY_PRESS	0x90
diff --git a/android/handsfree.c b/android/handsfree.c
index dc5c73d..275a0cf 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -838,9 +838,9 @@ static void handle_device_status_notif(const void *buf, uint16_t len)
 static void handle_cops(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_cops_response *cmd = buf;
-	char operator[17];
 
-	if (len != sizeof(*cmd) + cmd->len) {
+	if (len != sizeof(*cmd) + cmd->cops.len ||
+				cmd->cops.data[cmd->cops.len - 1] != '\0') {
 		error("Invalid cops response command, terminating");
 		raise(SIGTERM);
 		return;
@@ -848,10 +848,7 @@ static void handle_cops(const void *buf, uint16_t len)
 
 	DBG("");
 
-	memset(operator, 0, sizeof(operator));
-	memcpy(operator, cmd->buf, MIN(cmd->len, 16));
-
-	hfp_gw_send_info(device.gw, "+COPS: 0,0,\"%s\" ", operator);
+	hfp_gw_send_info(device.gw, "+COPS: 0,0,\"%.16s\" ", cmd->cops.data);
 
 	hfp_gw_send_result(device.gw, HFP_RESULT_OK);
 
-- 
1.8.5.3

