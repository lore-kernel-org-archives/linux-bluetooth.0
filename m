Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 23/39] android/hf-client: Add Network Signal Strenght event
Date: Tue,  9 Sep 2014 21:57:08 +0200
Message-Id: <1410292644-23497-24-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 11 +++++++++++
 android/hal-msg.h       |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 2ff9e9f..044e296 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -76,6 +76,14 @@ static void handle_network_roaming(void *buf, uint16_t len, int fd)
 		cbs->network_roaming_cb(ev->state);
 }
 
+static void handle_network_signal(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_net_signal_strength *ev = buf;
+
+	if (cbs->network_signal_cb)
+		cbs->network_signal_cb(ev->signal_strength);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -95,6 +103,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/*HAL_EV_HF_CLIENT_NET_ROAMING_TYPE */
 	{ handle_network_roaming, false,
 			sizeof(struct hal_ev_hf_client_net_roaming_type) },
+	/* HAL_EV_HF_CLIENT_NET_SIGNAL_STRENGTH */
+	{ handle_network_signal, false,
+			sizeof(struct hal_ev_hf_client_net_signal_strength) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 80aa244..a780e30 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1739,3 +1739,8 @@ struct hal_ev_hf_client_net_state {
 struct hal_ev_hf_client_net_roaming_type {
 	uint8_t state;
 } __attribute__((packed));
+
+#define HAL_EV_HF_CLIENT_NET_SIGNAL_STRENGTH		0x86
+struct hal_ev_hf_client_net_signal_strength {
+	uint8_t signal_strength;
+} __attribute__((packed));
-- 
1.8.4

