Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/4] sdp: Add initial support for MPS
Date: Wed, 10 Dec 2014 12:20:50 +0100
Message-Id: <1418210453-21036-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to register Multi Profile Specification record with proper
MPSD bits set depending on currently registered services.

Service Name: Multi Profile
Service RecHandle: 0x10001
Service Class ID List:
  "" (0x113b)
Profile Descriptor List:
  "" (0x113a)
    Version: 0x0100
---
 src/main.c          |   1 +
 src/sdpd-database.c |   1 +
 src/sdpd-request.c  |   1 +
 src/sdpd-server.c   |   1 +
 src/sdpd-service.c  | 230 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/sdpd.h          |   1 +
 6 files changed, 234 insertions(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 061060d..b3140d0 100644
--- a/src/main.c
+++ b/src/main.c
@@ -33,6 +33,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <signal.h>
+#include <stdbool.h>
 #include <sys/signalfd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index 6f5577b..e3b9e09 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -29,6 +29,7 @@
 #endif
 
 #include <stdlib.h>
+#include <stdbool.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 3e58c22..081e7c8 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -31,6 +31,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <limits.h>
+#include <stdbool.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index 015551d..8ecda9b 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -31,6 +31,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index a90b299..f3e4a28 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -32,6 +32,7 @@
 #include <stdlib.h>
 #include <assert.h>
 #include <sys/time.h>
+#include <stdbool.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
@@ -43,6 +44,72 @@
 #include "sdpd.h"
 #include "log.h"
 
+/*
+ * default MPS features are all disabled, will be updated if relevant service
+ * is (un)registered
+ */
+#define MPS_MPSD_DEFAULT_FEATURES 0
+#define MPS_MPMD_DEFAULT_FEATURES 0
+
+/*
+ * Those defines bits for all features that depend on specific profile and role.
+ * If profile is not supported then all those bits should not be set in record
+ */
+#define MPS_MPSD_HFP_AG ((1ULL << 0) | (1ULL << 2) | (1ULL << 4) | \
+			(1ULL << 6) | (1ULL << 8) | (1ULL << 10) | \
+			(1ULL << 12) | (1ULL << 16) | (1ULL << 18) | \
+			(1ULL << 24) | (1ULL << 26) | (1ULL << 28) | \
+			(1ULL << 30))
+
+#define MPS_MPSD_HFP_HF ((1ULL << 1) | (1ULL << 3) | (1ULL << 5) | \
+			(1ULL << 7) | (1ULL << 9) | (1ULL << 11) | \
+			(1ULL << 13) | (1ULL << 15) | (1ULL << 17) | \
+			(1ULL << 19) | (1ULL << 25) | (1ULL << 27) | \
+			(1ULL << 29) | (1ULL << 31))
+
+#define MPS_MPSD_A2DP_SRC ((1ULL << 0) | (1ULL << 2) | (1ULL << 4) |\
+				(1ULL << 6) | (1ULL << 8) | (1ULL << 10) | \
+				(1ULL << 12) | (1ULL << 20) | (1ULL << 22) | \
+				(1ULL << 32) | (1ULL << 34) | (1ULL << 36))
+
+#define MPS_MPSD_A2DP_SNK ((1ULL << 1) | (1ULL << 3) | (1ULL << 5) | \
+				(1ULL << 7) | (1ULL << 9) | (1ULL << 11) | \
+				(1ULL << 13) | (1ULL << 21) | (1ULL << 23) | \
+				(1ULL << 33) | (1ULL << 35) | (1ULL << 37))
+
+#define MPS_MPSD_AVRCP_CT MPS_MPSD_A2DP_SNK
+
+#define MPS_MPSD_AVRCP_TG MPS_MPSD_A2DP_SRC
+
+#define MPS_MPSD_DUN_GW ((1ULL << 14) | (1ULL << 16) | (1ULL << 18) | \
+			(1ULL << 20) | (1ULL << 22) | (1ULL << 24))
+
+#define MPS_MPSD_DUN_DT ((1ULL << 15) | (1ULL << 17) | (1ULL << 19) | \
+			(1ULL << 21) | (1ULL << 23) | (1ULL << 25))
+
+#define MPS_MPSD_PAN_NAP ((1ULL << 26) | (1ULL << 28) | (1ULL << 30) | \
+				(1ULL << 32) | (1ULL << 34))
+
+#define MPS_MPSD_PAN_PANU ((1ULL << 27) | (1ULL << 29) | (1ULL << 31) | \
+				(1ULL << 33) | (1ULL << 35))
+
+#define MPS_MPSD_PBAP_SRC (1ULL << 36)
+#define MPS_MPSD_PBAP_CLI (1ULL << 37)
+
+#define MPS_MPSD_ALL (MPS_MPSD_HFP_AG | MPS_MPSD_HFP_HF | \
+			MPS_MPSD_A2DP_SRC | MPS_MPSD_A2DP_SNK | \
+			MPS_MPSD_AVRCP_CT | MPS_MPSD_AVRCP_TG | \
+			MPS_MPSD_DUN_GW | MPS_MPSD_DUN_DT | \
+			MPS_MPSD_PAN_NAP | MPS_MPSD_PAN_PANU | \
+			MPS_MPSD_PBAP_SRC | MPS_MPSD_PBAP_CLI)
+
+/*
+ * Assume all dependencies are supported.
+ * Bits in bitmask as defined in table 6.5 of Multi Profile Specification
+ * Note that in this table spec starts bit positions from 1 (bit 0 unused?)
+ */
+#define MPS_DEFAULT_DEPS ((1 << 1) | (1 << 2) | (1 << 3))
+
 static sdp_record_t *server = NULL;
 static uint32_t fixed_dbts = 0;
 
