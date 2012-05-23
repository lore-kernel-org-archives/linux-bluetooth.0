Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 05/12] telephony-maemo6: Remove redundant D-Bus error
 initilization
Date: Wed, 23 May 2012 21:27:25 +0530
Message-id: <1337788652-23697-6-git-send-email-s.syam@samsung.com>
In-reply-to: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony-maemo6.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 0727ffe..fcfd4a4 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1911,7 +1911,6 @@ static void phonebook_read_reply(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
-	dbus_error_init(&derr);
 	if (dbus_message_get_args(reply, NULL,
 				DBUS_TYPE_INT32, &index,
 				DBUS_TYPE_STRING, &name,
-- 
1.7.4.1

