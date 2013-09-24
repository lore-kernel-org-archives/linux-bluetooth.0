Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] obexd: Add function set_folder to MAP client
Date: Tue, 24 Sep 2013 16:16:05 +0200
Message-Id: <1380032167-6440-6-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The function allows to change the folder a message belongs to.
---
 obexd/client/map.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 3b0f662..8ddbc46 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1830,6 +1830,18 @@ static void map_msg_create_from_event(struct map_data *map,
 		parse_type(msg, event->msg_type);
 }
 
+static void set_folder(struct map_msg *msg, const char *folder)
+{
+	if (g_strcmp0(msg->folder, folder) == 0)
+		return;
+
+	g_free(msg->folder);
+	msg->folder = g_strdup(folder);
+
+	g_dbus_emit_property_changed(conn, msg->path, MAP_MSG_INTERFACE,
+								"Folder");
+}
+
 static void set_reception_status(struct map_msg *msg, const char *status)
 {
 	if (g_strcmp0(msg->status, status) == 0)
-- 
1.8.3.4

