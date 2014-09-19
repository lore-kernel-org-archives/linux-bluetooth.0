Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 5/6] android/handsfree-client: Implement hf client events
Date: Fri, 19 Sep 2014 16:30:50 +0200
Message-Id: <1411137051-28904-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements skeletons for following events:
1. Call Indicator event
2. Call Setup Indicator event
3. Call Held Indicator event
4. Response and Hold Status event
5. Add Call Waiting and Call Line Ident. events
6. Add Current Client Call event
---
 android/hal-handsfree-client.c | 111 +++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h              |  69 +++++++++++++++++++++++++
 2 files changed, 180 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index c33f7bc..0987221 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -111,6 +111,96 @@ static void handle_operator_name(void *buf, uint16_t len, int fd)
 		cbs->current_operator_cb(name);
 }
 
+static void handle_call(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_call_indicator *ev = buf;
+
+	if (cbs->call_cb)
+		cbs->call_cb(ev->call);
+}
+
+static void handle_call_setup(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_call_setup_indicator *ev = buf;
+
+	if (cbs->callsetup_cb)
+		cbs->callsetup_cb(ev->call_setup);
+}
+
+static void handle_call_held(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_call_held_indicator *ev = buf;
+
+	if (cbs->callheld_cb)
+		cbs->callheld_cb(ev->call_held);
+}
+
+static void handle_response_and_hold(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_response_and_hold_status *ev = buf;
+
+	if (cbs->resp_and_hold_cb)
+		cbs->resp_and_hold_cb(ev->status);
+}
+
+static void handle_clip(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_calling_line_ident *ev = buf;
+	uint16_t num_len = ev->number_len;
+	char *number = NULL;
+
+	if (len != sizeof(*ev) + num_len ||
+		(num_len != 0 && ev->number[num_len - 1] != '\0')) {
+		error("invalid  clip, aborting");
+		exit(EXIT_FAILURE);
+	}
+
+	if (num_len)
+		number = (char *) ev->number;
+
+	if (cbs->clip_cb)
+		cbs->clip_cb(number);
+}
+
+static void handle_call_waiting(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_call_waiting *ev = buf;
+	uint16_t num_len = ev->number_len;
+	char *number = NULL;
+
+	if (len != sizeof(*ev) + num_len ||
+		(num_len != 0 && ev->number[num_len - 1] != '\0')) {
+		error("invalid call waiting, aborting");
+		exit(EXIT_FAILURE);
+	}
+
+	if (num_len)
+		number = (char *) ev->number;
+
+	if (cbs->call_waiting_cb)
+		cbs->call_waiting_cb(number);
+}
+
+static void handle_current_calls(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_current_call *ev = buf;
+	uint16_t num_len = ev->number_len;
+	char *number = NULL;
+
+	if (len != sizeof(*ev) + num_len ||
+		(num_len != 0 && ev->number[num_len - 1] != '\0')) {
+		error("invalid current calls, aborting");
+		exit(EXIT_FAILURE);
+	}
+
+	if (num_len)
+		number = (char *) ev->number;
+
+	if (cbs->current_calls_cb)
+		cbs->current_calls_cb(ev->index, ev->direction, ev->call_state,
+							ev->multiparty, number);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -139,6 +229,27 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_OPERATOR_NAME */
 	{ handle_operator_name, true,
 			sizeof(struct hal_ev_hf_client_operator_name) },
+	/* HAL_EV_HF_CLIENT_CALL_INDICATOR */
+	{ handle_call, false,
+			sizeof(struct hal_ev_hf_client_call_indicator) },
+	/* HAL_EV_HF_CLIENT_CALL_SETUP_INDICATOR */
+	{ handle_call_setup, false,
+		sizeof(struct hal_ev_hf_client_call_setup_indicator) },
+	/* HAL_EV_HF_CLIENT_CALL_HELD_INDICATOR */
+	{ handle_call_held, false,
+			sizeof(struct hal_ev_hf_client_call_held_indicator) },
+	/* HAL_EV_HF_CLIENT_RESPONSE_AND_HOLD_STATUS */
+	{ handle_response_and_hold, false,
+		sizeof(struct hal_ev_hf_client_response_and_hold_status) },
+	/* HAL_EV_HF_CLIENT_CALLING_LINE_IDENT */
+	{ handle_clip, true,
+			sizeof(struct hal_ev_hf_client_calling_line_ident) },
+	/* HAL_EV_HF_CLIENT_CALL_WAITING */
+	{ handle_call_waiting, true,
+			sizeof(struct hal_ev_hf_client_call_waiting) },
+	/* HAL_EV_HF_CLIENT_CURRENT_CALL */
+	{ handle_current_calls, true,
+			sizeof(struct hal_ev_hf_client_current_call) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 53f3f51..6cd6713 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1778,3 +1778,72 @@ struct hal_ev_hf_client_operator_name {
 	uint16_t name_len;
 	uint8_t name[0];
 } __attribute__((packed));
+
+#define HAL_HF_CLIENT_CALL_IND_NO_CALL_IN_PROGERSS	0x00
+#define HAL_HF_CLIENT_CALL_IND_CALL_IN_PROGERSS		0x01
+
+#define HAL_EV_HF_CLIENT_CALL_INDICATOR			0x89
+struct hal_ev_hf_client_call_indicator {
+	uint8_t call;
+} __attribute__((packed));
+
+#define HAL_HF_CLIENT_CALL_SETUP_NONE			0x00
+#define HAL_HF_CLIENT_CALL_SETUP_INCOMING		0x01
+#define HAL_HF_CLIENT_CALL_SETUP_OUTGOING		0x02
+#define HAL_HF_CLIENT_CALL_SETUP_ALERTING		0x03
+
+#define HAL_EV_HF_CLIENT_CALL_SETUP_INDICATOR		0x8a
+struct hal_ev_hf_client_call_setup_indicator {
+	uint8_t call_setup;
+} __attribute__((packed));
+
+#define HAL_HF_CLIENT_CALL_HELD_IND_NONE		0x00
+#define HAL_HF_CLIENT_CALL_HELD_IND_HOLD_AND_ACTIVE	0x01
+#define HAL_HF_CLIENT_CALL_SETUP_IND_HOLD		0x02
+
+#define HAL_EV_HF_CLIENT_CALL_HELD_INDICATOR		0x8b
+struct hal_ev_hf_client_call_held_indicator {
+	uint8_t call_held;
+} __attribute__((packed));
+
+#define HAL_HF_CLIENT_RESP_AND_HOLD_STATUS_HELD		0x00
+#define HAL_HF_CLIENT_RESP_AND_HOLD_STATUS_ACCEPT	0x01
+#define HAL_HF_CLIENT_RESP_AND_HOLD_STATUS_REJECT	0x02
+
+#define HAL_EV_HF_CLIENT_RESPONSE_AND_HOLD_STATUS	0x8c
+struct hal_ev_hf_client_response_and_hold_status {
+	uint8_t status;
+} __attribute__((packed));
+
+#define HAL_EV_HF_CLIENT_CALLING_LINE_IDENT		0x8d
+struct hal_ev_hf_client_calling_line_ident {
+	uint16_t number_len;
+	uint8_t number[0];
+} __attribute__((packed));
+
+#define HAL_EV_HF_CLIENT_CALL_WAITING			0x8e
+struct hal_ev_hf_client_call_waiting {
+	uint16_t number_len;
+	uint8_t number[0];
+} __attribute__((packed));
+
+#define HAL_HF_CLIENT_DIRECTION_OUTGOING	0x00
+#define HAL_HF_CLIENT_DIRECTION_INCOMIGN	0x01
+
+#define HAL_HF_CLIENT_CALL_STATE_ACTIVE			0x00
+#define HAL_HF_CLIENT_CALL_STATE_HELD			0x01
+#define HAL_HF_CLIENT_CALL_STATE_DIALING		0x02
+#define HAL_HF_CLIENT_CALL_STATE_ALERTING		0x03
+#define HAL_HF_CLIENT_CALL_STATE_INCOMING		0x04
+#define HAL_HF_CLIENT_CALL_STATE_WAITING		0x05
+#define HAL_HF_CLIENT_CALL_STATE_HELD_BY_RESP_AND_HOLD	0x06
+
+#define HAL_EV_HF_CLIENT_CURRENT_CALL			0x8f
+struct hal_ev_hf_client_current_call {
+	uint8_t index;
+	uint8_t direction;
+	uint8_t call_state;
+	uint8_t multiparty;
+	uint16_t number_len;
+	uint8_t number[0];
+} __attribute__((packed));
-- 
1.8.4

