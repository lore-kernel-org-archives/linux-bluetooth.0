Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 4/4] android/handsfree-client: Handle disconnect command
Date: Tue, 11 Nov 2014 18:52:57 +0100
Message-Id: <1415728377-20880-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415728377-20880-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415728377-20880-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function adds handling of handsfree client disconnect.
This patch also moves device_set_state and device_destroy funtion in the
file as this is needed by the handle_disconnect
---
 android/handsfree-client.c | 118 ++++++++++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 38 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index ebf5d89..c576ae8 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -193,11 +193,89 @@ static struct device *get_device(const bdaddr_t *addr)
 	return NULL;
 }
 
+static void device_set_state(struct device *dev, uint8_t state)
+{
+	struct hal_ev_hf_client_conn_state ev;
+	char address[18];
+
+	if (dev->state == state)
+		return;
+
+	memset(&ev, 0, sizeof(ev));
+
+	dev->state = state;
+
+	ba2str(&dev->bdaddr, address);
+	DBG("device %s state %u", address, state);
+
+	bdaddr2android(&dev->bdaddr, ev.bdaddr);
+	ev.state = state;
+
+	ev.chld_feat = dev->chld_features;
+	ev.peer_feat = dev->features;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_EV_HF_CLIENT_CONN_STATE, sizeof(ev), &ev);
+}
+
+static void device_destroy(struct device *dev)
+{
+	device_set_state(dev, HAL_HF_CLIENT_CONN_STATE_DISCONNECTED);
+	queue_remove(devices, dev);
+
+	if (dev->hf)
+		hfp_hf_unref(dev->hf);
+
+	free(dev);
+}
+
 static void handle_disconnect(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct hal_cmd_hf_client_disconnect *cmd = buf;
+	struct device *dev;
+	uint32_t status;
+	bdaddr_t bdaddr;
+	char addr[18];
+
+	DBG("");
+
+	android2bdaddr(&cmd->bdaddr, &bdaddr);
+
+	ba2str(&bdaddr, addr);
+	DBG("Disconnect %s", addr);
+
+	dev = get_device(&bdaddr);
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (dev->state == HAL_HF_CLIENT_CONN_STATE_DISCONNECTED) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (dev->state == HAL_HF_CLIENT_CONN_STATE_DISCONNECTING) {
+		status = HAL_STATUS_SUCCESS;
+		goto done;
+	}
+
+	if (dev->state == HAL_HF_CLIENT_CONN_STATE_CONNECTING) {
+		device_destroy(dev);
+		status = HAL_STATUS_SUCCESS;
+		goto done;
+	}
+
+	status = hfp_hf_disconnect(dev->hf) ? HAL_STATUS_SUCCESS :
+							HAL_STATUS_FAILED;
+
+	if (status)
+		device_set_state(dev, HAL_HF_CLIENT_CONN_STATE_DISCONNECTING);
+
+done:
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
-			HAL_OP_HF_CLIENT_DISCONNECT, HAL_STATUS_UNSUPPORTED);
+			HAL_OP_HF_CLIENT_DISCONNECT, status);
 }
 
 static void handle_connect_audio(const void *buf, uint16_t len)
@@ -306,42 +384,6 @@ static void handle_get_last_vc_tag_num(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
-static void device_set_state(struct device *dev, uint8_t state)
-{
-	struct hal_ev_hf_client_conn_state ev;
-	char address[18];
-
-	if (dev->state == state)
-		return;
-
-	memset(&ev, 0, sizeof(ev));
-
-	dev->state = state;
-
-	ba2str(&dev->bdaddr, address);
-	DBG("device %s state %u", address, state);
-
-	bdaddr2android(&dev->bdaddr, ev.bdaddr);
-	ev.state = state;
-
-	ev.chld_feat = dev->chld_features;
-	ev.peer_feat = dev->features;
-
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
-				HAL_EV_HF_CLIENT_CONN_STATE, sizeof(ev), &ev);
-}
-
-static void device_destroy(struct device *dev)
-{
-	device_set_state(dev, HAL_HF_CLIENT_CONN_STATE_DISCONNECTED);
-	queue_remove(devices, dev);
-
-	if (dev->hf)
-		hfp_hf_unref(dev->hf);
-
-	free(dev);
-}
-
 static void disconnect_watch(void *user_data)
 {
 	DBG("");
-- 
1.8.4

