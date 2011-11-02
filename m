Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ] Fix response on AT+CHLD=0 in maemo6
Date: Wed,  2 Nov 2011 10:50:17 +0200
Message-Id: <1320223817-7391-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, +CIEV indicator after AT+CHLD=0 command for one active call,
one held call, one incoming call scenario is incorrect. callheld=2
according to HFP 1.5 spec., p.70, means 'Call on hold, no active call'.
Hence, value 2 cannot be provided in +CIEV if there is an active call.
---
 audio/telephony-maemo6.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 10967fb..dd75422 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1354,12 +1354,16 @@ static void call_set_status(struct csd_call *call, dbus_uint32_t status)
 		break;
 	case CSD_CALL_STATUS_TERMINATED:
 		if (call->on_hold &&
-				!find_call_with_status(CSD_CALL_STATUS_HOLD))
+				!find_call_with_status(CSD_CALL_STATUS_HOLD)) {
 			telephony_update_indicator(maemo_indicators,
 							"callheld",
 							EV_CALLHELD_NONE);
-		else if (callheld == EV_CALLHELD_MULTIPLE &&
-				find_call_with_status(CSD_CALL_STATUS_HOLD))
+			return;
+		}
+
+		if (callheld == EV_CALLHELD_MULTIPLE &&
+				find_call_with_status(CSD_CALL_STATUS_HOLD) &&
+				!find_call_with_status(CSD_CALL_STATUS_ACTIVE))
 			telephony_update_indicator(maemo_indicators,
 							"callheld",
 							EV_CALLHELD_ON_HOLD);
-- 
1.7.4.1

