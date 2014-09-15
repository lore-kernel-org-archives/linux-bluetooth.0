Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 06/15] android/handsfree-client: Add Connect/Disconnect commands
Date: Mon, 15 Sep 2014 13:51:19 +0200
Message-Id: <1410781888-1952-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-handsfree-client.c | 40 ++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h              | 12 ++++++++++++
 android/handsfree-client.c     | 20 ++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index 9422e0f..441d2b4 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -70,6 +70,44 @@ static bt_status_t init(bthf_client_callbacks_t *callbacks)
 	return ret;
 }
 
+static bt_status_t hf_client_connect(bt_bdaddr_t *bd_addr)
+{
+	struct hal_cmd_hf_client_connect cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_CONNECT, sizeof(cmd), &cmd,
+				NULL, NULL, NULL);
+}
+
+static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
+{
+	struct hal_cmd_hf_client_disconnect cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_DISCONNECT, sizeof(cmd), &cmd,
+				NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -92,6 +130,8 @@ static void cleanup(void)
 static bthf_client_interface_t iface = {
 	.size = sizeof(iface),
 	.init = init,
+	.connect = hf_client_connect,
+	.disconnect = disconnect,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 8b1e292..02cc798 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -976,6 +976,18 @@ struct hal_cmd_gatt_server_send_response {
 	uint8_t data[0];
 } __attribute__((packed));
 
+/* Handsfree client HAL API */
+
+#define HAL_OP_HF_CLIENT_CONNECT		0x01
+struct hal_cmd_hf_client_connect {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_OP_HF_CLIENT_DISCONNECT		0x02
+struct hal_cmd_hf_client_disconnect {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index c3ff555..f43829a 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -44,7 +44,27 @@ static bdaddr_t adapter_addr;
 
 static struct ipc *hal_ipc = NULL;
 
+static void handle_connect(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+			HAL_OP_HF_CLIENT_CONNECT, HAL_STATUS_UNSUPPORTED);
+}
+
+static void handle_disconnect(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+			HAL_OP_HF_CLIENT_DISCONNECT, HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
+	/* HAL_OP_HF_CLIENT_CONNECT */
+	{ handle_connect, false,
+				sizeof(struct hal_cmd_hf_client_connect) },
+	/* HAL_OP_HF_CLIENT_DISCONNECT */
+	{ handle_disconnect, false,
+				sizeof(struct hal_cmd_hf_client_disconnect) },
 };
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
-- 
1.8.4

