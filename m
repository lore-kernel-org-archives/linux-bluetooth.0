Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 2/7] obexd/client/map : Handle MAP ReadStatusChanged event type
Date: Thu, 11 Sep 2014 18:50:02 +0530
Message-id: <1410441607-9687-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
References: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds ReadStatusChanged MCE event type handling in map_handle_notification()
---
 obexd/client/map.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 520e492..a505707 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1872,6 +1872,25 @@ static void map_handle_status_changed(struct map_data *map,
 								"Status");
 }
 
+static void map_handle_read_status_changed(struct map_data *map,
+                                                        struct map_event *event)
+{
+	struct map_msg *msg;
+
+	msg = g_hash_table_lookup(map->messages, &event->handle);
+	if (msg == NULL)
+		return;
+
+	/* In MAP V 1.2 specification : ReadStatusChanged event didn't have  clear explaination.
+	So as of now it will set the message read status as "yes" if it was "no" already
+	and the other way round. This implementation may change once we get 'read' attribute in the event report. */
+
+	if(msg->flags & MAP_MSG_FLAG_READ)
+		parse_read(msg,"no");
+	else
+		parse_read(msg,"yes");
+}
+
 static void map_handle_folder_changed(struct map_data *map,
 							struct map_event *event,
 							const char *folder)
@@ -1927,6 +1946,9 @@ static void map_handle_notification(struct map_event *event, void *user_data)
 	case MAP_ET_MESSAGE_SHIFT:
 		map_handle_folder_changed(map, event, event->folder);
 		break;
+	case MAP_ET_READ_STATUS_CHANGED:
+		map_handle_read_status_changed(map, event);
+		break;
 	default:
 		break;
 	}
-- 
1.9.1

