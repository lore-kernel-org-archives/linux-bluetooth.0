Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/7] android/handsfree-client: Add service record
Date: Wed,  5 Nov 2014 12:22:06 +0100
Message-Id: <1415186531-23288-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415186531-23288-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415186531-23288-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds service record for HFP 1.6 HF role

Note that we do not fix codec negotiation feature as this will be later
controled by android property
---
 android/handsfree-client.c | 130 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 773ef76..b63aa13 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -32,18 +32,44 @@
 #include <glib.h>
 
 #include "lib/bluetooth.h"
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+#include "src/sdp-client.h"
 #include "ipc.h"
 #include "ipc-common.h"
 #include "src/log.h"
 #include "utils.h"
 
+#include "bluetooth.h"
 #include "hal-msg.h"
 #include "handsfree-client.h"
 
+#define HFP_HF_CHANNEL 7
+
+#define HFP_HF_FEAT_ECNR	0x00000001
+#define HFP_HF_FEAT_3WAY	0x00000002
+#define HFP_HF_FEAT_CLI		0x00000004
+#define HFP_HF_FEAT_VR		0x00000008
+#define HFP_HF_FEAT_RVC		0x00000010
+#define HFP_HF_FEAT_ECS		0x00000020
+#define HFP_HF_FEAT_ECC		0x00000040
+#define HFP_HF_FEAT_CODEC	0x00000080
+#define HFP_HF_FEAT_HF_IND	0x00000100
+#define HFP_HF_FEAT_ESCO_S4_T2	0x00000200
+
+
+#define HFP_HF_FEATURES (HFP_HF_FEAT_ECNR | HFP_HF_FEAT_3WAY |\
+				HFP_HF_FEAT_CLI | HFP_HF_FEAT_VR |\
+				HFP_HF_FEAT_RVC | HFP_HF_FEAT_ECS |\
+				HFP_HF_FEAT_ECC)
+
 static bdaddr_t adapter_addr;
 
 static struct ipc *hal_ipc = NULL;
 
+static uint32_t hfp_hf_features = 0;
+static uint32_t hfp_hf_record_id = 0;
+
 static void handle_connect(const void *buf, uint16_t len)
 {
 	DBG("Not Implemented");
@@ -205,12 +231,114 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_get_last_vc_tag_num, false, 0 },
 };
 
+static sdp_record_t *hfp_hf_record(void)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
+	uuid_t l2cap_uuid, rfcomm_uuid;
+	sdp_profile_desc_t profile;
+	sdp_list_t *aproto, *proto[2];
+	sdp_record_t *record;
+	sdp_data_t *channel, *features;
+	uint16_t sdpfeat;
+	uint8_t ch = HFP_HF_CHANNEL;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&svclass_uuid, HANDSFREE_SVCLASS_ID);
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
+	proto[0] = sdp_list_append(NULL, &l2cap_uuid);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+	proto[1] = sdp_list_append(NULL, &rfcomm_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &ch);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	/* Codec Negotiation bit in SDP feature is different then in BRSF */
+	sdpfeat = hfp_hf_features & 0x0000003F;
+	if (hfp_hf_features & HFP_HF_FEAT_CODEC)
+		sdpfeat |= 0x00000020;
+	else
+		sdpfeat &= ~0x00000020;
+
+	features = sdp_data_alloc(SDP_UINT16, &sdpfeat);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, "Hands-Free unit", NULL, NULL);
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
+static bool enable_hf_client(void)
+{
+	sdp_record_t *rec;
+
+	hfp_hf_features = HFP_HF_FEATURES;
+
+	rec = hfp_hf_record();
+	if (!rec) {
+		error("hf-client: Could not create service record");
+		return false;
+	}
+
+	if (bt_adapter_add_record(rec, 0) < 0) {
+		error("hf-client: Failed to register service record");
+		sdp_record_free(rec);
+		return false;
+	}
+
+	hfp_hf_record_id = rec->handle;
+
+	return true;
+}
+
+static void cleanup_hfp_hf(void)
+{
+	if (hfp_hf_record_id > 0) {
+		bt_adapter_remove_record(hfp_hf_record_id);
+		hfp_hf_record_id = 0;
+	}
+}
+
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	DBG("");
 
 	bacpy(&adapter_addr, addr);
 
+	if (!enable_hf_client())
+		return false;
+
 	hal_ipc = ipc;
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
@@ -222,6 +350,8 @@ void bt_hf_client_unregister(void)
 {
 	DBG("");
 
+	cleanup_hfp_hf();
+
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HANDSFREE);
 	hal_ipc = NULL;
 }
-- 
1.8.4

