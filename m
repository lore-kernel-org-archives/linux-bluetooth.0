Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Fixes potential lockup while finding latency
Date: Tue, 21 Sep 2010 13:45:53 -0300
Message-Id: <1285087553-11868-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

(To be applied after Jose reorganization patch)

This patch fixes a potential infinite loop while finding the
BT/system clock read latency. If the adapter is removed exactly
at that moment, BT clock simply can't be read and it must quit.
This is handled as a temporary failure (if a new connection is
made, adapter is probably in place again).
---
 health/mcap_sync.c |   46 ++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index 0943e41..670260b 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -360,7 +360,7 @@ uint32_t mcap_get_btclock(struct mcap_mcl *mcl)
 	return btclock;
 }
 
-static void initialize_caps(struct mcap_mcl *mcl)
+static gboolean initialize_caps(struct mcap_mcl *mcl)
 {
 	struct timespec t1, t2;
 	int latencies[20];
@@ -368,6 +368,7 @@ static void initialize_caps(struct mcap_mcl *mcl)
 	uint32_t btclock;
 	uint16_t btaccuracy;
 	int i;
+	int retries;
 
 	clock_getres(CLK, &t1);
 
@@ -383,10 +384,12 @@ static void initialize_caps(struct mcap_mcl *mcl)
 
 	/* Do clock read a number of times and measure latency */
 	avg = 0;
-	for (i = 0; i < 20; ++i) {
+	retries = 10;
+	for (i = 0; i < 20 && retries > 0; ++i) {
 		clock_gettime(CLK, &t1);
 		if (!read_btclock(mcl, &btclock, &btaccuracy)) {
 			--i;
+			--retries;
 			continue;
 		}
 		clock_gettime(CLK, &t2);
@@ -395,9 +398,12 @@ static void initialize_caps(struct mcap_mcl *mcl)
 		latencies[i] = latency;
 		avg += latency;
 	}
-	avg /= 20;
 
-	/* Calculate deviation */
+	if (retries <= 0)
+		return FALSE;
+
+	/* Calculate average and deviation */
+	avg /= 20;
 	dev = 0;
 	for (i = 0; i < 20; ++i)
 		dev += abs(latencies[i] - avg);
@@ -418,12 +424,16 @@ static void initialize_caps(struct mcap_mcl *mcl)
 	_caps.syncleadtime_ms = latency * 50 / 1000;
 
 	csp_caps_initialized = TRUE;
+	return TRUE;
 }
 
 static struct csp_caps *caps(struct mcap_mcl *mcl)
 {
 	if (!csp_caps_initialized)
-		initialize_caps(mcl);
+		if (!initialize_caps(mcl)) {
+			/* Temporary failure in reading BT clock */
+			return NULL;
+		}
 
 	return &_caps;
 }
@@ -465,6 +475,12 @@ static void proc_sync_cap_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		return;
 	}
 
+	if (!caps(mcl)) {
+		send_sync_cap_rsp(mcl, MCAP_RESOURCE_UNAVAILABLE,
+					0, 0, 0, 0);
+		return;
+	}
+
 	req = (mcap_md_sync_cap_req *) cmd;
 	required_accuracy = ntohs(req->timest);
 	our_accuracy = caps(mcl)->ts_acc;
@@ -514,11 +530,16 @@ static gboolean get_all_clocks(struct mcap_mcl *mcl, uint32_t *btclock,
 				struct timespec *base_time,
 				uint64_t *timestamp)
 {
-	int latency = caps(mcl)->preempt_thresh + 1;
+	int latency;
 	int retry = 5;
 	uint16_t btres;
 	struct timespec t0;
 
+	if (!caps(mcl))
+		return FALSE;
+
+	latency = caps(mcl)->preempt_thresh + 1;
+
 	while (latency > caps(mcl)->preempt_thresh && --retry >= 0) {
 
 		clock_gettime(CLK, &t0);
@@ -553,6 +574,9 @@ static gboolean sync_send_indication(gpointer user_data)
 
 	mcl = user_data;
 
+	if (!caps(mcl))
+		return FALSE;
+
 	if (!get_all_clocks(mcl, &btclock, &base_time, &tmstamp))
 		return FALSE;
 
@@ -600,6 +624,11 @@ static gboolean proc_sync_set_req_phase2(gpointer user_data)
 	ind_freq = data->ind_freq;
 	role = data->role;
 
+	if (!caps(mcl)) {
+		send_sync_set_rsp(mcl, MCAP_UNSPECIFIED_ERROR, 0, 0, 0);
+		return FALSE;
+	}
+
 	if (!get_all_clocks(mcl, &btclock, &base_time, &tmstamp)) {
 		send_sync_set_rsp(mcl, MCAP_UNSPECIFIED_ERROR, 0, 0, 0);
 		return FALSE;
@@ -688,6 +717,11 @@ static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		return;
 	}
 
+	if (!caps(mcl)) {
+		send_sync_set_rsp(mcl, MCAP_UNSPECIFIED_ERROR, 0, 0, 0);
+		return;
+	}
+
 	if (!read_btclock_retry(mcl, &cur_btclock, &btres)) {
 		send_sync_set_rsp(mcl, MCAP_UNSPECIFIED_ERROR, 0, 0, 0);
 		return;
-- 
1.7.0.4

