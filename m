Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/13] android/handsfree: Add connect command handling
Date: Sun,  2 Feb 2014 22:09:20 +0100
Message-Id: <1391375364-27106-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to query SDP for RFCOMM channel and connect.
---
 android/handsfree.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index a4ce398..79e61b4 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -202,12 +202,111 @@ drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
+static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
+{
+	sdp_list_t *protos, *classes;
+	GError *gerr = NULL;
+	GIOChannel *io;
+	uuid_t uuid;
+	int channel;
+
+	DBG("");
+
+	if (err < 0) {
+		error("handsfree: unable to get SDP record: %s", strerror(-err));
+		goto fail;
+	}
+
+	if (!recs || !recs->data) {
+		error("handsfree: no SDP records found");
+		goto fail;
+	}
+
+	if (sdp_get_service_classes(recs->data, &classes) < 0) {
+		error("handsfree: unable to get service classes from record");
+		goto fail;
+	}
+
+	if (sdp_get_access_protos(recs->data, &protos) < 0) {
+		error("handsfree: unable to get access protocols from record");
+		goto fail;
+	}
+
+	/* TODO read remote version? */
+
+	memcpy(&uuid, classes->data, sizeof(uuid));
+	sdp_list_free(classes, free);
+
+	if (!sdp_uuid128_to_uuid(&uuid) || uuid.type != SDP_UUID16 ||
+			uuid.value.uuid16 != HANDSFREE_SVCLASS_ID) {
+		sdp_list_free(protos, NULL);
+		error("handsfree: invalid service record or not HFP");
+		goto fail;
+	}
+
+	channel = sdp_get_proto_port(protos, RFCOMM_UUID);
+	sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
+	sdp_list_free(protos, NULL);
+	if (channel <= 0) {
+		error("handsfree: unable to get RFCOMM channel from record");
+		goto fail;
+	}
+
+	io = bt_io_connect(connect_cb, NULL, NULL, &gerr,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+				BT_IO_OPT_DEST_BDADDR, &device.bdaddr,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_CHANNEL, channel,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("handsfree: unable to connect: %s", gerr->message);
+		g_error_free(gerr);
+		goto fail;
+	}
+
+	g_io_channel_unref(io);
+	return;
+
+fail:
+	device_cleanup();
+}
+
 static void handle_connect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_handsfree_connect *cmd = buf;
+	char addr[18];
+	uint8_t status;
+	uuid_t uuid;
+	bdaddr_t bdaddr;
+
 	DBG("");
 
+	if (device.state != HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTED) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	android2bdaddr(&cmd->bdaddr, &bdaddr);
+
+	ba2str(&device.bdaddr, addr);
+	DBG("connecting to %s", addr);
+
+	device_init(&bdaddr);
+
+	bt_string2uuid(&uuid, HFP_HS_UUID);
+	if (bt_search_service(&adapter_addr, &device.bdaddr, &uuid,
+					sdp_search_cb, NULL, NULL, 0) < 0) {
+		error("handsfree: SDP search failed");
+		device_cleanup();
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_CONNECT,
-							HAL_STATUS_FAILED);
+									status);
 }
 
 static void handle_disconnect(const void *buf, uint16_t len)
-- 
1.8.5.3

