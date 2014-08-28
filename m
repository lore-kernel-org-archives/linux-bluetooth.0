Return-Path: <cyrus@holtmann.org>
From: gowtham babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, bharat.panda@samsung.com,
	gowtham babu <gowtham.ab@samsung.com>
Subject: [MAP] obexd/client: Handle MAP event types
Date: Thu, 28 Aug 2014 11:16:43 +0530
Message-id: <1409204803-3705-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds below MCE event types handling in map_handle_notification()
MAP_ET_MEMORY_FULL
MAP_ET_MEMORY_AVAILABLE
---
 obexd/client/map.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 520e492..84feecf 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1927,6 +1927,12 @@ static void map_handle_notification(struct map_event *event, void *user_data)
 	case MAP_ET_MESSAGE_SHIFT:
 		map_handle_folder_changed(map, event, event->folder);
 		break;
+	case MAP_ET_MEMORY_FULL:
+		map_handle_status_changed(map, event, "memory-full");
+		break;
+	case MAP_ET_MEMORY_AVAILABLE:
+		map_handle_status_changed(map, event, "memory-available");
+		break;
 	default:
 		break;
 	}
-- 
1.9.1

