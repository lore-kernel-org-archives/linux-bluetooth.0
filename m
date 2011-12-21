Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/2] Fix GAttrib ref counting in Generic Attribute
Date: Wed, 21 Dec 2011 18:41:49 -0300
Message-Id: <1324503710-29815-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Although ATT connection callbacks control GAttrib reference, each
entity using GAttrib should be increment the GAttrib reference to
keep the code standard.
---
 attrib/client.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 1b22139..5f1e6ce 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -318,7 +318,7 @@ static void attio_connected(GAttrib *attrib, gpointer user_data)
 {
 	struct gatt_service *gatt = user_data;
 
-	gatt->attrib = attrib;
+	gatt->attrib = g_attrib_ref(attrib);
 
 	g_attrib_register(gatt->attrib, ATT_OP_HANDLE_NOTIFY,
 					events_handler, gatt, NULL);
@@ -332,7 +332,10 @@ static void attio_disconnected(gpointer user_data)
 {
 	struct gatt_service *gatt = user_data;
 
-	gatt->attrib = NULL;
+	if (gatt->attrib) {
+		g_attrib_unref(gatt->attrib);
+		gatt->attrib = NULL;
+	}
 }
 
 static DBusMessage *register_watcher(DBusConnection *conn,
@@ -892,7 +895,7 @@ static void send_discover(GAttrib *attrib, gpointer user_data)
 	struct gatt_service *gatt = qchr->gatt;
 	struct att_primary *prim = gatt->prim;
 
-	gatt->attrib = attrib;
+	gatt->attrib = g_attrib_ref(attrib);
 
 	gatt_discover_char(gatt->attrib, prim->start, prim->end, NULL,
 						char_discovered_cb, qchr);
@@ -903,6 +906,7 @@ static void cancel_discover(gpointer user_data)
 	struct query_data *qchr = user_data;
 	struct gatt_service *gatt = qchr->gatt;
 
+	g_attrib_unref(gatt->attrib);
 	gatt->attrib = NULL;
 }
 
-- 
1.7.8

