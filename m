Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 06/19] gateway: Fix D-Bus reply memory leak
Date: Thu, 12 Apr 2012 20:32:57 +0530
Message-id: <1334243001-17016-7-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Re-arrange the code to avoid the D-Bus memory leak. Earlier if rfcomm
is not connected, then there was a reply memory leak.
---
 audio/gateway.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 19f8ce3..afd2669 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -598,13 +598,13 @@ static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
 	if (!device->conn)
 		return NULL;
 
+	if (!gw->rfcomm)
+		return  btd_error_not_connected(msg);
+
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return NULL;
 
-	if (!gw->rfcomm)
-		return  btd_error_not_connected(msg);
-
 	gateway_close(device);
 	ba2str(&device->dst, gw_addr);
 	DBG("Disconnected from %s, %s", gw_addr, device->path);
-- 
1.7.4.1

