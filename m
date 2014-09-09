Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 26/39] android/hf-client: Add Call Indicator event
Date: Tue,  9 Sep 2014 21:57:11 +0200
Message-Id: <1410292644-23497-27-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 11 +++++++++++
 android/hal-msg.h       |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index b1b481f..b8e61ac 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -111,6 +111,14 @@ static void handle_operator_name(void *buf, uint16_t len, int fd)
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
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -139,6 +147,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_OPERATOR_NAME */
 	{ handle_operator_name, true,
 			sizeof(struct hal_ev_hf_client_operator_name) },
+	/* HAL_EV_HF_CLIENT_CALL_INDICATOR */
+	{ handle_call, false,
+			sizeof(struct hal_ev_hf_client_call_indicator) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0af198e..282bca5 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1755,3 +1755,11 @@ struct hal_ev_hf_client_operator_name {
 	uint16_t name_len;
 	uint8_t name[0];
 } __attribute__((packed));
+
+#define HF_CLIENT_CALL_IND_NO_CALL_IN_PROGERSS	0x00
+#define HF_CLIENT_CALL_IND_CALL_IN_PROGERSS	0x01
+
+#define HAL_EV_HF_CLIENT_CALL_INDICATOR			0x89
+struct hal_ev_hf_client_call_indicator {
+	uint8_t call;
+} __attribute__((packed));
-- 
1.8.4

