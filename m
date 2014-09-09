Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 31/39] android/hf-client: Add Current Client Call event
Date: Tue,  9 Sep 2014 21:57:16 +0200
Message-Id: <1410292644-23497-32-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 23 +++++++++++++++++++++++
 android/hal-msg.h       | 21 +++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index a5fd84e..4e31421 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -181,6 +181,26 @@ static void handle_call_waiting(void *buf, uint16_t len, int fd)
 		cbs->call_waiting_cb(number);
 }
 
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
@@ -227,6 +247,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_CALL_WAITING */
 	{ handle_call_waiting, true,
 			sizeof(struct hal_ev_hf_client_call_waiting) },
+	/* HAL_EV_HF_CLIENT_CURRENT_CALL */
+	{ handle_current_calls, true,
+			sizeof(struct hal_ev_hf_client_current_call) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 1532805..01a1711 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1803,3 +1803,24 @@ struct hal_ev_hf_client_call_waiting {
 	uint16_t number_len;
 	uint8_t number[0];
 } __attribute__((packed));
+
+#define HF_CLIENT_DIRECTION_OUTGOING	0x00
+#define HF_CLIENT_DIRECTION_INCOMIGN	0x01
+
+#define HF_CLIENT_CALL_STATE_ACTIVE			0x00
+#define HF_CLIENT_CALL_STATE_HELD			0x01
+#define HF_CLIENT_CALL_STATE_DIALING			0x02
+#define HF_CLIENT_CALL_STATE_ALERTING			0x03
+#define HF_CLIENT_CALL_STATE_INCOMING			0x04
+#define HF_CLIENT_CALL_STATE_WAITING			0x05
+#define HF_CLIENT_CALL_STATE_HELD_BY_RESPONSE_AND_HOLD	0x06
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

