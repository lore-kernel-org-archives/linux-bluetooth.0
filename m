Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android/bluetooth: Register SDP record for MPS
Date: Thu, 22 May 2014 11:57:53 +0200
Message-Id: <1400752674-31232-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400752674-31232-1-git-send-email-szymon.janc@tieto.com>
References: <1400752674-31232-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This was affecting TC_AG_SRC_HFAV_ACT_SD_BV_01_I and
TC_SDP_CTH_SD_BV_01_I PTS qualification tests.
---
 android/bluetooth.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 379d8ea..afce43f 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -53,6 +53,28 @@
 #include "utils.h"
 #include "bluetooth.h"
 
+/* TODO consider MPS configuration bits dynamic based on registered HALs */
+
+/*
+ * bits in bitmask as defined in table 6.3 of Multi Profile Specification
+ * Currently enabled HFP + AV only
+ */
+#define MPS_DEFAULT_MPSD ((1 << 0) | (1 << 2) | (1 << 4) | (1 << 6) | \
+					(1 << 8) | (1 << 10) | (1 << 12))
+
+/*
+ * bits in bitmask as defined in table 6.4 of Multi Profile Specification
+ * Currently enabled HFP + AV only
+ */
+#define MPS_DEFAULT_MPMD ((1 << 1) | (1 << 3) | (1 << 5) | (1 << 6) | \
+					(1 << 8) | (1 << 10) | (1 << 12))
+
+/*
+ * bits in bitmask as defined in table 6.5 of Multi Profile Specification
+ * Note that in this table spec starts bit positions from 1 (bit 0 unused?)
+ */
+#define MPS_DEFAULT_DEPS ((1 << 1) | (1 << 2) | (1 << 3))
+
 #define DEFAULT_ADAPTER_NAME "BlueZ for Android"
 
 #define DUT_MODE_FILE "/sys/kernel/debug/bluetooth/hci%u/dut_mode"
@@ -2498,6 +2520,70 @@ static void set_adapter_class(void)
 	error("Failed to set class of device");
 }
 
+static sdp_record_t *mps_record(void)
+{
+	sdp_data_t *mpsd_features, *mpmd_features, *dependencies;
+	sdp_list_t *svclass_id, *pfseq, *root;
+	uuid_t root_uuid, svclass_uuid;
+	sdp_profile_desc_t profile;
+	sdp_record_t *record;
+	uint64_t mpsd_feat, mpmd_feat;
+	uint16_t deps;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&svclass_uuid, MPS_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &svclass_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile.uuid, MPS_PROFILE_ID);
+	profile.version = 0x0100;
+	pfseq = sdp_list_append(NULL, &profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	mpsd_feat = MPS_DEFAULT_MPSD;
+	mpsd_features = sdp_data_alloc(SDP_UINT64, &mpsd_feat);
+	sdp_attr_add(record, SDP_ATTR_MPSD_SCENARIOS, mpsd_features);
+
+	mpmd_feat = MPS_DEFAULT_MPMD;
+	mpmd_features = sdp_data_alloc(SDP_UINT64, &mpmd_feat);
+	sdp_attr_add(record, SDP_ATTR_MPMD_SCENARIOS, mpmd_features);
+
+	deps = MPS_DEFAULT_DEPS;
+	dependencies = sdp_data_alloc(SDP_UINT16, &deps);
+	sdp_attr_add(record, SDP_ATTR_MPS_DEPENDENCIES, dependencies);
+
+	sdp_set_info_attr(record, "Multi Profile", 0, 0);
+
+	sdp_list_free(pfseq, NULL);
+	sdp_list_free(root, NULL);
+	sdp_list_free(svclass_id, NULL);
+
+	return record;
+}
+
+static void add_mps_record(void)
+{
+	sdp_record_t *rec;
+
+	rec = mps_record();
+	if (!rec) {
+		error("Failed to allocate MPS record");
+		return;
+	}
+
+	if (bt_adapter_add_record(rec, 0) < 0) {
+		error("Failed to register MPS record");
+		sdp_record_free(rec);
+	}
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -2558,6 +2644,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
 	set_io_capability();
 	set_device_id();
+	add_mps_record();
 
 	missing_settings = adapter.current_settings ^
 						adapter.supported_settings;
-- 
1.9.1

