Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH v2] Add UUID property to GATT service object
Date: Wed,  9 Feb 2011 11:12:34 -0200
Message-Id: <1297257154-10995-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 44638d3..27ab7f1 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -940,6 +940,7 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 	DBusMessageIter dict;
 	GSList *l;
 	char **chars;
+	const char *uuid;
 	int i;
 
 	reply = dbus_message_new_method_return(msg);
@@ -962,6 +963,9 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 
 	dict_append_array(&dict, "Characteristics", DBUS_TYPE_OBJECT_PATH,
 								&chars, i);
+	uuid = prim->att->uuid;
+	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
+
 	g_free(chars);
 
 	dbus_message_iter_close_container(&iter, &dict);
-- 
1.7.1

