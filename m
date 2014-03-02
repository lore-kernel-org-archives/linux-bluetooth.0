Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 6/8] android/handsfree: Add support for HSP AG
Date: Mon,  3 Mar 2014 00:50:47 +0100
Message-Id: <1393804249-12392-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
References: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 7a1d697..0b97a5d 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -46,7 +46,9 @@
 #include "src/log.h"
 #include "utils.h"
 
+#define HSP_AG_CHANNEL 12
 #define HFP_AG_CHANNEL 13
+
 #define HFP_AG_FEATURES 0
 
 static struct {
@@ -61,6 +63,9 @@ static struct ipc *hal_ipc = NULL;
 static uint32_t hfp_record_id = 0;
 static GIOChannel *hfp_server = NULL;
 
+static uint32_t hsp_record_id = 0;
+static GIOChannel *hsp_server = NULL;
+
 static void device_set_state(uint8_t state)
 {
 	struct hal_ev_handsfree_conn_state ev;
@@ -460,6 +465,129 @@ static const struct ipc_handler cmd_handlers[] = {
 			sizeof(struct hal_cmd_handsfree_phone_state_change)},
 };
 
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
+	profile.version = 0x0102;
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
+
+static bool enable_hsp_ag(void)
+{
+	sdp_record_t *rec;
+	GError *err = NULL;
+
+	DBG("");
+
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
+
+	hsp_record_id = rec->handle;
+
+	return true;
+
+failed:
+	g_io_channel_shutdown(hsp_server, TRUE, NULL);
+	g_io_channel_unref(hsp_server);
+	hsp_server = NULL;
+
+	return false;
+}
+
+static void cleanup_hsp_ag(void)
+{
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
+}
+
 static sdp_record_t *hfp_ag_record(void)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -597,9 +725,14 @@ bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 
 	bacpy(&adapter_addr, addr);
 
-	if (!enable_hfp_ag())
+	if (!enable_hsp_ag())
 		return false;
 
+	if (!enable_hfp_ag()) {
+		cleanup_hsp_ag();
+		return false;
+	}
+
 	hal_ipc = ipc;
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
@@ -615,4 +748,5 @@ void bt_handsfree_unregister(void)
 	hal_ipc = NULL;
 
 	cleanup_hfp_ag();
+	cleanup_hsp_ag();
 }
-- 
1.8.5.3

