Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/7] android/gatt: Fix some whitespace issues
Date: Mon, 28 Apr 2014 15:32:04 +0200
Message-Id: <1398691926-1777-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 706d009..549bb30 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -972,8 +972,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 reply:
 	data.dev = dev;
 	data.status = status;
-	queue_foreach(app_connections, send_app_connect_notifications,
-									&data);
+	queue_foreach(app_connections, send_app_connect_notifications, &data);
 	device_unref(dev);
 
 	/* Check if we should restart scan */
@@ -1248,9 +1247,8 @@ static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id,
 	conn_match.device = dev;
 	conn_match.app = app;
 
-	return queue_find(app_connections,
-				match_connection_by_device_and_app,
-				&conn_match);
+	return queue_find(app_connections, match_connection_by_device_and_app,
+								&conn_match);
 }
 
 static void handle_client_connect(const void *buf, uint16_t len)
@@ -1285,9 +1283,8 @@ static void handle_client_connect(const void *buf, uint16_t len)
 	conn_match.device = device;
 	conn_match.app = client;
 
-	conn = queue_find(app_connections,
-					match_connection_by_device_and_app,
-					&conn_match);
+	conn = queue_find(app_connections, match_connection_by_device_and_app,
+								&conn_match);
 	if (!conn) {
 		conn = create_connection(device, client);
 		if (!conn) {
-- 
1.9.1

