Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 29/39] android/hf-client: Add Response and Hold Status event
Date: Tue,  9 Sep 2014 21:57:14 +0200
Message-Id: <1410292644-23497-30-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 11 +++++++++++
 android/hal-msg.h       |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 8c03e52..a4f7e0c 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -135,6 +135,14 @@ static void handle_call_held(void *buf, uint16_t len, int fd)
 		cbs->callheld_cb(ev->call_held);
 }
 
+static void handle_response_and_hold(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_response_and_hold_status *ev = buf;
+
+	if (cbs->resp_and_hold_cb)
+		cbs->resp_and_hold_cb(ev->status);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -172,6 +180,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_CALL_HELD_INDICATOR */
 	{ handle_call_held, false,
 			sizeof(struct hal_ev_hf_client_call_held_indicator) },
+	/* HAL_EV_HF_CLIENT_RESPONSE_AND_HOLD_STATUS */
+	{ handle_response_and_hold, false,
+		sizeof(struct hal_ev_hf_client_response_and_hold_status) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index edf1d3e..34cffbc 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1782,3 +1782,12 @@ struct hal_ev_hf_client_call_setup_indicator {
 struct hal_ev_hf_client_call_held_indicator {
 	uint8_t call_held;
 } __attribute__((packed));
+
+#define HF_CLIENT_RESPONSE_AND_HOLD_STATUS_HELD		0x00
+#define HF_CLIENT_RESPONSE_AND_HOLD_STATUS_ACCEPT	0x01
+#define HF_CLIENT_RESPONSE_AND_HOLD_STATUS_REJECT	0x02
+
+#define HAL_EV_HF_CLIENT_RESPONSE_AND_HOLD_STATUS	0x8c
+struct hal_ev_hf_client_response_and_hold_status {
+	uint8_t status;
+} __attribute__((packed));
-- 
1.8.4

