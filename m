Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/2] Remove magic numbers in MCAP CSP
Date: Wed, 22 Sep 2010 09:03:51 +0200
Message-Id: <1285139031-1570-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1285139031-1570-1-git-send-email-sancane@gmail.com>
References: <1285139031-1570-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap_sync.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index 3d54936..b9f2a65 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -48,6 +48,8 @@
 #define CLK CLOCK_MONOTONIC
 
 #define MCAP_CSP_ERROR g_quark_from_static_string("mcap-csp-error-quark")
+#define MAX_RETRIES	10
+#define SAMPLE_COUNT	20
 
 struct mcap_csp {
 	uint64_t	base_tmstamp;	/* CSP base timestamp */
@@ -363,7 +365,7 @@ uint32_t mcap_get_btclock(struct mcap_mcl *mcl)
 static gboolean initialize_caps(struct mcap_mcl *mcl)
 {
 	struct timespec t1, t2;
-	int latencies[20];
+	int latencies[SAMPLE_COUNT];
 	int latency, avg, dev;
 	uint32_t btclock;
 	uint16_t btaccuracy;
@@ -385,8 +387,8 @@ static gboolean initialize_caps(struct mcap_mcl *mcl)
 	/* Do clock read a number of times and measure latency */
 	avg = 0;
 	i = 0;
-	retries = 10;
-	while ((i < 20) && (retries > 0)) {
+	retries = MAX_RETRIES;
+	while ((i < SAMPLE_COUNT) && (retries > 0)) {
 		clock_gettime(CLK, &t1);
 		if (!read_btclock(mcl, &btclock, &btaccuracy)) {
 			retries--;
@@ -404,21 +406,21 @@ static gboolean initialize_caps(struct mcap_mcl *mcl)
 		return FALSE;
 
 	/* Calculate average and deviation */
-	avg /= 20;
+	avg /= SAMPLE_COUNT;
 	dev = 0;
-	for (i = 0; i < 20; ++i)
+	for (i = 0; i < SAMPLE_COUNT; ++i)
 		dev += abs(latencies[i] - avg);
-	dev /= 20;
+	dev /= SAMPLE_COUNT;
 
 	/* Calculate corrected average, without 'freak' latencies */
 	latency = 0;
-	for (i = 0; i < 20; ++i) {
+	for (i = 0; i < SAMPLE_COUNT; ++i) {
 		if (latencies[i] > (avg + dev * 6))
 			latency += avg;
 		else
 			latency += latencies[i];
 	}
-	latency /= 20;
+	latency /= SAMPLE_COUNT;
 
 	_caps.latency = latency;
 	_caps.preempt_thresh = latency * 4;
-- 
1.7.0.4

