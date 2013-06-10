Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] obexd: Register notification handler in the MAP client
Date: Mon, 10 Jun 2013 13:01:38 +0200
Message-Id: <1370862099-31046-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1370862099-31046-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1370862099-31046-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 obexd/client/map.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 0285286..ab2b5a0 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -36,6 +36,7 @@
 #include "dbus.h"
 #include "log.h"
 #include "map_ap.h"
+#include "map-dispatcher.h"
 
 #include "map.h"
 #include "transfer.h"
@@ -1694,12 +1695,35 @@ static void map_msg_remove(void *data)
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
 static bool set_notification_registration(struct map_data *map, bool status)
 {
 	struct obc_transfer *transfer;
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
1.8.2.3

