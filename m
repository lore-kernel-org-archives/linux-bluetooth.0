Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 3/4] android/handsfree-client: Add support for outgoing connection
Date: Tue, 11 Nov 2014 18:52:56 +0100
Message-Id: <1415728377-20880-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415728377-20880-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415728377-20880-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 129 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 7 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index a059f57..ebf5d89 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -193,13 +193,6 @@ static struct device *get_device(const bdaddr_t *addr)
 	return NULL;
 }
 
-static void handle_connect(const void *buf, uint16_t len)
-{
-	DBG("Not Implemented");
-	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
-			HAL_OP_HF_CLIENT_CONNECT, HAL_STATUS_UNSUPPORTED);
-}
-
 static void handle_disconnect(const void *buf, uint16_t len)
 {
 	DBG("Not Implemented");
@@ -853,6 +846,128 @@ failed:
 	device_destroy(dev);
 }
 
+static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
+{
+	sdp_list_t *protos, *classes;
+	struct device *dev = data;
+	GError *gerr = NULL;
+	GIOChannel *io;
+	uuid_t uuid;
+	int channel;
+
+	DBG("");
+
+	if (err < 0) {
+		error("hf-client: unable to get SDP record: %s",
+							strerror(-err));
+		goto failed;
+	}
+
+	if (!recs || !recs->data) {
+		info("hf-client: no HFP SDP records found");
+		goto failed;
+	}
+
+	if (sdp_get_service_classes(recs->data, &classes) < 0 || !classes) {
+		error("hf-client: unable to get service classes from record");
+		goto failed;
+	}
+
+	/* TODO read remote version? */
+
+	memcpy(&uuid, classes->data, sizeof(uuid));
+	sdp_list_free(classes, free);
+
+	if (!sdp_uuid128_to_uuid(&uuid) || uuid.type != SDP_UUID16 ||
+			uuid.value.uuid16 != HANDSFREE_AGW_SVCLASS_ID) {
+		error("hf-client: invalid service record or not HFP");
+		goto failed;
+	}
+
+	if (sdp_get_access_protos(recs->data, &protos) < 0) {
+		error("hf-client: unable to get access protocols from record");
+		sdp_list_free(classes, free);
+		goto failed;
+	}
+
+	channel = sdp_get_proto_port(protos, RFCOMM_UUID);
+	sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
+	sdp_list_free(protos, NULL);
+	if (channel <= 0) {
+		error("hf-client: unable to get RFCOMM channel from record");
+		goto failed;
+	}
+
+	io = bt_io_connect(connect_cb, dev, NULL, &gerr,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+				BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_CHANNEL, channel,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("hf-client: unable to connect: %s", gerr->message);
+		g_error_free(gerr);
+		goto failed;
+	}
+
+	g_io_channel_unref(io);
+	return;
+
+failed:
+	device_destroy(dev);
+}
+
+static int sdp_search_hfp(struct device *dev)
+{
+	uuid_t uuid;
+
+	sdp_uuid16_create(&uuid, HANDSFREE_AGW_SVCLASS_ID);
+
+	return bt_search_service(&adapter_addr, &dev->bdaddr, &uuid,
+					sdp_hfp_search_cb, dev, NULL, 0);
+}
+
+static void handle_connect(const void *buf, uint16_t len)
+{
+	struct device *dev;
+	const struct hal_cmd_hf_client_connect *cmd = buf;
+	uint32_t status;
+	bdaddr_t bdaddr;
+	char addr[18];
+
+	DBG("");
+
+	android2bdaddr(&cmd->bdaddr, &bdaddr);
+
+	ba2str(&bdaddr, addr);
+	DBG("connecting to %s", addr);
+
+	dev = get_device(&bdaddr);
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (dev->state != HAL_HF_CLIENT_CONN_STATE_DISCONNECTED) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (sdp_search_hfp(dev) < 0) {
+		status = HAL_STATUS_FAILED;
+		device_destroy(dev);
+		goto done;
+	}
+
+	device_set_state(dev, HAL_HF_CLIENT_CONN_STATE_CONNECTING);
+
+	status = HAL_STATUS_SUCCESS;
+
+done:
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_OP_HF_CLIENT_CONNECT, status);
+}
+
 static void confirm_cb(GIOChannel *chan, gpointer data)
 {
 	struct device *dev;
-- 
1.8.4

