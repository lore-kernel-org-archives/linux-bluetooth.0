Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/2] Simplify logic to calculate the BT/system clock latency
Date: Wed, 22 Sep 2010 09:03:50 +0200
Message-Id: <1285139031-1570-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is only a cosmetic change. Using a while loop
we avoid direct manipulation of counter loop variable
when error happens reading the BT clock.
---
 health/mcap_sync.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index 670260b..3d54936 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -384,12 +384,12 @@ static gboolean initialize_caps(struct mcap_mcl *mcl)
 
 	/* Do clock read a number of times and measure latency */
 	avg = 0;
+	i = 0;
 	retries = 10;
-	for (i = 0; i < 20 && retries > 0; ++i) {
+	while ((i < 20) && (retries > 0)) {
 		clock_gettime(CLK, &t1);
 		if (!read_btclock(mcl, &btclock, &btaccuracy)) {
-			--i;
-			--retries;
+			retries--;
 			continue;
 		}
 		clock_gettime(CLK, &t2);
@@ -397,6 +397,7 @@ static gboolean initialize_caps(struct mcap_mcl *mcl)
 		latency = time_us(&t2) - time_us(&t1);
 		latencies[i] = latency;
 		avg += latency;
+		i++;
 	}
 
 	if (retries <= 0)
-- 
1.7.0.4

