Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v4 12/13] gdbus: do not check signature twice
Date: Thu,  3 May 2012 09:29:01 -0300
Message-Id: <1336048142-1194-13-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message signature is already checked in generic_message(), so there's no
need to check again in the callback.
---
 gdbus/object.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index e7b118c..c17d635 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -174,11 +174,6 @@ static DBusMessage *introspect(DBusConnection *connection,
 	struct generic_data *data = user_data;
 	DBusMessage *reply;
 
-	if (!dbus_message_has_signature(message, DBUS_TYPE_INVALID_AS_STRING)) {
-		error("Unexpected signature to introspect call");
-		return NULL;
-	}
-
 	if (data->introspect == NULL)
 		generate_introspection_xml(connection, data,
 						dbus_message_get_path(message));
-- 
1.7.10

