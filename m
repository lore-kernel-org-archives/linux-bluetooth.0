Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 06/12] telephony-ofono: Remove redundant D-Bus error
 initilization
Date: Wed, 23 May 2012 21:27:26 +0530
Message-id: <1337788652-23697-7-git-send-email-s.syam@samsung.com>
In-reply-to: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony-ofono.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 961fedd..5e4ca89 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -1360,7 +1360,6 @@ static void hal_battery_level_reply(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
-	dbus_error_init(&err);
 	if (dbus_message_get_args(reply, &err,
 				DBUS_TYPE_INT32, &level,
 				DBUS_TYPE_INVALID) == FALSE) {
-- 
1.7.4.1

