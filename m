Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ 3/4] Fix play DTMF feeback tones only for active call
Date: Mon, 19 Sep 2011 13:54:38 +0300
Message-Id: <1316429679-18651-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1316429679-18651-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1316429679-18651-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check on active call is added for playing of DTMF feedback tones to
notify user. Network DTMF tones are handled by modem, and therefore
there is no need in special check for those.
---
 audio/telephony-maemo6.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 85bb478..49d35fe 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -881,7 +881,10 @@ void telephony_transmit_dtmf_req(void *telephony_device, char tone)
 
 	start_dtmf(telephony_device, tone);
 
-	start_feedback_tone(tone);
+	if (!find_call_with_status(CSD_CALL_STATUS_ACTIVE))
+		error("No active call");
+	else
+		start_feedback_tone(tone);
 }
 
 void telephony_subscriber_number_req(void *telephony_device)
-- 
1.7.4.1

