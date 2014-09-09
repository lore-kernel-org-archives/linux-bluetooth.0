Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 08/39] android/hf-client: Add Connect/Disconnect commands
Date: Tue,  9 Sep 2014 21:56:53 +0200
Message-Id: <1410292644-23497-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 40 ++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h       | 10 ++++++++++
 android/hf-client.c     | 21 +++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 40553ff..5a31563 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
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
+	return hal_ipc_cmd(HAL_SERVICE_ID_HF_CLIENT, HAL_OP_HF_CLIENT_CONNECT,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
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
+	return hal_ipc_cmd(HAL_SERVICE_ID_HF_CLIENT,
+						HAL_OP_HF_CLIENT_DISCONNECT,
+						sizeof(cmd), &cmd, NULL, NULL,
+						NULL);
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
index 986f26b..fa8beb9 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -974,6 +974,16 @@ struct hal_cmd_avrcp_set_volume {
 	uint8_t value;
 } __attribute__((packed));
 
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
diff --git a/android/hf-client.c b/android/hf-client.c
index f1566d0..d6c2ef6 100644
--- a/android/hf-client.c
+++ b/android/hf-client.c
@@ -44,7 +44,28 @@ static bdaddr_t adapter_addr;
 
 static struct ipc *hal_ipc = NULL;
 
+static void handle_connect(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HF_CLIENT,
+			HAL_OP_HF_CLIENT_CONNECT, HAL_STATUS_UNSUPPORTED);
+}
+
+static void handle_disconnect(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HF_CLIENT,
+						HAL_OP_HF_CLIENT_DISCONNECT,
+						HAL_STATUS_UNSUPPORTED);
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

