Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] obexd: Handle message status events
Date: Tue, 24 Sep 2013 16:16:03 +0200
Message-Id: <1380032167-6440-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

For outgoing messages, the message status is changed when an event
indicates that the sending/delivery has failed or succeeded.
---
 obexd/client/map.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index ae7a334..3b0f662 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1854,6 +1854,15 @@ static void map_handle_new_message(struct map_data *map,
 	map_msg_create_from_event(map, event, event->folder);
 }
 
+static void map_handle_status(struct map_data *map, struct map_event *event,
+							const char *status)
+{
+	struct map_msg *msg = g_hash_table_lookup(map->messages, event->handle);
+
+	if (msg)
+		set_reception_status(msg, status);
+}
+
 static void map_handle_notification(struct map_event *event, void *user_data)
 {
 	struct map_data *map = user_data;
@@ -1868,6 +1877,18 @@ static void map_handle_notification(struct map_event *event, void *user_data)
 	case MAP_ET_NEW_MESSAGE:
 		map_handle_new_message(map, event);
 		break;
+	case MAP_ET_DELIVERY_SUCCESS:
+		map_handle_status(map, event, "delivery-success");
+		break;
+	case MAP_ET_SENDING_SUCCESS:
+		map_handle_status(map, event, "sending-success");
+		break;
+	case MAP_ET_DELIVERY_FAILURE:
+		map_handle_status(map, event, "delivery-failure");
+		break;
+	case MAP_ET_SENDING_FAILURE:
+		map_handle_status(map, event, "sending-failure");
+		break;
 	default:
 		break;
 	}
-- 
1.8.3.4

