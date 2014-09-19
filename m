Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/6] android/handsfree-client: Implement hf client events
Date: Fri, 19 Sep 2014 16:30:48 +0200
Message-Id: <1411137051-28904-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements skeleton for following events:
1. Connection State event
2. Audio Connection State event
3. Voice Recognition State event
---
 android/hal-handsfree-client.c | 33 +++++++++++++++++++++++++++
 android/hal-msg.h              | 51 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index 98b6cb6..f788f68 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -35,11 +35,44 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
+static void handle_conn_state(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_conn_state *ev = buf;
+
+	if (cbs->connection_state_cb)
+		cbs->connection_state_cb(ev->state, ev->peer_feat,
+				ev->chld_feat, (bt_bdaddr_t *) ev->bdaddr);
+}
+
+static void handle_audio_state(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_audio_state *ev = buf;
+
+	if (cbs->audio_state_cb)
+		cbs->audio_state_cb(ev->state, (bt_bdaddr_t *) (ev->bdaddr));
+}
+
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
  */
 static const struct hal_ipc_handler ev_handlers[] = {
+	/* HAL_EV_HF_CLIENT_CONN_STATE */
+	{ handle_conn_state, false,
+				sizeof(struct hal_ev_hf_client_conn_state) },
+	/* HAL_EV_HF_CLIENT_AUDIO_STATE */
+	{ handle_audio_state, false,
+				sizeof(struct hal_ev_hf_client_audio_state) },
+	/* HAL_EV_HF_CLIENT_VR_STATE */
+	{ handle_vr_state, false, sizeof(struct hal_ev_hf_client_vr_state) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index eba47df..295bf58 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1695,3 +1695,54 @@ struct hal_ev_gatt_server_rsp_confirmation {
 #define HAL_GATT_AUTHENTICATION_NONE		0
 #define HAL_GATT_AUTHENTICATION_NO_MITM		1
 #define HAL_GATT_AUTHENTICATION_MITM		2
+
+#define HAL_HF_CLIENT_CONN_STATE_DISCONNECTED		0x00
+#define HAL_HF_CLIENT_CONN_STATE_CONNECTING		0x01
+#define HAL_HF_CLIENT_CONN_STATE_SLC_CONNECTED		0x02
+#define HAL_HF_CLIENT_CONN_STATE_DISCONNECTING		0x03
+
+#define HAL_HF_CLIENT_PEER_FEAT_3WAY		0x00000001
+#define HAL_HF_CLIENT_PEER_FEAT_ECNR		0x00000002
+#define HAL_HF_CLIENT_PEER_FEAT_VREC		0x00000004
+#define HAL_HF_CLIENT_PEER_FEAT_INBAND		0x00000008
+#define HAL_HF_CLIENT_PEER_FEAT_VTAG		0x00000010
+#define HAL_HF_CLIENT_PEER_FEAT_REJECT		0x00000020
+#define HAL_HF_CLIENT_PEER_FEAT_ECS		0x00000040
+#define HAL_HF_CLIENT_PEER_FEAT_ECC		0x00000080
+#define HAL_HF_CLIENT_PEER_FEAT_EXTERR		0x00000100
+#define HAL_HF_CLIENT_PEER_FEAT_CODEC		0x00000200
+
+#define HAL_HF_CLIENT_CHLD_FEAT_REL		0x00000001
+#define HAL_HF_CLIENT_CHLD_FEAT_REL_ACC		0x00000002
+#define HAL_HF_CLIENT_CHLD_FEAT_REL_X		0x00000004
+#define HAL_HF_CLIENT_CHLD_FEAT_HOLD_ACC	0x00000008
+#define HAL_HF_CLIENT_CHLD_FEAT_PRIV_X		0x00000010
+#define HAL_HF_CLIENT_CHLD_FEAT_MERGE		0x00000020
+#define HAL_HF_CLIENT_CHLD_FEAT_MERGE_DETACH	0x00000040
+
+#define HAL_EV_HF_CLIENT_CONN_STATE			0x81
+struct hal_ev_hf_client_conn_state {
+	uint8_t state;
+	uint32_t peer_feat;
+	uint32_t chld_feat;
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_HF_CLIENT_AUDIO_STATE_DISCONNECTED		0x00
+#define HAL_HF_CLIENT_AUDIO_STATE_CONNECTING		0x01
+#define HAL_HF_CLIENT_AUDIO_STATE_CONNECTED		0x02
+#define HAL_HF_CLIENT_AUDIO_STATE_CONNECTED_MSBC	0x03
+
+#define HAL_EV_HF_CLIENT_AUDIO_STATE			0x82
+struct hal_ev_hf_client_audio_state {
+	uint8_t state;
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_HF_CLIENT_VR_STOPPED	0x00
+#define HAL_HF_CLIENT_VR_STARTED	0x01
+
+#define HAL_EV_HF_CLIENT_VR_STATE			0x83
+struct hal_ev_hf_client_vr_state {
+	uint8_t state;
+} __attribute__((packed));
-- 
1.8.4

