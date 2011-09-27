Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ v2 5/5] Fix remove feedback DTMF tones timer on call release
Date: Tue, 27 Sep 2011 13:22:47 +0300
Message-Id: <1317118967-18469-6-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1317118967-18469-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1317118967-18469-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

User feedback DTMF tones queue is freed and timer removed when call
is released.
---
 audio/telephony-maemo6.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 30803ce..874cba1 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1317,6 +1317,9 @@ static void call_set_status(struct csd_call *call, dbus_uint32_t status)
 		if (g_slist_length(active_calls) == 0)
 			telephony_update_indicator(maemo_indicators, "call",
 							EV_CALL_INACTIVE);
+
+		if (create_tones_timer)
+			g_source_remove(create_tones_timer);
 		break;
 	case CSD_CALL_STATUS_HOLD_INITIATED:
 		break;
-- 
1.7.4.1

