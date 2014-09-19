Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/6] android/handsfree-client: Implement hf client events
Date: Fri, 19 Sep 2014 16:30:49 +0200
Message-Id: <1411137051-28904-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements skeleton for following events:
1. Network State event
2. Network Roaming State event
3. Network Signal Strenght event
4. Battery Level event
5. Operator Name event
---
 android/hal-handsfree-client.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h              | 32 ++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index f788f68..c33f7bc 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -60,6 +60,57 @@ static void handle_vr_state(void *buf, uint16_t len, int fd)
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
+static void handle_network_roaming(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_net_roaming_type *ev = buf;
+
+	if (cbs->network_roaming_cb)
+		cbs->network_roaming_cb(ev->state);
+}
+
+static void handle_network_signal(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_net_signal_strength *ev = buf;
+
+	if (cbs->network_signal_cb)
+		cbs->network_signal_cb(ev->signal_strength);
+}
+
+static void handle_battery_level(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_battery_level *ev = buf;
+
+	if (cbs->battery_level_cb)
+		cbs->battery_level_cb(ev->battery_level);
+}
+
+static void handle_operator_name(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_operator_name *ev = buf;
+	uint16_t name_len = ev->name_len;
+	char *name = NULL;
+
+	if (len != sizeof(*ev) + name_len ||
+		(name_len != 0 && ev->name[name_len - 1] != '\0')) {
+		error("invalid  clip, aborting");
+		exit(EXIT_FAILURE);
+	}
+
+	if (name_len)
+		name = (char *) ev->name;
+
+	if (cbs->current_operator_cb)
+		cbs->current_operator_cb(name);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -73,6 +124,21 @@ static const struct hal_ipc_handler ev_handlers[] = {
 				sizeof(struct hal_ev_hf_client_audio_state) },
 	/* HAL_EV_HF_CLIENT_VR_STATE */
 	{ handle_vr_state, false, sizeof(struct hal_ev_hf_client_vr_state) },
+	/*HAL_EV_HF_CLIENT_NET_STATE */
+	{ handle_network_state, false,
+				sizeof(struct hal_ev_hf_client_net_state)},
+	/*HAL_EV_HF_CLIENT_NET_ROAMING_TYPE */
+	{ handle_network_roaming, false,
+			sizeof(struct hal_ev_hf_client_net_roaming_type) },
+	/* HAL_EV_HF_CLIENT_NET_SIGNAL_STRENGTH */
+	{ handle_network_signal, false,
+			sizeof(struct hal_ev_hf_client_net_signal_strength) },
+	/* HAL_EV_HF_CLIENT_BATTERY_LEVEL */
+	{ handle_battery_level, false,
+			sizeof(struct hal_ev_hf_client_battery_level) },
+	/* HAL_EV_HF_CLIENT_OPERATOR_NAME */
+	{ handle_operator_name, true,
+			sizeof(struct hal_ev_hf_client_operator_name) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 295bf58..53f3f51 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1746,3 +1746,35 @@ struct hal_ev_hf_client_audio_state {
 struct hal_ev_hf_client_vr_state {
 	uint8_t state;
 } __attribute__((packed));
+
+#define HAL_HF_CLIENT_NET_NOT_AVAILABLE		0x00
+#define HAL_HF_CLIENT_NET_AVAILABLE		0x01
+
+#define HAL_EV_HF_CLIENT_NET_STATE			0x84
+struct hal_ev_hf_client_net_state {
+	uint8_t state;
+} __attribute__((packed));
+
+#define HAL_HF_CLIENT_NET_ROAMING_TYPE_HOME		0x00
+#define HAL_HF_CLIENT_NET_ROAMING_TYPE_ROAMING		0x01
+
+#define HAL_EV_HF_CLIENT_NET_ROAMING_TYPE		0x85
+struct hal_ev_hf_client_net_roaming_type {
+	uint8_t state;
+} __attribute__((packed));
+
+#define HAL_EV_HF_CLIENT_NET_SIGNAL_STRENGTH		0x86
+struct hal_ev_hf_client_net_signal_strength {
+	uint8_t signal_strength;
+} __attribute__((packed));
+
+#define HAL_EV_HF_CLIENT_BATTERY_LEVEL			0x87
+struct hal_ev_hf_client_battery_level {
+	uint8_t battery_level;
+} __attribute__((packed));
+
+#define HAL_EV_HF_CLIENT_OPERATOR_NAME			0x88
+struct hal_ev_hf_client_operator_name {
+	uint16_t name_len;
+	uint8_t name[0];
+} __attribute__((packed));
-- 
1.8.4

