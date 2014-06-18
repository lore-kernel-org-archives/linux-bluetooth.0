Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 10/11] android/health: Fix missing error check
Date: Wed, 18 Jun 2014 16:33:53 +0300
Message-Id: <1403098434-28193-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/mcap-lib.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/android/mcap-lib.c b/android/mcap-lib.c
index 346688e..2a86416 100644
--- a/android/mcap-lib.c
+++ b/android/mcap-lib.c
@@ -2654,12 +2654,14 @@ static gboolean get_all_clocks(struct mcap_mcl *mcl, uint32_t *btclock,
 
 	while (latency > caps(mcl)->preempt_thresh && --retry >= 0) {
 
-		clock_gettime(CLK, &t0);
+		if (clock_gettime(CLK, &t0) < 0)
+			return FALSE;
 
 		if (!read_btclock(mcl, btclock, &btres))
 			continue;
 
-		clock_gettime(CLK, base_time);
+		if (clock_gettime(CLK, base_time) < 0)
+			return FALSE;
 
 		/*
 		 * Tries to detect preemption between clock_gettime
@@ -2668,6 +2670,9 @@ static gboolean get_all_clocks(struct mcap_mcl *mcl, uint32_t *btclock,
 		latency = time_us(base_time) - time_us(&t0);
 	}
 
+	if (retry < 0)
+		return FALSE;
+
 	*timestamp = mcap_get_timestamp(mcl, base_time);
 
 	return TRUE;
-- 
1.8.3.2

