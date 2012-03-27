Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 BlueZ 3/8] attrib: Move Characteristic Discovery reply to a new function
Date: Tue, 27 Mar 2012 16:43:44 -0400
Message-Id: <1332881029-1732-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1332881029-1732-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
 <1332881029-1732-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Minor cleanup patch moving the creation of the reply for Discover
All Characteristics call to a new local function in the Generic
Attribute.
---
 attrib/client.c |   44 +++++++++++++++++++++++++++-----------------
 1 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 2ad3956..651eade 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -835,11 +835,35 @@ static void update_all_chars(gpointer data, gpointer user_data)
 	gatt_read_char(gatt->attrib, chr->handle, 0, update_char_value, qvalue);
 }
 
+static DBusMessage *create_discover_char_reply(DBusMessage *msg, GSList *chars)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter, array_iter;
+	GSList *l;
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_OBJECT_PATH_AS_STRING, &array_iter);
+
+	for (l = chars; l; l = l->next) {
+		struct characteristic *chr = l->data;
+
+		dbus_message_iter_append_basic(&array_iter,
+					DBUS_TYPE_OBJECT_PATH, &chr->path);
+	}
+
+	dbus_message_iter_close_container(&iter, &array_iter);
+
+	return reply;
+}
+
 static void char_discovered_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
 	DBusMessage *reply;
-	DBusMessageIter iter, array_iter;
 	struct query_data *current = user_data;
 	struct gatt_service *gatt = current->gatt;
 	struct gatt_primary *prim = gatt->prim;
@@ -888,24 +912,10 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 	g_slist_foreach(gatt->chars, register_characteristic, gatt->path);
 
-	reply = dbus_message_new_method_return(gatt->query->msg);
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-				DBUS_TYPE_OBJECT_PATH_AS_STRING, &array_iter);
-
-	for (l = gatt->chars; l; l = l->next) {
-		struct characteristic *chr = l->data;
-
-		dbus_message_iter_append_basic(&array_iter,
-					DBUS_TYPE_OBJECT_PATH, &chr->path);
-	}
-
-	dbus_message_iter_close_container(&iter, &array_iter);
-
 	g_slist_foreach(gatt->chars, update_all_chars, gatt);
 
+	reply = create_discover_char_reply(gatt->query->msg, gatt->chars);
+
 fail:
 	g_dbus_send_message(gatt->conn, reply);
 	query_list_remove(gatt, current);
-- 
1.7.5.4

