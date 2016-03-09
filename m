Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Biman Paul <bimanpaul@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Biman Paul <biman.paul@samsung.com>
Subject: [PATCH 1/1] parser/sdp: parse MAS Instance ID and Message Type
Date: Thu, 10 Mar 2016 03:06:07 +0530
Message-Id: <1457559367-5626-1-git-send-email-bimanpaul@yahoo.co.in>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Biman Paul <biman.paul@samsung.com>

Parsing Support added in SDP record:
1. MAS Instance ID in MAP
2. Message Types supported by MAS
---
 tools/parser/sdp.c |    3 +++
 tools/parser/sdp.h |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/parser/sdp.c b/tools/parser/sdp.c
index dba9a36..1f8d6c5 100644
--- a/tools/parser/sdp.c
+++ b/tools/parser/sdp.c
@@ -211,6 +211,9 @@ static sdp_attr_id_nam_lookup_table_t sdp_attr_id_nam_lookup_table[] = {
 	{ SDP_ATTR_ID_SUPPORTED_FUNCTIONS,               "SuppFunctions"      }, /* Imaging */
 	{ SDP_ATTR_ID_TOTAL_IMAGING_DATA_CAPACITY,       "SuppTotalCapacity"  }, /* Imaging */
 	{ SDP_ATTR_ID_SUPPORTED_REPOSITORIES,            "SuppRepositories"   }, /* PBAP */
+	{ SDP_ATTR_ID_MAS_INSTANCE_ID,                   "MASInstanceID"      }, /* MAS ID */
+	{ SDP_ATTR_ID_MAP_SUPPORTED_TYPES,               "SupportedMessageTypes" }, /* Message Types */
 };
 
 #define SDP_ATTR_ID_NAM_LOOKUP_TABLE_SIZE \
diff --git a/tools/parser/sdp.h b/tools/parser/sdp.h
index ed55a23..130da3f 100644
--- a/tools/parser/sdp.h
+++ b/tools/parser/sdp.h
@@ -157,5 +157,8 @@
 #define SDP_ATTR_ID_SUPPORTED_FUNCTIONS                0x0312 /* Imaging */
 #define SDP_ATTR_ID_TOTAL_IMAGING_DATA_CAPACITY        0x0313 /* Imaging */
 #define SDP_ATTR_ID_SUPPORTED_REPOSITORIES             0x0314 /* PBAP */
+#define SDP_ATTR_ID_MAS_INSTANCE_ID                    0x0315 /* MAS ID */
+#define SDP_ATTR_ID_MAP_SUPPORTED_TYPES                0x0316 /* Message Types */
 
 #endif /* __SDP_H */
-- 
1.7.9.5

