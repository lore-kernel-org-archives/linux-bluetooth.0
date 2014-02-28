Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/6] android/handsfree: Add support for enable HFP command
Date: Fri, 28 Feb 2014 17:19:30 +0100
Message-Id: <1393604374-10127-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393604374-10127-1-git-send-email-szymon.janc@tieto.com>
References: <1393604374-10127-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to not enable HFP AG when initializing HAL.
---
 android/handsfree.c | 246 ++++++++++++++++++++++++++++------------------------
 1 file changed, 132 insertions(+), 114 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 81ddcc7..e9478ad 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -56,10 +56,82 @@ static struct {
 } device;
 
 static bdaddr_t adapter_addr;
-static uint32_t record_id = 0;
+static uint32_t hfp_record_id = 0;
 static struct ipc *hal_ipc = NULL;
 
-static GIOChannel *server = NULL;
+static GIOChannel *hfp_server = NULL;
+
+static sdp_record_t *handsfree_ag_record(void)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
+	uuid_t l2cap_uuid, rfcomm_uuid;
+	sdp_profile_desc_t profile;
+	sdp_list_t *aproto, *proto[2];
+	sdp_record_t *record;
+	sdp_data_t *channel, *features;
+	uint8_t netid = 0x01;
+	uint16_t sdpfeat;
+	sdp_data_t *network;
+	uint8_t ch = HFP_AG_CHANNEL;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	network = sdp_data_alloc(SDP_UINT8, &netid);
+	if (!network) {
+		sdp_record_free(record);
+		return NULL;
+	}
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&svclass_uuid, HANDSFREE_AGW_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &svclass_uuid);
+	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile.uuid, HANDSFREE_PROFILE_ID);
+	profile.version = 0x0106;
+	pfseq = sdp_list_append(NULL, &profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+	proto[1] = sdp_list_append(NULL, &rfcomm_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &ch);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	sdpfeat = HFP_AG_FEATURES;
+	features = sdp_data_alloc(SDP_UINT16, &sdpfeat);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, "Hands-Free Audio Gateway", NULL, NULL);
+
+	sdp_attr_add(record, SDP_ATTR_EXTERNAL_NETWORK, network);
+
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(pfseq, NULL);
+	sdp_list_free(aproto, NULL);
+	sdp_list_free(root, NULL);
+	sdp_list_free(svclass_id, NULL);
+
+	return record;
+}
 
 static void device_set_state(uint8_t state)
 {
@@ -422,6 +494,54 @@ static void handle_phone_state_change(const void *buf, uint16_t len)
 					HAL_STATUS_FAILED);
 }
 
+static void handle_enable_hfp(const void *buf, uint16_t len)
+{
+	sdp_record_t *rec;
+	GError *err = NULL;
+
+	DBG("");
+
+	if (hfp_server)
+		goto failed;
+
+	hfp_server =  bt_io_listen(NULL, confirm_cb, NULL, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+				BT_IO_OPT_CHANNEL, HFP_AG_CHANNEL,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_INVALID);
+	if (!hfp_server) {
+		error("Failed to listen on Handsfree rfcomm: %s", err->message);
+		g_error_free(err);
+		goto failed;
+	}
+
+	rec = handsfree_ag_record();
+	if (!rec) {
+		error("Failed to allocate Handsfree record");
+		goto failed_io;
+	}
+
+	if (bt_adapter_add_record(rec, 0) < 0) {
+		error("Failed to register Handsfree record");
+		sdp_record_free(rec);
+		goto failed_io;
+	}
+	hfp_record_id = rec->handle;
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+			HAL_OP_HANDSFREE_ENABLE_HFP, HAL_STATUS_SUCCESS);
+	return;
+
+failed_io:
+	g_io_channel_shutdown(hfp_server, TRUE, NULL);
+	g_io_channel_unref(hfp_server);
+	hfp_server = NULL;
+
+failed:
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+			HAL_OP_HANDSFREE_ENABLE_HFP, HAL_STATUS_FAILED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HANDSFREE_CONNECT */
 	{ handle_connect, false, sizeof(struct hal_cmd_handsfree_connect)},
@@ -458,125 +578,21 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HANDSFREE_PHONE_STATE_CHANGE */
 	{handle_phone_state_change, true,
 			sizeof(struct hal_cmd_handsfree_phone_state_change)},
+	/* HAL_OP_HANDSFREE_ENABLE_HFP */
+	{handle_enable_hfp, false, 0 },
 };
 
