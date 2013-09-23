Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] obexd: Fix setting message folder for relative folder in ListMessages
Date: Mon, 23 Sep 2013 11:24:27 +0200
Message-Id: <1379928269-14651-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1379928269-14651-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1379928269-14651-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The method ListMessages allows to specify a relative subfolder.
This subfolder needs to be added to the current path when registering
a new message interface.
---
 obexd/client/map.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 131b140..45b4ef1 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -103,6 +103,7 @@ struct map_data {
 struct pending_request {
 	struct map_data *map;
 	DBusMessage *msg;
+	char *folder;
 };
 
 #define MAP_MSG_FLAG_PRIORITY	0x01
@@ -154,6 +155,7 @@ static void pending_request_free(struct pending_request *p)
 {
 	dbus_message_unref(p->msg);
 
+	g_free(p->folder);
 	g_free(p);
 }
 
@@ -1098,8 +1100,7 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
 
 	msg = g_hash_table_lookup(data->messages, values[i]);
 	if (msg == NULL) {
-		msg = map_msg_create(data, values[i],
-					obc_session_get_folder(data->session));
+		msg = map_msg_create(data, values[i], parser->request->folder);
 		if (msg == NULL)
 			return;
 	}
@@ -1195,6 +1196,17 @@ done:
 	pending_request_free(request);
 }
 
+static char *get_absolute_folder(const char *root, const char *subfolder)
+{
+	if (!subfolder || strlen(subfolder) == 0)
+		return g_strdup(root);
+	else
+		if (g_str_has_suffix(root, "/"))
+			return g_strconcat(root, subfolder, NULL);
+		else
+			return g_strconcat(root, "/", subfolder, NULL);
+}
+
 static DBusMessage *get_message_listing(struct map_data *map,
 							DBusMessage *message,
 							const char *folder,
@@ -1214,6 +1226,8 @@ static DBusMessage *get_message_listing(struct map_data *map,
 	obc_transfer_set_apparam(transfer, apparam);
 
 	request = pending_request_new(map, message);
+	request->folder = get_absolute_folder(obc_session_get_folder(
+							map->session), folder);
 
 	if (!obc_session_queue(map->session, transfer, message_listing_cb,
 							request, &err)) {
-- 
1.8.3.4

