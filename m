Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] obexd/MAP: Fix invalid snprintf format string in map_msg_get()
Date: Fri, 4 Oct 2013 09:01:25 +0200
Message-ID: <1380870086-3663-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

obexd/client/map.c: In function ‘map_msg_get’:
obexd/client/map.c:446:2: warning: format ‘%u’ expects argument of type
     ‘unsigned int’, but argument 4 has type ‘uint64_t’ [-Wformat]
obexd/client/map.c:446:2: warning: format ‘%u’ expects argument of type
     ‘unsigned int’, but argument 4 has type ‘uint64_t’ [-Wformat]
---
 obexd/client/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 72c4de4..fe15bab 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -443,7 +443,7 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".InvalidArguments", NULL);
 
-	if (snprintf(handle, sizeof(handle), "%u" PRIu64, msg->handle) < 0)
+	if (snprintf(handle, sizeof(handle), "%" PRIu64, msg->handle) < 0)
 		goto fail;
 
 	transfer = obc_transfer_get("x-bt/message", handle, target_file, &err);
-- 
1.8.4

