Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 28/39] android/hf-client: Add Call Held Indicator event
Date: Tue,  9 Sep 2014 21:57:13 +0200
Message-Id: <1410292644-23497-29-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 11 +++++++++++
 android/hal-msg.h       |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index ef647f1..8c03e52 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -127,6 +127,14 @@ static void handle_call_setup(void *buf, uint16_t len, int fd)
 		cbs->callsetup_cb(ev->call_setup);
 }
 
+static void handle_call_held(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_call_held_indicator *ev = buf;
+
+	if (cbs->callheld_cb)
+		cbs->callheld_cb(ev->call_held);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -161,6 +169,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_CALL_SETUP_INDICATOR */
 	{ handle_call_setup, false,
 		sizeof(struct hal_ev_hf_client_call_setup_indicator) },
+	/* HAL_EV_HF_CLIENT_CALL_HELD_INDICATOR */
+	{ handle_call_held, false,
+			sizeof(struct hal_ev_hf_client_call_held_indicator) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4620ce3..edf1d3e 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1773,3 +1773,12 @@ struct hal_ev_hf_client_call_indicator {
 struct hal_ev_hf_client_call_setup_indicator {
 	uint8_t call_setup;
 } __attribute__((packed));
+
+#define HF_CLIENT_CALL_HELD_IND_NONE		0x00
+#define HF_CLIENT_CALL_HELD_IND_HOLD_AND_ACTIVE	0x01
+#define HF_CLIENT_CALL_SETUP_IND_HOLD		0x02
+
+#define HAL_EV_HF_CLIENT_CALL_HELD_INDICATOR		0x8b
+struct hal_ev_hf_client_call_held_indicator {
+	uint8_t call_held;
+} __attribute__((packed));
-- 
1.8.4

