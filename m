Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/2] Fix minor coding style issues in MCAP CSP code
Date: Mon, 20 Sep 2010 10:35:28 +0200
Message-Id: <1284971729-20509-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap_sync.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index bc1ffcd..ae7ab5b 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -590,9 +590,9 @@ static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		return;
 	}
 
-	if (sched_btclock == MCAP_BTCLOCK_IMMEDIATE) {
+	if (sched_btclock == MCAP_BTCLOCK_IMMEDIATE)
 		phase2_delay = 0;
-	} else {
+	else {
 		phase2_delay = btdiff(cur_btclock, sched_btclock);
 
 		if (phase2_delay < 0) {
@@ -631,9 +631,8 @@ static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		}
 
 		DBG("CSP: indication every %dms", ind_freq);
-	} else {
+	} else
 		ind_freq = 0;
-	}
 
 	if (mcl->csp->ind_timer) {
 		/* Old indications are no longer sent */
@@ -661,14 +660,12 @@ static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		mcl->csp->set_timer = g_timeout_add(when,
 						proc_sync_set_req_phase2,
 						mcl);
-	} else {
+	} else
 		proc_sync_set_req_phase2(mcl);
-	}
 
 	/* First indication is immediate */
-	if (update) {
+	if (update)
 		sync_send_indication(mcl);
-	}
 }
 
 static gboolean get_all_clocks(struct mcap_mcl *mcl, uint32_t *btclock,
@@ -749,11 +746,10 @@ static gboolean proc_sync_set_req_phase2(gpointer user_data)
 			if (delay >= 0 || ((new_tmstamp - delay) > 0)) {
 				new_tmstamp += delay;
 				DBG("CSP: reset w/ delay %dus, compensated",
-					delay);
-			} else {
+									delay);
+			} else
 				DBG("CSP: reset w/ delay %dus, uncompensated",
-					delay);
-			}
+									delay);
 		}
 
 		reset_tmstamp(mcl->csp, &base_time, new_tmstamp);
@@ -860,7 +856,7 @@ static void proc_sync_cap_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		mcl->csp->local_caps = TRUE;
 
 	cb(mcl, mcap_err, btclockres, synclead, tmstampres, tmstampacc, NULL,
-		user_data);
+								user_data);
 }
 
 static void proc_sync_set_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
-- 
1.7.0.4

