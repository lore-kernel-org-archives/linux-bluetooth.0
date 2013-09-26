Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] gdbus: Remove not needed check for NULL DBusPendingCall
Date: Thu, 26 Sep 2013 10:02:35 +0200
Message-ID: <1380182555-11609-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380182555-11609-1-git-send-email-szymon.janc@tieto.com>
References: <1380182555-11609-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is now checked by g_dbus_send_message_with_reply() so there is no
need to double check that in caller.
---
 gdbus/client.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index 7bffdad..be8cc29 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -112,11 +112,6 @@ static gboolean modify_match(DBusConnection *conn, const char *member,
 		return FALSE;
 	}
 
-	if (call == NULL) {
-		dbus_message_unref(msg);
-		return FALSE;
-	}
-
 	dbus_pending_call_set_notify(call, modify_match_reply, NULL, NULL);
 	dbus_pending_call_unref(call);
 
-- 
1.8.4

