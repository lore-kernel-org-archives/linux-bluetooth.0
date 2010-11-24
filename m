Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] sdpd header cleanup
Date: Wed, 24 Nov 2010 15:16:56 -0300
Message-Id: <1290622616-26505-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdpd-request.c |   12 +++++++++++-
 src/sdpd.h         |   14 --------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 025de60..9e4b6b8 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -45,6 +45,16 @@
 #include "sdpd.h"
 #include "log.h"
 
+typedef struct {
+	uint32_t timestamp;
+	union {
+		uint16_t maxBytesSent;
+		uint16_t lastIndexSent;
+	} cStateValue;
+} sdp_cont_state_t;
+
+#define SDP_CONT_STATE_SIZE (sizeof(uint8_t) + sizeof(sdp_cont_state_t))
+
 #define MIN(x, y) ((x) < (y)) ? (x): (y)
 
 typedef struct _sdp_cstate_list sdp_cstate_list_t;
@@ -58,7 +68,7 @@ struct _sdp_cstate_list {
 static sdp_cstate_list_t *cstates;
 
 // FIXME: should probably remove it when it's found
-sdp_buf_t *sdp_get_cached_rsp(sdp_cont_state_t *cstate)
+static sdp_buf_t *sdp_get_cached_rsp(sdp_cont_state_t *cstate)
 {
 	sdp_cstate_list_t *p;
 
diff --git a/src/sdpd.h b/src/sdpd.h
index a46ad3c..f8e6ee7 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -79,20 +79,6 @@ void register_server_service(void);
 void register_device_id(const uint16_t vendor, const uint16_t product,
 						const uint16_t version);
 
-typedef struct {
-	uint32_t timestamp;
-	union {
-		uint16_t maxBytesSent;
-		uint16_t lastIndexSent;
-	} cStateValue;
-} sdp_cont_state_t;
-
-#define SDP_CONT_STATE_SIZE (sizeof(uint8_t) + sizeof(sdp_cont_state_t))
-
-sdp_buf_t *sdp_get_cached_rsp(sdp_cont_state_t *cstate);
-void sdp_cstate_cache_init(void);
-void sdp_cstate_clean_buf(void);
-
 int record_sort(const void *r1, const void *r2);
 void sdp_svcdb_reset(void);
 void sdp_svcdb_collect_all(int sock);
-- 
1.7.3.2

