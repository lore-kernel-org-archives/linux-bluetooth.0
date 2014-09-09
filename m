Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 30/39] android/hf-client: Add Call Waiting and Calling Line Ident. events
Date: Tue,  9 Sep 2014 21:57:15 +0200
Message-Id: <1410292644-23497-31-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h       | 12 ++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index a4f7e0c..a5fd84e 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -143,6 +143,44 @@ static void handle_response_and_hold(void *buf, uint16_t len, int fd)
 		cbs->resp_and_hold_cb(ev->status);
 }
 
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
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -183,6 +221,12 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_RESPONSE_AND_HOLD_STATUS */
 	{ handle_response_and_hold, false,
 		sizeof(struct hal_ev_hf_client_response_and_hold_status) },
+	/* HAL_EV_HF_CLIENT_CALLING_LINE_IDENT */
+	{ handle_clip, true,
+			sizeof(struct hal_ev_hf_client_calling_line_ident) },
+	/* HAL_EV_HF_CLIENT_CALL_WAITING */
+	{ handle_call_waiting, true,
+			sizeof(struct hal_ev_hf_client_call_waiting) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 34cffbc..1532805 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1791,3 +1791,15 @@ struct hal_ev_hf_client_call_held_indicator {
 struct hal_ev_hf_client_response_and_hold_status {
 	uint8_t status;
 } __attribute__((packed));
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
-- 
1.8.4

