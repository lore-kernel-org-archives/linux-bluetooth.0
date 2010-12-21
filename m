Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 14/18] Add a Discover method to the GATT Client
Date: Tue, 21 Dec 2010 19:26:36 -0200
Message-Id: <1292966800-6264-15-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This methods allows users to actively start the discovery of characteristics
presents in a service.
---
 attrib/client.c |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 21ce439..8dc5c79 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -497,15 +497,6 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static GDBusMethodTable prim_methods[] = {
-	{ "GetCharacteristics",	"",	"a{oa{sv}}", get_characteristics},
-	{ "RegisterCharacteristicsWatcher",	"o", "",
-						register_watcher	},
-	{ "UnregisterCharacteristicsWatcher",	"o", "",
-						unregister_watcher	},
-	{ }
-};
-
 static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
 			DBusMessageIter *iter, struct characteristic *chr)
 {
@@ -971,21 +962,40 @@ fail:
 	g_free(current);
 }
 
-static void discover_all_char(gpointer data, gpointer user_data)
+static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
+								void *data)
 {
-	struct query_data *qchr;
-	struct gatt_service *gatt = user_data;
 	struct primary *prim = data;
 	struct att_primary *att = prim->att;
+	struct gatt_service *gatt = prim->gatt;
+	struct query_data *qchr;
+	GError *gerr = NULL;
+
+	if (l2cap_connect(prim->gatt, &gerr, FALSE) < 0) {
+		DBusMessage *reply = btd_error_failed(msg, gerr->message);
+		g_error_free(gerr);
+		return reply;
+	}
 
 	qchr = g_new0(struct query_data, 1);
 	qchr->prim = prim;
 
-	gatt->attrib = g_attrib_ref(gatt->attrib);
 	gatt_discover_char(gatt->attrib, att->start, att->end,
 						char_discovered_cb, qchr);
+
+	return dbus_message_new_method_return(msg);
 }
 
+static GDBusMethodTable prim_methods[] = {
+	{ "GetCharacteristics",	"",	"a{oa{sv}}", get_characteristics},
+	{ "Discover",		"",	"",		discover_char	},
+	{ "RegisterCharacteristicsWatcher",	"o", "",
+						register_watcher	},
+	{ "UnregisterCharacteristicsWatcher",	"o", "",
+						unregister_watcher	},
+	{ }
+};
+
 static void register_primaries(struct gatt_service *gatt, GSList *primaries)
 {
 	GSList *l;
@@ -1031,10 +1041,6 @@ int attrib_client_register(struct btd_device *device, int psm)
 
 	register_primaries(gatt, primaries);
 
-	/* FIXME: just to avoid breaking the build */
-	if (FALSE)
-		discover_all_char(NULL, NULL);
-
 	gatt_services = g_slist_append(gatt_services, gatt);
 
 	return 0;
-- 
1.7.3.4

