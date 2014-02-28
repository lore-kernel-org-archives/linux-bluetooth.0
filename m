Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/6] android/handsfree: Add support for HSP AG
Date: Fri, 28 Feb 2014 17:19:33 +0100
Message-Id: <1393604374-10127-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393604374-10127-1-git-send-email-szymon.janc@tieto.com>
References: <1393604374-10127-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 3 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index e9478ad..6052d5d 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -47,6 +47,8 @@
 #include "utils.h"
 
 #define HFP_AG_CHANNEL 13
+#define HSP_AG_CHANNEL 11
+
 #define HFP_AG_FEATURES 0
 
 static struct {
@@ -56,11 +58,78 @@ static struct {
 } device;
 
 static bdaddr_t adapter_addr;
-static uint32_t hfp_record_id = 0;
 static struct ipc *hal_ipc = NULL;
 
+static uint32_t hfp_record_id = 0;
 static GIOChannel *hfp_server = NULL;
 
+static uint32_t hsp_record_id = 0;
+static GIOChannel *hsp_server = NULL;
+
+static sdp_record_t *headset_ag_record(void)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
+	uuid_t l2cap_uuid, rfcomm_uuid;
+	sdp_profile_desc_t profile;
+	sdp_list_t *aproto, *proto[2];
+	sdp_record_t *record;
+	sdp_data_t *channel;
+	uint8_t netid = 0x01;
+	sdp_data_t *network;
+	uint8_t ch = HSP_AG_CHANNEL;
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
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&svclass_uuid, HEADSET_AGW_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &svclass_uuid);
+	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile.uuid, HEADSET_PROFILE_ID);
+	profile.version = 0x0100;
+	pfseq = sdp_list_append(0, &profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	apseq = sdp_list_append(0, proto[0]);
+
+	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+	proto[1] = sdp_list_append(0, &rfcomm_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &ch);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, "Voice Gateway", 0, 0);
+
+	sdp_attr_add(record, SDP_ATTR_EXTERNAL_NETWORK, network);
+
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(aproto, 0);
+
+	return record;
+}
+
 static sdp_record_t *handsfree_ag_record(void)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -584,23 +653,66 @@ static const struct ipc_handler cmd_handlers[] = {
 
 bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr)
 {
+	sdp_record_t *rec;
+	GError *err = NULL;
+
 	DBG("");
 
 	bacpy(&adapter_addr, addr);
 
+	hsp_server =  bt_io_listen(NULL, confirm_cb, NULL, NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+					BT_IO_OPT_CHANNEL, HSP_AG_CHANNEL,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_INVALID);
+	if (!hsp_server) {
+		error("Failed to listen on Headset rfcomm: %s", err->message);
+		g_error_free(err);
+		return false;
+	}
+
+	rec = headset_ag_record();
+	if (!rec) {
+		error("Failed to allocate Headset record");
+		goto failed;
+	}
+
+	if (bt_adapter_add_record(rec, 0) < 0) {
+		error("Failed to register Headset record");
+		sdp_record_free(rec);
+		goto failed;
+	}
+	hsp_record_id = rec->handle;
+
 	hal_ipc = ipc;
+
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
 	return true;
+
+failed:
+	g_io_channel_shutdown(hsp_server, TRUE, NULL);
+	g_io_channel_unref(hsp_server);
+	hsp_server = NULL;
+
+	return false;
 }
 
 void bt_handsfree_unregister(void)
 {
 	DBG("");
 
-	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HANDSFREE);
-	hal_ipc = NULL;
+	if (hsp_server) {
+		g_io_channel_shutdown(hsp_server, TRUE, NULL);
+		g_io_channel_unref(hsp_server);
+		hsp_server = NULL;
+	}
+
+	if (hsp_record_id > 0) {
+		bt_adapter_remove_record(hsp_record_id);
+		hsp_record_id = 0;
+	}
 
 	if (hfp_server) {
 		g_io_channel_shutdown(hfp_server, TRUE, NULL);
@@ -612,4 +724,7 @@ void bt_handsfree_unregister(void)
 		bt_adapter_remove_record(hfp_record_id);
 		hfp_record_id = 0;
 	}
+
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HANDSFREE);
+	hal_ipc = NULL;
 }
-- 
1.8.3.2

