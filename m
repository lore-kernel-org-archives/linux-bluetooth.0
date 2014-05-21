Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/3] android/gatt: Check for connection state on connection search
Date: Wed, 21 May 2014 16:34:40 +0200
Message-Id: <1400682882-11341-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This search was used with the assumption that connection is in
"connected" state. This could result in attrib pointer being
dereferenced while it's still NULL (pending connection).
---
 android/gatt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 89da60d..1b000c4 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -364,8 +364,14 @@ static bool match_connection_by_device_and_app(const void *data,
 
 static struct app_connection *find_connection_by_id(int32_t conn_id)
 {
-	return queue_find(app_connections, match_connection_by_id,
+	struct app_connection *conn;
+
+	conn = queue_find(app_connections, match_connection_by_id,
 							INT_TO_PTR(conn_id));
+	if (conn && conn->device->state == DEVICE_CONNECTED)
+		return conn;
+
+	return NULL;
 }
 
 static bool match_connection_by_device(const void *data, const void *user_data)
-- 
1.9.3