-static sdp_record_t *handsfree_ag_record(void)
-{
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
-	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
-	uuid_t l2cap_uuid, rfcomm_uuid;
-	sdp_profile_desc_t profile;
-	sdp_list_t *aproto, *proto[2];
-	sdp_record_t *record;
-	sdp_data_t *channel, *features;
-	uint8_t netid = 0x01;
-	uint16_t sdpfeat;
-	sdp_data_t *network;
-	uint8_t ch = HFP_AG_CHANNEL;
-
-	record = sdp_record_alloc();
-	if (!record)
-		return NULL;
-
-	network = sdp_data_alloc(SDP_UINT8, &netid);
-	if (!network) {
-		sdp_record_free(record);
-		return NULL;
-	}
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(NULL, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	sdp_uuid16_create(&svclass_uuid, HANDSFREE_AGW_SVCLASS_ID);
-	svclass_id = sdp_list_append(NULL, &svclass_uuid);
-	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
-	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
-	sdp_set_service_classes(record, svclass_id);
-
-	sdp_uuid16_create(&profile.uuid, HANDSFREE_PROFILE_ID);
-	profile.version = 0x0106;
-	pfseq = sdp_list_append(NULL, &profile);
-	sdp_set_profile_descs(record, pfseq);
-
-	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
-	proto[0] = sdp_list_append(0, &l2cap_uuid);
-	apseq = sdp_list_append(NULL, proto[0]);
-
-	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
-	proto[1] = sdp_list_append(NULL, &rfcomm_uuid);
-	channel = sdp_data_alloc(SDP_UINT8, &ch);
-	proto[1] = sdp_list_append(proto[1], channel);
-	apseq = sdp_list_append(apseq, proto[1]);
-
-	sdpfeat = HFP_AG_FEATURES;
-	features = sdp_data_alloc(SDP_UINT16, &sdpfeat);
-	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
-
-	aproto = sdp_list_append(NULL, apseq);
-	sdp_set_access_protos(record, aproto);
-
-	sdp_set_info_attr(record, "Hands-Free Audio Gateway", NULL, NULL);
-
-	sdp_attr_add(record, SDP_ATTR_EXTERNAL_NETWORK, network);
-
-	sdp_data_free(channel);
-	sdp_list_free(proto[0], NULL);
-	sdp_list_free(proto[1], NULL);
-	sdp_list_free(apseq, NULL);
-	sdp_list_free(pfseq, NULL);
-	sdp_list_free(aproto, NULL);
-	sdp_list_free(root, NULL);
-	sdp_list_free(svclass_id, NULL);
-
-	return record;
-}
-
 bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr)
 {
-	sdp_record_t *rec;
-	GError *err = NULL;
-
 	DBG("");
 
 	bacpy(&adapter_addr, addr);
 
-	server =  bt_io_listen( NULL, confirm_cb, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
-				BT_IO_OPT_CHANNEL, HFP_AG_CHANNEL,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_INVALID);
-	if (!server) {
-		error("Failed to listen on Handsfree rfcomm: %s", err->message);
-		g_error_free(err);
-		return false;
-	}
-
-	rec = handsfree_ag_record();
-	if (!rec) {
-		error("Failed to allocate Handsfree record");
-		goto failed;
-	}
-
-	if (bt_adapter_add_record(rec, 0) < 0) {
-		error("Failed to register Handsfree record");
-		sdp_record_free(rec);
-		goto failed;
-	}
-	record_id = rec->handle;
-
 	hal_ipc = ipc;
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
 	return true;
-
-failed:
-	g_io_channel_shutdown(server, TRUE, NULL);
-	g_io_channel_unref(server);
-	server = NULL;
-
-	return false;
 }
 
 void bt_handsfree_unregister(void)
@@ -586,12 +602,14 @@ void bt_handsfree_unregister(void)
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HANDSFREE);
 	hal_ipc = NULL;
 
-	if (server) {
-		g_io_channel_shutdown(server, TRUE, NULL);
-		g_io_channel_unref(server);
-		server = NULL;
+	if (hfp_server) {
+		g_io_channel_shutdown(hfp_server, TRUE, NULL);
+		g_io_channel_unref(hfp_server);
+		hfp_server = NULL;
 	}
 
-	bt_adapter_remove_record(record_id);
-	record_id = 0;
+	if (hfp_record_id > 0) {
+		bt_adapter_remove_record(hfp_record_id);
+		hfp_record_id = 0;
+	}
 }
-- 
1.8.3.2

