Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 20/39] android/hf-client: Add Voice Recognition State event
Date: Tue,  9 Sep 2014 21:57:05 +0200
Message-Id: <1410292644-23497-21-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 10 ++++++++++
 android/hal-msg.h       |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index c49666b..42908de 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -52,6 +52,14 @@ static void handle_audio_state(void *buf, uint16_t len, int fd)
 		cbs->audio_state_cb(ev->state, (bt_bdaddr_t *) (ev->bdaddr));
 }
 
+static void handle_vr_state(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_vr_state *ev = buf;
+
+	if (cbs->vr_cmd_cb)
+		cbs->vr_cmd_cb(ev->state);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -63,6 +71,8 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_AUDIO_STATE */
 	{ handle_audio_state, false,
 				sizeof(struct hal_ev_hf_client_audio_state) },
+	/* HAL_EV_HF_CLIENT_VR_STATE */
+	{ handle_vr_state, false, sizeof(struct hal_ev_hf_client_vr_state) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index a94606e..16b095b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1715,3 +1715,11 @@ struct hal_ev_hf_client_audio_state {
 	uint8_t state;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
+
+#define HF_CLIENT_VR_STOPPED	0x00
+#define HF_CLIENT_VR_STARTED	0x01
+
+#define HAL_EV_HF_CLIENT_VR_STATE			0x83
+struct hal_ev_hf_client_vr_state {
+	uint8_t state;
+} __attribute__((packed));
-- 
1.8.4

