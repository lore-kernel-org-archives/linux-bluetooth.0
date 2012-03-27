Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 BlueZ 2/8] attrib: Discover Characteristics if already connected
Date: Tue, 27 Mar 2012 16:43:43 -0400
Message-Id: <1332881029-1732-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1332881029-1732-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
 <1332881029-1732-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

On Generic Attribute, Discover All Characteristics of a Service can be
started immediately if already connected, without registering a ATTIO
connection callback.
---
 attrib/client.c |   49 ++++++++++++++++++++++++-------------------------
 1 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 143c06b..2ad3956 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -325,6 +325,9 @@ static void offline_char_write(gpointer data, gpointer user_data)
 						offline_char_written, chr);
 }
 
+static void char_discovered_cb(GSList *characteristics, guint8 status,
+							gpointer user_data);
+
 static void attio_connected(GAttrib *attrib, gpointer user_data)
 {
 	struct gatt_service *gatt = user_data;
@@ -337,6 +340,16 @@ static void attio_connected(GAttrib *attrib, gpointer user_data)
 					events_handler, gatt, NULL);
 
 	g_slist_foreach(gatt->offline_chars, offline_char_write, attrib);
+
+	if (gatt->query) {
+		struct gatt_primary *prim = gatt->prim;
+		struct query_data *qchr;
+
+		qchr = g_slist_nth_data(gatt->query->list, 0);
+		gatt_discover_char(gatt->attrib, prim->range.start,
+						prim->range.end, NULL,
+						char_discovered_cb, qchr);
+	}
 }
 
 static void attio_disconnected(gpointer user_data)
@@ -899,27 +912,6 @@ fail:
 	g_free(current);
 }
 
-static void send_discover(GAttrib *attrib, gpointer user_data)
-{
-	struct query_data *qchr = user_data;
-	struct gatt_service *gatt = qchr->gatt;
-	struct gatt_primary *prim = gatt->prim;
-
-	gatt->attrib = g_attrib_ref(attrib);
-
-	gatt_discover_char(gatt->attrib, prim->range.start, prim->range.end, NULL,
-						char_discovered_cb, qchr);
-}
-
-static void cancel_discover(gpointer user_data)
-{
-	struct query_data *qchr = user_data;
-	struct gatt_service *gatt = qchr->gatt;
-
-	g_attrib_unref(gatt->attrib);
-	gatt->attrib = NULL;
-}
-
 static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -937,10 +929,17 @@ static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 
 	query->msg = dbus_message_ref(msg);
 
-	gatt->attioid = btd_device_add_attio_callback(gatt->dev,
-							send_discover,
-							cancel_discover,
-							qchr);
+	if (gatt->attioid == 0) {
+		gatt->attioid = btd_device_add_attio_callback(gatt->dev,
+							attio_connected,
+							attio_disconnected,
+							gatt);
+	} else if (gatt->attrib) {
+		struct gatt_primary *prim = gatt->prim;
+		gatt_discover_char(gatt->attrib, prim->range.start,
+						prim->range.end, NULL,
+						char_discovered_cb, qchr);
+	}
 
 	gatt->query = query;
 
-- 
1.7.5.4

