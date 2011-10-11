Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ] Fix call status in +CLCC for maemo6 telephony
Date: Tue, 11 Oct 2011 12:18:38 +0300
Message-Id: <1318324718-19760-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If list current calls is requested when there is second incoming call
and csd call status is CSD_CALL_STATUS_PROCEEDING, then returned 'state
of the call' value in +CLCC is 4 (incoming, MT call), which is incorrect.
Indication than proceeds from incoming to waiting state.

This patch sets the corresponding value to 5 (waiting, MT call) in
maemo6 telephony driver for the second call.
---
 audio/telephony-maemo6.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 102daeb..13bb198 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -932,8 +932,12 @@ static int csd_status_to_hfp(struct csd_call *call)
 		/* PROCEEDING can happen in outgoing/incoming */
 		if (call->originating)
 			return CALL_STATUS_DIALING;
-		else
-			return CALL_STATUS_INCOMING;
+		else {
+			if (g_slist_length(active_calls) > 0)
+				return CALL_STATUS_WAITING;
+			else
+				return CALL_STATUS_INCOMING;
+		}
 	case CSD_CALL_STATUS_COMING:
 		return CALL_STATUS_INCOMING;
 	case CSD_CALL_STATUS_MO_ALERTING:
-- 
1.7.4.1

