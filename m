Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] obexd: Add folder property to map_msg_create
Date: Mon, 23 Sep 2013 11:24:26 +0200
Message-Id: <1379928269-14651-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1379928269-14651-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1379928269-14651-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Message interfaces are not necessarily created for the current folder,
therefore the folder needs to be specified in a parameter.

For example, messages can be created for sub folders when using the folder
parameter in ListMessages.
---
 obexd/client/map.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 9fe872d..131b140 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -809,7 +809,8 @@ static const GDBusPropertyTable map_msg_properties[] = {
 	{ }
 };
 
-static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
+static struct map_msg *map_msg_create(struct map_data *data, const char *handle,
+							const char *folder)
 {
 	struct map_msg *msg;
 
@@ -818,7 +819,7 @@ static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
 	msg->path = g_strdup_printf("%s/message%s",
 					obc_session_get_path(data->session),
 					handle);
-	msg->folder = g_strdup(obc_session_get_folder(data->session));
+	msg->folder = g_strdup(folder);
 
 	if (!g_dbus_register_interface(conn, msg->path, MAP_MSG_INTERFACE,
 						map_msg_methods, NULL,
@@ -1097,7 +1098,8 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
 
 	msg = g_hash_table_lookup(data->messages, values[i]);
 	if (msg == NULL) {
-		msg = map_msg_create(data, values[i]);
+		msg = map_msg_create(data, values[i],
+					obc_session_get_folder(data->session));
 		if (msg == NULL)
 			return;
 	}
-- 
1.8.3.4