@@ -55,6 +122,9 @@ static sdp_version_t sdpVnumArray[1] = {
 };
 static const int sdpServerVnumEntries = 1;
 
+static uint32_t mps_handle = 0;
+static bool mps_mpmd = false;
+
 /*
  * A simple function which returns the time of day in
  * seconds. Used for updating the service db state
@@ -235,6 +305,161 @@ void register_device_id(uint16_t source, uint16_t vendor,
 	update_db_timestamp();
 }
 
+static bool class_supported(uint16_t class)
+{
+	sdp_list_t *list;
+	uuid_t uuid;
+
+	sdp_uuid16_create(&uuid, class);
+
+	for (list = sdp_get_record_list(); list; list = list->next) {
+		sdp_record_t *rec = list->data;
+
+		if (sdp_uuid_cmp(&rec->svclass, &uuid) == 0)
+			return true;
+	}
+
+	return false;
+}
+
+static uint64_t mps_mpsd_features(void)
+{
+	uint64_t feat = MPS_MPSD_ALL;
+
+	if (!class_supported(HANDSFREE_AGW_SVCLASS_ID))
+		feat &= ~MPS_MPSD_HFP_AG;
+
+	if (!class_supported(HANDSFREE_SVCLASS_ID))
+		feat &= ~MPS_MPSD_HFP_HF;
+
+	if (!class_supported(AUDIO_SOURCE_SVCLASS_ID))
+		feat &= ~MPS_MPSD_A2DP_SRC;
+
+	if (!class_supported(AUDIO_SINK_SVCLASS_ID))
+		feat &= ~MPS_MPSD_A2DP_SNK;
+
+	if (!class_supported(AV_REMOTE_CONTROLLER_SVCLASS_ID))
+		feat &= ~MPS_MPSD_AVRCP_CT;
+
+	if (!class_supported(AV_REMOTE_TARGET_SVCLASS_ID))
+		feat &= ~MPS_MPSD_AVRCP_TG;
+
+	if (!class_supported(DIALUP_NET_SVCLASS_ID))
+		feat &= ~MPS_MPSD_DUN_GW;
+
+	/* TODO */
+	feat &= ~MPS_MPSD_DUN_DT;
+
+	if (!class_supported(NAP_SVCLASS_ID))
+		feat &= ~MPS_MPSD_PAN_NAP;
+
+	if (!class_supported(PANU_SVCLASS_ID))
+		feat &= ~MPS_MPSD_PAN_PANU;
+
+	if (!class_supported(PBAP_PSE_SVCLASS_ID))
+		feat &= ~MPS_MPSD_PBAP_SRC;
+
+	if (!class_supported(PBAP_PCE_SVCLASS_ID))
+		feat &= ~MPS_MPSD_PBAP_CLI;
+
+	return feat;
+}
+
+static uint64_t mps_mpmd_features(void)
+{
+	/* TODO */
+
+	return 0;
+}
+
+static sdp_record_t *mps_record(int mpmd)
+{
+	sdp_data_t *mpsd_features, *mpmd_features, *dependencies;
+	sdp_list_t *svclass_id, *pfseq, *root;
+	uuid_t root_uuid, svclass_uuid;
+	sdp_profile_desc_t profile;
+	sdp_record_t *record;
+	uint64_t mpsd_feat = MPS_MPSD_DEFAULT_FEATURES;
+	uint64_t mpmd_feat = MPS_MPMD_DEFAULT_FEATURES;
+	uint16_t deps = MPS_DEFAULT_DEPS;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+	sdp_list_free(root, NULL);
+
+	sdp_uuid16_create(&svclass_uuid, MPS_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &svclass_uuid);
+	sdp_set_service_classes(record, svclass_id);
+	sdp_list_free(svclass_id, NULL);
+
+	sdp_uuid16_create(&profile.uuid, MPS_PROFILE_ID);
+	profile.version = 0x0100;
+	pfseq = sdp_list_append(NULL, &profile);
+	sdp_set_profile_descs(record, pfseq);
+	sdp_list_free(pfseq, NULL);
+
+	mpsd_features = sdp_data_alloc(SDP_UINT64, &mpsd_feat);
+	sdp_attr_add(record, SDP_ATTR_MPSD_SCENARIOS, mpsd_features);
+
+	if (mpmd) {
+		mpmd_features = sdp_data_alloc(SDP_UINT64, &mpmd_feat);
+		sdp_attr_add(record, SDP_ATTR_MPMD_SCENARIOS, mpmd_features);
+	}
+
+	dependencies = sdp_data_alloc(SDP_UINT16, &deps);
+	sdp_attr_add(record, SDP_ATTR_MPS_DEPENDENCIES, dependencies);
+
+	sdp_set_info_attr(record, "Multi Profile", 0, 0);
+
+	return record;
+}
+
+void register_mps(bool mpmd)
+{
+	sdp_record_t *record;
+
+	record = mps_record(mpmd);
+	if (!record)
+		return;
+
+	if (add_record_to_server(BDADDR_ANY, record) < 0) {
+		sdp_record_free(record);
+		return;
+	}
+
+	mps_handle = record->handle;
+	mps_mpmd = mpmd;
+}
+
+static void update_mps(void)
+{
+	sdp_record_t *rec;
+	sdp_data_t *data;
+	uint64_t mpsd_feat, mpmd_feat;
+
+	if (!mps_handle)
+		return;
+
+	rec = sdp_record_find(mps_handle);
+	if (!rec)
+		return;
+
+	mpsd_feat = mps_mpsd_features();
+	data = sdp_data_alloc(SDP_UINT64, &mpsd_feat);
+	sdp_attr_replace(rec, SDP_ATTR_MPSD_SCENARIOS, data);
+
+	if (mps_mpmd) {
+		mpmd_feat = mps_mpmd_features();
+		data = sdp_data_alloc(SDP_UINT64, &mpmd_feat);
+		sdp_attr_replace(rec, SDP_ATTR_MPMD_SCENARIOS, data);
+	}
+}
+
 int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec)
 {
 	sdp_data_t *data;
@@ -272,6 +497,7 @@ int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec)
 		DBG("Record pattern UUID %s", uuid);
 	}
 
+	update_mps();
 	update_db_timestamp();
 
 	return 0;
@@ -291,8 +517,10 @@ int remove_record_from_server(uint32_t handle)
 	if (!rec)
 		return -ENOENT;
 
-	if (sdp_record_remove(handle) == 0)
+	if (sdp_record_remove(handle) == 0) {
+		update_mps();
 		update_db_timestamp();
+	}
 
 	sdp_record_free(rec);
 
diff --git a/src/sdpd.h b/src/sdpd.h
index 6de0af7..4425c87 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -58,6 +58,7 @@ void register_public_browse_group(void);
 void register_server_service(void);
 void register_device_id(uint16_t source, uint16_t vendor,
 					uint16_t product, uint16_t version);
+void register_mps(bool mpmd);
 
 int record_sort(const void *r1, const void *r2);
 void sdp_svcdb_reset(void);
-- 
1.9.3

