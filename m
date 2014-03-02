Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 7/8] android/handsfree: Allow to connect to HSP or HFP handsfree unit
Date: Mon,  3 Mar 2014 00:50:48 +0100
Message-Id: <1393804249-12392-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
References: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to connect to HSP (it HFP is not enabled) or fallback to
HSP if HFP is not supported by remote device.
---
 android/handsfree.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 106 insertions(+), 7 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 0b97a5d..6149c62 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -184,7 +184,7 @@ drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
-static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
+static void sdp_hsp_search_cb(sdp_list_t *recs, int err, gpointer data)
 {
 	sdp_list_t *protos, *classes;
 	GError *gerr = NULL;
@@ -195,12 +195,13 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 	DBG("");
 
 	if (err < 0) {
-		error("handsfree: unable to get SDP record: %s", strerror(-err));
+		error("handsfree: unable to get SDP record: %s",
+								strerror(-err));
 		goto fail;
 	}
 
 	if (!recs || !recs->data) {
-		error("handsfree: no SDP records found");
+		info("handsfree: no HSP SDP records found");
 		goto fail;
 	}
 
@@ -216,6 +217,94 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 	}
 
 	/* TODO read remote version? */
+	/* TODO read volume control support */
+
+	memcpy(&uuid, classes->data, sizeof(uuid));
+	sdp_list_free(classes, free);
+
+	if (!sdp_uuid128_to_uuid(&uuid) || uuid.type != SDP_UUID16 ||
+			uuid.value.uuid16 != HEADSET_SVCLASS_ID) {
+		sdp_list_free(protos, NULL);
+		error("handsfree: invalid service record or not HSP");
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
+static int sdp_search_hsp(void)
+{
+	uuid_t uuid;
+
+	sdp_uuid16_create(&uuid, HEADSET_SVCLASS_ID);
+
+	return bt_search_service(&adapter_addr, &device.bdaddr, &uuid,
+					sdp_hsp_search_cb, NULL, NULL, 0);
+}
+
+static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
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
+		error("handsfree: unable to get SDP record: %s",
+								strerror(-err));
+		goto fail;
+	}
+
+	if (!recs || !recs->data) {
+		info("handsfree: no HFP SDP records found, trying HSP");
+
+		if (sdp_search_hsp() < 0) {
+			error("handsfree: HSP SDP search failed");
+			goto fail;
+		}
+
+		return;
+	}
+
+	if (sdp_get_service_classes(recs->data, &classes) < 0) {
+		error("handsfree: unable to get service classes from record");
+		goto fail;
+	}
+
+	if (sdp_get_access_protos(recs->data, &protos) < 0) {
+		error("handsfree: unable to get access protocols from record");
+		sdp_list_free(classes, free);
+		goto fail;
+	}
+
+	/* TODO read remote version? */
 
 	memcpy(&uuid, classes->data, sizeof(uuid));
 	sdp_list_free(classes, free);
@@ -254,13 +343,23 @@ fail:
 	device_cleanup();
 }
 
+static int sdp_search_hfp(void)
+{
+	uuid_t uuid;
+
+	sdp_uuid16_create(&uuid, HANDSFREE_SVCLASS_ID);
+
+	return bt_search_service(&adapter_addr, &device.bdaddr, &uuid,
+					sdp_hfp_search_cb, NULL, NULL, 0);
+}
+
 static void handle_connect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_connect *cmd = buf;
 	char addr[18];
 	uint8_t status;
-	uuid_t uuid;
 	bdaddr_t bdaddr;
+	int ret;
 
 	DBG("");
 
@@ -276,9 +375,9 @@ static void handle_connect(const void *buf, uint16_t len)
 
 	device_init(&bdaddr);
 
-	sdp_uuid16_create(&uuid, HANDSFREE_SVCLASS_ID);
-	if (bt_search_service(&adapter_addr, &device.bdaddr, &uuid,
-					sdp_search_cb, NULL, NULL, 0) < 0) {
+	/* prefer HFP over HSP */
+	ret = hfp_server ? sdp_search_hfp() : sdp_search_hsp();
+	if (ret < 0) {
 		error("handsfree: SDP search failed");
 		device_cleanup();
 		status = HAL_STATUS_FAILED;
-- 
1.8.5.3

