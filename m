Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Send a proper configuration when a source doesn't have a first reliable
Date: Mon, 25 Oct 2010 15:43:59 +0200
Message-Id: <1288014239-10832-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index fd3b1ca..10f4c5f 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -1026,7 +1026,7 @@ static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 	case HDP_NO_PREFERENCE_DC:
 		if (app->role == HDP_SINK)
 			return MCAP_CONFIGURATION_REJECTED;
-		else if (app->chan_type_set)
+		else if (dev->fr && app->chan_type_set)
 			*conf = app->chan_type;
 		else
 			*conf = HDP_RELIABLE_DC;
-- 
1.7.3.1

