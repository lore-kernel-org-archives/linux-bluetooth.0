Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ] Fix crash on power off in maemo6 after sending DTMF
Date: Thu, 13 Oct 2011 13:02:38 +0300
Message-Id: <1318500158-9529-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes regression introduced in
b48e610314fb466035b198f594c5b6a68126fcf1. Crash happens when powering
off adapter after sending DTMF tone.
---
 audio/telephony-maemo6.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 82cb274..1910410 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -771,7 +771,7 @@ static void start_dtmf_reply(DBusPendingCall *call, void *user_data)
 				DBUS_TYPE_INVALID);
 
 	dbus_message_unref(reply);
-	dbus_pending_call_unref(call);
+	remove_pending(call);
 }
 
 static void start_dtmf(void *telephony_device, char tone)
-- 
1.7.4.1

