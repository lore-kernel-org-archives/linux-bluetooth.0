Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 19/39] android/hf-client: Add Audio Connection State event
Date: Tue,  9 Sep 2014 21:57:04 +0200
Message-Id: <1410292644-23497-20-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 11 +++++++++++
 android/hal-msg.h       | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index a7d164f..c49666b 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -44,6 +44,14 @@ static void handle_conn_state(void *buf, uint16_t len, int fd)
 				ev->chld_feat, (bt_bdaddr_t *) ev->bdaddr);
 }
 
+static void handle_audio_state(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_audio_state *ev = buf;
+
+	if (cbs->audio_state_cb)
+		cbs->audio_state_cb(ev->state, (bt_bdaddr_t *) (ev->bdaddr));
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -52,6 +60,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_CONN_STATE */
 	{ handle_conn_state, false,
 				sizeof(struct hal_ev_hf_client_conn_state) },
+	/* HAL_EV_HF_CLIENT_AUDIO_STATE */
+	{ handle_audio_state, false,
+				sizeof(struct hal_ev_hf_client_audio_state) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index e385f59..a94606e 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1704,3 +1704,14 @@ struct hal_ev_hf_client_conn_state {
 	uint16_t chld_feat;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
+
+#define HF_CLIENT_AUDIO_STATE_DISCONNECTED	0x00
+#define HF_CLIENT_AUDIO_STATE_CONNECTING	0x01
+#define HF_CLIENT_AUDIO_STATE_CONNECTED		0x02
+#define HF_CLIENT_AUDIO_STATE_CONNECTED_MSBC	0x03
+
+#define HAL_EV_HF_CLIENT_AUDIO_STATE			0x82
+struct hal_ev_hf_client_audio_state {
+	uint8_t state;
+	uint8_t bdaddr[6];
+} __attribute__((packed));
-- 
1.8.4

