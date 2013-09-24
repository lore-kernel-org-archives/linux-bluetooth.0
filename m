Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] obexd: Handle message shift and message deleted events
Date: Tue, 24 Sep 2013 16:16:06 +0200
Message-Id: <1380032167-6440-7-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

For already existing messages, the folder property needs to be updated.
Non existing messages are created only if they are moved into the
current folder. Otherwise, the event will be ignored.

A message deleted event signals that a message has been moved into the
folder /telecom/msg/deleted.
---
 obexd/client/map.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 8ddbc46..ee8d488 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1875,6 +1875,25 @@ static void map_handle_status(struct map_data *map, struct map_event *event,
 		set_reception_status(msg, status);
 }
 
+static void map_handle_message_shift(struct map_data *map,
+							struct map_event *event,
+							const char *dest)
+{
+	struct map_msg *msg;
+
+	if (!dest)
+		return;
+
+	msg = g_hash_table_lookup(map->messages, event->handle);
+
+	/* Change folder for existing messages; create non existing messages
+	 * only when they are moved into the current folder. */
+	if (msg)
+		set_folder(msg, dest);
+	else if (g_strcmp0(obc_session_get_folder(map->session), dest) == 0)
+		map_msg_create_from_event(map, event, dest);
+}
+
 static void map_handle_notification(struct map_event *event, void *user_data)
 {
 	struct map_data *map = user_data;
@@ -1901,6 +1920,12 @@ static void map_handle_notification(struct map_event *event, void *user_data)
 	case MAP_ET_SENDING_FAILURE:
 		map_handle_status(map, event, "sending-failure");
 		break;
+	case MAP_ET_MESSAGE_DELETED:
+		map_handle_message_shift(map, event, "/telecom/msg/deleted");
+		break;
+	case MAP_ET_MESSAGE_SHIFT:
+		map_handle_message_shift(map, event, event->folder);
+		break;
 	default:
 		break;
 	}
-- 
1.8.3.4

