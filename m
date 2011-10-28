Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ v2] Fix incorrect use of atoi in maemo6
Date: Fri, 28 Oct 2011 14:41:50 +0300
Message-Id: <1319802110-29936-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use of atoi is incorrect and unsafe in maemo6 telephony and replaced
by g_ascii_digit_value.
---
 audio/telephony-maemo6.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 5df3235..10967fb 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -823,7 +823,10 @@ static int tonegen_startevent(char tone)
 		event_tone = DTMF_D;
 		break;
 	default:
-		event_tone = atoi(&tone);
+		ret = g_ascii_digit_value(tone);
+		if (ret < 0)
+			return -EINVAL;
+		event_tone = ret;
 	}
 
 	ret = send_method_call(TONEGEN_BUS_NAME, TONEGEN_PATH,
-- 
1.7.4.1

