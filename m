Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 21/39] android/hf-client: Add Network State event
Date: Tue,  9 Sep 2014 21:57:06 +0200
Message-Id: <1410292644-23497-22-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 11 +++++++++++
 android/hal-msg.h       |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 42908de..7facb83 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -60,6 +60,14 @@ static void handle_vr_state(void *buf, uint16_t len, int fd)
 		cbs->vr_cmd_cb(ev->state);
 }
 
+static void handle_network_state(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_net_state *ev = buf;
+
+	if (cbs->network_state_cb)
+		cbs->network_state_cb(ev->state);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -73,6 +81,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 				sizeof(struct hal_ev_hf_client_audio_state) },
 	/* HAL_EV_HF_CLIENT_VR_STATE */
 	{ handle_vr_state, false, sizeof(struct hal_ev_hf_client_vr_state) },
+	/*HAL_EV_HF_CLIENT_NET_STATE */
+	{ handle_network_state, false,
+				sizeof(struct hal_ev_hf_client_net_state)},
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 16b095b..bbee8ad 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1723,3 +1723,11 @@ struct hal_ev_hf_client_audio_state {
 struct hal_ev_hf_client_vr_state {
 	uint8_t state;
 } __attribute__((packed));
+
+#define HF_CLIENT_NET_NOT_AVAILABLE	0x00
+#define HF_CLIENT_NET_AVAILABLE		0x01
+
+#define HAL_EV_HF_CLIENT_NET_STATE			0x84
+struct hal_ev_hf_client_net_state {
+	uint8_t state;
+} __attribute__((packed));
-- 
1.8.4

