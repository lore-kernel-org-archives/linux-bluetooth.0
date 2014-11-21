Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 1/2] android/avrcp: Create avrcp-common.c|h files
Date: Fri, 21 Nov 2014 12:14:54 +0200
Message-Id: <1416564895-18577-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Keep the common code between avrcp target and controller roles
in avrcp-common.c|h.
---
 android/Android.mk     |   1 +
 android/Makefile.am    |   1 +
 android/avrcp-common.c | 171 +++++++++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-common.h |  25 ++++++++
 android/avrcp.c        | 149 +++---------------------------------------
 5 files changed, 207 insertions(+), 140 deletions(-)
 create mode 100644 android/avrcp-common.c
 create mode 100644 android/avrcp-common.h

diff --git a/android/Android.mk b/android/Android.mk
index adc5255..34c6186 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -47,6 +47,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/avdtp.c \
 	bluez/android/a2dp.c \
 	bluez/android/avctp.c \
+	bluez/android/avrcp-common.c \
 	bluez/android/avrcp.c \
 	bluez/android/avrcp-lib.c \
 	bluez/android/pan.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 3787489..98b8a3a 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -37,6 +37,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/avdtp.h android/avdtp.c \
 				android/a2dp.h android/a2dp.c \
 				android/avctp.h android/avctp.c \
+				android/avrcp-common.h android/avrcp-common.c \
 				android/avrcp.h android/avrcp.c \
 				android/avrcp-lib.h android/avrcp-lib.c \
 				android/socket.h android/socket.c \
diff --git a/android/avrcp-common.c b/android/avrcp-common.c
new file mode 100644
index 0000000..e486b59
--- /dev/null
+++ b/android/avrcp-common.c
@@ -0,0 +1,171 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <glib.h>
+
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+#include "src/sdp-client.h"
+#include "src/log.h"
+
+#include "avctp.h"
+#include "avrcp-common.h"
+
+#define L2CAP_PSM_AVCTP 0x17
+
+sdp_record_t *avrcp_tg_record(uint16_t feature)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, l2cap, avctp, avrtg;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto_control, *proto_control[2];
+	sdp_record_t *record;
+	sdp_data_t *psm, *version, *features;
+	uint16_t lp = L2CAP_PSM_AVCTP;
+	uint16_t avrcp_ver = 0x0105, avctp_ver = 0x0104;
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
+	features = sdp_data_alloc(SDP_UINT16, &feature);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
+
+	sdp_set_info_attr(record, "AVRCP TG", NULL, NULL);
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
+sdp_record_t *avrcp_ct_record(uint16_t feature)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, l2cap, avctp, avrct, avrctr;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto, *proto[2];
+	sdp_record_t *record;
+	sdp_data_t *psm, *version, *features;
+	uint16_t lp = AVCTP_CONTROL_PSM;
+	uint16_t avrcp_ver = 0x0105, avctp_ver = 0x0104;
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
+	sdp_uuid16_create(&avrct, AV_REMOTE_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &avrct);
+	sdp_uuid16_create(&avrctr, AV_REMOTE_CONTROLLER_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &avrctr);
+	sdp_set_service_classes(record, svclass_id);
+
+	/* Protocol Descriptor List */
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(NULL, &l2cap);
+	psm = sdp_data_alloc(SDP_UINT16, &lp);
+	proto[0] = sdp_list_append(proto[0], psm);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&avctp, AVCTP_UUID);
+	proto[1] = sdp_list_append(NULL, &avctp);
+	version = sdp_data_alloc(SDP_UINT16, &avctp_ver);
+	proto[1] = sdp_list_append(proto[1], version);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	/* Bluetooth Profile Descriptor List */
+	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
+	profile[0].version = avrcp_ver;
+	pfseq = sdp_list_append(NULL, &profile[0]);
+	sdp_set_profile_descs(record, pfseq);
+
+	features = sdp_data_alloc(SDP_UINT16, &feature);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
+
+	sdp_set_info_attr(record, "AVRCP CT", NULL, NULL);
+
+	free(psm);
+	free(version);
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
diff --git a/android/avrcp-common.h b/android/avrcp-common.h
new file mode 100644
index 0000000..a07105f
--- /dev/null
+++ b/android/avrcp-common.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+sdp_record_t *avrcp_tg_record(uint16_t feature);
+sdp_record_t *avrcp_ct_record(uint16_t feature);
diff --git a/android/avrcp.c b/android/avrcp.c
index a0d412d..d06ecc4 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -45,6 +45,7 @@
 #include "ipc.h"
 #include "bluetooth.h"
 #include "avrcp.h"
+#include "avrcp-common.h"
 #include "utils.h"
 
 #define L2CAP_PSM_AVCTP 0x17
@@ -382,144 +383,6 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_set_volume, false, sizeof(struct hal_cmd_avrcp_set_volume) },
 };
 
