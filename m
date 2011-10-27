Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ] Fix incorrect use of atoi in maemo6
Date: Thu, 27 Oct 2011 13:42:56 +0300
Message-Id: <1319712176-709-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use of atoi is incorrect and unsafe in maemo6 telephony and replaced
by g_ascii_digit_value.
---
 audio/telephony-maemo6.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 5df3235..a546f44 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -823,7 +823,9 @@ static int tonegen_startevent(char tone)
 		event_tone = DTMF_D;
 		break;
 	default:
-		event_tone = atoi(&tone);
+		event_tone = g_ascii_digit_value(tone);
+		if (event_tone < 0)
+			return -EINVAL;
 	}
 
 	ret = send_method_call(TONEGEN_BUS_NAME, TONEGEN_PATH,
-- 
1.7.4.1

