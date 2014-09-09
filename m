Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 18/39] android/hf-client: Add Connection State event
Date: Tue,  9 Sep 2014 21:57:03 +0200
Message-Id: <1410292644-23497-19-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 12 ++++++++++++
 android/hal-msg.h       | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 8ee77f2..a7d164f 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -35,11 +35,23 @@ static bool interface_ready(void)
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
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
  */
 static const struct hal_ipc_handler ev_handlers[] = {
+	/* HAL_EV_HF_CLIENT_CONN_STATE */
+	{ handle_conn_state, false,
+				sizeof(struct hal_ev_hf_client_conn_state) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9445c66..e385f59 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1691,3 +1691,16 @@ struct hal_ev_gatt_server_rsp_confirmation {
 #define HAL_GATT_AUTHENTICATION_NONE		0
 #define HAL_GATT_AUTHENTICATION_NO_MITM		1
 #define HAL_GATT_AUTHENTICATION_MITM		2
+
+#define HF_CLIENT_CONN_STATE_DISCONNECTED	0x00
+#define HF_CLIENT_CONN_STATE_CONNECTING		0x01
+#define HF_CLIENT_CONN_STATE_SLC_CONNECTED	0x02
+#define HF_CLIENT_CONN_STATE_DISCONNECTING	0x03
+
+#define HAL_EV_HF_CLIENT_CONN_STATE			0x81
+struct hal_ev_hf_client_conn_state {
+	uint8_t state;
+	uint16_t peer_feat;
+	uint16_t chld_feat;
+	uint8_t bdaddr[6];
+} __attribute__((packed));
-- 
1.8.4

