Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 1/3] Add UUID property to GATT service object
Date: Wed, 16 Feb 2011 16:13:39 -0200
Message-Id: <1297880021-31728-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index ec5fcf2..0f9ba3e 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -941,6 +941,7 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 	DBusMessageIter dict;
 	GSList *l;
 	char **chars;
+	const char *uuid;
 	int i;
 
 	reply = dbus_message_new_method_return(msg);
@@ -963,6 +964,9 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 
 	dict_append_array(&dict, "Characteristics", DBUS_TYPE_OBJECT_PATH,
 								&chars, i);
+	uuid = prim->att->uuid;
+	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
+
 	g_free(chars);
 
 	dbus_message_iter_close_container(&iter, &dict);
-- 
1.7.1

