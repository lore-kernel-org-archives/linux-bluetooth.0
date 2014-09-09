Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 22/39] android/hf-client: Add Network Roaming State event
Date: Tue,  9 Sep 2014 21:57:07 +0200
Message-Id: <1410292644-23497-23-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 11 +++++++++++
 android/hal-msg.h       |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 7facb83..2ff9e9f 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -68,6 +68,14 @@ static void handle_network_state(void *buf, uint16_t len, int fd)
 		cbs->network_state_cb(ev->state);
 }
 
+static void handle_network_roaming(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_net_roaming_type *ev = buf;
+
+	if (cbs->network_roaming_cb)
+		cbs->network_roaming_cb(ev->state);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -84,6 +92,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/*HAL_EV_HF_CLIENT_NET_STATE */
 	{ handle_network_state, false,
 				sizeof(struct hal_ev_hf_client_net_state)},
+	/*HAL_EV_HF_CLIENT_NET_ROAMING_TYPE */
+	{ handle_network_roaming, false,
+			sizeof(struct hal_ev_hf_client_net_roaming_type) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index bbee8ad..80aa244 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1731,3 +1731,11 @@ struct hal_ev_hf_client_vr_state {
 struct hal_ev_hf_client_net_state {
 	uint8_t state;
 } __attribute__((packed));
+
+#define HF_CLIENT_NET_ROAMING_TYPE_HOME		0x00
+#define HF_CLIENT_NET_ROAMING_TYPE_ROAMING	0x01
+
+#define HAL_EV_HF_CLIENT_NET_ROAMING_TYPE		0x85
+struct hal_ev_hf_client_net_roaming_type {
+	uint8_t state;
+} __attribute__((packed));
-- 
1.8.4

