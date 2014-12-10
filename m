Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/4] sdp: Add support for MPMD in MPS
Date: Wed, 10 Dec 2014 12:20:51 +0100
Message-Id: <1418210453-21036-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1418210453-21036-1-git-send-email-szymon.janc@tieto.com>
References: <1418210453-21036-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This enables MPMD field in MPS record.
---
 src/sdpd-service.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index f3e4a28..c12b4f8 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -103,6 +103,33 @@
 			MPS_MPSD_PAN_NAP | MPS_MPSD_PAN_PANU | \
 			MPS_MPSD_PBAP_SRC | MPS_MPSD_PBAP_CLI)
 
+#define MPS_MPMD_HFP_AG (1ULL << 6)
+
+#define MPS_MPMD_HFP_HF ((1ULL << 0) | (1ULL << 2) | (1ULL << 4) | \
+			(1ULL << 7) | (1ULL << 9))
+
+#define MPS_MPMD_A2DP_SRC ((1ULL << 1) | (1ULL << 3) | (1ULL << 5) |\
+				(1ULL << 8) | (1ULL << 10) | (1ULL << 12) | \
+				(1ULL << 14) | (1ULL << 15) | (1ULL << 17))
+
+#define MPS_MPMD_A2DP_SNK ((1ULL << 0) | (1ULL << 2) | (1ULL << 4) | \
+				(1ULL << 7) | (1ULL << 9) | \
+				(1ULL << 16) | (1ULL << 18))
+
+#define MPS_MPMD_AVRCP_CT MPS_MPMD_A2DP_SNK
+
+/* should be set only if CT is supported but SNK is not supported */
+#define MPS_MPMD_AVRCP_CT_ONLY ((1ULL << 11) | (1ULL << 13))
+
+#define MPS_MPMD_AVRCP_TG MPS_MPMD_A2DP_SRC
+
+#define MPS_MPMD_DUN_DT ((1ULL << 16) | (1ULL << 18))
+
+#define MPS_MPMD_ALL (MPS_MPMD_HFP_AG | MPS_MPMD_HFP_HF | MPS_MPMD_A2DP_SRC | \
+			MPS_MPMD_A2DP_SNK | MPS_MPMD_AVRCP_CT | \
+			MPS_MPMD_AVRCP_CT_ONLY | MPS_MPMD_AVRCP_TG | \
+			MPS_MPMD_DUN_DT)
+
 /*
  * Assume all dependencies are supported.
  * Bits in bitmask as defined in table 6.5 of Multi Profile Specification
@@ -367,9 +394,34 @@ static uint64_t mps_mpsd_features(void)
 
 static uint64_t mps_mpmd_features(void)
 {
+	uint64_t feat = MPS_MPMD_ALL;
+
+	if (!class_supported(HANDSFREE_AGW_SVCLASS_ID))
+		feat &= ~MPS_MPMD_HFP_AG;
+
+	if (!class_supported(HANDSFREE_SVCLASS_ID))
+		feat &= ~MPS_MPMD_HFP_HF;
+
+	if (!class_supported(AUDIO_SOURCE_SVCLASS_ID))
+		feat &= ~MPS_MPMD_A2DP_SRC;
+
+	if (!class_supported(AUDIO_SINK_SVCLASS_ID))
+		feat &= ~MPS_MPMD_A2DP_SNK;
+	else
+		feat &= ~MPS_MPMD_AVRCP_CT_ONLY;
+
+	if (!class_supported(AV_REMOTE_CONTROLLER_SVCLASS_ID)) {
+		feat &= ~MPS_MPMD_AVRCP_CT;
+		feat &= ~MPS_MPMD_AVRCP_CT_ONLY;
+	}
+
+	if (!class_supported(AV_REMOTE_TARGET_SVCLASS_ID))
+		feat &= ~MPS_MPMD_AVRCP_TG;
+
 	/* TODO */
+	feat &= ~MPS_MPMD_DUN_DT;
 
-	return 0;
+	return feat;
 }
 
 static sdp_record_t *mps_record(int mpmd)
-- 
1.9.3

