Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/8] android/AVRCP: Add implementation of SDP record
Date: Sun, 26 Jan 2014 15:55:44 -0800
Message-Id: <1390780546-18402-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390780546-18402-1-git-send-email-luiz.dentz@gmail.com>
References: <1390780546-18402-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following record:

Service Name: AVRCP TG
Service RecHandle: 0x10002
Service Class ID List:
  "AV Remote Target" (0x110c)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x103
Profile Descriptor List:
  "AV Remote" (0x110e)
    Version: 0x0100
---
 android/avrcp.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/android/avrcp.c b/android/avrcp.c
index a6fb5f5..a699865 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -29,22 +29,116 @@
 #include <glib.h>
 
 #include "lib/bluetooth.h"
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
 #include "src/log.h"
+#include "bluetooth.h"
 #include "avrcp.h"
 #include "hal-msg.h"
 #include "ipc.h"
 
+#define L2CAP_PSM_AVCTP 0x17
+
+#define AVRCP_FEATURE_CATEGORY_1	0x0001
+#define AVRCP_FEATURE_CATEGORY_2	0x0002
+#define AVRCP_FEATURE_CATEGORY_3	0x0004
+#define AVRCP_FEATURE_CATEGORY_4	0x0008
+
 static bdaddr_t adapter_addr;
+static uint32_t record_id = 0;
 
 static const struct ipc_handler cmd_handlers[] = {
 };
 
+static sdp_record_t *avrcp_record(void)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, l2cap, avctp, avrtg;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto_control, *proto_control[2];
+	sdp_record_t *record;
+	sdp_data_t *psm, *version, *features;
+	uint16_t lp = L2CAP_PSM_AVCTP;
+	uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
+	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
+					AVRCP_FEATURE_CATEGORY_2 |
+					AVRCP_FEATURE_CATEGORY_3 |
+					AVRCP_FEATURE_CATEGORY_4);
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	/* Service Class ID List */
+	sdp_uuid16_create(&avrtg, AV_REMOTE_TARGET_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &avrtg);
+	sdp_set_service_classes(record, svclass_id);
+
+	/* Protocol Descriptor List */
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto_control[0] = sdp_list_append(NULL, &l2cap);
+	psm = sdp_data_alloc(SDP_UINT16, &lp);
+	proto_control[0] = sdp_list_append(proto_control[0], psm);
+	apseq = sdp_list_append(NULL, proto_control[0]);
+
+	sdp_uuid16_create(&avctp, AVCTP_UUID);
+	proto_control[1] = sdp_list_append(NULL, &avctp);
+	version = sdp_data_alloc(SDP_UINT16, &avctp_ver);
+	proto_control[1] = sdp_list_append(proto_control[1], version);
+	apseq = sdp_list_append(apseq, proto_control[1]);
+
+	aproto_control = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto_control);
+
+	/* Bluetooth Profile Descriptor List */
+	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
+	profile[0].version = avrcp_ver;
+	pfseq = sdp_list_append(NULL, &profile[0]);
+	sdp_set_profile_descs(record, pfseq);
+
+	features = sdp_data_alloc(SDP_UINT16, &feat);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
+
+	sdp_set_info_attr(record, "AVRCP TG", 0, 0);
+
+	sdp_data_free(psm);
+	sdp_data_free(version);
+	sdp_list_free(proto_control[0], NULL);
+	sdp_list_free(proto_control[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(aproto_control, NULL);
+	sdp_list_free(pfseq, NULL);
+	sdp_list_free(root, NULL);
+	sdp_list_free(svclass_id, NULL);
+
+	return record;
+}
+
 bool bt_avrcp_register(const bdaddr_t *addr)
 {
+	sdp_record_t *rec;
+
 	DBG("");
 
 	bacpy(&adapter_addr, addr);
 
+	rec = avrcp_record();
+	if (!rec) {
+		error("Failed to allocate AVRCP record");
+		return false;
+	}
+
+	if (bt_adapter_add_record(rec, 0) < 0) {
+		error("Failed to register AVRCP record");
+		sdp_record_free(rec);
+		return false;
+	}
+	record_id = rec->handle;
+
 	ipc_register(HAL_SERVICE_ID_AVRCP, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
@@ -56,4 +150,7 @@ void bt_avrcp_unregister(void)
 	DBG("");
 
 	ipc_unregister(HAL_SERVICE_ID_AVRCP);
+
+	bt_adapter_remove_record(record_id);
+	record_id = 0;
 }
-- 
1.8.4.2

