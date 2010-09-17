Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Change the for loop to read blutooth clock in MCAP CSP
Date: Fri, 17 Sep 2010 09:52:30 +0200
Message-Id: <1284709950-5302-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is only a cosmetic change. Using a do..while loop
we avoid direct manipulation of counter loop variable
when error happens reading the BT clock.
---
 health/mcap_sync.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index bc1ffcd..78cb163 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -406,18 +406,18 @@ static void initialize_caps(struct mcap_mcl *mcl)
 
 	/* Do clock read a number of times and measure latency */
 	avg = 0;
-	for (i = 0; i < 20; ++i) {
+	i = 0;
+	do {
 		clock_gettime(CLK, &t1);
-		if (!read_btclock(mcl, &btclock, &btaccuracy)) {
-			--i;
+		if (!read_btclock(mcl, &btclock, &btaccuracy))
 			continue;
-		}
 		clock_gettime(CLK, &t2);
 
 		latency = time_us(&t2) - time_us(&t1);
 		latencies[i] = latency;
 		avg += latency;
-	}
+		i++;
+	} while (i < 20);
 	avg /= 20;
 
 	/* Calculate deviation */
-- 
1.7.2.3

