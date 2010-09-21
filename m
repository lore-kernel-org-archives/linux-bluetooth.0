Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Some code reordering in mcap_sync
Date: Tue, 21 Sep 2010 10:14:21 +0200
Message-Id: <1285056861-10099-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Declaration, defines and struct definitions are moved to the begining
of the file. Just for make the code more readable.
---
 health/mcap_sync.c |   86 +++++++++++++++++++++++++--------------------------
 1 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index 260cd71..25fc2d4 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -44,6 +44,11 @@
 #include "mcap_lib.h"
 #include "mcap_internal.h"
 
+#define MCAP_BTCLOCK_HALF (MCAP_BTCLOCK_FIELD / 2)
+#define CLK CLOCK_MONOTONIC
+
+#define MCAP_CSP_ERROR g_quark_from_static_string("mcap-csp-error-quark")
+
 struct mcap_csp {
 	uint64_t	base_tmstamp;	/* CSP base timestamp */
 	struct timespec	base_time;	/* CSP base time when timestamp set */
@@ -60,8 +65,31 @@ struct mcap_csp {
 	void		*csp_priv_data;	/* CSP-Master: In-flight request data */
 };
 
-#define MCAP_BTCLOCK_HALF (MCAP_BTCLOCK_FIELD / 2)
-#define CLK CLOCK_MONOTONIC
+struct mcap_sync_cap_cbdata {
+	mcap_sync_cap_cb	cb;
+	gpointer		user_data;
+};
+
+struct mcap_sync_set_cbdata {
+	mcap_sync_set_cb	cb;
+	gpointer		user_data;
+};
+
+struct csp_caps {
+	int ts_acc;		/* timestamp accuracy */
+	int ts_res;		/* timestamp resolution */
+	int latency;		/* Read BT clock latency */
+	int preempt_thresh;	/* Preemption threshold for latency */
+	int syncleadtime_ms;	/* SyncLeadTime in ms */
+};
+
+struct sync_set_data {
+	uint8_t update;
+	uint32_t sched_btclock;
+	uint64_t timestamp;
+	int ind_freq;
+	gboolean role;
+};
 
 /* Ripped from lib/sdp.c */
 
@@ -80,6 +108,18 @@ static inline uint64_t ntoh64(uint64_t n)
 
 #define hton64(x)     ntoh64(x)
 
+static gboolean csp_caps_initialized = FALSE;
+struct csp_caps _caps;
+
+static void proc_sync_cap_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
+static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
+static void proc_sync_cap_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
+static void proc_sync_set_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
+static void proc_sync_info_ind(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
+
+static gboolean sync_send_indication(gpointer user_data);
+static gboolean proc_sync_set_req_phase2(gpointer user_data);
+
 static int send_sync_cmd(struct mcap_mcl *mcl, const void *buf, uint32_t size)
 {
 	int sock;
@@ -121,24 +161,6 @@ static int send_unsupported_set_req(struct mcap_mcl *mcl)
 	return sent;
 }
 
-static void proc_sync_cap_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
-static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
-static void proc_sync_cap_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
-static void proc_sync_set_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
-static void proc_sync_info_ind(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
-
-#define MCAP_CSP_ERROR g_quark_from_static_string("mcap-csp-error-quark")
-
-struct mcap_sync_cap_cbdata {
-	mcap_sync_cap_cb	cb;
-	gpointer		user_data;
-};
-
-struct mcap_sync_set_cbdata {
-	mcap_sync_set_cb	cb;
-	gpointer		user_data;
-};
-
 void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
 	if (!mcl->ms->csp_enabled || !mcl->csp) {
@@ -319,7 +341,6 @@ static gboolean read_btclock(struct mcap_mcl *mcl, uint32_t *btclock,
 	return ret < 0 ? FALSE : TRUE;
 }
 
-
 static gboolean read_btclock_retry(struct mcap_mcl *mcl, uint32_t *btclock,
 							uint16_t *btaccuracy)
 {
@@ -381,17 +402,6 @@ uint32_t mcap_get_btclock(struct mcap_mcl *mcl)
 	return btclock;
 }
 
-struct csp_caps {
-	int ts_acc;		/* timestamp accuracy */
-	int ts_res;		/* timestamp resolution */
-	int latency;		/* Read BT clock latency */
-	int preempt_thresh;	/* Preemption threshold for latency */
-	int syncleadtime_ms;	/* SyncLeadTime in ms */
-};
-
-static struct csp_caps _caps;
-static gboolean csp_caps_initialized = FALSE;
-
 static void initialize_caps(struct mcap_mcl *mcl)
 {
 	struct timespec t1, t2;
@@ -542,18 +552,6 @@ static int send_sync_set_rsp(struct mcap_mcl *mcl, uint8_t rspcode,
 	return sent;
 }
 
-static gboolean proc_sync_set_req_phase2(gpointer user_data);
-
-struct sync_set_data {
-	uint8_t update;
-	uint32_t sched_btclock;
-	uint64_t timestamp;
-	int ind_freq;
-	gboolean role;
-};
-
-static gboolean sync_send_indication(gpointer user_data);
-
 static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
 	mcap_md_sync_set_req *req;
-- 
1.7.0.4