-static sdp_record_t *avrcp_tg_record(void)
-{
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
-	uuid_t root_uuid, l2cap, avctp, avrtg;
-	sdp_profile_desc_t profile[1];
-	sdp_list_t *aproto_control, *proto_control[2];
-	sdp_record_t *record;
-	sdp_data_t *psm, *version, *features;
-	uint16_t lp = L2CAP_PSM_AVCTP;
-	uint16_t avrcp_ver = 0x0105, avctp_ver = 0x0104;
-	uint16_t feat = (AVRCP_FEATURE_CATEGORY_1 |
-					AVRCP_FEATURE_CATEGORY_2 |
-					AVRCP_FEATURE_CATEGORY_3 |
-					AVRCP_FEATURE_CATEGORY_4);
-
-	record = sdp_record_alloc();
-	if (!record)
-		return NULL;
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(NULL, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	/* Service Class ID List */
-	sdp_uuid16_create(&avrtg, AV_REMOTE_TARGET_SVCLASS_ID);
-	svclass_id = sdp_list_append(NULL, &avrtg);
-	sdp_set_service_classes(record, svclass_id);
-
-	/* Protocol Descriptor List */
-	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto_control[0] = sdp_list_append(NULL, &l2cap);
-	psm = sdp_data_alloc(SDP_UINT16, &lp);
-	proto_control[0] = sdp_list_append(proto_control[0], psm);
-	apseq = sdp_list_append(NULL, proto_control[0]);
-
-	sdp_uuid16_create(&avctp, AVCTP_UUID);
-	proto_control[1] = sdp_list_append(NULL, &avctp);
-	version = sdp_data_alloc(SDP_UINT16, &avctp_ver);
-	proto_control[1] = sdp_list_append(proto_control[1], version);
-	apseq = sdp_list_append(apseq, proto_control[1]);
-
-	aproto_control = sdp_list_append(NULL, apseq);
-	sdp_set_access_protos(record, aproto_control);
-
-	/* Bluetooth Profile Descriptor List */
-	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
-	profile[0].version = avrcp_ver;
-	pfseq = sdp_list_append(NULL, &profile[0]);
-	sdp_set_profile_descs(record, pfseq);
-
-	features = sdp_data_alloc(SDP_UINT16, &feat);
-	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
-
-	sdp_set_info_attr(record, "AVRCP TG", NULL, NULL);
-
-	sdp_data_free(psm);
-	sdp_data_free(version);
-	sdp_list_free(proto_control[0], NULL);
-	sdp_list_free(proto_control[1], NULL);
-	sdp_list_free(apseq, NULL);
-	sdp_list_free(aproto_control, NULL);
-	sdp_list_free(pfseq, NULL);
-	sdp_list_free(root, NULL);
-	sdp_list_free(svclass_id, NULL);
-
-	return record;
-}
-
-static sdp_record_t *avrcp_ct_record(void)
-{
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
-	uuid_t root_uuid, l2cap, avctp, avrct, avrctr;
-	sdp_profile_desc_t profile[1];
-	sdp_list_t *aproto, *proto[2];
-	sdp_record_t *record;
-	sdp_data_t *psm, *version, *features;
-	uint16_t lp = AVCTP_CONTROL_PSM;
-	uint16_t avrcp_ver = 0x0105, avctp_ver = 0x0104;
-	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
-						AVRCP_FEATURE_CATEGORY_2 |
-						AVRCP_FEATURE_CATEGORY_3 |
-						AVRCP_FEATURE_CATEGORY_4);
-
-	record = sdp_record_alloc();
-	if (!record)
-		return NULL;
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(NULL, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	/* Service Class ID List */
-	sdp_uuid16_create(&avrct, AV_REMOTE_SVCLASS_ID);
-	svclass_id = sdp_list_append(NULL, &avrct);
-	sdp_uuid16_create(&avrctr, AV_REMOTE_CONTROLLER_SVCLASS_ID);
-	svclass_id = sdp_list_append(svclass_id, &avrctr);
-	sdp_set_service_classes(record, svclass_id);
-
-	/* Protocol Descriptor List */
-	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto[0] = sdp_list_append(NULL, &l2cap);
-	psm = sdp_data_alloc(SDP_UINT16, &lp);
-	proto[0] = sdp_list_append(proto[0], psm);
-	apseq = sdp_list_append(NULL, proto[0]);
-
-	sdp_uuid16_create(&avctp, AVCTP_UUID);
-	proto[1] = sdp_list_append(NULL, &avctp);
-	version = sdp_data_alloc(SDP_UINT16, &avctp_ver);
-	proto[1] = sdp_list_append(proto[1], version);
-	apseq = sdp_list_append(apseq, proto[1]);
-
-	aproto = sdp_list_append(NULL, apseq);
-	sdp_set_access_protos(record, aproto);
-
-	/* Bluetooth Profile Descriptor List */
-	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
-	profile[0].version = avrcp_ver;
-	pfseq = sdp_list_append(NULL, &profile[0]);
-	sdp_set_profile_descs(record, pfseq);
-
-	features = sdp_data_alloc(SDP_UINT16, &feat);
-	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
-
-	sdp_set_info_attr(record, "AVRCP CT", NULL, NULL);
-
-	free(psm);
-	free(version);
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
 static void avrcp_device_free(void *data)
 {
 	struct avrcp_device *dev = data;
@@ -1053,6 +916,7 @@ bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	GError *err = NULL;
 	sdp_record_t *rec;
+	uint16_t features;
 
 	DBG("");
 
@@ -1069,7 +933,12 @@ bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 		return false;
 	}
 
-	rec = avrcp_tg_record();
+	features = AVRCP_FEATURE_CATEGORY_1 |
+					AVRCP_FEATURE_CATEGORY_2 |
+					AVRCP_FEATURE_CATEGORY_3 |
+					AVRCP_FEATURE_CATEGORY_4;
+
+	rec = avrcp_tg_record(features);
 	if (!rec) {
 		error("Failed to allocate AVRCP TG record");
 		goto fail;
@@ -1082,7 +951,7 @@ bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 	}
 	record_tg_id = rec->handle;
 
-	rec = avrcp_ct_record();
+	rec = avrcp_ct_record(features);
 	if (!rec) {
 		error("Failed to allocate AVRCP CT record");
 		bt_adapter_remove_record(record_tg_id);
-- 
2.1.0

