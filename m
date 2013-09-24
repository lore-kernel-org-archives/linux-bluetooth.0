Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] obexd: Add function set_reception_status to MAP client
Date: Tue, 24 Sep 2013 16:16:02 +0200
Message-Id: <1380032167-6440-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The function allows to change the status of a message.
---
 obexd/client/map.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 74c826e..ae7a334 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1830,6 +1830,18 @@ static void map_msg_create_from_event(struct map_data *map,
 		parse_type(msg, event->msg_type);
 }
 
+static void set_reception_status(struct map_msg *msg, const char *status)
+{
+	if (g_strcmp0(msg->status, status) == 0)
+		return;
+
+	g_free(msg->status);
+	msg->status = g_strdup(status);
+
+	g_dbus_emit_property_changed(conn, msg->path, MAP_MSG_INTERFACE,
+								"Status");
+}
+
 static void map_handle_new_message(struct map_data *map,
 							struct map_event *event)
 {
-- 
1.8.3.4

