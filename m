Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/4] android: Use common MPS implementation
Date: Sat, 14 Feb 2015 14:02:25 +0100
Message-Id: <1423918946-14332-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423918946-14332-1-git-send-email-szymon.janc@tieto.com>
References: <1423918946-14332-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allow for dynamic MPS configuration ie fixing MPS on tablets.
---
 android/bluetooth.c | 109 +++++-----------------------------------------------
 1 file changed, 9 insertions(+), 100 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index fdf7b91..b99dab1 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -54,40 +54,6 @@
 #include "utils.h"
 #include "bluetooth.h"
 
-/*
- * bits in bitmask as defined in table 6.3 of Multi Profile Specification
- * HFP AG + A2DP SRC + AVRCP TG + PAN (NAP/PANU) + PBAP PSE
- */
-#define MPS_DEFAULT_MPSD ((1ULL << 0) | (1ULL << 2) | (1ULL << 4) | \
-				(1ULL << 6) | (1ULL << 8) | (1ULL << 10) | \
-				(1ULL << 12) | (1ULL << 26) | (1ULL << 28) | \
-				(1ULL << 30) | (1ULL << 32) | (1ULL << 34) | \
-				(1ULL << 36))
-
-/*
- * bits in bitmask as defined in table 6.4 of Multi Profile Specification
- * HFP AG + A2DP SRC + AVRCP TG + PAN (NAP/PANU) + PBAP PSE
- */
-#define MPS_DEFAULT_MPMD ((1ULL << 1) | (1ULL << 3) | (1ULL << 5) | \
-				(1ULL << 6) | (1ULL << 8) | (1ULL << 10) | \
-				(1ULL << 12) | (1ULL << 15) | (1ULL << 17))
-
-/*
- * bits in bitmask as defined in table 6.5 of Multi Profile Specification
- * Note that in this table spec starts bit positions from 1 (bit 0 unused?)
- */
-#define MPS_DEFAULT_DEPS ((1 << 1) | (1 << 2) | (1 << 3))
-
-/* MPSD bit dependent on HFP AG support */
-#define MPS_MPSD_HFP_AG_DEP ((1ULL << 0) | (1ULL << 2) | (1ULL << 4) | \
-				(1ULL << 6) | (1ULL << 8) | (1ULL << 10) | \
-				(1ULL << 12) | (1ULL << 14) | (1ULL << 16) | \
-				(1ULL << 18) | (1ULL << 26) | (1ULL << 28) | \
-				(1ULL << 30))
-
-/* MPMD bit dependent on HFP AG support */
-#define MPS_MPMD_HFP_AG_DEP (1ULL << 6)
-
 #define DUT_MODE_FILE "/sys/kernel/debug/bluetooth/hci%u/dut_mode"
 
 #define SETTINGS_FILE ANDROID_STORAGEDIR"/settings"
@@ -3310,75 +3276,18 @@ static void set_adapter_class(void)
 	error("Failed to set class of device");
 }
 
-static sdp_record_t *mps_record(void)
+static void enable_mps(void)
 {
-	sdp_data_t *mpsd_features, *mpmd_features, *dependencies;
-	sdp_list_t *svclass_id, *pfseq, *root;
-	uuid_t root_uuid, svclass_uuid;
-	sdp_profile_desc_t profile;
-	sdp_record_t *record;
-	uint64_t mpsd_feat, mpmd_feat;
-	uint16_t deps;
-
-	record = sdp_record_alloc();
-	if (!record)
-		return NULL;
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(NULL, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	sdp_uuid16_create(&svclass_uuid, MPS_SVCLASS_ID);
-	svclass_id = sdp_list_append(NULL, &svclass_uuid);
-	sdp_set_service_classes(record, svclass_id);
-
-	sdp_uuid16_create(&profile.uuid, MPS_PROFILE_ID);
-	profile.version = 0x0100;
-	pfseq = sdp_list_append(NULL, &profile);
-	sdp_set_profile_descs(record, pfseq);
+	uuid_t uuid, *uuid128;
 
-	mpsd_feat = MPS_DEFAULT_MPSD;
-	mpmd_feat = MPS_DEFAULT_MPMD;
-
-	/* TODO should be configurable based on HFP AG support */
-	if (false) {
-		mpsd_feat &= MPS_MPSD_HFP_AG_DEP;
-		mpmd_feat &= MPS_MPMD_HFP_AG_DEP;
-	}
-
-	mpsd_features = sdp_data_alloc(SDP_UINT64, &mpsd_feat);
-	sdp_attr_add(record, SDP_ATTR_MPSD_SCENARIOS, mpsd_features);
-
-	mpmd_features = sdp_data_alloc(SDP_UINT64, &mpmd_feat);
-	sdp_attr_add(record, SDP_ATTR_MPMD_SCENARIOS, mpmd_features);
-
-	deps = MPS_DEFAULT_DEPS;
-	dependencies = sdp_data_alloc(SDP_UINT16, &deps);
-	sdp_attr_add(record, SDP_ATTR_MPS_DEPENDENCIES, dependencies);
-
-	sdp_set_info_attr(record, "Multi Profile", 0, 0);
-
-	sdp_list_free(pfseq, NULL);
-	sdp_list_free(root, NULL);
-	sdp_list_free(svclass_id, NULL);
-
-	return record;
-}
-
-static void add_mps_record(void)
-{
-	sdp_record_t *rec;
-
-	rec = mps_record();
-	if (!rec) {
-		error("Failed to allocate MPS record");
+	sdp_uuid16_create(&uuid, MPS_PROFILE_ID);
+	uuid128 = sdp_uuid_to_uuid128(&uuid);
+	if (!uuid128)
 		return;
-	}
 
-	if (bt_adapter_add_record(rec, 0) < 0) {
-		error("Failed to register MPS record");
-		sdp_record_free(rec);
-	}
+	register_mps(true);
+	adapter.uuids = g_slist_prepend(adapter.uuids, uuid128);
+	add_uuid(0, uuid128);
 }
 
 static void clear_auto_connect_list_complete(uint8_t status,
@@ -3467,7 +3376,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
 	set_io_capability();
 	set_device_id();
-	add_mps_record();
+	enable_mps();
 
 	missing_settings = adapter.current_settings ^
 						adapter.supported_settings;
-- 
1.9.3

