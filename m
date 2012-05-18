Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH RESEND BlueZ v6 13/13] adapter: do not check signature twice
Date: Fri, 18 May 2012 00:23:37 -0300
Message-Id: <1337311417-1245-14-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337311417-1245-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337311417-1245-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message signature is already checked in generic_message(), so there's no
need to check again in the callback.
---
 src/adapter.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e2e466d..dafe595 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1317,9 +1317,6 @@ static DBusMessage *list_devices(DBusConnection *conn,
 	DBusMessageIter array_iter;
 	const gchar *dev_path;
 
-	if (!dbus_message_has_signature(msg, DBUS_TYPE_INVALID_AS_STRING))
-		return btd_error_invalid_args(msg);
-
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return NULL;
-- 
1.7.10.2

