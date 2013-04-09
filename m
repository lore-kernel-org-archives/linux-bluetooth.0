Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] obexd: Register notification handler in the MAP client
Date: Tue,  9 Apr 2013 13:55:24 +0200
Message-Id: <1365508525-13251-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508525-13251-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508525-13251-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 obexd/client/map.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 7a02583..aaf581b 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -41,6 +41,7 @@
 #include "driver.h"
 #include "sdp.h"
 #include "sdp_lib.h"
+#include "map-dispatcher.h"
 
 #define OBEX_MAS_UUID \
 	"\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
@@ -1694,6 +1695,17 @@ static void map_msg_remove(void *data)
 	g_free(path);
 }
 
+static void map_handle_notification(struct map_event *event, void *user_data)
+{
+	struct map_data *map = user_data;
+
+	DBG("Event report for %s:%d", obc_session_get_destination(map->session),
+							map->mas_instance_id);
+	DBG("type=%x, handle=%s, folder=%s, old_folder=%s, msg_type=%s",
+				event->type, event->handle, event->folder,
+					event->old_folder, event->msg_type);
+}
+
 static gboolean set_notification_registration(struct map_data *map,
 								gboolean status)
 {
@@ -1701,6 +1713,18 @@ static gboolean set_notification_registration(struct map_data *map,
 	GError *err = NULL;
 	GObexApparam *apparam;
 	char contents[2];
+	const char *address;
+
+	address = obc_session_get_destination(map->session);
+	if (!address || map->mas_instance_id < 0)
+		return FALSE;
+
+	if (status) {
+		map_acquire_mns(map->mas_instance_id, address,
+						&map_handle_notification, map);
+	} else {
+		map_release_mns(map->mas_instance_id, address);
+	}
 
 	contents[0] = FILLER_BYTE;
 	contents[1] = '\0';
-- 
1.8.2.1

