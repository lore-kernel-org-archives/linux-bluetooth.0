Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] obexd: Handle new message event
Date: Tue, 24 Sep 2013 16:16:01 +0200
Message-Id: <1380032167-6440-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Register new org.bluez.obex.Message1 D-Bus object when a NewMessage
event report has arrived.
---
 obexd/client/map.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 45b4ef1..74c826e 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1821,6 +1821,27 @@ static void map_msg_remove(void *data)
 	g_free(path);
 }
 
+static void map_msg_create_from_event(struct map_data *map,
+							struct map_event *event,
+							const char *folder)
+{
+	struct map_msg *msg = map_msg_create(map, event->handle, folder);
+	if (msg)
+		parse_type(msg, event->msg_type);
+}
+
+static void map_handle_new_message(struct map_data *map,
+							struct map_event *event)
+{
+	struct map_msg *msg = g_hash_table_lookup(map->messages, event->handle);
+
+	/* New message event can be used if a new message replaces an old one */
+	if (msg)
+		g_hash_table_remove(map->messages, event->handle);
+
+	map_msg_create_from_event(map, event, event->folder);
+}
+
 static void map_handle_notification(struct map_event *event, void *user_data)
 {
 	struct map_data *map = user_data;
@@ -1830,6 +1851,14 @@ static void map_handle_notification(struct map_event *event, void *user_data)
 	DBG("type=%x, handle=%s, folder=%s, old_folder=%s, msg_type=%s",
 				event->type, event->handle, event->folder,
 					event->old_folder, event->msg_type);
+
+	switch (event->type) {
+	case MAP_ET_NEW_MESSAGE:
+		map_handle_new_message(map, event);
+		break;
+	default:
+		break;
+	}
 }
 
 static bool set_notification_registration(struct map_data *map, bool status)
-- 
1.8.3.4

