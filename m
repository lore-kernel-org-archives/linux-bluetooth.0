Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 27/39] android/hf-client: Add Call Setup Indicator event
Date: Tue,  9 Sep 2014 21:57:12 +0200
Message-Id: <1410292644-23497-28-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 11 +++++++++++
 android/hal-msg.h       | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index b8e61ac..ef647f1 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -119,6 +119,14 @@ static void handle_call(void *buf, uint16_t len, int fd)
 		cbs->call_cb(ev->call);
 }
 
+static void handle_call_setup(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_call_setup_indicator *ev = buf;
+
+	if (cbs->callsetup_cb)
+		cbs->callsetup_cb(ev->call_setup);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -150,6 +158,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_CALL_INDICATOR */
 	{ handle_call, false,
 			sizeof(struct hal_ev_hf_client_call_indicator) },
+	/* HAL_EV_HF_CLIENT_CALL_SETUP_INDICATOR */
+	{ handle_call_setup, false,
+		sizeof(struct hal_ev_hf_client_call_setup_indicator) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 282bca5..4620ce3 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1763,3 +1763,13 @@ struct hal_ev_hf_client_operator_name {
 struct hal_ev_hf_client_call_indicator {
 	uint8_t call;
 } __attribute__((packed));
+
+#define HF_CLIENT_CALL_SETUP_IND_NONE		0x00
+#define HF_CLIENT_CALL_SETUP_IND_INCOMING	0x01
+#define HF_CLIENT_CALL_SETUP_IND_OUTGOING	0x02
+#define HF_CLIENT_CALL_SETUP_IND_ALERTING	0x03
+
+#define HAL_EV_HF_CLIENT_CALL_SETUP_INDICATOR		0x8a
+struct hal_ev_hf_client_call_setup_indicator {
+	uint8_t call_setup;
+} __attribute__((packed));
-- 
1.8.4

