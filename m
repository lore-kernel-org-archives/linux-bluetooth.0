Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/3] android/health: Handle incoming streaming data channel request
Date: Wed,  2 Jul 2014 12:32:00 +0300
Message-Id: <1404293522-7220-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

First data channel should be reliable data channel when remote device
in sink role request data channel with option any.
---
 android/health.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/android/health.c b/android/health.c
index 1943ced..2d80365 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1423,7 +1423,8 @@ static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 	struct health_app *app;
 	struct mdep_cfg *mdep;
 
-	DBG("Data channel request: mdepid %u mdlid %u", mdepid, mdlid);
+	DBG("Data channel request: mdepid %u mdlid %u conf %u",
+							mdepid, mdlid, *conf);
 
 	if (mdepid == MDEP_ECHO)
 		/* For echo service take last app */
@@ -1478,10 +1479,14 @@ static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 
 	switch (*conf) {
 	case CHANNEL_TYPE_ANY:
-		if (mdep->role == HAL_HEALTH_MDEP_ROLE_SINK)
+		if (mdep->role == HAL_HEALTH_MDEP_ROLE_SINK) {
 			return MCAP_CONFIGURATION_REJECTED;
-		else
-			*conf = CHANNEL_TYPE_RELIABLE;
+		} else {
+			if (queue_length(channel->dev->channels) <= 1)
+				*conf = CHANNEL_TYPE_RELIABLE;
+			else
+				*conf = CHANNEL_TYPE_STREAM;
+		}
 		break;
 	case CHANNEL_TYPE_STREAM:
 		if (mdep->role == HAL_HEALTH_MDEP_ROLE_SOURCE)
-- 
1.9.1

