Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 03/12] media: Remove redundant D-Bus error initilization
Date: Wed, 23 May 2012 21:27:23 +0530
Message-id: <1337788652-23697-4-git-send-email-s.syam@samsung.com>
In-reply-to: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/media.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index fdd7b49..cb8872f 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -276,7 +276,6 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
-	dbus_error_init(&err);
 	if (dbus_message_is_method_call(request->msg, MEDIA_ENDPOINT_INTERFACE,
 				"SelectConfiguration")) {
 		DBusMessageIter args, array;
-- 
1.7.4.1

