Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/6] HDP: Fix adding missing breaks
Date: Mon, 30 Jun 2014 15:53:48 +0300
Message-Id: <1404132829-5670-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404132829-5670-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404132829-5670-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/health/hdp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 54aca9d..d09bdd4 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1066,6 +1066,7 @@ static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 		switch (*conf) {
 		case HDP_NO_PREFERENCE_DC:
 			*conf = HDP_RELIABLE_DC;
+			break;
 		case HDP_RELIABLE_DC:
 			break;
 		case HDP_STREAMING_DC:
@@ -1112,6 +1113,7 @@ static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 	case HDP_STREAMING_DC:
 		if (!dev->fr || app->role == HDP_SOURCE)
 			return MCAP_CONFIGURATION_REJECTED;
+		break;
 	case HDP_RELIABLE_DC:
 		if (app->role == HDP_SOURCE)
 			return MCAP_CONFIGURATION_REJECTED;
-- 
1.8.3.2

