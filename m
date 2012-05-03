Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v4 13/13] adapter: do not check signature twice
Date: Thu,  3 May 2012 09:29:02 -0300
Message-Id: <1336048142-1194-14-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message signature is already checked in generic_message(), so there's no
need to check again in the callback.
---
 src/adapter.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1e2dd02..9d87c6b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1321,9 +1321,6 @@ static DBusMessage *list_devices(DBusConnection *conn,
 	DBusMessageIter array_iter;
 	const gchar *dev_path;
 
-	if (!dbus_message_has_signature(msg, DBUS_TYPE_INVALID_AS_STRING))
-		return btd_error_invalid_args(msg);
-
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return NULL;
-- 
1.7.10

